CREATE OR REPLACE FORCE VIEW tsk_lov_boards_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id
    FROM DUAL
)
SELECT
    t.board_id,
    t.board_name
FROM tsk_boards t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
WHERE t.is_active       = 'Y'
ORDER BY
    t.board_name,
    t.board_id;
--
COMMENT ON TABLE tsk_lov_boards_v IS '';

