CREATE OR REPLACE FORCE VIEW tsk_p960_roles_v AS
SELECT
    t.role_id,
    t.role_name,
    t.role_group,
    t.role_desc,
    t.is_active,
    t.order#
    --
    -- counters
    --
FROM tsk_roles t;
--
COMMENT ON TABLE tsk_p960_roles_v IS '';

