prompt --application/pages/page_00105
begin
--   Manifest
--     PAGE: 00105
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
 p_id=>105
,p_name=>'New Task'
,p_alias=>'NEW-TASK'
,p_page_mode=>'MODAL'
,p_step_title=>'New Task'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(78949836938576475)  -- MAIN
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(71258645843174377)  -- MASTER - IS_USER
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(63213380867844590)
,p_plug_name=>'&P105_HEADER.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(63213536180844591)
,p_plug_name=>'[FORM]'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_TASKS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34798797839743638)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_button_name=>'CREATE_TASK'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70970074101975671)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create Task'
,p_button_position=>'NEXT'
,p_button_condition=>'P105_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_button_css_classes=>'u-pullRight'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34949339576065803)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_button_name=>'UPDATE_TASK'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70970074101975671)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Update Task'
,p_button_position=>'NEXT'
,p_button_condition=>'P105_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_button_css_classes=>'u-pullRight'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34949592599065805)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_button_name=>'DELETE_TASK'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Delete Task'
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>'P105_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_button_css_classes=>'u-pullRight'
,p_icon_css_classes=>'fa-trash-o'
,p_button_cattributes=>'style="margin-right: 0.5rem !important;"'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(63213580209844592)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(63213380867844590)
,p_button_name=>'CLOSE_DIALOG'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Close Dialog'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'u-pullRight'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34798917102743640)
,p_name=>'P105_TASK_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_default=>'TSK_TASK_ID'
,p_item_default_type=>'SEQUENCE'
,p_source=>'TASK_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799008594743641)
,p_name=>'P105_TASK_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_prompt=>'Task Name'
,p_source=>'TASK_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>64
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799148806743642)
,p_name=>'P105_TASK_DESC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_prompt=>'Task Desc'
,p_source=>'TASK_DESC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799227459743643)
,p_name=>'P105_BOARD_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_prompt=>'Board Id'
,p_source=>'BOARD_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_BOARDS'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799302370743644)
,p_name=>'P105_CLIENT_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_default=>'P0_CLIENT_ID'
,p_item_default_type=>'ITEM'
,p_source=>'CLIENT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799438673743645)
,p_name=>'P105_PROJECT_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_default=>'P0_PROJECT_ID'
,p_item_default_type=>'ITEM'
,p_source=>'PROJECT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799532575743646)
,p_name=>'P105_SWIMLANE_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_prompt=>'Swimlane Id'
,p_source=>'SWIMLANE_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TASK_SWIMLANES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799683532743647)
,p_name=>'P105_STATUS_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_prompt=>'Status Id'
,p_source=>'STATUS_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TASK_STATUSES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799770741743648)
,p_name=>'P105_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799818186743649)
,p_name=>'P105_UPDATED_AT'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_source=>'UPDATED_AT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34799957644743650)
,p_name=>'P105_ORDER_H'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_item_source_plug_id=>wwv_flow_imp.id(63213536180844591)
,p_prompt=>'Order#'
,p_source=>'ORDER#'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(63213944180844595)
,p_name=>'P105_HEADER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(63213380867844590)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(63214052740844596)
,p_computation_sequence=>10
,p_computation_item=>'P105_HEADER'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.page_name',
'FROM apex_application_pages p',
'WHERE p.application_id  = :APP_ID',
'    AND p.page_id       = :APP_PAGE_ID;'))
,p_compute_when=>'P105_TASK_ID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(34949428946065804)
,p_computation_sequence=>20
,p_computation_item=>'P105_HEADER'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'Update Task'
,p_compute_when=>'P105_TASK_ID'
,p_compute_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(63213674749844593)
,p_name=>'CLOSE_DIALOG'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(63213580209844592)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(63213859633844594)
,p_event_id=>wwv_flow_imp.id(63213674749844593)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34949211976065802)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(63213536180844591)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'SAVE_FORM'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34949717657065807)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'CLOSE_MODAL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34798826412743639)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(63213536180844591)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'INIT_FORM'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34954117428067239)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'INIT_DEFAULTS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P105_CLIENT_ID     := NVL(:P105_CLIENT_ID,     :P0_CLIENT_ID);',
':P105_PROJECT_ID    := NVL(:P105_PROJECT_ID,    :P0_PROJECT_ID);',
':P105_BOARD_ID      := NVL(:P105_BOARD_ID,      :P0_BOARD_ID);',
''))
,p_process_clob_language=>'PLSQL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34956155001097869)
,p_process_sequence=>30
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SAVE_FILTERS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P105_CLIENT_ID   := NVL(:P105_CLIENT_ID, :P0_CLIENT_ID);',
':P105_PROJECT_ID  := NVL(:P105_PROJECT_ID, :P0_PROJECT_ID);',
':P105_BOARD_ID    := NVL(:P105_BOARD_ID, :P0_BOARD_ID);',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp.component_end;
end;
/
