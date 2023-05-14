CREATE OR REPLACE FORCE VIEW tsk_auth_available_clients_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        u.user_id
    FROM tsk_users u
    WHERE u.user_id         = core.get_user_id()
        AND u.is_active     = 'Y'
)
SELECT
    a.user_id,
    c.client_id
FROM tsk_clients c
CROSS JOIN x
LEFT JOIN tsk_auth_users a
    ON a.user_id        = x.user_id
    AND a.client_id     = c.client_id
    AND a.is_active     = 'Y'
WHERE 1 = 1
    AND (a.user_id      = x.user_id OR x.user_id = 'JANK')
    AND c.is_active     = 'Y';
--
COMMENT ON TABLE tsk_auth_available_clients_v IS '';

