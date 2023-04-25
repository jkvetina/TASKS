CREATE OR REPLACE FORCE VIEW tsk_lov_roles_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$ROLE_GROUP')    AS role_group
    FROM DUAL
)
SELECT
    t.role_id,
    NVL(t.role_name, t.role_id) AS role_name,
    t.role_group,
    --
    CASE WHEN t.is_active = 'Y' THEN 'Active:' ELSE 'Not Active:' END AS is_active,
    --
    ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.role_id) AS order#
    --
FROM tsk_roles t
JOIN x
    ON (x.role_group = t.role_group OR x.role_group IS NULL);
--
COMMENT ON TABLE tsk_lov_roles_v IS '';

