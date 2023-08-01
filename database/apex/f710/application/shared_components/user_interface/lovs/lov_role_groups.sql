prompt --application/shared_components/user_interface/lovs/lov_role_groups
begin
--   Manifest
--     LOV_ROLE_GROUPS
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
 p_id=>wwv_flow_imp.id(47013937673244274)  -- LOV_ROLE_GROUPS
,p_lov_name=>'LOV_ROLE_GROUPS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'TSK_LOV_ROLE_GROUPS_V'
,p_return_column_name=>'ROLE_GROUP'
,p_display_column_name=>'ROLE_GROUP'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'ORDER#'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
