prompt --application/shared_components/user_interface/lovs/lov_app_tables
begin
--   Manifest
--     LOV_APP_TABLES
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(46514006412586236)  -- LOV_APP_TABLES
,p_lov_name=>'LOV_APP_TABLES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'TSK_LOV_APP_TABLES_V'
,p_return_column_name=>'TABLE_NAME'
,p_display_column_name=>'TABLE_NAME'
,p_default_sort_column_name=>'TABLE_NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
