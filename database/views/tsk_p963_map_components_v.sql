CREATE OR REPLACE FORCE VIEW tsk_p963_map_components_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$PAGE_GROUP')        AS page_group,
        core.get_number_item('$PAGE_ID')    AS page_id
    FROM DUAL
)
SELECT
    g.component_id,
    g.component_type,
    --
    g.component_name ||
        CASE WHEN MAX(c.is_active) IS NULL AND g.dml_actions IS NOT NULL
            THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;"></span>'
            END AS component_name,
    --
    p.page,
    p.page_group,
    g.page_id,
    --
    MAX(CASE WHEN r.r# = 1 THEN c.is_active END) AS role_1,
    MAX(CASE WHEN r.r# = 2 THEN c.is_active END) AS role_2,
    MAX(CASE WHEN r.r# = 3 THEN c.is_active END) AS role_3,
    MAX(CASE WHEN r.r# = 4 THEN c.is_active END) AS role_4,
    MAX(CASE WHEN r.r# = 5 THEN c.is_active END) AS role_5,
    MAX(CASE WHEN r.r# = 6 THEN c.is_active END) AS role_6,
    MAX(CASE WHEN r.r# = 7 THEN c.is_active END) AS role_7,
    MAX(CASE WHEN r.r# = 8 THEN c.is_active END) AS role_8,
    --
    MAX(c.is_active) AS is_used,
    --
    g.path_,
    g.dml_actions
    --
FROM tsk_p963_regions_mv g
JOIN tsk_lov_app_pages_v p
    ON p.page_id        = g.page_id
JOIN x
    ON (x.page_id       = p.page_id         OR x.page_id IS NULL)
    AND (x.page_group   = p.page_group_raw  OR x.page_group IS NULL)
LEFT JOIN tsk_auth_components c
    ON c.page_id        = g.page_id
    AND c.component_id  = g.component_id
LEFT JOIN tsk_p960_roles_columns_v r
    ON r.role_id        = c.role_id
GROUP BY
    g.component_id,
    g.component_name,
    g.component_type,
    p.page,
    p.page_group,
    g.page_id,
    g.path_,
    g.dml_actions;
--
COMMENT ON TABLE tsk_p963_map_components_v IS '';

