CREATE OR REPLACE FORCE VIEW tsk_p200_boards_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')           AS client_id,
        core.get_item('P0_PROJECT_ID')          AS project_id,
        core.get_number_item('P0_BOARD_ID')     AS board_id,
        core.get_user_id()                      AS user_id
    FROM DUAL
),
s AS (
    SELECT /*+ MATERIALIZE */
        t.client_id,
        t.project_id,
        t.board_id,
        --
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 1 THEN 1 ELSE 0 END) AS count_status_1,
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 2 THEN 1 ELSE 0 END) AS count_status_2,
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 3 THEN 1 ELSE 0 END) AS count_status_3,
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 4 THEN 1 ELSE 0 END) AS count_status_4,
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 5 THEN 1 ELSE 0 END) AS count_status_5,
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 6 THEN 1 ELSE 0 END) AS count_status_6,
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 7 THEN 1 ELSE 0 END) AS count_status_7,
        SUM(CASE WHEN t.status_id = f.status_id AND f.r# = 8 THEN 1 ELSE 0 END) AS count_status_8,
        --
        COUNT(t.task_id)    AS count_tasks
        --
    FROM tsk_tasks t
    JOIN tsk_lov_statuses_all_v s
        ON s.status_id      = t.status_id
    LEFT JOIN tsk_p200_boards_first8_v f
        ON f.status_id      = t.status_id
    GROUP BY
        t.client_id,
        t.project_id,
        t.board_id
)
SELECT
    t.client_id,
    t.project_id,
    t.board_id,
    t.board_name,
    --
    CASE WHEN t.board_id = x.board_id
        THEN '<span class="fa fa-check-square"></span>'
        ELSE '<a href="' ||
            core.get_page_url (
                in_page_id      => core.get_page_id(),
                in_app_id       => core.get_app_id(),
                in_names        => 'P0_CLIENT_ID,P0_PROJECT_ID,P0_BOARD_ID',
                in_values       => t.client_id || ',' || t.project_id || ',' || t.board_id,
                in_reset        => 'Y'
            ) || '">SET</a>'
        END AS is_current,
    --
    CASE WHEN f.board_id IS NOT NULL THEN 'Y' END AS is_favorite,
    --
    t.is_active,
    --
    '<a href="' ||
        core.get_page_url (
            in_page_id      => 205,
            in_names        => 'P205_BOARD_ID',
            in_values       => t.board_id,
            in_reset        => 'Y'
        ) || '"><span class="fa fa-edit"></span></a>' AS edit_button,
    --
    s.count_status_1,
    s.count_status_2,
    s.count_status_3,
    s.count_status_4,
    s.count_status_5,
    s.count_status_6,
    s.count_status_7,
    s.count_status_8,
    s.count_tasks
    --
FROM tsk_boards t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
LEFT JOIN s
    ON s.client_id      = t.client_id
    AND s.project_id    = t.project_id
    AND s.board_id      = t.board_id
LEFT JOIN tsk_user_fav_boards f
    ON f.user_id        = x.user_id
    AND f.board_id      = t.board_id;
--
COMMENT ON TABLE tsk_p200_boards_v IS '';

