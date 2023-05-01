CREATE OR REPLACE FORCE VIEW tsk_p100_tasks_grid_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id,
        tsk_app.get_board_id()      AS board_id
    FROM DUAL
),
l AS (
    SELECT /*+ MATERIALIZE */
        l.task_id,
        NULLIF(SUM(CASE WHEN l.checklist_done = 'Y' THEN 1 ELSE 0 END) || '/' || COUNT(l.checklist_id), '0/0') AS task_progress
    FROM tsk_task_checklist l
    GROUP BY l.task_id
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
    l.task_progress,
    --
    t.client_id,
    t.project_id,
    t.board_id,
    --
    t.status_id,
    t.swimlane_id,
    t.category_id,
    t.owner_id,
    t.deadline_at,
    t.tags,
    g.color_bg,
    t.updated_by,
    t.updated_at,
    --
    LAG(t.task_id) OVER (
        PARTITION BY t.client_id, t.project_id, t.board_id
        ORDER BY w.order# NULLS LAST, s.order# NULLS LAST, t.order# NULLS LAST
    ) AS prev_task,
    --
    LEAD(t.task_id) OVER (
        PARTITION BY t.client_id, t.project_id, t.board_id
        ORDER BY w.order# NULLS LAST, s.order# NULLS LAST, t.order# NULLS LAST
    ) AS next_task,
    --
    w.order#            AS swimlane_order#,
    s.order#            AS status_order#,
    t.order#            AS task_order#,
    --
    ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.task_id) AS order#
    --
FROM tsk_tasks t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
    AND x.board_id      = t.board_id
JOIN tsk_statuses s
    ON s.status_id      = t.status_id
    AND s.client_id     = t.client_id
    AND s.project_id    = t.project_id
JOIN tsk_swimlanes w
    ON w.swimlane_id    = t.swimlane_id
    AND w.client_id     = t.client_id
    AND W.project_id    = t.project_id
LEFT JOIN tsk_categories g
    ON g.category_id    = t.category_id
    AND g.client_id     = t.client_id
    AND g.project_id    = t.project_id
    AND g.color_bg      IS NOT NULL
    AND g.is_active     = 'Y'
LEFT JOIN l
    ON l.task_id        = t.task_id;
--
COMMENT ON TABLE tsk_p100_tasks_grid_v IS '';

