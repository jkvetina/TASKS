CREATE OR REPLACE FORCE VIEW tsk_navigation_top_v AS
WITH curr AS (
    -- current context
    SELECT /*+ MATERIALIZE */
        core.get_app_id()               AS app_id,
        n.page_id,
        n.parent_id,
        core.get_page_group(n.page_id)  AS page_group,
        u.user_id,
        u.user_name,
        tsk_app.get_client_id()         AS client_id,
        tsk_app.get_project_id()        AS project_id,
        tsk_app.get_swimlane_id()       AS swimlane_id
    FROM tsk_navigation n
    LEFT JOIN tsk_users u
        ON u.user_id        = core.get_user_id()
        AND u.is_active     = 'Y'
    WHERE n.page_id         = core.get_page_id()
),
t AS (
    -- available pages
    SELECT /*+ MATERIALIZE */
        curr.app_id     AS app_id,
        curr.app_id     AS curr_app_id,
        curr.user_name  AS user_name,
        --
        n.page_id,
        n.parent_id,
        --
        s.page_alias,
        s.page_name,        -- core.get_page_name(t.page_id)    -- #icons
        s.auth_scheme,
        n.is_reset,
        n.order#
    FROM tsk_navigation n
    CROSS JOIN curr
    JOIN tsk_navigation_map_mv s
        ON s.app_id         = curr.app_id
        AND s.page_id       = n.page_id
        AND n.is_hidden     IS NULL
    WHERE
        'Y' = tsk_auth.is_page_available (
            in_user_id          => curr.user_id,
            in_page_id          => s.page_id,
            in_client_id        => curr.client_id,
            in_project_id       => curr.project_id,
            in_auth_scheme      => s.auth_scheme,
            in_procedure_name   => s.procedure_name
        )
    --
    UNION ALL
    SELECT              -- append launchpad icon/link
        700             AS app_id,
        curr.app_id     AS curr_app_id,
        curr.user_name  AS user_name,
        --
        100             AS page_id,
        NULL            AS parent_id,
        'HOME'          AS page_alias,
        --
        '<span class="fa fa-navicon"></span>' AS page_name,
        --
        NULL            AS auth_scheme,
        'Y'             AS is_reset,
        -1000           AS order#
    FROM curr
),
n AS (
    -- build the tree
    SELECT /*+ MATERIALIZE */
        CASE WHEN t.parent_id IS NULL THEN 1 ELSE 2 END AS lvl,
        --
        CASE
            WHEN t.page_id = 9999   THEN 'Logout'
            WHEN t.page_id = 0      THEN '</li></ul><ul class="empty"></ul><ul><li>'
            ELSE REPLACE(t.page_name, '&' || 'APP_USER.', t.user_name)
            END AS label,
        CASE
            WHEN t.page_id = 9999   THEN '&' || 'LOGOUT_URL.'
            WHEN t.page_id > 0      THEN
                APEX_PAGE.GET_URL (
                    p_application   => t.app_id,
                    p_page          => NVL(t.page_alias, t.page_id),
                    p_clear_cache   => CASE WHEN t.is_reset = 'Y' THEN t.page_id END
                )
            END AS target,
        --
        CASE
            WHEN t.app_id = t.curr_app_id AND t.page_id = (SELECT page_id   FROM curr)  THEN 'YES'
            WHEN t.app_id = t.curr_app_id AND t.page_id = (SELECT parent_id FROM curr)  THEN 'YES'
            END AS is_current_list_entry,
        --
        NULL                    AS image,
        NULL                    AS image_attribute,
        NULL                    AS image_alt_attribute,
        --
        CASE
            WHEN t.page_id = 900 THEN 'RIGHT'
            END AS attribute01,
        --
        NULL                    AS attribute02,             -- li.class
        --
        CASE
            WHEN t.page_id = 0  THEN '" style="display: none;'
            END AS attribute03,     -- a.class
        --
        NULL                    AS attribute04,
        NULL                    AS attribute05,
        NULL                    AS attribute06,
        NULL                    AS attribute07,
        NULL                    AS attribute08,
        NULL                    AS attribute09,
        NULL                    AS attribute10,
        --
        t.page_id,
        t.parent_id,
        t.auth_scheme,
        --
        SYS_CONNECT_BY_PATH(t.order# || '.' || t.page_id, '/') AS order#,
        --
        REPLACE(RPAD(' ', (LEVEL - 1) * 4, ' '), ' ', '&' || 'nbsp; ') || t.page_name AS label__
    FROM t
    CONNECT BY t.app_id         = PRIOR t.app_id
        AND t.parent_id         = PRIOR t.page_id
    START WITH t.parent_id      IS NULL
    ORDER SIBLINGS BY t.order# NULLS LAST, t.page_id
)
SELECT
    n.lvl,
    n.label,
    n.target,
    n.is_current_list_entry,
    n.image,
    n.image_attribute,
    n.image_alt_attribute,
    n.attribute01,          -- <li class="...">
    n.attribute02,          -- <li>...<a>
    n.attribute03,          -- <a class="..."
    n.attribute04,          -- <a title="..."
    n.attribute05,          -- <a ...> // javascript onclick
    n.attribute06,          -- <a>... #TEXT</a>
    n.attribute07,          -- <a>#TEXT ...</a>
    n.attribute08,          -- </a>...
    n.attribute09,
    n.attribute10,
    n.page_id,
    n.parent_id,
    n.auth_scheme,
    n.label__,
    n.order#
FROM n
UNION ALL
--
SELECT                      -- append favorite boards
    2 AS lvl,
    p.project_name || ' - ' || b.board_name AS label,
    --
    APEX_PAGE.GET_URL (
        p_application       => curr.app_id,
        p_page              => 100,--curr.page_id,
        p_clear_cache       => 100,
        p_items             => 'P100_CLIENT_ID,P100_PROJECT_ID,P100_BOARD_ID,P100_SWIMLANE_ID',
        p_values            => '' || b.client_id || ',' || b.project_id || ',' || b.board_id || ',' || curr.swimlane_id
    ) AS target,
    --
    NULL AS is_current_list_entry,
    NULL AS image,
    NULL AS image_attribute,
    NULL AS image_alt_attribute,
    NULL AS attribute01,
    NULL AS attribute02,
    NULL AS attribute03,
    NULL AS attribute04,
    NULL AS attribute05,
    --'<span class="fa fa-heart-o"></span> &' || 'nbsp;'
    NULL AS attribute06,
    NULL AS attribute07,
    NULL AS attribute08,
    NULL AS attribute09,
    NULL AS attribute10,
    NULL AS page_id,
    NULL AS parent_id,
    NULL AS auth_scheme,
    NULL AS label__,
    '/100.100/' || b.updated_at || b.board_id AS order#
FROM tsk_user_fav_boards f
JOIN tsk_boards b
    ON b.board_id       = f.board_id
    AND b.is_active     = 'Y'
JOIN tsk_projects p
    ON p.project_id     = b.project_id
    AND p.is_active     = 'Y'
JOIN tsk_clients c
    ON c.client_id      = b.client_id
JOIN curr
    ON curr.user_id     = f.user_id;
--
COMMENT ON TABLE tsk_navigation_top_v IS '';

