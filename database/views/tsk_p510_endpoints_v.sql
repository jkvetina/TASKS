CREATE OR REPLACE FORCE VIEW tsk_p510_endpoints_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id
    FROM DUAL
)
SELECT
    t.repo_id,
    t.owner_id,
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
    --AND x.project_id    = r.project_id
ORDER BY
    t.repo_id,
    t.owner_id,
    t.endpoint_id;
--
COMMENT ON TABLE tsk_p510_endpoints_v IS '';

