CREATE OR REPLACE FORCE VIEW tsk_lov_repos_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id
    FROM DUAL
)
SELECT
    r.owner_id,
    r.repo_id
FROM tsk_repos r
JOIN tsk_lov_projects_v p   -- using tsk_auth_available_projects_v
    ON p.client_id          = r.client_id
    AND p.project_id        = r.project_id
JOIN x
    ON x.client_id          = r.client_id
    AND (x.project_id       = r.project_id  OR x.project_id IS NULL);
--
COMMENT ON TABLE tsk_lov_repos_v IS '';

