CREATE OR REPLACE FORCE VIEW tsk_auth_region_tables_v AS
SELECT
    p.page_id,
    p.region_id,
    COALESCE(a.table_name, p.attribute_03, r.table_name) AS table_name
FROM apex_application_page_proc p
LEFT JOIN apex_application_page_regions r
    ON r.application_id         = p.application_id
    AND r.page_id               = p.page_id
    AND r.region_id             = p.region_id
    AND r.query_type_code       = 'TABLE'
LEFT JOIN tsk_auth_procedures a
    ON UPPER(p.attribute_04)    LIKE '%' || UPPER(a.object_name || '.' || a.procedure_name) || '%'
    AND a.table_name            IS NOT NULL
    AND a.is_active             = 'Y'
WHERE p.application_id          = core.get_app_id()
    --AND p.page_id               = in_page_id
    --AND p.region_id             = in_component_id
    AND p.process_type_code     = 'NATIVE_IG_DML'
    AND p.process_point_code    = 'AFTER_SUBMIT'
    AND p.attribute_01          IN ('TABLE', 'REGION_SOURCE', 'PLSQL_CODE')
    AND p.process_point_code    = 'AFTER_SUBMIT';
--
COMMENT ON TABLE tsk_auth_region_tables_v IS '';

