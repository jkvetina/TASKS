CREATE OR REPLACE FORCE VIEW tsk_lov_repo_owners_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id
    FROM DUAL
)
SELECT
    r.owner_id
FROM tsk_repos r
JOIN x
    ON (x.client_id     = r.client_id   OR x.client_id IS NULL)
    AND (x.project_id   = r.project_id  OR x.project_id IS NULL);
--
COMMENT ON TABLE tsk_lov_repo_owners_v IS '';

