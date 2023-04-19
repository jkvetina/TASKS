CREATE OR REPLACE FORCE VIEW tsk_p200_boards_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')           AS client_id,
        core.get_item('P0_PROJECT_ID')          AS project_id,
        core.get_number_item('P0_BOARD_ID')     AS board_id
    FROM DUAL
)
SELECT
    t.client_id,
    t.project_id,
    t.board_id,
    t.board_name,
    --
    CASE WHEN t.board_id = x.board_id THEN 'Y' END AS is_current,
    t.is_active,
    --
    'EDIT'              AS edit_action,
    'ACTIVATE'          AS activate_action,
    --
    core.get_page_url (
        in_page_id      => core.get_page_id(),
        in_app_id       => core.get_app_id(),
        in_names        => 'P0_CLIENT_ID,P0_PROJECT_ID,P0_BOARD_ID',
        in_values       => t.client_id || ',' || t.project_id || ',' || t.board_id,
        in_reset        => 'Y'
    ) AS activate_url
    --
FROM tsk_boards t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id;
--
COMMENT ON TABLE tsk_p200_boards_v IS '';

