CREATE OR REPLACE FORCE VIEW tsk_p900_user_roles_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id,
        core.get_user_id()              AS user_id
    FROM DUAL
)
SELECT
    t.user_id,
    t.user_name,
    t.user_mail,
    p.client_id,
    p.project_id,
    n.project_name,
    p.role_id,
    r.role_name,
    r.role_group,
    r.role_desc,
    r.order#
FROM tsk_users t
CROSS JOIN x
JOIN tsk_auth_users a
    ON a.client_id      = x.client_id
    AND a.user_id       = x.user_id
    AND a.is_active     = 'Y'
JOIN tsk_auth_roles p
    ON (p.client_id     = x.client_id   OR x.client_id IS NULL)
    AND (p.project_id   = x.project_id  OR x.project_id IS NULL)
    AND p.user_id       = t.user_id
JOIN tsk_roles r
    ON r.role_id        = p.role_id
    AND r.is_active     = 'Y'
JOIN tsk_projects n
    ON n.project_id     = p.project_id
    AND n.is_active     = 'Y'
WHERE t.user_id         = x.user_id
    AND t.is_active     = 'Y';
--
COMMENT ON TABLE tsk_p900_user_roles_v IS '';

