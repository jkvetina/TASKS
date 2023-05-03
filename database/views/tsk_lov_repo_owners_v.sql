CREATE OR REPLACE FORCE VIEW tsk_lov_repo_owners_v AS
SELECT
    r.owner_id
FROM tsk_lov_repos_v r
GROUP BY
    r.owner_id;
--
COMMENT ON TABLE tsk_lov_repo_owners_v IS '';

