prompt --application/shared_components/user_interface/lovs/lov_board_types
begin
--   Manifest
--     LOV_BOARD_TYPES
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
 p_id=>wwv_flow_imp.id(44081882365233350)  -- LOV_BOARD_TYPES
,p_lov_name=>'LOV_BOARD_TYPES'
,p_lov_query=>'.'||wwv_flow_imp.id(44081882365233350)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(44082120173233372)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'My tasks + unassigned'
,p_lov_return_value=>'MY+'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(44082510607233376)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'My tasks'
,p_lov_return_value=>'MY'
);
wwv_flow_imp.component_end;
end;
/
