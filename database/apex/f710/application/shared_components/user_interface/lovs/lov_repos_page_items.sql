prompt --application/shared_components/user_interface/lovs/lov_repos_page_items
begin
--   Manifest
--     LOV_REPOS #PAGE_ITEMS
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
 p_id=>wwv_flow_imp.id(46964058460863294)  -- LOV_REPOS #PAGE_ITEMS
,p_lov_name=>'LOV_REPOS #PAGE_ITEMS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'TSK_LOV_REPOS_V'
,p_return_column_name=>'REPO_ID'
,p_display_column_name=>'REPO_ID'
,p_group_column_name=>'OWNER_ID'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'REPO_ID'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
