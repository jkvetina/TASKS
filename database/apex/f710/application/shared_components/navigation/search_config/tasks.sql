prompt --application/shared_components/navigation/search_config/tasks
begin
--   Manifest
--     SEARCH CONFIG: TASKS
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_search_config(
 p_id=>wwv_flow_imp.id(49576429373209742)
,p_label=>'TASKS'
,p_static_id=>'TASKS'
,p_search_type=>'SIMPLE'
,p_location=>'LOCAL'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_TASKS'
,p_searchable_columns=>'CATEGORY_ID:OWNER_ID:TAGS:TASK_ID:TASK_NAME:TASK_DESC:STATUS_ID:SWIMLANE_ID'
,p_pk_column_name=>'TASK_ID'
,p_title_column_name=>'TASK_NAME'
,p_description_column_name=>'TASK_DESC'
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:105:&APP_SESSION.::&DEBUG.:105:P105_TASK_ID,P105_SOURCE_PAGE:&TASK_ID.,115'
,p_icon_source_type=>'STATIC_CLASS'
,p_icon_css_classes=>'fa-tasks'
);
wwv_flow_imp.component_end;
end;
/
