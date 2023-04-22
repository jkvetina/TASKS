CREATE TABLE tsk_task_files (
    task_id                         VARCHAR2(16)    CONSTRAINT nn_tsk_task_files_task NOT NULL,
    file_id                         NUMBER(10,0)    CONSTRAINT nn_tsk_task_files_id NOT NULL,
    file_name                       VARCHAR2(256)   CONSTRAINT nn_tsk_task_files_name NOT NULL,
    file_mime                       VARCHAR2(256)   CONSTRAINT nn_tsk_task_files_mime NOT NULL,
    file_size                       NUMBER          CONSTRAINT nn_tsk_task_files_len NOT NULL,
    file_payload                    BLOB,
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_task_files
        PRIMARY KEY (file_id),
    --
    CONSTRAINT uq_tsk_task_files
        UNIQUE (task_id, file_id),
    --
    CONSTRAINT uq_tsk_task_files_name
        UNIQUE (task_id, file_name),
    --
    CONSTRAINT fk_tsk_task_files_task
        FOREIGN KEY (task_id)
        REFERENCES tsk_tasks (task_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_task_files IS '';
--
COMMENT ON COLUMN tsk_task_files.task_id        IS '';
COMMENT ON COLUMN tsk_task_files.file_id        IS '';
COMMENT ON COLUMN tsk_task_files.file_name      IS '';
COMMENT ON COLUMN tsk_task_files.file_mime      IS '';
COMMENT ON COLUMN tsk_task_files.file_size      IS '';
COMMENT ON COLUMN tsk_task_files.file_payload   IS '';

