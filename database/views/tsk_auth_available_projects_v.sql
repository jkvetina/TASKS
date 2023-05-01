CREATE OR REPLACE FORCE VIEW tsk_auth_available_projects_v AS
SELECT
    p.client_id,
    p.project_id
FROM tsk_auth_available_clients_v c
JOIN tsk_projects p
    ON p.client_id      = c.client_id
    AND p.is_active     = 'Y'
JOIN tsk_auth_roles r
    ON r.client_id      = p.client_id
    AND (r.project_id   = p.project_id  OR r.project_id IS NULL)
    AND r.user_id       = c.user_id
    AND r.is_active     = 'Y'
GROUP BY
    p.client_id,
    p.project_id;
--
COMMENT ON TABLE tsk_auth_available_projects_v IS '';

