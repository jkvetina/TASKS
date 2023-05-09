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
    --
    p.region_id,
    r.region_name,
    r.static_id,
    p.process_name,
    --
    -- @TODO: process_name_check
    --
    -- @TODO: show region source, expect a view only
    --
    -- @TODO: show handler, match to procedure
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
    CASE WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'i') > 0 AND NVL(g.add_authorization_scheme, '-')    != 'IS_USER_C'
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;" title="Missing IS_USER_C on grid attributes"></span>'
        END AS check_create,
    --
    CASE WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'u') > 0 AND NVL(g.update_authorization_scheme, '-') != 'IS_USER_U'
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;" title="Missing IS_USER_U on grid attributes"></span>'
        END AS check_update,
    --
    CASE WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'd') > 0 AND NVL(g.delete_authorization_scheme, '-') != 'IS_USER_D'
        THEN '<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;" title="Missing IS_USER_D on grid attributes"></span>'
        END AS check_delete
    --
    -- @TODO: toolbar check, js init check...
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

