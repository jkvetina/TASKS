CREATE OR REPLACE FORCE VIEW tsk_auth_components_list_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_app_id() AS app_id
    FROM DUAL
),
d (component_type, component_id, authorization_scheme_id, page_id, component_signature) AS (
    SELECT 'APEX_APPLICATION_BC_ENTRIES',       breadcrumb_entry_id,        authorization_scheme_id, NULL,      component_signature FROM apex_application_bc_entries    JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_COMPUTATIONS',     application_computation_id, authorization_scheme_id, NULL,      component_signature FROM apex_application_computations  JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_LIST_ENTRIES',     list_entry_id,              authorization_scheme_id, NULL,      component_signature FROM apex_application_list_entries  JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_NAV_BAR',          nav_bar_id,                 authorization_scheme_id, NULL,      component_signature FROM apex_application_nav_bar       JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_BRANCHES',    branch_id,                  authorization_scheme_id, page_id,   component_signature FROM apex_application_page_branches JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_BUTTONS',     button_id,                  authorization_scheme_id, page_id,   component_signature FROM apex_application_page_buttons  JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_CHART_S',     series_id,                  authorization_scheme_id, page_id,   component_signature FROM apex_application_page_chart_s  JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_COMP',        computation_id,             authorization_scheme_id, page_id,   component_signature FROM apex_application_page_comp     JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_DA',          dynamic_action_id,          authorization_scheme_id, page_id,   component_signature FROM apex_application_page_da       JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_DA_ACTS',     dynamic_action_id,          authorization_scheme_id, page_id,   component_signature FROM apex_application_page_da_acts  JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_IR_COL',      interactive_report_id,      authorization_scheme_id, page_id,   component_signature FROM apex_application_page_ir_col   JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_ITEMS',       item_id,                    authorization_scheme_id, page_id,   component_signature FROM apex_application_page_items    JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_PROC',        process_id,                 authorization_scheme_id, page_id,   component_signature FROM apex_application_page_proc     JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_REGIONS',     region_id,                  authorization_scheme_id, page_id,   component_signature FROM apex_application_page_regions  JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_REG_COLS',    region_column_id,           authorization_scheme_id, page_id,   NULL                FROM apex_application_page_reg_cols JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_RPT_COLS',    region_report_column_id,    authorization_scheme_id, page_id,   component_signature FROM apex_application_page_rpt_cols JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PAGE_VAL',         validation_id,              authorization_scheme_id, page_id,   component_signature FROM apex_application_page_val      JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PARENT_TABS',      parent_tab_id,              authorization_scheme_id, NULL,      component_signature FROM apex_application_parent_tabs   JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_PROCESSES',        application_process_id,     authorization_scheme_id, NULL,      component_signature FROM apex_application_processes     JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPLICATION_TABS',             tab_id,                     authorization_scheme_id, NULL,      component_signature FROM apex_application_tabs          JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_PAGE_CARD_ACTIONS',       action_id,                  authorization_scheme_id, NULL,      NULL                FROM apex_appl_page_card_actions    JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_PAGE_FILTERS',            item_id,                    authorization_scheme_id, page_id,   component_signature FROM apex_appl_page_filters         JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_PAGE_FILTER_GROUPS',      item_group_id,              authorization_scheme_id, page_id,   NULL                FROM apex_appl_page_filter_groups   JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_PAGE_IG_COLUMNS',         column_id,                  authorization_scheme_id, page_id,   NULL                FROM apex_appl_page_ig_columns      JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_PAGE_IG_RPTS',            report_id,                  authorization_scheme_id, page_id,   NULL                FROM apex_appl_page_ig_rpts         JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_PAGE_MAP_LAYERS',         layer_id,                   authorization_scheme_id, page_id,   NULL                FROM apex_appl_page_map_layers      JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_SEARCH_CONFIGS',          search_config_id,           authorization_scheme_id, NULL,      NULL                FROM apex_appl_search_configs       JOIN x ON x.app_id = application_id UNION ALL
    SELECT 'APEX_APPL_WEB_SRC_OPERATIONS',      operation_id,               authorization_scheme_id, NULL,      component_signature FROM apex_appl_web_src_operations   JOIN x ON x.app_id = application_id
)
SELECT
    component_type,
    component_id,
    authorization_scheme_id,
    page_id,
    component_signature FROM d;
--
COMMENT ON TABLE tsk_auth_components_list_v IS '';

