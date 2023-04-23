CREATE OR REPLACE FORCE VIEW tsk_lov_roles_v AS
SELECT
    t.role_id,
    NVL(t.role_name, t.role_id) AS role_name,
    --
    CASE WHEN t.is_active = 'Y' THEN 'Active:' ELSE 'Not Active:' END AS is_active
    --
FROM tsk_roles t;
--
COMMENT ON TABLE tsk_lov_roles_v IS '';

