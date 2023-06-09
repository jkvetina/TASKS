CREATE OR REPLACE FORCE VIEW tsk_p966_map_procedures_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$PAGE_GROUP')    AS page_group,
        core.get_item('$PAGE_ID')       AS page_id
    FROM DUAL
)
SELECT
    p.object_name,
    p.procedure_name,
    --
    CASE
        WHEN MAX(g.procedure_name) IS NOT NULL AND MAX(t.table_name) IS NOT NULL
            THEN tsk_app.get_icon_check()
        WHEN MAX(g.procedure_name) IS NOT NULL AND MAX(t.table_name) IS NULL
            THEN tsk_app.get_icon_warning('Grid handler is missing')
        WHEN p.procedure_name LIKE 'SAVE\_%' ESCAPE '\' AND MAX(t.table_name) IS NULL
            THEN tsk_app.get_icon_warning('Table assignment missing')
        END AS grid_handler,
    --
    MAX(t.table_name) AS table_name,
    --
    MAX(CASE WHEN r.r# = 1 THEN a.is_active END) AS role_1,
    MAX(CASE WHEN r.r# = 2 THEN a.is_active END) AS role_2,
    MAX(CASE WHEN r.r# = 3 THEN a.is_active END) AS role_3,
    MAX(CASE WHEN r.r# = 4 THEN a.is_active END) AS role_4,
    MAX(CASE WHEN r.r# = 5 THEN a.is_active END) AS role_5,
    MAX(CASE WHEN r.r# = 6 THEN a.is_active END) AS role_6,
    MAX(CASE WHEN r.r# = 7 THEN a.is_active END) AS role_7,
    MAX(CASE WHEN r.r# = 8 THEN a.is_active END) AS role_8
    --
FROM tsk_lov_app_procedures_v p
CROSS JOIN x
CROSS JOIN tsk_p960_roles_columns_v r
LEFT JOIN tsk_auth_procedures a
    ON a.object_name        = p.object_name
    AND a.procedure_name    = p.procedure_name
    AND a.role_id           = r.role_id
LEFT JOIN tsk_auth_procedures t
    ON t.object_name        = p.object_name
    AND t.procedure_name    = p.procedure_name
    AND t.table_name        IS NOT NULL
LEFT JOIN tsk_p968_grid_check_v g
    ON g.object_name_raw    = p.object_name
    AND g.procedure_name    = p.procedure_name
WHERE 1 = 1
    AND (x.page_group       = p.page_group_raw  OR x.page_group IS NULL)
    AND (x.page_id          = p.page_id         OR x.page_id IS NULL)
GROUP BY
    p.object_name,
    p.procedure_name;
--
COMMENT ON TABLE tsk_p966_map_procedures_v IS '';

