CREATE OR REPLACE FORCE VIEW tsk_p400_clients_v AS
WITH c AS (
    SELECT /*+ MATERIALIZE */
        t.client_id,
        COUNT(*) AS count_tasks
    FROM tsk_tasks t
    GROUP BY
        t.client_id
)
SELECT
    t.client_id         AS pk_client_id,    -- to allow PK changes
    --
    t.client_id,
    t.client_name,
    t.is_active,
    --
    core.get_page_url (
        in_page_id      => 100,
        in_app_id       => core.get_app_id(),
        in_names        => 'P100_CLIENT_ID,P100_PROJECT_ID,P100_BOARD_ID',
        in_values       => t.client_id || ',,',
        in_reset        => 'Y'
    ) AS activate_url,
    --
    c.count_tasks
    --
FROM tsk_clients t
LEFT JOIN c
    ON c.client_id      = t.client_id;
--
COMMENT ON TABLE tsk_p400_clients_v IS '';

