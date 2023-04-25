CREATE OR REPLACE FORCE VIEW tsk_p955_map_roles_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id,
        core.get_item('$SHOW_ALL')      AS show_all
    FROM DUAL
)
SELECT
    x.client_id,
    x.project_id,
    t.user_id,
    t.user_name,
    t.user_mail,
    --
    MAX(CASE WHEN r.r# = 1 THEN p.is_active END) AS role_1,
    MAX(CASE WHEN r.r# = 2 THEN p.is_active END) AS role_2,
    MAX(CASE WHEN r.r# = 3 THEN p.is_active END) AS role_3,
    MAX(CASE WHEN r.r# = 4 THEN p.is_active END) AS role_4,
    MAX(CASE WHEN r.r# = 5 THEN p.is_active END) AS role_5,
    MAX(CASE WHEN r.r# = 6 THEN p.is_active END) AS role_6,
    MAX(CASE WHEN r.r# = 7 THEN p.is_active END) AS role_7,
    MAX(CASE WHEN r.r# = 8 THEN p.is_active END) AS role_8
    --
FROM tsk_users t
CROSS JOIN x
CROSS JOIN tsk_p962_map_pages_cols_v r
JOIN tsk_auth_users a
    ON a.client_id      = x.client_id
    AND a.user_id       = t.user_id
    AND a.is_active     = 'Y'
LEFT JOIN tsk_auth_roles p
    ON p.client_id      = x.client_id
    AND p.project_id    = x.project_id
    AND p.user_id       = t.user_id
    AND p.role_id       = r.role_id
WHERE 1 = 1
    AND t.is_active     = 'Y'
    AND (
        x.show_all      IS NOT NULL
        OR p.user_id    IS NOT NULL
    )
GROUP BY
    x.client_id,
    x.project_id,
    t.user_id,
    t.user_name,
    t.user_mail;
--
COMMENT ON TABLE tsk_p955_map_roles_v IS '';

