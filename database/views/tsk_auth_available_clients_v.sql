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
    a.client_id
FROM x
JOIN tsk_auth_users a
    ON a.user_id        = x.user_id
    AND a.is_active     = 'Y'
JOIN tsk_clients c
    ON c.client_id      = a.client_id
    AND c.is_active     = 'Y';
--
COMMENT ON TABLE tsk_auth_available_clients_v IS '';

