CREATE OR REPLACE FORCE VIEW tsk_navigation_auth_v AS
SELECT
    -- which users can access which pages for IS_USER auth scheme
    r.client_id,
    r.project_id,
    r.user_id,
    p.page_id,
    --
    LISTAGG(n.role_id, ',') WITHIN GROUP (ORDER BY r.role_id) AS roles
    --
FROM tsk_auth_pages p
JOIN tsk_roles n
    ON n.role_id        = p.role_id
    AND n.is_active     = 'Y'
JOIN tsk_auth_roles r
    ON r.role_id        = n.role_id
    AND r.is_active     = 'Y'
JOIN tsk_auth_users c
    ON c.client_id      = r.client_id
    AND c.user_id       = r.user_id
    AND r.is_active     = 'Y'
JOIN tsk_users u
    ON u.user_id        = c.user_id
    AND u.is_active     = 'Y'
WHERE p.is_active       = 'Y'
GROUP BY
    r.client_id,
    r.project_id,
    r.user_id,
    p.page_id;
--
COMMENT ON TABLE tsk_navigation_auth_v IS '';

