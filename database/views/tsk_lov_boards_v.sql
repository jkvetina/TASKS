CREATE OR REPLACE FORCE VIEW tsk_lov_boards_v AS
SELECT
    p.client_id,
    p.client_name,
    p.project_id,
    p.project_name,
    t.board_id,
    t.board_name,
    --
    p.client_r#,
    p.project_r#,
    ROW_NUMBER() OVER (ORDER BY t.order#, t.board_id) AS board_r#
    --
FROM tsk_boards t
JOIN tsk_lov_projects_v p   -- using tsk_auth_available_projects_v
    ON p.client_id          = t.client_id
    AND p.project_id        = t.project_id
WHERE t.is_active           = 'Y'
    AND p.is_page_client    = 'Y'
    AND p.is_page_project   = 'Y';
--
COMMENT ON TABLE tsk_lov_boards_v IS '';

