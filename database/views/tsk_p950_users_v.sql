CREATE OR REPLACE FORCE VIEW tsk_p950_users_v AS
WITH c AS (
    SELECT /*+ MATERIALIZE */
        t.user_id,
        COUNT(DISTINCT t.client_id)     AS count_clients
    FROM tsk_auth_users t
    WHERE t.is_active   = 'Y'
    GROUP BY
        t.user_id
),
r AS (
    SELECT /*+ MATERIALIZE */
        r.user_id,
        COUNT(DISTINCT r.project_id)    AS count_projects,
        COUNT(DISTINCT r.role_id)       AS count_roles
    FROM tsk_auth_roles r
    WHERE r.is_active   = 'Y'
    GROUP BY
        r.user_id
)
SELECT
    t.user_id,
    t.user_name,
    t.user_mail,
    t.is_active,
    --
    c.count_clients,
    r.count_projects,
    r.count_roles
    --
FROM tsk_users t
LEFT JOIN c
    ON c.user_id    = t.user_id
LEFT JOIN r
    ON r.user_id    = t.user_id;
--
COMMENT ON TABLE tsk_p950_users_v IS '';

