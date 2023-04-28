CREATE OR REPLACE FORCE VIEW tsk_lov_app_tables_v AS
SELECT
    t.table_name,
    p.procedure_name
FROM all_tables t
LEFT JOIN all_procedures p
    ON p.owner              = t.owner
    AND p.object_name       = 'TSK_TAPI'
    AND p.procedure_name    = REPLACE(t.table_name, 'TSK_', '')
WHERE t.owner               = core.get_owner()
    AND t.table_name        LIKE 'TSK\_%' ESCAPE '\'
    AND t.table_name        NOT LIKE '%\_MV' ESCAPE '\'
    AND t.table_name        NOT IN (
        'TSK_NAVIGATION'
    );
--
COMMENT ON TABLE tsk_lov_app_tables_v IS '';

