CREATE OR REPLACE FORCE VIEW tsk_p962_map_pages_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_app_id()               AS app_id,
        core.get_item('$PAGE_GROUP')    AS page_group
    FROM DUAL
),
a AS (
    -- get APEX pages
    SELECT /*+ MATERIALIZE */
        a.page_id,
        a.page_name,
        a.page_group,
        CASE WHEN a.page_mode != 'Normal' THEN 'Y' END AS is_modal
    FROM apex_application_pages a
    JOIN x
        ON x.app_id         = a.application_id
        AND (a.page_group   = x.page_group OR x.page_group IS NULL)
        AND a.page_id       NOT IN (0, 9999)
        --
        AND a.authorization_scheme = 'IS_USER'
),
g AS (
    -- order page groups
    SELECT
        g.page_group,
        ROW_NUMBER() OVER (ORDER BY g.parent_id DESC) AS group_order#
    FROM (
        SELECT
            g.page_group,
            MAX(g.parent_id) AS parent_id
        FROM (
            SELECT /*+ MATERIALIZE */
                a.page_id,
                a.page_group,
                NVL(CONNECT_BY_ROOT n.parent_id, a.page_id) AS parent_id
            FROM a
            JOIN tsk_navigation n
                ON n.page_id        = a.page_id
            CONNECT BY n.page_id    = PRIOR n.parent_id
        ) g
        GROUP BY
            g.page_group
    ) g
)
SELECT
    a.page_id,
    a.is_modal,
    --
    CASE WHEN n.parent_id IS NOT NULL THEN REPLACE(LPAD(' ', 3, ' '), ' ', '&' || 'nbsp; ') END ||
        a.page_name ||
        CASE WHEN MAX(p.is_active) IS NULL
            THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;"></span>' END
        AS page_name,
    --
    LPAD(' ', g.group_order#) || g.page_group AS page_group,
    --
    n.parent_id,
    n.order#,
    n.is_hidden,
    n.is_reset,
    --
    MAX(CASE WHEN r.r# = 1 THEN p.is_active END) AS role_1,
    MAX(CASE WHEN r.r# = 2 THEN p.is_active END) AS role_2,
    MAX(CASE WHEN r.r# = 3 THEN p.is_active END) AS role_3,
    MAX(CASE WHEN r.r# = 4 THEN p.is_active END) AS role_4,
    MAX(CASE WHEN r.r# = 5 THEN p.is_active END) AS role_5,
    MAX(CASE WHEN r.r# = 6 THEN p.is_active END) AS role_6,
    MAX(CASE WHEN r.r# = 7 THEN p.is_active END) AS role_7,
    MAX(CASE WHEN r.r# = 8 THEN p.is_active END) AS role_8,
    --
    MAX(p.is_active) AS is_used
    --
FROM a
LEFT JOIN tsk_navigation n
    ON n.page_id        = a.page_id
CROSS JOIN tsk_p960_roles_columns_v r
LEFT JOIN tsk_auth_pages p
    ON p.role_id        = r.role_id
    AND p.page_id       = a.page_id
LEFT JOIN g
    ON g.page_group     = a.page_group
GROUP BY
    a.page_id,
    a.is_modal,
    a.page_name,
    LPAD(' ', g.group_order#) || g.page_group,
    n.parent_id,
    n.order#,
    n.is_hidden,
    n.is_reset;
--
COMMENT ON TABLE tsk_p962_map_pages_v IS '';

