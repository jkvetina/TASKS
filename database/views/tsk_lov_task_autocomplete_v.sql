CREATE OR REPLACE FORCE VIEW tsk_lov_task_autocomplete_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id,
        core.get_item('$BOARD_ID')      AS board_id
    FROM DUAL
)
SELECT
    t.task_id,
    '#' || t.task_id || ' - ' || t.task_name AS task_name
FROM tsk_tasks t
JOIN tsk_lov_boards_v p
    ON p.client_id      = t.client_id
    AND p.project_id    = t.project_id
    AND p.board_id      = t.board_id
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
    AND x.board_id      = t.board_id;
--
COMMENT ON TABLE tsk_lov_task_autocomplete_v IS '';

