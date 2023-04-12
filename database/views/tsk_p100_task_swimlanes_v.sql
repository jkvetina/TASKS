CREATE OR REPLACE FORCE VIEW tsk_p100_task_swimlanes_v AS
SELECT
    t.client_id,
    t.project_id,
    t.swimlane_id,
    t.swimlane_name,
    t.order#,
    t.is_active
    --
FROM tsk_task_swimlanes t;
--
COMMENT ON TABLE tsk_p100_task_swimlanes_v IS '';

