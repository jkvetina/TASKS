CREATE TABLE tsk_task_comments (
    task_id                         VARCHAR2(16)    CONSTRAINT nn_tsk_comments_task_id NOT NULL,
    comment_id                      NUMBER(10,0)    CONSTRAINT nn_tsk_comments_id NOT NULL,
    comment_payload                 VARCHAR2(4000),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_comments
        PRIMARY KEY (task_id, comment_id),
    --
    CONSTRAINT fk_tsk_comments_task
        FOREIGN KEY (task_id)
        REFERENCES tsk_tasks (task_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_task_comments IS '';
--
COMMENT ON COLUMN tsk_task_comments.task_id             IS '';
COMMENT ON COLUMN tsk_task_comments.comment_id          IS '';
COMMENT ON COLUMN tsk_task_comments.comment_payload     IS '';

