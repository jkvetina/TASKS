CREATE OR REPLACE FORCE VIEW tsk_p300_repositories_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id,
        core.get_item('P0_PROJECT_ID')  AS project_id
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
FROM tsk_commit_repos t
JOIN x
    ON x.client_id      = t.client_id
    --AND x.project_id    = t.project_id
ORDER BY
    t.owner_id,
    t.project_id;
--
COMMENT ON TABLE tsk_p300_repositories_v IS '';

