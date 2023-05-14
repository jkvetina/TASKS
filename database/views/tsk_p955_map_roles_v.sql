CREATE OR REPLACE FORCE VIEW tsk_p955_map_roles_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id,
        core.get_item('$USER_ID')       AS user_id,
        core.get_item('$SHOW_ALL')      AS show_all,
        core.get_item('$SHOW_PROJECTS') AS show_projects
    FROM DUAL
)
SELECT
    x.client_id,
    --
    NVL(x.project_id, p.project_id)     AS project_id,
    NVL(x.project_id, p.project_id)     AS project__,
    --
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
JOIN tsk_auth_users a
    ON a.user_id        = t.user_id
    AND a.is_active     = 'Y'
JOIN x
    ON x.client_id      = a.client_id
    AND (x.user_id      = t.user_id OR x.user_id IS NULL)
    --
CROSS JOIN tsk_p960_roles_columns_v r
LEFT JOIN tsk_auth_roles p
    ON p.client_id      = x.client_id
    AND (
        p.project_id        = x.project_id
        OR (p.project_id    IS NULL AND x.project_id IS NULL)
        OR (x.show_projects = 'Y' AND x.project_id IS NULL)
    )
    AND p.user_id       = t.user_id
    AND p.role_id       = r.role_id
    AND p.is_active     = 'Y'
WHERE t.is_active       = 'Y'
    AND (x.show_all     IS NOT NULL OR p.user_id IS NOT NULL)
GROUP BY
    x.client_id,
    NVL(x.project_id, p.project_id),
    t.user_id,
    t.user_name,
    t.user_mail;
--
COMMENT ON TABLE tsk_p955_map_roles_v IS '';

