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
        r.*
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
        r.authorization_scheme,
        r.items,
        r.buttons
    FROM r
    CONNECT BY NOCYCLE r.parent_region_id = PRIOR r.region_id
        AND r.page_id = PRIOR r.page_id
    START WITH r.parent_region_id IS NULL
),
page_buttons AS (
    SELECT /*+ MATERIALIZE */
        b.region_id,
        b.button_id,
        b.button_name,
        b.label,
        b.button_is_hot,
        b.icon_css_classes,
        b.database_action,
        b.authorization_scheme,
        b.button_action_code,
        b.redirect_url
    FROM apex_application_page_buttons b
    JOIN x
        ON x.app_id = b.application_id
),
page_items AS (
    SELECT /*+ MATERIALIZE */
        i.region_id,
        i.item_id,
        i.item_name,
        i.label
    FROM apex_application_page_items i
    JOIN x
        ON x.app_id = i.application_id
),
page_processes AS (
    SELECT /*+ MATERIALIZE */
        p.region_id,                -- NULL
        p.process_id,
        p.process_name
    FROM apex_application_page_proc p
    JOIN x
        ON x.app_id = p.application_id
),
grid_columns AS (
    SELECT /*+ MATERIALIZE */
        g.region_id,
        g.column_id,
        g.name
    FROM apex_appl_page_ig_columns g
    JOIN x
        ON x.app_id = g.application_id
)
SELECT
    r.page_id,
    r.region_id,
    r.level_,
    r.path_,
    r.region_id     AS component_id,
    'REGION'        AS component_type,
    --
    REPLACE(LPAD(' ', (NVL(r.level_, 1) - 1) * 3, ' '), ' ', '&' || 'nbsp; ') || r.region_name || ' &' || 'mdash; ' || r.template || '' AS component_name,
    --
    ''              AS dml_actions
FROM page_regions r
WHERE r.region_id NOT IN (
    SELECT c.component_id
    FROM c
    WHERE c.component_type    = 'REGION'
)
UNION ALL
--
SELECT
    c.page_id,
    r.region_id,
    r.level_,
    r.path_ || '/' || '',     -- to show after region, @TODO: add button_seq., display_seq. ...
    c.component_id,
    c.component_type,
    --
    REPLACE(LPAD(' ', (NVL(r.level_, 1) - CASE WHEN c.component_type = 'PROCESS' THEN 1 ELSE 0 END) * 3, ' '), ' ', '&' || 'nbsp; ') || c.component_name AS component_name,
    --
    'U'         AS dml_actions
FROM c
LEFT JOIN page_buttons b    ON b.button_id  = c.component_id
LEFT JOIN page_items i      ON i.item_id    = c.component_id
LEFT JOIN page_processes p  ON p.process_id = c.component_id
LEFT JOIN grid_columns g    ON g.column_id  = c.component_id
LEFT JOIN page_regions r
    ON r.region_id          = COALESCE(b.region_id, i.region_id, p.region_id, g.region_id, c.component_id)
WHERE 1 = 1
    AND c.component_type    NOT IN ('REGION', 'PAGE');
--
COMMENT ON TABLE tsk_p963_regions_v IS '';

