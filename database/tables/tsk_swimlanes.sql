CREATE TABLE tsk_swimlanes (
    swimlane_id                     VARCHAR2(32)    CONSTRAINT nn_tsk_swimlanes_id NOT NULL,
    swimlane_name                   VARCHAR2(64)    CONSTRAINT nn_tsk_swimlanes_name NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_swimlanes_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_swimlanes_project NOT NULL,
    is_active                       CHAR(1),
    order#                          NUMBER(4,0),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_swimlanes
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_swimlanes
        PRIMARY KEY (client_id, project_id, swimlane_id),
    --
    CONSTRAINT fk_tsk_swimlanes_project
        FOREIGN KEY (client_id, project_id)
        REFERENCES tsk_projects (client_id, project_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_swimlanes IS '';
--
COMMENT ON COLUMN tsk_swimlanes.swimlane_id     IS '';
COMMENT ON COLUMN tsk_swimlanes.swimlane_name   IS '';
COMMENT ON COLUMN tsk_swimlanes.client_id       IS '';
COMMENT ON COLUMN tsk_swimlanes.project_id      IS '';
COMMENT ON COLUMN tsk_swimlanes.is_active       IS '';
COMMENT ON COLUMN tsk_swimlanes.order#          IS '';

