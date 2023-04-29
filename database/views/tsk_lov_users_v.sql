CREATE OR REPLACE FORCE VIEW tsk_lov_users_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        COALESCE(core.get_item('$CLIENT_ID'), tsk_app.get_client_id()) AS client_id
    FROM DUAL
)
SELECT
    t.user_id,
    NVL(t.user_name, t.user_id) AS user_name
    --
FROM tsk_users t
JOIN tsk_auth_users u
    ON u.user_id        = t.user_id
JOIN x
    ON x.client_id      = u.client_id
WHERE t.is_active       = 'Y'
    AND u.is_active     = 'Y';
--
COMMENT ON TABLE tsk_lov_users_v IS '';

