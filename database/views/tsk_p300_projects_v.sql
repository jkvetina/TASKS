CREATE OR REPLACE FORCE VIEW tsk_p300_projects_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id
    FROM DUAL
),
c AS (
    SELECT /*+ MATERIALIZE */
        t.project_id,
        COUNT(*) AS count_tasks
    FROM tsk_tasks t
    JOIN x
        ON x.client_id  = t.client_id
    GROUP BY
        t.project_id
)
SELECT
    t.project_id        AS pk_project_id,   -- to allow PK changes
    --
    t.client_id,
    t.project_id,
    t.project_name,
    t.is_active,
    --
    core.get_page_url (
        in_page_id      => 100,
        in_app_id       => core.get_app_id(),
        in_names        => 'P100_CLIENT_ID,P100_PROJECT_ID,P100_BOARD_ID',
        in_values       => t.client_id || ',' || t.project_id || ',',
        in_reset        => 'Y'
    ) AS activate_url,
    --
    c.count_tasks
    --
FROM tsk_projects t
JOIN x
    ON x.client_id      = t.client_id
LEFT JOIN c
    ON c.project_id     = t.project_id;
--
COMMENT ON TABLE tsk_p300_projects_v IS '';

