CREATE OR REPLACE FORCE VIEW tsk_p963_map_components_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$PAGE_GROUP')        AS page_group,
        core.get_number_item('$PAGE_ID')    AS page_id
    FROM DUAL
)
SELECT
    c.component_id,
    c.component_name,
    --
    REPLACE(c.component_type, 'APEX_APPLICATION_', '') AS component_type,
    --
    p.page,
    p.page_group,
    c.page_id,
    --
    c.region_id,
    ''                  AS region,
    --
    MAX(CASE WHEN r.r# = 1 THEN c.is_active END) AS role_1,
    MAX(CASE WHEN r.r# = 2 THEN c.is_active END) AS role_2,
    MAX(CASE WHEN r.r# = 3 THEN c.is_active END) AS role_3,
    MAX(CASE WHEN r.r# = 4 THEN c.is_active END) AS role_4,
    MAX(CASE WHEN r.r# = 5 THEN c.is_active END) AS role_5,
    MAX(CASE WHEN r.r# = 6 THEN c.is_active END) AS role_6,
    MAX(CASE WHEN r.r# = 7 THEN c.is_active END) AS role_7,
    MAX(CASE WHEN r.r# = 8 THEN c.is_active END) AS role_8
    --
FROM tsk_auth_components c
JOIN tsk_lov_app_pages_v p
    ON p.page_id        = c.page_id
JOIN x
    ON (x.page_id       = p.page_id     OR x.page_id IS NULL)
    AND (x.page_group   = p.page_group  OR x.page_group IS NULL)
LEFT JOIN tsk_p960_roles_columns_v r
    ON r.role_id        = c.role_id
GROUP BY
    c.component_id,
    c.component_name,
    REPLACE(c.component_type, 'APEX_APPLICATION_', ''),
    p.page,
    p.page_group,
    c.page_id,
    c.region_id;
--
COMMENT ON TABLE tsk_p963_map_components_v IS '';

