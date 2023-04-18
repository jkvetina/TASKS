CREATE OR REPLACE FORCE VIEW tsk_p100_tasks_grid_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')           AS client_id,
        core.get_item('P0_PROJECT_ID')          AS project_id,
        core.get_number_item('P0_BOARD_ID')     AS board_id
    FROM DUAL
)
SELECT
    t.task_id,
    t.task_name,
    --
    APEX_PAGE.GET_URL (
        p_page          => 105,
        p_clear_cache   => 105,
        p_items         => 'P105_TASK_ID,P105_SOURCE_PAGE',
        p_values        => '' || t.task_id || ',100'
    ) AS task_link,
    --
    NULLIF(SUM(CASE WHEN l.checklist_done = 'Y' THEN 1 ELSE 0 END) || '/' || COUNT(l.checklist_id), '0/0') AS task_progress,
    --
    t.status_id,
    t.swimlane_id,
    w.order#            AS swimlane_order#,
    s.order#            AS status_order#,
    t.order#            AS task_order#
    --
FROM tsk_tasks t
CROSS JOIN x
JOIN tsk_statuses s
    ON s.status_id      = t.status_id
JOIN tsk_swimlanes w
    ON w.swimlane_id    = t.swimlane_id
LEFT JOIN tsk_task_checklist l
    ON l.task_id        = t.task_id
WHERE t.client_id       = x.client_id
    AND t.project_id    = x.project_id
    AND t.board_id      = x.board_id
    --AND t.swimlane_id   = w.swimlane_id
GROUP BY
    t.task_id,
    t.task_name,
    t.status_id,
    t.swimlane_id,
    w.order#,
    s.order#,
    t.order#;
--
COMMENT ON TABLE tsk_p100_tasks_grid_v IS '';

