CREATE OR REPLACE FORCE VIEW tsk_p300_projects_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id
    FROM DUAL
)
SELECT
    t.client_id,
    t.project_id,
    t.project_name,
    t.is_active,
    --
    core.get_page_url (
        in_page_id      => core.get_page_id(),
        in_app_id       => core.get_app_id(),
        in_names        => 'P0_CLIENT_ID,P0_PROJECT_ID,P0_BOARD_ID',
        in_values       => t.client_id || ',' || t.project_id || ',',
        in_reset        => 'Y'
    ) AS activate_url
    --
FROM tsk_projects t
JOIN x
    ON x.client_id      = t.client_id;
--
COMMENT ON TABLE tsk_p300_projects_v IS '';

