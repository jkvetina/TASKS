CREATE TABLE tsk_task_swimlanes (
    swimlane_id                     VARCHAR2(32)    CONSTRAINT nn_tsk_swimlanes_id NOT NULL,
    swimlane_name                   VARCHAR2(64)    CONSTRAINT nn_tsk_swimlanes_name NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_swimlanes_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_swimlanes_project NOT NULL,
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    order#                          NUMBER(4,0),
    --
    CONSTRAINT pk_tsk_swimlanes
        PRIMARY KEY (client_id, project_id, swimlane_id),
    --
    CONSTRAINT uq_tsk_swimlanes
        UNIQUE (client_id, project_id, swimlane_name),
    --
    CONSTRAINT ch_tsk_swimlanes
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT fk_tsk_swimlanes_project
        FOREIGN KEY (client_id, project_id)
        REFERENCES tsk_projects (client_id, project_id)
);
--
COMMENT ON TABLE tsk_task_swimlanes IS '';
--
COMMENT ON COLUMN tsk_task_swimlanes.swimlane_id        IS '';
COMMENT ON COLUMN tsk_task_swimlanes.swimlane_name      IS '';
COMMENT ON COLUMN tsk_task_swimlanes.client_id          IS '';
COMMENT ON COLUMN tsk_task_swimlanes.project_id         IS '';
COMMENT ON COLUMN tsk_task_swimlanes.is_active          IS '';
COMMENT ON COLUMN tsk_task_swimlanes.order#             IS '';

