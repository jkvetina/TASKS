CREATE OR REPLACE FORCE VIEW tsk_p510_repositories_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id
        --core.get_item('$OWNER_ID')      AS owner_id,
        --core.get_item('$REPO_ID')       AS repo_id
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
    AND (x.project_id   = t.project_id  OR x.project_id IS NULL)
ORDER BY
    t.owner_id,
    t.repo_id,
    t.project_id;
--
COMMENT ON TABLE tsk_p510_repositories_v IS '';

