CREATE OR REPLACE FORCE VIEW tsk_auth_available_boards_v AS
SELECT
    p.client_id,
    p.project_id,
    b.board_id,
    b.board_name
FROM tsk_auth_available_projects_v p
JOIN tsk_boards b
    ON b.client_id      = p.client_id
    AND b.project_id    = p.project_id
    AND b.is_active     = 'Y'
GROUP BY
    p.client_id,
    p.project_id,
    b.board_id,
    b.board_name;
--
COMMENT ON TABLE tsk_auth_available_boards_v IS '';

