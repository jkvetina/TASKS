CREATE OR REPLACE FORCE VIEW tsk_auth_grids_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_app_id()       AS app_id,
        core.get_owner()        AS owner
    FROM DUAL
),
t AS (
    SELECT /*+ MATERIALIZE */
        x.app_id,
        p.page_id,
        p.region_id,
        --
        CASE WHEN r.region_name NOT LIKE '% [GRID]' THEN '[!] ' END || REPLACE(r.region_name, '[GRID]', '') AS region_name,
        --
        CASE WHEN r.where_clause IS NOT NULL THEN '[!] ' END || r.table_name AS source_object,
        --
        CASE WHEN v.view_name IS NOT NULL THEN 'VIEW' ELSE '[!] ' || r.query_type_code END AS source_type,
        --
        p.process_name,
        p.process_type_code         AS process_handler,
        p.attribute_01              AS process_type,
        --
        CASE p.attribute_01
            WHEN 'PLSQL_PACKAGE'    THEN p.attribute_03
            WHEN 'PLSQL_CODE'       THEN NVL(REGEXP_SUBSTR(UPPER(p.attribute_04), '^([A-Z0-9_]+)\.?([A-Z0-9_]*)', 1, 1, NULL, 1), '[!]')
            ELSE NULL
            END AS object_name,
        --
        CASE p.attribute_01
            WHEN 'PLSQL_PACKAGE'    THEN p.attribute_04
            WHEN 'PLSQL_CODE'       THEN NVL(REGEXP_SUBSTR(UPPER(p.attribute_04), '^([A-Z0-9_]+)\.?([A-Z0-9_]*)', 1, 1, NULL, 2), '[!]')
            ELSE NULL
            END AS procedure_name,
        --
        CASE p.attribute_01
            WHEN 'TABLE'            THEN p.attribute_03
            WHEN 'REGION_SOURCE'    THEN r.table_name
            WHEN 'PLSQL_CODE'       THEN ''
            WHEN 'PLSQL_PACKAGE'    THEN ''
            ELSE NULL END AS table_name,
        --
        CASE WHEN r.authorization_scheme = 'IS_USER' THEN 'Y' END AS auth_region,
        CASE WHEN p.authorization_scheme = 'IS_USER' THEN 'Y' END AS auth_process,
        --
        CASE
            WHEN g.add_authorization_scheme = 'IS_USER_C' THEN 'Y'
            WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'i') > 0 THEN '[!]'
            END AS auth_c,
        CASE
            WHEN g.update_authorization_scheme = 'IS_USER_U' THEN 'Y'
            WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'u') > 0 THEN '[!]'
            END AS auth_u,
        CASE
            WHEN g.delete_authorization_scheme = 'IS_USER_D' THEN 'Y'
            WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'd') > 0 THEN '[!]'
            END AS auth_d
        --
    FROM apex_application_page_proc p
    JOIN x
        ON x.app_id                 = p.application_id
    JOIN apex_appl_page_igs g
        ON g.application_id         = p.application_id
        AND g.page_id               = p.page_id
        AND g.region_id             = p.region_id
    JOIN apex_application_page_regions r
        ON r.application_id         = p.application_id
        AND r.page_id               = p.page_id
        AND r.region_id             = p.region_id
        AND r.query_type_code       = 'TABLE'
        AND r.source_type_code      = 'NATIVE_IG'
    LEFT JOIN all_views v
        ON v.owner                  = x.owner
        AND v.view_name             = r.table_name
    WHERE 1 = 1
        AND p.process_point_code    = 'AFTER_SUBMIT'
        AND p.process_type_code     IN ('NATIVE_IG_DML', 'NATIVE_INVOKE_API')
        AND p.attribute_01          IN ('TABLE', 'REGION_SOURCE', 'PLSQL_CODE', 'PLSQL_PACKAGE')
),
d AS (
    SELECT /*+ MATERIALIZE */
        d.page_id,
        d.when_region_id            AS region_id,
        COUNT(*)                    AS count_da
    FROM apex_application_page_da d
    JOIN x
        ON x.app_id                 = d.application_id
    WHERE d.when_region_id          IS NOT NULL
    GROUP BY
        d.page_id,
        d.when_region_id
),
i AS (
    SELECT /*+ MATERIALIZE */
        t.page_id,
        t.region_id,
        --
        COUNT(p.column_value) AS page_items,
        --
        LISTAGG(REPLACE(REGEXP_SUBSTR(CASE WHEN s.column_value IS NULL THEN p.column_value END, '''([^'']+)''', 1, 1, NULL, 1), '$', 'P' || t.page_id || '_'), ', ')
            WITHIN GROUP (ORDER BY t.page_id, t.region_id) AS missing_items
        --
    FROM t
    CROSS JOIN TABLE(APEX_STRING.SPLIT(tsk_app.get_user_views_text(t.source_object), CHR(10))) p
    LEFT JOIN apex_application_page_regions c
        ON c.application_id = t.app_id
        AND c.page_id       = t.page_id
        AND c.region_id     = t.region_id
        --
    LEFT JOIN TABLE(APEX_STRING.SPLIT(UPPER(c.ajax_items_to_submit), ',')) s
        ON s.column_value   = REPLACE(REGEXP_SUBSTR(p.column_value, '''([^'']+)''', 1, 1, NULL, 1), '$', 'P' || t.page_id || '_')
    WHERE p.column_value    LIKE '%core.get_%item%(''%'')%'
    GROUP BY
        t.page_id,
        t.region_id
)
SELECT
    t.page_id,
    t.region_id,
    t.region_name,
    t.source_object,
    t.source_type,
    --
    CASE
        WHEN i.page_items > 0 AND i.missing_items IS NOT NULL
            THEN tsk_app.get_icon_warning('Items ' || i.missing_items || ' missing on IG for proper refresh')
        WHEN i.page_items > 0
            THEN tsk_app.get_icon_check(i.page_items || ' page items used in view')
        END AS missing_items,
    --
    CASE WHEN t.process_name != NVL(t.procedure_name, '-') THEN '[!] ' END || t.process_name AS process_name,
    --
    t.process_type,
    t.process_handler,
    t.object_name,
    t.procedure_name,
    --
    COALESCE(t.table_name, a.table_name, '[!]') AS table_name,
    --
    t.auth_region,
    t.auth_process,
    t.auth_c,
    t.auth_u,
    t.auth_d,
    --attribute_05
    --attribute_06
    --
    d.count_da
FROM t
LEFT JOIN tsk_auth_procedures a
    ON a.object_name        = t.object_name
    AND a.procedure_name    = t.procedure_name
    AND a.table_name        IS NOT NULL
    AND a.role_id           IS NULL
    AND a.is_active         = 'Y'
LEFT JOIN d
    ON d.page_id            = t.page_id
    AND d.region_id         = t.region_id
LEFT JOIN i
    ON i.page_id            = t.page_id
    AND i.region_id         = t.region_id;
--
COMMENT ON TABLE tsk_auth_grids_v IS '';

