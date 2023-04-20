CREATE TABLE tsk_tasks (
    task_id                         VARCHAR2(16)    CONSTRAINT nn_tsk_tasks_id NOT NULL,
    task_name                       VARCHAR2(128)   CONSTRAINT nn_tsk_tasks_name NOT NULL,
    task_desc                       VARCHAR2(4000),
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_tasks_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_tasks_project NOT NULL,
    board_id                        NUMBER(10,0)    CONSTRAINT nn_tsk_tasks_board NOT NULL,
    status_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_tasks_status NOT NULL,
    swimlane_id                     VARCHAR2(32)    CONSTRAINT nn_tsk_tasks_swimlane NOT NULL,
    order#                          NUMBER(10,0),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_tasks
        PRIMARY KEY (task_id),
    --
    CONSTRAINT fk_tsk_tasks_board
        FOREIGN KEY (board_id)
        REFERENCES tsk_boards (board_id),
    --
    CONSTRAINT fk_tsk_tasks_status
        FOREIGN KEY (client_id, project_id, status_id)
        REFERENCES tsk_statuses (client_id, project_id, status_id),
    --
    CONSTRAINT fk_tsk_tasks_swimlane
        FOREIGN KEY (client_id, project_id, swimlane_id)
        REFERENCES tsk_swimlanes (client_id, project_id, swimlane_id)
);
--
COMMENT ON TABLE tsk_tasks IS '';
--
COMMENT ON COLUMN tsk_tasks.task_id         IS '';
COMMENT ON COLUMN tsk_tasks.task_name       IS '';
COMMENT ON COLUMN tsk_tasks.task_desc       IS '';
COMMENT ON COLUMN tsk_tasks.client_id       IS '';
COMMENT ON COLUMN tsk_tasks.project_id      IS '';
COMMENT ON COLUMN tsk_tasks.board_id        IS '';
COMMENT ON COLUMN tsk_tasks.status_id       IS '';
COMMENT ON COLUMN tsk_tasks.swimlane_id     IS '';
COMMENT ON COLUMN tsk_tasks.order#          IS '';

