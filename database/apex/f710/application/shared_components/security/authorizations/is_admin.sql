prompt --application/shared_components/security/authorizations/is_admin
begin
--   Manifest
--     SECURITY SCHEME: IS_ADMIN
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(47236933937694563)  -- IS_ADMIN
,p_name=>'IS_ADMIN'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>'RETURN tsk_auth.is_admin() = ''Y'';'
,p_error_message=>'ACCESS_DENIED|IS_ADMIN'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_imp.component_end;
end;
/
