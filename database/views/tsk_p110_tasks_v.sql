CREATE OR REPLACE FORCE VIEW tsk_p110_tasks_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P110_SOURCE_CLIENT')     AS client_id,
        core.get_item('P110_SOURCE_PROJECT')    AS project_id,
        core.get_item('P110_SOURCE_BOARD')      AS board_id,
        core.get_item('P110_SOURCE_STATUS')     AS status_id,
        core.get_item('P110_SOURCE_SWIMLANE')   AS swimlane_id
    FROM DUAL
)
SELECT
    t.task_id,
    --
    '<a href="' || APEX_PAGE.GET_URL (
        p_page          => 105,
        p_clear_cache   => 105,
        p_items         => 'P105_TASK_ID,P105_SOURCE_PAGE',
        p_values        => '' || t.task_id || ',110'
    ) || '">#' ||
    t.task_id || '</a> ' || t.task_name AS task_name,
    --
    APEX_PAGE.GET_URL (
        p_page          => 105,
        p_clear_cache   => 105,
        p_items         => 'P105_TASK_ID,P105_SOURCE_PAGE',
        p_values        => '' || t.task_id || ',110'
    ) AS task_link,
    --
    'Y' AS task_selected
    --
FROM tsk_tasks t
CROSS JOIN x
LEFT JOIN tsk_task_checklist l
    ON l.task_id        = t.task_id
WHERE t.client_id       = x.client_id
    AND t.project_id    = x.project_id
    AND t.board_id      = x.board_id
    AND t.status_id     = x.status_id
    AND t.swimlane_id   = x.swimlane_id
GROUP BY
    t.task_id,
    t.task_name,
    t.order#
ORDER BY
    t.order# NULLS LAST,
    t.task_id;
--
COMMENT ON TABLE tsk_p110_tasks_v IS '';

