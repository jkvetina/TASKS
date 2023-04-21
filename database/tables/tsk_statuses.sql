CREATE TABLE tsk_statuses (
    status_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_status_id NOT NULL,
    status_name                     VARCHAR2(64)    CONSTRAINT nn_tsk_status_name NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_status_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_status_project NOT NULL,
    is_active                       CHAR(1),
    is_default                      CHAR(1),
    is_with_name                    CHAR(1),
    order#                          NUMBER(4,0),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_statuses
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT ch_tsk_statuses_default
        CHECK (is_default = 'Y' OR is_default IS NULL),
    --
    CONSTRAINT ch_tsk_statuses_name
        CHECK (is_with_name = 'Y' OR is_with_name IS NULL),
    --
    CONSTRAINT pk_tsk_status
        PRIMARY KEY (client_id, project_id, status_id),
    --
    CONSTRAINT fk_tsk_status_project
        FOREIGN KEY (client_id, project_id)
        REFERENCES tsk_projects (client_id, project_id)
);
--
COMMENT ON TABLE tsk_statuses IS '';
--
COMMENT ON COLUMN tsk_statuses.status_id        IS '';
COMMENT ON COLUMN tsk_statuses.status_name      IS '';
COMMENT ON COLUMN tsk_statuses.client_id        IS '';
COMMENT ON COLUMN tsk_statuses.project_id       IS '';
COMMENT ON COLUMN tsk_statuses.is_active        IS '';
COMMENT ON COLUMN tsk_statuses.order#           IS '';

