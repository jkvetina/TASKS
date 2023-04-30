CREATE OR REPLACE FORCE VIEW tsk_lov_app_procedures_v AS
SELECT
    p.object_name,
    p.procedure_name
FROM all_procedures p
WHERE p.owner               = core.get_owner()
    AND p.object_name       LIKE 'TSK\_%' ESCAPE '\'
    AND p.procedure_name    IS NOT NULL
    AND p.procedure_name    NOT IN (
        'INIT_DEFAULTS'
    )
    AND REGEXP_LIKE(p.object_name, 'TSK_P\d+');
--
COMMENT ON TABLE tsk_lov_app_procedures_v IS '';

