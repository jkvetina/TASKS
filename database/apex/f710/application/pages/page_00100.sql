prompt --application/pages/page_00100
begin
--   Manifest
--     PAGE: 00100
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_page.create_page(
 p_id=>100
,p_name=>'Tasks'
,p_alias=>'HOME'
,p_step_title=>'&APP_NAME.'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(78949836938576475)  -- MAIN
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(71258645843174377)  -- MASTER - IS_USER
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(35122875520937003)
,p_plug_name=>'Tasks'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34744374076440316)
,p_plug_name=>'Tasks for &P100_BOARD_NAME.'
,p_parent_plug_id=>wwv_flow_imp.id(35122875520937003)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34744427648440317)
,p_plug_name=>'Tasks [CONTENT]'
,p_parent_plug_id=>wwv_flow_imp.id(35122875520937003)
,p_region_template_options=>'#DEFAULT#:margin-top-md'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    in_statuses     PLS_INTEGER;',
'BEGIN',
'    SELECT COUNT(s.status_id)',
'    INTO in_statuses',
'    FROM tsk_task_statuses s',
'    WHERE s.client_id       = :P0_CLIENT_ID',
'        AND s.project_id    = :P0_PROJECT_ID;',
'    --',
'    HTP.P(''<div class="BOARD" style="'' ||',
'        ''grid-template-columns: 100px repeat('' || in_statuses || '', minmax(300px, 1fr)); '' ||',
'        ''">'');',
'END;',
'--',
'FOR w IN (',
'    SELECT',
'        w.*,',
'        ROW_NUMBER() OVER (ORDER BY CASE WHEN w.swimlane_id = ''-'' THEN NULL ELSE w.order# END NULLS LAST) AS r#',
'    FROM tsk_task_swimlanes w',
'    WHERE w.client_id       = :P0_CLIENT_ID',
'        AND w.project_id    = :P0_PROJECT_ID',
'        AND (w.swimlane_id  = :P100_SWIMLANE_ID OR :P100_SWIMLANE_ID IS NULL)',
'    ORDER BY r#',
') LOOP',
'    -- column names',
'    IF w.r# = 1 THEN',
'        HTP.P(''<h3></h3>'');',
'        --',
'        FOR s IN (',
'            SELECT s.*',
'            FROM tsk_task_statuses s',
'            WHERE s.client_id       = :P0_CLIENT_ID',
'                AND s.project_id    = :P0_PROJECT_ID',
'            ORDER BY s.order#',
'        ) LOOP',
'            HTP.P(''<div class="TARGET_LIKE">'');',
'            HTP.P(''<h3>'' || s.status_name || ''</h3>'');',
'            HTP.P(''</div>'');',
'        END LOOP;',
'    END IF;',
'',
'    -- swimlanes per user',
'    HTP.P(''<h3 style="text-align: right;">'' || NULLIF(w.swimlane_name, ''-'') || ''</h3>'');',
'    --',
'    FOR s IN (',
'        SELECT s.*',
'        FROM tsk_task_statuses s',
'        WHERE s.client_id       = :P0_CLIENT_ID',
'            AND s.project_id    = :P0_PROJECT_ID',
'        ORDER BY s.order#',
'    ) LOOP',
'        HTP.P(''<div class="TARGET" id="STATUS_'' || s.status_id || ''_SWIMLANE_'' || w.swimlane_id || ''">'');',
'        --',
'        FOR t IN (',
'            SELECT',
'                t.task_id,',
'                t.task_name,',
'                --',
'                APEX_PAGE.GET_URL (',
'                    p_page          => 105,',
'                    p_clear_cache   => 105,',
'                    p_items         => ''P105_TASK_ID,P105_SOURCE_PAGE'',',
'                    p_values        => '''' || t.task_id || '',100''',
'                ) AS task_link,',
'                --',
'                NULLIF(SUM(CASE WHEN l.checklist_done = ''Y'' THEN 1 ELSE 0 END) || ''/'' || COUNT(l.checklist_id), ''0/0'') AS task_progress',
'            FROM tsk_tasks t',
'            LEFT JOIN tsk_task_checklist l',
'                ON l.task_id        = t.task_id',
'            WHERE t.client_id       = :P0_CLIENT_ID',
'                AND t.project_id    = :P0_PROJECT_ID',
'                AND t.board_id      = :P0_BOARD_ID',
'                AND t.status_id     = s.status_id',
'                AND t.swimlane_id   = w.swimlane_id',
'            GROUP BY',
'                t.task_id,',
'                t.task_name,',
'                t.order#',
'            ORDER BY t.order# NULLS LAST, t.task_id',
'        ) LOOP',
'            HTP.P(',
'                ''<div class="TASK" draggable="true" id="TASK_'' || t.task_id || ''">'' ||',
'                ''<a href="'' || t.task_link || ''">'' ||',
'                CASE WHEN t.task_progress IS NOT NULL',
'                    THEN ''<span style="float: right;">'' || t.task_progress || ''</span>''',
'                    END ||',
'                ''#'' || t.task_id || '' '' || t.task_name ||',
'                ''</a></div>''',
'            );',
'        END LOOP;',
'        --',
'        HTP.P(''</div>'');',
'    END LOOP;',
'END LOOP;',
'--',
'HTP.P(''</div>'');',
''))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(35123712321937012)
,p_plug_name=>'Filters'
,p_parent_plug_id=>wwv_flow_imp.id(35122875520937003)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34798486722743635)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(34744374076440316)
,p_button_name=>'ADD_TASK'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(70970191130975672)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Task'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:105:&SESSION.::&DEBUG.:105:P105_SOURCE_PAGE:100'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(35126878686937043)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(35125984655937034)
,p_button_name=>'REORDER_STATUSES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Reorder Statuses'
,p_button_position=>'RIGHT_OF_TITLE'
,p_icon_css_classes=>'fa-list-ol'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(35126986782937044)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(35126053649937035)
,p_button_name=>'REORDER_SWIMLANES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Reorder Swimlanes'
,p_button_position=>'RIGHT_OF_TITLE'
,p_icon_css_classes=>'fa-list-ol'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34952422242065834)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(34744374076440316)
,p_button_name=>'REFRESH_TASKS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Refresh Tasks'
,p_button_position=>'RIGHT_OF_TITLE'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34905220916116348)
,p_name=>'P100_CLIENT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(35123712321937012)
,p_prompt=>'Client'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CLIENTS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34905691081116349)
,p_name=>'P100_PROJECT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(35123712321937012)
,p_prompt=>'Project'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PROJECTS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34906072735116349)
,p_name=>'P100_BOARD_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(35123712321937012)
,p_prompt=>'Board'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_BOARDS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34951490119065824)
,p_name=>'P100_SWIMLANE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(35123712321937012)
,p_prompt=>'Swimlane'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_TASK_SWIMLANES'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(35124240356937017)
,p_name=>'P100_BOARD_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(35123712321937012)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(35124396504937018)
,p_computation_sequence=>10
,p_computation_item=>'P100_BOARD_NAME'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT b.board_name',
'FROM tsk_boards b',
'WHERE b.board_id = :P0_BOARD_ID;'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34906414430118509)
,p_name=>'CHANGED_CLIENT'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P100_CLIENT_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34906818783118510)
,p_event_id=>wwv_flow_imp.id(34906414430118509)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34797895247743629)
,p_name=>'CHANGED_PROJECT'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P100_PROJECT_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34797941868743630)
,p_event_id=>wwv_flow_imp.id(34797895247743629)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34798017052743631)
,p_name=>'CHANGED_BOARD'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P100_BOARD_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34798178572743632)
,p_event_id=>wwv_flow_imp.id(34798017052743631)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34951564344065825)
,p_name=>'CHANGED_SWIMLINE'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P100_SWIMLANE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34951606974065826)
,p_event_id=>wwv_flow_imp.id(34951564344065825)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34951752190065827)
,p_name=>'CLOSED_DETAIL'
,p_event_sequence=>80
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(35122614857937001)
,p_event_id=>wwv_flow_imp.id(34951752190065827)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'console.log(''DIALOG_CLOSED'');',
'location.reload();',
''))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(35124678578937021)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(103818363045884265)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_CLIENTS'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(35124975121937024)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(68999230713897460)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_PROJECTS'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(35125218112937027)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(69004865415898319)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_BOARDS'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(35125564158937030)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(69917364734925850)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_STATUSES'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(35125827314937033)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(69922594965926597)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_SWIMLANES'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34910738304127684)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'LOAD_FILTERS'
,p_process_sql_clob=>'tsk_app.load_tasks_filters();'
,p_process_clob_language=>'PLSQL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34798564961743636)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'UPDATE_TASK'
,p_process_sql_clob=>'tsk_app.update_task_on_drag();'
,p_process_clob_language=>'PLSQL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34907319414119830)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SAVE_FILTERS'
,p_process_sql_clob=>'tsk_app.save_tasks_filters();'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp.component_end;
end;
/
