CREATE TABLE tsk_projects (
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_project_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_project_id NOT NULL,
    project_name                    VARCHAR2(64)    CONSTRAINT nn_tsk_project_name NOT NULL,
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_projects
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_projects
        PRIMARY KEY (client_id, project_id),
    --
    CONSTRAINT fk_tsk_projects_client
        FOREIGN KEY (client_id)
        REFERENCES tsk_clients (client_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_projects IS '';
--
COMMENT ON COLUMN tsk_projects.client_id        IS '';
COMMENT ON COLUMN tsk_projects.project_id       IS '';
COMMENT ON COLUMN tsk_projects.project_name     IS '';
COMMENT ON COLUMN tsk_projects.is_active        IS '';

