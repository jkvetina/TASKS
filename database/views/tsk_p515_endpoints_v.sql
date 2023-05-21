CREATE OR REPLACE FORCE VIEW tsk_p515_endpoints_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id,
        core.get_item('$OWNER_ID')      AS owner_id,
        core.get_item('$REPO_ID')       AS repo_id
    FROM DUAL
)
SELECT
    t.repo_id           AS old_repo_id,
    t.owner_id          AS old_owner_id,
    --
    r.client_id,
    r.project_id,
    t.owner_id,
    t.repo_id,
    t.endpoint_id,
    t.endpoint_url,
    t.endpoint_body,
    t.endpoint_method
FROM tsk_repo_endpoints t
JOIN tsk_repos r
    ON r.repo_id        = t.repo_id
    AND r.owner_id      = t.owner_id
JOIN x
    ON x.client_id      = r.client_id
    AND (x.project_id   = r.project_id  OR x.project_id IS NULL)
    AND (x.owner_id     = r.owner_id    OR x.owner_id IS NULL)
    AND (x.repo_id      = r.repo_id     OR x.repo_id IS NULL)
ORDER BY
    r.client_id,
    r.project_id,
    t.owner_id,
    t.repo_id,
    t.endpoint_id;
--
COMMENT ON TABLE tsk_p515_endpoints_v IS '';

