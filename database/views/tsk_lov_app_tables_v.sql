CREATE OR REPLACE FORCE VIEW tsk_lov_app_tables_v AS
SELECT
    t.table_name
FROM all_tables t
WHERE t.owner           = core.get_owner()
    AND t.table_name    LIKE 'TSK\_%' ESCAPE '\'
    AND t.table_name    NOT LIKE 'TSK\_AUTH\_%' ESCAPE '\'
    AND t.table_name    NOT IN (
        'TSK_NAVIGATION',
        'TSK_ROLES',
        'TSK_USERS'
    );
--
COMMENT ON TABLE tsk_lov_app_tables_v IS '';

