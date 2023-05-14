CREATE OR REPLACE FORCE VIEW tsk_auth_grids_v AS
WITH t AS (
    SELECT /*+ MATERIALIZE */
        p.page_id,
        p.region_id,
        --
        r.region_name || CASE WHEN r.region_name NOT LIKE '% [GRID]' THEN ' [!]' END AS region_name,
        --
        r.table_name || CASE WHEN r.where_clause IS NOT NULL THEN ' [!]' END AS region_source,
        --
        CASE WHEN v.view_name IS NOT NULL THEN 'VIEW' ELSE r.query_type_code || ' [!]' END AS region_source_type,
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
        ON v.owner                  = core.get_owner()
        AND v.view_name             = r.table_name
    WHERE p.application_id          = core.get_app_id()
        AND p.process_point_code    = 'AFTER_SUBMIT'
        AND p.process_type_code     IN ('NATIVE_IG_DML', 'NATIVE_INVOKE_API')
        AND p.attribute_01          IN ('TABLE', 'REGION_SOURCE', 'PLSQL_CODE', 'PLSQL_PACKAGE')
)
SELECT
    t.page_id,
    t.region_id,
    t.region_name,
    t.region_source,
    t.region_source_type,
    --
    t.process_name || CASE WHEN t.process_name != NVL(t.procedure_name, '-') THEN ' [!]' END AS process_name,
    --
    t.process_handler,
    t.process_type,
    t.object_name,
    t.procedure_name,
    --
    COALESCE(t.table_name, a.table_name, '[!]') AS table_name,
    --
    t.auth_region,
    t.auth_process,
    t.auth_c,
    t.auth_u,
    t.auth_d
FROM t
LEFT JOIN tsk_auth_procedures a
    ON a.object_name        = t.object_name
    AND a.procedure_name    = t.procedure_name
    AND a.table_name        IS NOT NULL
    AND a.role_id           IS NULL
    AND a.is_active         = 'Y';
--
COMMENT ON TABLE tsk_auth_grids_v IS '';

