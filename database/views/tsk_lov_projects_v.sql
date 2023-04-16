CREATE OR REPLACE FORCE VIEW tsk_lov_projects_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id
    FROM DUAL
)
SELECT
    t.project_id,
    t.project_name
FROM tsk_projects t
JOIN x
    ON x.client_id      = t.client_id
WHERE t.is_active       = 'Y'
ORDER BY t.project_name, t.project_id;
--
COMMENT ON TABLE tsk_lov_projects_v IS '';

