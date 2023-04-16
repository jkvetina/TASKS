prompt --application/shared_components/user_interface/lovs/lov_task_statuses_all
begin
--   Manifest
--     LOV_TASK_STATUSES_ALL
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(45359629206027195)  -- LOV_TASK_STATUSES_ALL
,p_lov_name=>'LOV_TASK_STATUSES_ALL'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'TSK_LOV_TASK_STATUSES_ALL_V'
,p_return_column_name=>'STATUS_ID'
,p_display_column_name=>'STATUS_NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(45368730175147983)
,p_query_column_name=>'STATUS_ID'
,p_display_sequence=>10
,p_data_type=>'VARCHAR2'
,p_is_visible=>'N'
,p_is_searchable=>'N'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(45369177340147984)
,p_query_column_name=>'STATUS_NAME'
,p_heading=>'Status Name'
,p_display_sequence=>20
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(45369576593147984)
,p_query_column_name=>'IS_ACTIVE'
,p_heading=>'Is Active'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp.component_end;
end;
/
