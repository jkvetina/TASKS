CREATE TABLE tsk_repo_endpoints (
    repo_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_repo_endpoint_repo NOT NULL,
    owner_id                        VARCHAR2(64)    CONSTRAINT nn_tsk_repo_endpoint_owner NOT NULL,
    endpoint_id                     VARCHAR2(32)    CONSTRAINT nn_tsk_repo_endpoint_id NOT NULL,
    endpoint_url                    VARCHAR2(256),
    endpoint_body                   VARCHAR2(2000),
    endpoint_method                 VARCHAR2(8),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_repo_endpoint
        PRIMARY KEY (repo_id, owner_id),
    --
    CONSTRAINT fk_tsk_repo_endpoint_repos
        FOREIGN KEY (repo_id, owner_id)
        REFERENCES tsk_repos (repo_id, owner_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_repo_endpoints IS '';
--
COMMENT ON COLUMN tsk_repo_endpoints.repo_id            IS '';
COMMENT ON COLUMN tsk_repo_endpoints.owner_id           IS '';
COMMENT ON COLUMN tsk_repo_endpoints.endpoint_id        IS '';
COMMENT ON COLUMN tsk_repo_endpoints.endpoint_url       IS '';
COMMENT ON COLUMN tsk_repo_endpoints.endpoint_body      IS '';
COMMENT ON COLUMN tsk_repo_endpoints.endpoint_method    IS '';

