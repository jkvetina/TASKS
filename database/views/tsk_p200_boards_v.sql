CREATE OR REPLACE FORCE VIEW tsk_p200_boards_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id,
        tsk_app.get_board_id()      AS board_id,
        core.get_user_id()          AS user_id
    FROM DUAL
),
s AS (
    SELECT /*+ MATERIALIZE */
        t.client_id,
        t.project_id,
        t.board_id,
        s.status_id,
        s.status_name,
        s.is_active,
        --
        ROW_NUMBER() OVER (PARTITION BY s.is_active ORDER BY s.order# NULLS LAST, s.status_id) AS r#,
        --
        COUNT(t.task_id)    AS count_tasks
        --
    FROM tsk_tasks t
    JOIN tsk_statuses s
        ON s.client_id      = t.client_id
        AND s.project_id    = t.project_id
        AND s.status_id     = t.status_id
    JOIN x
        ON x.client_id      = s.client_id
        AND x.project_id    = s.project_id
    GROUP BY
        t.client_id,
        t.project_id,
        t.board_id,
        s.status_id,
        s.status_name,
        s.is_active,
        s.order#
),
g AS (
    SELECT /*+ MATERIALIZE */
        s.client_id,
        s.project_id,
        s.board_id,
        --
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 1 THEN s.count_tasks END) AS count_status_1,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 2 THEN s.count_tasks END) AS count_status_2,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 3 THEN s.count_tasks END) AS count_status_3,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 4 THEN s.count_tasks END) AS count_status_4,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 5 THEN s.count_tasks END) AS count_status_5,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 6 THEN s.count_tasks END) AS count_status_6,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 7 THEN s.count_tasks END) AS count_status_7,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 8 THEN s.count_tasks END) AS count_status_8,
        --
        SUM(CASE WHEN s.is_active IS NULL THEN s.count_tasks END) AS count_inactive,
        SUM(s.count_tasks) AS count_total,
        --
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 1 THEN s.status_name END) AS status_name_1,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 2 THEN s.status_name END) AS status_name_2,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 3 THEN s.status_name END) AS status_name_3,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 4 THEN s.status_name END) AS status_name_4,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 5 THEN s.status_name END) AS status_name_5,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 6 THEN s.status_name END) AS status_name_6,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 7 THEN s.status_name END) AS status_name_7,
        MAX(CASE WHEN s.is_active = 'Y' AND s.r# = 8 THEN s.status_name END) AS status_name_8
        --
    FROM s
    GROUP BY
        s.client_id,
        s.project_id,
        s.board_id
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
                in_page_id      => 100,
                in_app_id       => core.get_app_id(),
                in_names        => 'P100_CLIENT_ID,P100_PROJECT_ID,P100_BOARD_ID',
                in_values       => t.client_id || ',' || t.project_id || ',' || t.board_id
            ) || '">SET</a>'
        END AS is_current,
    --
    CASE WHEN f.board_id IS NOT NULL THEN 'Y' END AS is_favorite,
    --
    t.is_active,
    t.order#,
    --
    '<a href="' ||
        core.get_page_url (
            in_page_id      => 205,
            in_names        => 'P205_BOARD_ID',
            in_values       => t.board_id,
            in_reset        => 'Y'
        ) || '"><span class="fa fa-edit"></span></a>' AS edit_button,
    --
    g.count_status_1,
    g.count_status_2,
    g.count_status_3,
    g.count_status_4,
    g.count_status_5,
    g.count_status_6,
    g.count_status_7,
    g.count_status_8,
    g.count_inactive,
    g.count_total,
    --
    MAX(g.status_name_1) OVER() AS status_name_1,
    MAX(g.status_name_2) OVER() AS status_name_2,
    MAX(g.status_name_3) OVER() AS status_name_3,
    MAX(g.status_name_4) OVER() AS status_name_4,
    MAX(g.status_name_5) OVER() AS status_name_5,
    MAX(g.status_name_6) OVER() AS status_name_6,
    MAX(g.status_name_7) OVER() AS status_name_7,
    MAX(g.status_name_8) OVER() AS status_name_8
    --
FROM tsk_boards t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
LEFT JOIN g
    ON g.client_id      = t.client_id
    AND g.project_id    = t.project_id
    AND g.board_id      = t.board_id
LEFT JOIN tsk_user_fav_boards f
    ON f.user_id        = x.user_id
    AND f.board_id      = t.board_id;
--
COMMENT ON TABLE tsk_p200_boards_v IS '';

