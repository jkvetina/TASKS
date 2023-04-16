CREATE OR REPLACE FORCE VIEW tsk_lov_projects_all_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id
    FROM DUAL
)
SELECT
    t.project_id,
    t.project_name,
    t.is_active
FROM tsk_projects t
JOIN x
    ON x.client_id      = t.client_id
ORDER BY
    t.project_name,
    t.project_id;
--
COMMENT ON TABLE tsk_lov_projects_all_v IS '';

