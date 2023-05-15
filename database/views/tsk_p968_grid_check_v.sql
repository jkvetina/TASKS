CREATE OR REPLACE FORCE VIEW tsk_p968_grid_check_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_app_id()                   AS app_id,
        core.get_item('$PAGE_GROUP')        AS page_group,
        core.get_number_item('$PAGE_ID')    AS page_id
    FROM DUAL
)
SELECT
    t.page_id,
    p.page_group,
    t.region_id,
    --
    REPLACE(t.region_name,      '[!]', tsk_app.get_icon_warning('')) AS region_name,
    REPLACE(t.source_object,    '[!]', tsk_app.get_icon_warning('')) AS source_object,
    --
    CASE t.source_type
        WHEN 'TABLE'    THEN tsk_app.get_icon_warning('Don''t use tables directly')
        WHEN 'VIEW'     THEN tsk_app.get_icon_check()
        ELSE NULL
        END AS source_type,
    --
    REPLACE(t.process_name,     '[!]', tsk_app.get_icon_warning('')) AS process_name,
    --
    CASE t.process_type
        WHEN 'REGION'           THEN tsk_app.get_icon_warning('Junior developer?')
        WHEN 'TABLE'            THEN tsk_app.get_icon_warning('Don''t use tables directly')
        WHEN 'PLSQL_CODE'       THEN tsk_app.get_icon_warning('Package is great, but Invoke API is better')
        WHEN 'PLSQL_PACKAGE'    THEN tsk_app.get_icon_check()
        ELSE NULL
        END AS process_type,
    --
    t.process_handler,
    --
    CASE WHEN t.object_name != 'TSK_P' || t.page_id THEN tsk_app.get_icon_warning('') END || t.object_name AS object_name,
    --
    REPLACE(t.procedure_name,   '[!]', tsk_app.get_icon_warning('')) AS procedure_name,
    REPLACE(t.table_name,       '[!]', tsk_app.get_icon_warning('')) AS table_name,
    --
    CASE WHEN t.auth_region     = 'Y' THEN tsk_app.get_icon_check() END AS auth_region,
    CASE WHEN t.auth_process    = 'Y' THEN tsk_app.get_icon_check() END AS auth_process,
    --
    CASE t.auth_c
        WHEN '[!]'  THEN tsk_app.get_icon_warning('Create auth. scheme is missing or invalid')
        WHEN 'Y'    THEN tsk_app.get_icon_check()
        ELSE NULL
        END AS auth_c,
    --
    CASE t.auth_u
        WHEN '[!]'  THEN tsk_app.get_icon_warning('Update auth. scheme is missing or invalid')
        WHEN 'Y'    THEN tsk_app.get_icon_check()
        ELSE NULL
        END AS auth_u,
    --
    CASE t.auth_d
        WHEN '[!]'  THEN tsk_app.get_icon_warning('Delete auth. scheme is missing or invalid')
        WHEN 'Y'    THEN tsk_app.get_icon_check()
        ELSE NULL
        END AS auth_d
    --
FROM tsk_auth_grids_v t
CROSS JOIN x
JOIN tsk_lov_app_pages_v p
    ON p.page_id            = t.page_id
WHERE 1 = 1
    AND (x.page_id          = p.page_id         OR x.page_id IS NULL)
    AND (x.page_group       = p.page_group_raw  OR x.page_group IS NULL);
--
COMMENT ON TABLE tsk_p968_grid_check_v IS '';

