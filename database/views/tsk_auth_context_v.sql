CREATE OR REPLACE FORCE VIEW tsk_auth_context_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_user_id()              AS user_id,
        core.get_app_id()               AS app_id,
        core.get_page_id()              AS page_id,
        --
        tsk_app.get_client_id()         AS client_id,
        tsk_app.get_project_id()        AS project_id,
        --
        core.get_item('$CLIENT_ID')     AS page_client_id,
        core.get_item('$PROJECT_ID')    AS page_project_id
        --
    FROM tsk_users u
    WHERE u.user_id         = core.get_user_id()
        AND u.is_active     = 'Y'
)
SELECT
    x.user_id,
    x.app_id,
    x.page_id,
    --
    MAX(c.client_id)    AS client_id,
    MAX(p.project_id)   AS project_id,
    --
    MAX(d.client_id)    AS page_client_id,
    MAX(j.project_id)   AS page_project_id
FROM x
LEFT JOIN tsk_auth_available_projects_v c   ON c.client_id      = x.client_id
LEFT JOIN tsk_auth_available_projects_v p   ON p.project_id     = x.project_id
LEFT JOIN tsk_auth_available_projects_v d   ON d.client_id      = x.page_client_id
LEFT JOIN tsk_auth_available_projects_v j   ON j.project_id     = x.page_project_id
GROUP BY
    x.user_id,
    x.app_id,
    x.page_id;
--
COMMENT ON TABLE tsk_auth_context_v IS '';

