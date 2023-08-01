prompt --application/shared_components/logic/application_processes/init_defaults
begin
--   Manifest
--     APPLICATION PROCESS: INIT_DEFAULTS
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(44096575667033004)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'INIT_DEFAULTS'
,p_process_sql_clob=>'tsk_app.init_defaults();'
,p_process_clob_language=>'PLSQL'
);
wwv_flow_imp.component_end;
end;
/
