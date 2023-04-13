prompt --application/pages/page_00300
begin
--   Manifest
--     PAGE: 00300
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
 p_id=>300
,p_name=>'Projects'
,p_alias=>'PROJECTS'
,p_step_title=>'Projects'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(78949836938576475)  -- MAIN
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const draggables = document.querySelectorAll(''.TASK'');',
'const droppables = document.querySelectorAll(''.TARGET'');',
'',
'draggables.forEach((task) => {',
'    task.addEventListener(''dragstart'', () => {',
'        task.classList.add(''DRAGGING'');',
'    });',
'    //',
'    task.addEventListener(''dragend'', (p) => {',
'        task.classList.remove(''DRAGGING'');',
'        //',
'        var sorted          = [];',
'        var target_primary  = p.target.parentElement.getAttribute(''id'');',
'        var target_alt      = p.target.parentElement.parentElement.getAttribute(''id'');',
'        //',
'        const target        = target_primary.indexOf(''TASK_'') === 0 ? target_alt : target_primary;',
'        const task_id       = task.getAttribute(''id'').replace(''TASK_'', '''');',
'        const status_id     = target.replace(''STATUS_'', '''').split(''_SWIMLANE_'')[0];',
'        const swimlane_id   = target.replace(''STATUS_'', '''').split(''_SWIMLANE_'')[1];',
'        const tasks         = document.getElementById(target).querySelectorAll(''.TASK'');',
'        //',
'        tasks.forEach(function(task) {',
'            sorted.push(task.getAttribute(''id'').replace(''TASK_'', ''''));',
'        });',
'        sorted = sorted.join('':'');',
'        //',
'        console.group(''TASK_MOVED'');',
'        console.log(''TASK     :'', task_id);',
'        console.log(''TARGET   :'', target, target_primary, target_alt);',
'        console.log(''STATUS   :'', status_id);',
'        console.log(''SWIMLANE :'', swimlane_id);',
'        console.log(''SORTED   :'', sorted);',
'        console.groupEnd();',
'        //',
'        apex.server.process(''UPDATE_TASK'',',
'            {',
'                x01: task_id,',
'                x02: status_id,',
'                x03: swimlane_id,',
'                x04: sorted',
'            },',
'            {',
'                dataType: ''text'',',
'                success: function(pData) {',
'                    console.log(''RESULT'', pData);',
'                    if (pData.indexOf(''sqlerrm'') >= 0) {',
'                        apex.message.showErrors([{',
'                            type        : ''error'',',
'                            location    : [''page'', ''inline''],',
'                            pageItem    : '''',',
'                            message     : pData.split(''sqlerrm:'')[1],',
'                            unsafe      : false',
'                        }]);',
'                    }',
'                    else {',
'                        apex.message.showPageSuccess(pData);',
'                    }',
'                }',
'            }',
'        );',
'    });',
'});',
'',
'droppables.forEach((zone) => {',
'    zone.addEventListener(''dragover'', (e) => {',
'        e.preventDefault();',
'        //',
'        const curr_task = document.querySelector(''.DRAGGING'');',
'        const last_task = insertAboveTask(zone, e.clientY);',
'        //',
'        //console.log(''DRAGGING'', curr_task.getAttribute(''id''), zone.getAttribute(''id''));',
'        //',
'        if (!curr_task) {',
'            zone.appendChild(curr_task);',
'        }',
'        else {',
'            zone.insertBefore(curr_task, last_task);',
'        }',
'    });',
'});',
'',
'const insertAboveTask = (zone, mouseY) => {',
'    const els = zone.querySelectorAll(''.TASK:not(.DRAGGING)'');',
'    //',
'    let closest_task   = null;',
'    let closest_offset = Number.NEGATIVE_INFINITY;',
'    //',
'    els.forEach((task) => {',
'        const { top } = task.getBoundingClientRect();',
'        const offset  = mouseY - top;',
'        //',
'        if (offset < 0 && offset > closest_offset) {',
'            closest_offset = offset;',
'            closest_task   = task;',
'        }',
'    });',
'    //',
'    return closest_task;',
'};',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.BOARD {',
'    width                   : 100%;',
'    height                  : 100vh;',
'    overflow                : scroll;',
'    display                 : grid;',
'    grid-template-columns   : 100px repeat(6, minmax(300px, 1fr)); /* overridden on tag */',
'    grid-auto-rows          : max-content;',
'    grid-column-gap         : 0.5rem;',
'    grid-row-gap            : 0.5rem;',
'    padding                 : 0 1rem 1rem 0;',
'}',
'',
'.TARGET,',
'.TARGET_LIKE {',
'    margin          : 0;',
'    border-radius   : 5px;',
'    box-shadow      : 0 5px 10px rgba(0, 0, 0, 0.15);',
'    background      : #f9f9f9;',
'}',
'.TARGET_LIKE,',
'.TARGET_LIKE h3,',
'.BOARD h3 {',
'    padding         : 0 0.5rem;',
'    border          : 0;',
'    box-shadow      : none;',
'    background      : transparent;',
'    text-align      : center;',
'    font-size       : 100%;',
'}',
'',
'.TASK {',
'    margin          : 0.5rem;',
'    padding         : 0.8rem;',
'    border-radius   : 4px;',
'    box-shadow      : 0 5px 10px rgba(0, 0, 0, 0.05);',
'    cursor          : move;',
'    font-size       : 90%;',
'    background      : #fff;',
'    color           : #000;',
'}',
'.TASK a,',
'.TASK a:hover {',
'    color               : #000;',
'    text-decoration     : none;',
'}',
'',
'.DRAGGING {',
'    box-shadow      : 0px 5px 10px rgba(0, 0, 0, 0.20);',
'    background      : rgb(64, 64, 64);',
'    color           : #fff !important;',
'}',
'.DRAGGING a {',
'    color           : #fff !important;',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(71258645843174377)  -- MASTER - IS_USER
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(70448343714945041)
,p_plug_name=>'Projects'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(70448427208945042)
,p_plug_name=>'Projects'
,p_parent_plug_id=>wwv_flow_imp.id(70448343714945041)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(104323750697905488)
,p_plug_name=>'Projects [GRID]'
,p_parent_plug_id=>wwv_flow_imp.id(70448343714945041)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70887424081975615)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_P100_PROJECTS_V'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Projects [GRID]'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(70449303000945050)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(70449331137945051)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(70451117745945068)
,p_name=>'ACTIVATE_URL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVATE_URL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_link_target=>'&ACTIVATE_URL.'
,p_link_text=>'ACTIVATE'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(104324277063905493)
,p_name=>'CLIENT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CLIENT_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Client Id'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(34762829880497308)  -- LOV_CLIENTS
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_default_type=>'ITEM'
,p_default_expression=>'P0_CLIENT_ID'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(104324356126905494)
,p_name=>'PROJECT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Project Id'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>32
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(104324538396905495)
,p_name=>'PROJECT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROJECT_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Project Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>64
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(104324624006905496)
,p_name=>'IS_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_ACTIVE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Is Active'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'Y'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(104324196732905492)
,p_internal_uid=>104324196732905492
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(105216798785921280)
,p_interactive_grid_id=>wwv_flow_imp.id(104324196732905492)
,p_static_id=>'347283'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(105216953892921280)
,p_report_id=>wwv_flow_imp.id(105216798785921280)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(70521512127509992)
,p_view_id=>wwv_flow_imp.id(105216953892921280)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(70449303000945050)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(70555105775961583)
,p_view_id=>wwv_flow_imp.id(105216953892921280)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(70451117745945068)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(105222301567921297)
,p_view_id=>wwv_flow_imp.id(105216953892921280)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(104324277063905493)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>1
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(105223151784921299)
,p_view_id=>wwv_flow_imp.id(105216953892921280)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(104324356126905494)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(105224060530921302)
,p_view_id=>wwv_flow_imp.id(105216953892921280)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(104324538396905495)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(105224958935921304)
,p_view_id=>wwv_flow_imp.id(105216953892921280)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(104324624006905496)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(35357036941008061)
,p_name=>'CHANGED_CLIENT'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P300_CLIENT_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(35357587671008062)
,p_event_id=>wwv_flow_imp.id(35357036941008061)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(35357975049008062)
,p_name=>'CHANGED_PROJECT'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P300_PROJECT_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(35358400253008062)
,p_event_id=>wwv_flow_imp.id(35357975049008062)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(35358838765008063)
,p_name=>'CHANGED_BOARD'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P300_BOARD_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(35359376013008063)
,p_event_id=>wwv_flow_imp.id(35358838765008063)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(35360687300008064)
,p_name=>'CHANGED_SWIMLINE'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P300_SWIMLANE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(35361145267008064)
,p_event_id=>wwv_flow_imp.id(35360687300008064)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(35338344188008044)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(104323750697905488)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_PROJECTS'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp.component_end;
end;
/