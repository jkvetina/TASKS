CREATE TABLE tsk_commits (
    commit_id                       VARCHAR2(64)    CONSTRAINT nn_tsk_commits_id NOT NULL,
    commit_message                  VARCHAR2(2000),
    commit_url                      VARCHAR2(512),
    repo_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_commits_repo NOT NULL,
    owner_id                        VARCHAR2(64)    CONSTRAINT nn_tsk_commits_owner NOT NULL,
    created_by                      VARCHAR2(128),
    created_at                      DATE,
    --
    CONSTRAINT pk_tsk_commits
        PRIMARY KEY (commit_id),
    --
    CONSTRAINT fk_tsk_commits_repo
        FOREIGN KEY (repo_id, owner_id)
        REFERENCES tsk_repos (repo_id, owner_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_commits IS '';
--
COMMENT ON COLUMN tsk_commits.commit_id         IS '';
COMMENT ON COLUMN tsk_commits.commit_message    IS '';
COMMENT ON COLUMN tsk_commits.commit_url        IS '';
COMMENT ON COLUMN tsk_commits.repo_id           IS '';
COMMENT ON COLUMN tsk_commits.owner_id          IS '';

