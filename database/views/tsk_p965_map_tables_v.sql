CREATE OR REPLACE FORCE VIEW tsk_p965_map_tables_v AS
SELECT
    t.table_name,
    --
    CASE WHEN t.procedure_name IS NULL
        THEN tsk_app.get_icon_warning('TAPI procedure is missing')
        ELSE t.procedure_name
        END AS procedure_name,
    --
    MAX(CASE WHEN r.r# = 1 THEN a.is_allowed_create END) AS role_1c,
    MAX(CASE WHEN r.r# = 1 THEN a.is_allowed_update END) AS role_1u,
    MAX(CASE WHEN r.r# = 1 THEN a.is_allowed_delete END) AS role_1d,
    --
    MAX(CASE WHEN r.r# = 2 THEN a.is_allowed_create END) AS role_2c,
    MAX(CASE WHEN r.r# = 2 THEN a.is_allowed_update END) AS role_2u,
    MAX(CASE WHEN r.r# = 2 THEN a.is_allowed_delete END) AS role_2d,
    --
    MAX(CASE WHEN r.r# = 3 THEN a.is_allowed_create END) AS role_3c,
    MAX(CASE WHEN r.r# = 3 THEN a.is_allowed_update END) AS role_3u,
    MAX(CASE WHEN r.r# = 3 THEN a.is_allowed_delete END) AS role_3d,
    --
    MAX(CASE WHEN r.r# = 4 THEN a.is_allowed_create END) AS role_4c,
    MAX(CASE WHEN r.r# = 4 THEN a.is_allowed_update END) AS role_4u,
    MAX(CASE WHEN r.r# = 4 THEN a.is_allowed_delete END) AS role_4d,
    --
    MAX(CASE WHEN r.r# = 5 THEN a.is_allowed_create END) AS role_5c,
    MAX(CASE WHEN r.r# = 5 THEN a.is_allowed_update END) AS role_5u,
    MAX(CASE WHEN r.r# = 5 THEN a.is_allowed_delete END) AS role_5d,
    --
    MAX(CASE WHEN r.r# = 6 THEN a.is_allowed_create END) AS role_6c,
    MAX(CASE WHEN r.r# = 6 THEN a.is_allowed_update END) AS role_6u,
    MAX(CASE WHEN r.r# = 6 THEN a.is_allowed_delete END) AS role_6d,
    --
    MAX(CASE WHEN r.r# = 7 THEN a.is_allowed_create END) AS role_7c,
    MAX(CASE WHEN r.r# = 7 THEN a.is_allowed_update END) AS role_7u,
    MAX(CASE WHEN r.r# = 7 THEN a.is_allowed_delete END) AS role_7d,
    --
    MAX(CASE WHEN r.r# = 8 THEN a.is_allowed_create END) AS role_8c,
    MAX(CASE WHEN r.r# = 8 THEN a.is_allowed_update END) AS role_8u,
    MAX(CASE WHEN r.r# = 8 THEN a.is_allowed_delete END) AS role_8d
    --
FROM tsk_lov_app_tables_v t
CROSS JOIN tsk_p960_roles_columns_v r
LEFT JOIN tsk_auth_tables a
    ON a.role_id        = r.role_id
    AND a.table_name    = t.table_name
GROUP BY
    t.table_name,
    t.procedure_name;
--
COMMENT ON TABLE tsk_p965_map_tables_v IS '';

