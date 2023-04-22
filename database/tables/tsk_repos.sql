CREATE TABLE tsk_repos (
    repo_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_repos_repo NOT NULL,
    owner_id                        VARCHAR2(64)    CONSTRAINT nn_tsk_repos_owner NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_repos_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_repos_project NOT NULL,
    branch_id                       VARCHAR2(128),
    api_type                        VARCHAR2(16)    CONSTRAINT nn_tsk_repos_api_type NOT NULL,
    api_token                       VARCHAR2(128)   CONSTRAINT nn_tsk_repos_api_token NOT NULL,
    last_synced_at                  DATE,
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_repos
        PRIMARY KEY (repo_id, owner_id),
    --
    CONSTRAINT fk_tsk_repos_project
        FOREIGN KEY (client_id, project_id)
        REFERENCES tsk_projects (client_id, project_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_repos IS '';
--
COMMENT ON COLUMN tsk_repos.repo_id             IS '';
COMMENT ON COLUMN tsk_repos.owner_id            IS '';
COMMENT ON COLUMN tsk_repos.client_id           IS '';
COMMENT ON COLUMN tsk_repos.project_id          IS '';
COMMENT ON COLUMN tsk_repos.branch_id           IS '';
COMMENT ON COLUMN tsk_repos.api_type            IS '';
COMMENT ON COLUMN tsk_repos.api_token           IS '';
COMMENT ON COLUMN tsk_repos.last_synced_at      IS '';

