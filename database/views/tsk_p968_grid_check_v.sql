CREATE OR REPLACE FORCE VIEW tsk_p968_grid_check_v AS
SELECT
    p.page_id,
    p.region_id,
    p.process_name,
    --
    CASE WHEN r.authorization_scheme != 'IS_USER' THEN 'Missing IS_USER on region | ' END AS err_region,
    CASE WHEN g.is_editable = 'Yes' AND p.authorization_scheme != 'IS_USER' THEN 'Missing IS_USER on save process | ' END AS err_process,
    CASE WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'i') > 0 AND NVL(g.add_authorization_scheme, '-')    != 'IS_USER_C' THEN 'Missing IS_USER_C on grid attributes | ' END AS err_create,
    CASE WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'u') > 0 AND NVL(g.update_authorization_scheme, '-') != 'IS_USER_U' THEN 'Missing IS_USER_U on grid attributes | ' END AS err_update,
    CASE WHEN g.is_editable = 'Yes' AND INSTR(g.edit_operations, 'd') > 0 AND NVL(g.delete_authorization_scheme, '-') != 'IS_USER_D' THEN 'Missing IS_USER_D on grid attributes | ' END AS err_delete
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
WHERE p.application_id      = 710
    AND p.process_type_code = 'NATIVE_IG_DML';
--
COMMENT ON TABLE tsk_p968_grid_check_v IS '';

