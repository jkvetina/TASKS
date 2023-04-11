prompt --application/shared_components/logic/application_settings
begin
--   Manifest
--     APPLICATION SETTINGS: 710
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(35097556225810829)
,p_name=>'P0_CLIENT_ID'
,p_value=>'Q'
,p_is_required=>'N'
,p_on_upgrade_keep_value=>true
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(35097785689811654)
,p_name=>'P0_PROJECT_ID'
,p_value=>'PROJECT_ONE'
,p_is_required=>'N'
,p_on_upgrade_keep_value=>true
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(35098015092813076)
,p_name=>'P0_BOARD_ID'
,p_value=>'1'
,p_is_required=>'N'
,p_on_upgrade_keep_value=>true
);
wwv_flow_imp.component_end;
end;
/
