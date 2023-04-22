CREATE OR REPLACE FORCE VIEW tsk_p510_repositories_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id
    FROM DUAL
)
SELECT
    t.client_id,
    t.project_id,
    t.repo_id,
    t.owner_id,
    t.branch_id,
    t.api_type,
    t.api_token,
    t.last_synced_at
FROM tsk_repos t
JOIN x
    ON x.client_id      = t.client_id
    --AND x.project_id    = t.project_id
ORDER BY
    t.owner_id,
    t.project_id,
    t.repo_id;
--
COMMENT ON TABLE tsk_p510_repositories_v IS '';

