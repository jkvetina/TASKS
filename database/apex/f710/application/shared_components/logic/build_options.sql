prompt --application/shared_components/logic/build_options
begin
--   Manifest
--     BUILD OPTIONS: 710
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(48468460291668887)
,p_build_option_name=>'NEVER'
,p_build_option_status=>'EXCLUDE'
,p_on_upgrade_keep_status=>true
,p_build_option_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Alternative for server side condition = NEVER',
'so we can keep what is set there'))
);
wwv_flow_imp.component_end;
end;
/
