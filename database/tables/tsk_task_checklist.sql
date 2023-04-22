CREATE TABLE tsk_task_checklist (
    checklist_id                    NUMBER(10,0)    CONSTRAINT nn_tsk_checklist_item_id NOT NULL,
    checklist_item                  VARCHAR2(256)   CONSTRAINT nn_tsk_checklist_item NOT NULL,
    checklist_done                  CHAR(1),
    task_id                         VARCHAR2(16)    CONSTRAINT nn_tsk_checklist_task_id NOT NULL,
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_checklist_done
        CHECK (checklist_done = 'Y' OR checklist_done IS NULL),
    --
    CONSTRAINT pk_tsk_checklist
        PRIMARY KEY (checklist_id),
    --
    CONSTRAINT fk_tsk_checklist_task
        FOREIGN KEY (task_id)
        REFERENCES tsk_tasks (task_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_task_checklist IS '';
--
COMMENT ON COLUMN tsk_task_checklist.checklist_id       IS '';
COMMENT ON COLUMN tsk_task_checklist.checklist_item     IS '';
COMMENT ON COLUMN tsk_task_checklist.checklist_done     IS '';
COMMENT ON COLUMN tsk_task_checklist.task_id            IS '';

