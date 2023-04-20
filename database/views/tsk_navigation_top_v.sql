CREATE OR REPLACE FORCE VIEW tsk_navigation_top_v AS
WITH curr AS (
    SELECT /*+ MATERIALIZE */
        SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS app_schema,
        --
        core.get_app_id()               AS app_id,
        n.page_id,
        n.parent_id,
        NULL                            AS root_id,
        core.get_page_group(n.page_id)  AS page_group,
        core.get_user_id()              AS user_id
    FROM tsk_navigation n
    WHERE n.page_id = core.get_page_id()
),
s AS (
    SELECT /*+ MATERIALIZE */
        a.application_id            AS app_id,
        a.page_id,
        a.page_alias,
        a.page_name,
        --
        NULLIF(MIN(s.owner || '.' || s.object_name || '.' || s.procedure_name), '..') AS procedure_,
        --
        a.authorization_scheme      AS auth_scheme,
        --
        MIN(CASE WHEN a.position = 0 THEN a.pls_type END)       AS data_type,
        MIN(CASE WHEN a.position = 1 THEN a.argument_name END)  AS page_argument
        --
    FROM apex_application_pages a
    JOIN curr
        ON curr.app_id              = a.application_id
    LEFT JOIN all_procedures s
        ON s.owner                  = curr.app_schema
        AND s.object_name           = 'AUTH'
        AND s.procedure_name        = a.authorization_scheme
    LEFT JOIN all_arguments a
        ON a.owner                  = s.owner
        AND a.object_name           = s.procedure_name
        AND a.package_name          = s.object_name
        AND a.overload              IS NULL
        AND ((
                a.position          = 0
                AND a.argument_name IS NULL
                AND a.in_out        = 'OUT'
            )
            OR (
                a.position          = 1
                AND a.data_type     = 'NUMBER'
                AND a.in_out        = 'IN'
            )
        )
    GROUP BY
        a.application_id,
        a.page_id,
        a.page_alias,
        a.page_name,
        a.authorization_scheme
),
t AS (
    SELECT /*+ MATERIALIZE */
        curr.app_id     AS app_id,
        curr.app_id     AS curr_app_id,
        --
        n.page_id,
        n.parent_id,
        --
        s.page_alias,
        s.page_name,        -- core.get_page_name(t.page_id)
        s.auth_scheme,
        n.is_reset,
        n.order#
    FROM tsk_navigation n
    CROSS JOIN curr
    JOIN s
        ON s.page_id        = n.page_id
    WHERE n.is_hidden       IS NULL
        --
        --AND 'Y' = core.check_auth(s.auth_scheme, s.app_id, s.page_id, s.procedure_, s.data_type, s.page_argument)
    --
    UNION ALL
    SELECT              -- append launchpad icon
        700             AS app_id,
        curr.app_id     AS curr_app_id,
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
    SELECT /*+ MATERIALIZE */
        CASE WHEN t.parent_id IS NULL THEN 1 ELSE 2 END AS lvl,
        --
        CASE
            WHEN t.page_id = 9999   THEN 'Logout'
            WHEN t.page_id = 0      THEN '</li></ul><ul class="empty"></ul><ul><li>'
            ELSE t.page_name
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
            WHEN t.app_id = t.curr_app_id AND t.page_id = (SELECT root_id   FROM curr)  THEN 'YES'
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
FROM n;
--
COMMENT ON TABLE tsk_navigation_top_v IS '';

