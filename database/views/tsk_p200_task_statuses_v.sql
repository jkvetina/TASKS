CREATE OR REPLACE FORCE VIEW tsk_p200_task_statuses_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id,
        core.get_item('P0_PROJECT_ID')  AS project_id
    FROM DUAL
)
SELECT
    t.client_id,
    t.project_id,
    t.status_id,
    t.status_name,
    t.order#,
    t.is_active
    --
FROM tsk_statuses t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id;
--
COMMENT ON TABLE tsk_p200_task_statuses_v IS '';

