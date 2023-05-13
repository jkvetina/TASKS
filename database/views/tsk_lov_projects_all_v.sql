CREATE OR REPLACE FORCE VIEW tsk_lov_projects_all_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS page_client_id
    FROM DUAL
)
SELECT
    c.client_id,
    c.client_name,
    t.project_id,
    t.project_name,
    --
    ROW_NUMBER() OVER (ORDER BY c.client_id, t.project_name, t.project_id) AS project_r#
    --
FROM tsk_projects t
JOIN tsk_clients c
    ON c.client_id      = t.client_id
CROSS JOIN x
WHERE (x.page_client_id = c.client_id OR x.page_client_id IS NULL)
    AND t.is_active     = 'Y'
    AND c.is_active     = 'Y';
--
COMMENT ON TABLE tsk_lov_projects_all_v IS '';

