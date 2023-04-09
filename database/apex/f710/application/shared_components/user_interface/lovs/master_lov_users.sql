prompt --application/shared_components/user_interface/lovs/master_lov_users
begin
--   Manifest
--     MASTER - LOV_USERS
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
 p_id=>wwv_flow_imp.id(54625088629706656)  -- MASTER - LOV_USERS
,p_lov_name=>'MASTER - LOV_USERS'
,p_reference_id=>18781697091885858
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'INT_USERS'
,p_return_column_name=>'USER_ID'
,p_display_column_name=>'USER_NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'USER_NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
