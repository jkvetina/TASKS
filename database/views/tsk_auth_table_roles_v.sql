CREATE OR REPLACE FORCE VIEW tsk_auth_table_roles_v AS
SELECT
    r.user_id,
    r.client_id,
    r.project_id,
    r.role_id,
    t.table_name,
    t.is_allowed_create,
    t.is_allowed_update,
    t.is_allowed_delete
FROM tsk_auth_tables t
JOIN tsk_auth_roles r
    ON r.role_id        = t.role_id
    AND r.is_active     = 'Y'
JOIN tsk_auth_users a
    ON a.user_id        = r.user_id
    AND a.client_id     = r.client_id
    AND a.is_active     = 'Y'
JOIN tsk_users u
    ON u.user_id        = r.user_id
    AND u.is_active     = 'Y'
WHERE t.is_active       = 'Y';
--
COMMENT ON TABLE tsk_auth_table_roles_v IS '';

