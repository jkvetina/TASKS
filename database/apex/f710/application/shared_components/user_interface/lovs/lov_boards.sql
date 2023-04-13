prompt --application/shared_components/user_interface/lovs/lov_boards
begin
--   Manifest
--     LOV_BOARDS
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
 p_id=>wwv_flow_imp.id(34763544164505098)  -- LOV_BOARDS
,p_lov_name=>'LOV_BOARDS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'TSK_LOV_BOARDS_V'
,p_return_column_name=>'BOARD_ID'
,p_display_column_name=>'BOARD_NAME'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
