prompt --application/shared_components/security/authorizations/is_user_c
begin
--   Manifest
--     SECURITY SCHEME: IS_USER_C
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(47696452253028618)  -- IS_USER_C
,p_name=>'IS_USER_C'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'RETURN tsk_auth.is_user (',
'    in_component_id     => :APP_COMPONENT_ID,',
'    in_component_type   => :APP_COMPONENT_TYPE,',
'    in_component_name   => :APP_COMPONENT_NAME,',
'    in_action           => ''C''',
') = ''Y'';'))
,p_error_message=>'ACCESS_DENIED|IS_USER_C'
,p_caching=>'NOCACHE'
);
wwv_flow_imp.component_end;
end;
/
