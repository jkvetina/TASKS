CREATE OR REPLACE FORCE VIEW tsk_auth_context_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_user_id()          AS user_id,
        core.get_app_id()           AS app_id,
        core.get_page_id()          AS page_id,
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id
        --tsk_app.get_board_id()      AS board_id
    FROM tsk_users u
    WHERE u.user_id         = core.get_user_id()
        AND u.is_active     = 'Y'
),
c AS (
    -- verify access to client
    SELECT /*+ MATERIALIZE */
        c.client_id
    FROM tsk_clients c
    JOIN x
        ON x.client_id      = c.client_id
    JOIN tsk_auth_users a
        ON a.client_id      = x.client_id
        AND a.user_id       = x.user_id
        AND a.is_active     = 'Y'
    WHERE c.is_active       = 'Y'
),
p AS (
    -- verify access to project
    SELECT /*+ MATERIALIZE */
        CASE WHEN x.project_id IS NOT NULL THEN p.project_id END AS project_id
    FROM c
    JOIN x
        ON x.client_id      = c.client_id
    JOIN tsk_auth_roles r
        ON r.client_id      = x.client_id
        AND (r.project_id   = x.project_id  OR x.project_id IS NULL)
        AND r.user_id       = x.user_id
        AND r.is_active     = 'Y'
    JOIN tsk_roles s
        ON s.role_id        = r.role_id
        AND s.is_active     = 'Y'
    JOIN tsk_projects p
        ON p.project_id     = r.project_id
        AND p.is_active     = 'Y'
    GROUP BY
        CASE WHEN x.project_id IS NOT NULL THEN p.project_id END
)
SELECT
    -- so this should return 1 row if user is active and has permissions,
    -- except he is asking for a client/project which he cant access
    x.user_id,
    x.app_id,
    x.page_id,
    c.client_id,
    p.project_id
FROM x
LEFT JOIN c
    ON c.client_id      = x.client_id
LEFT JOIN p
    ON p.project_id     = x.project_id
WHERE 1 = 1
    AND (c.client_id    IS NOT NULL OR x.client_id IS NULL)
    AND (p.project_id   IS NOT NULL OR x.project_id IS NULL);
--
COMMENT ON TABLE tsk_auth_context_v IS '';

