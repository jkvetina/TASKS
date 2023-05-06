CREATE OR REPLACE FORCE VIEW tsk_lov_users_project_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        COALESCE(core.get_item('$CLIENT_ID'),   tsk_app.get_client_id())    AS client_id,
        COALESCE(core.get_item('$PROJECT_ID'),  tsk_app.get_project_id())   AS project_id
    FROM DUAL
)
SELECT
    t.user_id,
    NVL(t.user_name, t.user_id) || ' (' || t.user_mail || ')' AS user_name
    --
FROM tsk_users t
CROSS JOIN x
JOIN tsk_auth_available_projects_v a
    ON a.client_id      = x.client_id
    AND a.project_id    = x.project_id
JOIN tsk_auth_roles r
    ON r.client_id      = x.client_id
    AND r.project_id    = x.project_id
    AND r.user_id       = t.user_id
    AND r.is_active     = 'Y';
--
COMMENT ON TABLE tsk_lov_users_project_v IS '';

