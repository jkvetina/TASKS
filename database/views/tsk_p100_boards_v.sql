CREATE OR REPLACE FORCE VIEW tsk_p100_boards_v AS
SELECT
    t.board_id,
    t.board_name,
    t.client_id,
    t.project_id,
    t.is_active,
    --
    core.get_page_url (
        in_page_id      => core.get_page_id(),
        in_app_id       => core.get_app_id(),
        in_names        => 'P0_CLIENT_ID,P0_PROJECT_ID,P0_BOARD_ID',
        in_values       => t.client_id || ',' || t.project_id || ',' || t.board_id,
        in_reset        => 'Y'
    ) AS activate_url
    --
FROM tsk_boards t;
--
COMMENT ON TABLE tsk_p100_boards_v IS '';

