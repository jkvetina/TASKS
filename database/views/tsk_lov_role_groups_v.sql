CREATE OR REPLACE FORCE VIEW tsk_lov_role_groups_v AS
SELECT
    t.role_group,
    --
    ROW_NUMBER() OVER (ORDER BY t.role_group) AS order#
    --
FROM tsk_roles t
GROUP BY t.role_group;
--
COMMENT ON TABLE tsk_lov_role_groups_v IS '';

