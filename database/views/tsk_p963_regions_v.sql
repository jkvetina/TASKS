CREATE OR REPLACE FORCE VIEW tsk_p963_regions_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_app_id() AS app_id
    FROM DUAL
),
c AS (
    SELECT /*+ MATERIALIZE */
        c.page_id,
        c.component_id,
        c.component_type
    FROM tsk_auth_components c
    WHERE c.is_active   = 'Y'
    GROUP BY
        c.page_id,
        c.component_id,
        c.component_type
),
r AS (
    SELECT /*+ MATERIALIZE */
        r.page_id,
        r.region_id,
        r.region_name,
        r.parent_region_id,
        r.display_sequence,
        r.template,
        r.static_id,
        r.query_type_code,
        r.table_name,
        r.source_type_code,
        r.region_source,
        r.authorization_scheme,
        r.items,
        r.buttons
    FROM apex_application_page_regions r
    JOIN x
        ON x.app_id = r.application_id
),
page_regions AS (
    SELECT /*+ MATERIALIZE */
        r.page_id,
        r.region_id,
        r.region_name,
        --
        LEVEL AS level_,
        SYS_CONNECT_BY_PATH(LPAD(r.display_sequence, 4, '0') || '-' || r.region_id, '/') AS path_,
        --
        r.template,
        r.static_id,
        r.query_type_code,
        r.table_name,
        r.source_type_code,
        r.region_source,
        r.display_sequence,
        r.authorization_scheme
    FROM r
    CONNECT BY NOCYCLE r.parent_region_id = PRIOR r.region_id
        AND r.page_id = PRIOR r.page_id
    START WITH r.parent_region_id IS NULL
),
page_buttons AS (
    SELECT /*+ MATERIALIZE */
        b.page_id,
        b.region_id,
        b.button_id,
        b.button_name,
        b.label,
        b.button_is_hot,
        b.icon_css_classes,
        b.database_action,
        b.authorization_scheme,
        b.button_action_code,
        b.redirect_url,
        b.button_sequence
    FROM apex_application_page_buttons b
    JOIN x
        ON x.app_id = b.application_id
),
page_items AS (
    SELECT /*+ MATERIALIZE */
        i.region_id,
        i.item_id,
        i.item_name
            || CASE WHEN i.encrypt_session_state = 'Yes'
                THEN '<span class="fa fa-lock" style="color: #555; margin: 0.125rem 0.5rem 0;"></span>' END
            AS item_name,
        --
        i.label,
        i.authorization_scheme,
        i.display_sequence
    FROM apex_application_page_items i
    JOIN x
        ON x.app_id = i.application_id
),
page_processes AS (
    SELECT /*+ MATERIALIZE */
        p.page_id,
        p.region_id,                -- NULL
        p.process_id,
        p.process_name || CASE WHEN p.process_point LIKE 'Ajax%' THEN ' <span style="color: #999;">&' || 'mdash; AJAX Callback</span>' END AS process_name,
        p.authorization_scheme,
        p.execution_sequence,
        p.when_button_pressed_id
    FROM apex_application_page_proc p
    JOIN x
        ON x.app_id = p.application_id
),
grid_columns AS (
    SELECT /*+ MATERIALIZE */
        g.region_id,
        g.column_id,
        g.name,
        g.authorization_scheme,
        g.display_sequence
    FROM apex_appl_page_ig_columns g
    JOIN x
        ON x.app_id = g.application_id
),
d AS (
    SELECT
        r.page_id,
        r.region_id,
        r.region_id             AS component_id,
        'REGION'                AS component_type,
        r.region_name || ' <span style="color: #999;">&' || 'mdash; ' || r.template || '</span>' AS component_name,
        r.display_sequence      AS seq,
        r.authorization_scheme
    FROM page_regions r
    WHERE r.region_id NOT IN (
        SELECT c.component_id
        FROM c
        WHERE c.component_type  = 'REGION'
    )
    UNION ALL
    --
    SELECT
        c.page_id,
        r.region_id,
        --
        -- @TODO: show after region
        -- @TODO: add button_seq., display_seq. ...
        --
        c.component_id,
        c.component_type,
        --
        COALESCE (
            b.button_name,
            i.item_name,
            p.process_name,
            g.name,
            r.region_name,
            NULL            -- unknown component type
        ) AS component_name,
        --
        COALESCE (
            b.button_sequence,
            i.display_sequence,
            p.execution_sequence,
            g.display_sequence,
            r.display_sequence
        ) AS seq,
        --
        COALESCE (
            b.authorization_scheme,
            i.authorization_scheme,
            p.authorization_scheme,
            g.authorization_scheme,
            r.authorization_scheme
        ) AS  authorization_scheme
    FROM c
    LEFT JOIN page_buttons b    ON b.button_id  = c.component_id
    LEFT JOIN page_items i      ON i.item_id    = c.component_id
    LEFT JOIN page_processes p  ON p.process_id = c.component_id
    LEFT JOIN grid_columns g    ON g.column_id  = c.component_id
    LEFT JOIN page_regions r
        ON r.region_id          = COALESCE(b.region_id, i.region_id, p.region_id, g.region_id, c.component_id)
    WHERE 1 = 1
        AND c.component_type    NOT IN ('PAGE')
    UNION ALL
    --
    -- always show all buttons, allow inserts only if they have IS_USER scheme set
    SELECT
        b.page_id,
        b.region_id,
        b.button_id             AS component_id,
        'BUTTON'                AS component_type,
        b.button_name           AS component_name,
        b.button_sequence       AS seq,
        b.authorization_scheme
    FROM page_buttons b
    JOIN page_regions r
        ON r.region_id          = b.region_id
    LEFT JOIN c
        ON c.component_id       = b.button_id
    WHERE c.component_id        IS NULL
        AND b.button_name       NOT LIKE 'CLOSE_DIALOG%'
    UNION ALL
    --
    -- always show all processes, allow inserts only if they have IS_USER scheme set
    SELECT
        p.page_id,
        r.region_id,
        p.process_id            AS component_id,
        'PROCESS'               AS component_type,
        p.process_name          AS component_name,
        p.execution_sequence    AS seq,
        p.authorization_scheme
    FROM page_processes p
    LEFT JOIN page_regions r
        ON r.region_id          = p.region_id
    LEFT JOIN c
        ON c.component_id       = p.process_id
    WHERE c.component_id        IS NULL
),
t AS (
    -- prepare the tree view
    SELECT /*+ MATERIALIZE */
        d.page_id,
        d.region_id,
        --
        NVL(r.level_ - 1 + CASE WHEN d.component_type != 'REGION' THEN 1 ELSE 0 END, 0) AS level_,
        r.path_ || CASE WHEN d.component_type != 'REGION' THEN '/' || d.component_type || '-' || LPAD(d.seq, 4, '0') || '-' || d.component_id END AS path_,
        --
        d.component_id,
        d.component_type,
        --
        REPLACE(LPAD(' ', NVL(r.level_ - 1 + CASE WHEN d.component_type != 'REGION' THEN 1 ELSE 0 END, 0) * 3, ' '), ' ', '&' || 'nbsp; ') ||
            CASE WHEN d.component_type = 'PROCESS'  THEN '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>' END ||
            CASE WHEN d.component_type = 'BUTTON'   THEN '<span class="fa fa-button" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>' END ||
            d.component_name AS component_name,
        --
        CASE WHEN d.authorization_scheme = 'IS_USER' THEN 'U' END AS dml_actions
    FROM d
    LEFT JOIN page_regions r
        ON r.region_id = d.region_id
),
remap_processes AS (
    -- fix processes, if they are mapped to buttons, show them under that button
    SELECT /*+ MATERIALIZE */
        p.process_id AS component_id,
        REPLACE(LPAD(' ', (t.level_ + 1) * 3, ' '), ' ', '&' || 'nbsp; ') || n.component_name AS component_name,
        t.path_ || '/PROCESS' || '-' || LPAD(p.execution_sequence, 4, '0') || '-' || p.process_id AS path_,
        t.level_ + 1 AS level_
    FROM page_processes p
    JOIN t
        ON t.component_type     = 'BUTTON'
        AND t.component_id      = p.when_button_pressed_id
    JOIN t n
        ON n.component_id       = p.process_id
)
SELECT
    t.page_id,
    t.region_id,
    NVL(r.level_,   t.level_)   AS level_,
    NVL(r.path_,    t.path_)    AS path_,
    t.component_id,
    t.component_type,
    NVL(r.component_name, t.component_name) AS component_name,
    t.dml_actions
FROM t
LEFT JOIN remap_processes r
    ON r.component_id = t.component_id;
--
COMMENT ON TABLE tsk_p963_regions_v IS '';

