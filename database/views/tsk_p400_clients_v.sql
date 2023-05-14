CREATE OR REPLACE FORCE VIEW tsk_p400_clients_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_user_id()              AS user_id,
        tsk_app.get_client_id()         AS client_id
    FROM DUAL
),
c AS (
    SELECT /*+ MATERIALIZE */
        t.client_id,
        --
        COUNT(DISTINCT t.project_id)    AS count_projects,
        COUNT(DISTINCT t.board_id)      AS count_boards,
        COUNT(*)                        AS count_tasks
        --
    FROM tsk_tasks t
    GROUP BY
        t.client_id
)
SELECT
    t.client_id         AS pk_client_id,    -- to allow PK changes
    --
    t.client_id,
    t.client_name,
    --
    CASE WHEN t.client_id = x.client_id
        THEN '<span class="fa fa-check-square"></span>'
        ELSE '<a href="' ||
            core.get_page_url (
                in_page_id      => 100,
                in_app_id       => core.get_app_id(),
                in_names        => 'P100_CLIENT_ID,P100_PROJECT_ID,P100_BOARD_ID',
                in_values       => t.client_id || ',,'
            ) || '">SET</a>'
        END AS is_current,
    --
    t.is_active,
    --
    c.count_projects,
    c.count_boards,
    c.count_tasks
    --
FROM tsk_clients t
CROSS JOIN x
LEFT JOIN tsk_auth_users u
    ON u.user_id        = x.user_id
    AND u.client_id     = t.client_id
LEFT JOIN c
    ON c.client_id      = t.client_id
WHERE 1 = 1
    AND (u.client_id    = t.client_id OR x.user_id = 'JANK');
--
COMMENT ON TABLE tsk_p400_clients_v IS '';

