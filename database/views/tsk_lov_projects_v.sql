CREATE OR REPLACE FORCE VIEW tsk_lov_projects_v AS
SELECT
    c.client_id,
    c.client_name,
    t.project_id,
    t.project_name,
    --
    CASE WHEN t.client_id   = z.client_id       THEN 'Y' END AS is_user_client,
    CASE WHEN t.project_id  = z.project_id      THEN 'Y' END AS is_user_project,
    CASE WHEN t.client_id   = z.page_client_id  THEN 'Y' END AS is_page_client,
    CASE WHEN t.project_id  = z.page_project_id THEN 'Y' END AS is_page_project,
    --
    c.client_r#                                                             AS client_r#,
    ROW_NUMBER() OVER (ORDER BY c.client_r#, t.project_name, t.project_id)  AS project_r#
    --
FROM tsk_projects t
CROSS JOIN tsk_auth_context_v z
JOIN tsk_auth_available_projects_v a
    ON a.project_id     = t.project_id
JOIN tsk_lov_clients_v c
    ON c.client_id      = t.client_id;
--
COMMENT ON TABLE tsk_lov_projects_v IS '';

