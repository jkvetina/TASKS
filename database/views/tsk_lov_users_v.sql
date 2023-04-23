CREATE OR REPLACE FORCE VIEW tsk_lov_users_v AS
SELECT
    t.user_id,
    NVL(t.user_name, t.user_id) AS user_name,
    --
    CASE WHEN t.is_active = 'Y' THEN 'Active:' ELSE 'Not Active:' END AS is_active
    --
FROM tsk_users t;
--
COMMENT ON TABLE tsk_lov_users_v IS '';

