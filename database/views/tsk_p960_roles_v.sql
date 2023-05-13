CREATE OR REPLACE FORCE VIEW tsk_p960_roles_v AS
WITH p AS (
    SELECT /*+ MATERIALIZE */
        p.role_id,
        COUNT(*)        AS count_pages
    FROM tsk_auth_pages p
    WHERE p.is_active   = 'Y'
    GROUP BY
        p.role_id
),
b AS (
    SELECT /*+ MATERIALIZE */
        t.role_id,
        COUNT(*)        AS count_tables
    FROM tsk_auth_tables t
    WHERE t.is_active   = 'Y'
        AND COALESCE(t.is_allowed_create, t.is_allowed_update, t.is_allowed_delete) = 'Y'
    GROUP BY
        t.role_id
),
r AS (
    SELECT /*+ MATERIALIZE */
        r.role_id,
        COUNT(*)        AS count_users
    FROM tsk_auth_roles r
    GROUP BY
        r.role_id
)
SELECT
    t.role_id       AS old_role_id,
    --
    t.role_id,
    t.role_name,
    t.role_group,
    t.role_desc,
    t.is_active,
    t.order#,
    --
    p.count_pages,
    b.count_tables,
    r.count_users
    --
FROM tsk_roles t
LEFT JOIN p
    ON p.role_id    = t.role_id
LEFT JOIN b
    ON b.role_id    = t.role_id
LEFT JOIN r
    ON r.role_id    = t.role_id;
--
COMMENT ON TABLE tsk_p960_roles_v IS '';

