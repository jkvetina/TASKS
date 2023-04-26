prompt --application/shared_components/logic/application_processes/after_auth
begin
--   Manifest
--     APPLICATION PROCESS: AFTER_AUTH
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(35098301947828232)
,p_process_sequence=>1
,p_process_point=>'AFTER_LOGIN'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'AFTER_AUTH'
,p_process_sql_clob=>'tsk_auth.after_auth(:APP_USER);'
,p_process_clob_language=>'PLSQL'
);
wwv_flow_imp.component_end;
end;
/
