CREATE OR REPLACE FORCE VIEW tsk_lov_app_procedures_v AS
SELECT
    p.object_name,
    p.procedure_name,
    g.page_id,
    g.page_group,
    g.page_group_raw
    --
FROM all_procedures p
LEFT JOIN tsk_lov_app_pages_v g
    ON g.page_id            = TO_NUMBER(REGEXP_SUBSTR(p.object_name, '^TSK_P(\d+)$', 1, 1, NULL, 1))
WHERE p.owner               = core.get_owner()
    AND p.object_name       LIKE 'TSK\_%' ESCAPE '\'
    AND p.procedure_name    IS NOT NULL
    AND p.procedure_name    NOT IN (
        'INIT_DEFAULTS'
    )
    AND REGEXP_LIKE(p.object_name, 'TSK_P\d+');
--
COMMENT ON TABLE tsk_lov_app_procedures_v IS '';

