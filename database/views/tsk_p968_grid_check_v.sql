CREATE OR REPLACE FORCE VIEW tsk_p968_grid_check_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_app_id()               AS app_id,
        core.get_item('$PAGE_GROUP')    AS page_group
    FROM DUAL
)
SELECT
    p.page_id,
    s.page_group,
    p.page_name,
    p.region_id,
    r.region_name,
    r.static_id,
    p.process_id,
    --
    CASE WHEN NOT REGEXP_LIKE(p.process_name, '^[A-Z0-9_-]+$')
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0 0;" title="Wrong process name"></span>'
        END || p.process_name AS process_name,
    --
    p.process_point_code,
    --
    CASE
        WHEN p.attribute_06 = 'Y'
            OR p.attribute_05 = 'N'
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0 0;" title="' ||
            REGEXP_REPLACE (
                CASE WHEN p.attribute_06 = 'Y' THEN 'Row lock enabled' || CHR(10) END ||
                CASE WHEN p.attribute_05 = 'N' THEN 'Prevent lost updates disabled' || CHR(10) END,
                --
                -- @TODO: toolbar check, js init check...
                --
            '\s+$', '') ||
            '"></span>'
        END AS check_setup,
    --
    CASE WHEN (r.location_code != 'LOCAL' OR r.query_type_code != 'TABLE' OR r.table_name NOT LIKE '%\_V' ESCAPE '\')
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0 0;" title="Region source is not a view"></span>'
        END || r.table_name AS source_table,
    --
    p.attribute_01      AS target_type,
    --
    CASE WHEN p.attribute_04 IS NULL
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0 0;" title="PL/SQL handler is missing"></span>'
        END || NVL(p.attribute_03, REGEXP_SUBSTR(UPPER(p.attribute_04), '^[A-Z0-9_]+\.?[A-Z0-9_]*')) AS target_name,     -- code to execute
    --
    -- @TODO: toolbar check, js init check...
    --
    CASE WHEN NVL(r.authorization_scheme, '-') != 'IS_USER'
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;" title="Missing IS_USER on region"></span>'
        END AS check_region,
    --
    CASE WHEN g.is_editable = 'Yes' AND NVL(p.authorization_scheme, '-') != 'IS_USER'
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;" title="Missing IS_USER on save process"></span>'
        END AS check_process,
    --
    CASE WHEN (g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'i') > 0 AND NVL(g.add_authorization_scheme, '-') != 'IS_USER_C')
        OR (g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'u') > 0 AND NVL(g.update_authorization_scheme, '-') != 'IS_USER_U')
        OR (g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'd') > 0 AND NVL(g.delete_authorization_scheme, '-') != 'IS_USER_D')
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;" title="' ||
            REGEXP_REPLACE (
                CASE WHEN INSTR(g.edit_operations, 'i') > 0 AND NVL(g.add_authorization_scheme, '-') != 'IS_USER_C' THEN 'Missing IS_USER_C on grid attributes' || CHR(10) END ||
                CASE WHEN INSTR(g.edit_operations, 'u') > 0 AND NVL(g.add_authorization_scheme, '-') != 'IS_USER_U' THEN 'Missing IS_USER_U on grid attributes' || CHR(10) END ||
                CASE WHEN INSTR(g.edit_operations, 'd') > 0 AND NVL(g.add_authorization_scheme, '-') != 'IS_USER_D' THEN 'Missing IS_USER_D on grid attributes' || CHR(10) END,
            '\s+$', '') ||
            '"></span>'
        END AS check_dml
    --
FROM apex_application_page_proc p
JOIN apex_application_page_regions r
    ON r.application_id     = p.application_id
    AND r.page_id           = p.page_id
    AND r.region_id         = p.region_id
    AND r.source_type_code  = 'NATIVE_IG'
JOIN apex_appl_page_igs g
    ON g.application_id     = p.application_id
    AND g.page_id           = p.page_id
    AND g.region_id         = p.region_id
CROSS JOIN x
JOIN tsk_lov_app_pages_v s
    ON s.page_id            = r.page_id
WHERE p.application_id      = x.app_id
    --AND (x.page_id          = s.page_id         OR x.page_id IS NULL)
    AND (x.page_group       = s.page_group_raw  OR x.page_group IS NULL)
    AND p.process_type_code = 'NATIVE_IG_DML';
--
COMMENT ON TABLE tsk_p968_grid_check_v IS '';

