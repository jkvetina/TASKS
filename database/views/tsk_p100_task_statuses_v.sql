CREATE OR REPLACE FORCE VIEW tsk_p100_task_statuses_v AS
SELECT
    t.client_id,
    t.project_id,
    t.status_id,
    t.status_name,
    t.order#,
    t.is_active
    --
FROM tsk_task_statuses t;
--
COMMENT ON TABLE tsk_p100_task_statuses_v IS '';

