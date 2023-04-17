CREATE TABLE tsk_task_commits (
    task_id                         NUMBER(10,0)    CONSTRAINT nn_tsk_task_commits_task NOT NULL,
    commit_id                       VARCHAR2(64)    CONSTRAINT nn_tsk_task_commits_commit NOT NULL,
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_task_commits
        PRIMARY KEY (task_id, commit_id),
    --
    CONSTRAINT fk_tsk_task_commits_task
        FOREIGN KEY (task_id)
        REFERENCES tsk_tasks (task_id),
    --
    CONSTRAINT fk_tsk_task_commits_commit
        FOREIGN KEY (commit_id)
        REFERENCES tsk_commits (commit_id)
);
--
COMMENT ON TABLE tsk_task_commits IS '';
--
COMMENT ON COLUMN tsk_task_commits.task_id      IS '';
COMMENT ON COLUMN tsk_task_commits.commit_id    IS '';

