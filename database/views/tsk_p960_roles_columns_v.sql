CREATE OR REPLACE FORCE VIEW tsk_p960_roles_columns_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$ROLE_GROUP')    AS role_group,
        core.get_item('$ROLE_ID')       AS role_id
    FROM DUAL
)
SELECT
    r.role_id,
    r.role_name,
    --
    ROW_NUMBER() OVER (ORDER BY r.role_group, r.order# NULLS LAST, r.role_id) AS r#
    --
FROM tsk_roles r
JOIN x
    ON (x.role_group    = r.role_group  OR x.role_group IS NULL)
    AND (x.role_id      = r.role_id     OR x.role_id IS NULL)
    AND r.is_active     = 'Y'
    -- keep the order here, otherwise columns will break on various pages
ORDER BY r#;
--
COMMENT ON TABLE tsk_p960_roles_columns_v IS '';

