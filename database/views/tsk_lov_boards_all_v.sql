CREATE OR REPLACE FORCE VIEW tsk_lov_boards_all_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id
    FROM DUAL
)
SELECT
    t.board_id,
    t.board_name,
    t.is_active,
    --
    ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.board_id) AS order#
    --
FROM tsk_boards t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id;
--
COMMENT ON TABLE tsk_lov_boards_all_v IS '';

