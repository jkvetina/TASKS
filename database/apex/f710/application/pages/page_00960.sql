prompt --application/pages/page_00960
begin
--   Manifest
--     PAGE: 00960
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
 p_id=>960
,p_name=>'Roles'
,p_alias=>'ROLES'
,p_step_title=>'Roles'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(78950012693576929)  -- ADMIN
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(47236933937694563)  -- IS_ADMIN
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(92944558771865460)
,p_plug_name=>'Roles'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(92944636943865461)
,p_plug_name=>'Roles'
,p_parent_plug_id=>wwv_flow_imp.id(92944558771865460)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(92944735956865462)
,p_plug_name=>'Roles [GRID]'
,p_parent_plug_id=>wwv_flow_imp.id(92944558771865460)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70887424081975615)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_P960_ROLES_V'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Roles [GRID]'
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
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47575757836232109)
,p_heading=>'Counters'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47575880927232110)
,p_heading=>'Flags'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47575963184232111)
,p_heading=>'Role Info'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47000126970134501)
,p_name=>'ROLE_GROUP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_GROUP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Role Group'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(47575963184232111)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
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
 p_id=>wwv_flow_imp.id(47000290580134502)
,p_name=>'ROLE_DESC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_DESC'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Role Desc'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(47575963184232111)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>512
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47000375216134503)
,p_name=>'ORDER#'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORDER#'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Order#'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_imp.id(47575963184232111)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47575406358232106)
,p_name=>'COUNT_PAGES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNT_PAGES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Pages'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>100
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_imp.id(47575757836232109)
,p_use_group_for=>'BOTH'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47575526126232107)
,p_name=>'COUNT_TABLES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNT_TABLES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Tables'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_imp.id(47575757836232109)
,p_use_group_for=>'BOTH'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47575634265232108)
,p_name=>'COUNT_USERS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COUNT_USERS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Users'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>120
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_imp.id(47575757836232109)
,p_use_group_for=>'BOTH'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(92945231888865467)
,p_name=>'ROLE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Role'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(47575963184232111)
,p_use_group_for=>'BOTH'
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
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(92945334906865468)
,p_name=>'ROLE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Role Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(47575963184232111)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
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
 p_id=>wwv_flow_imp.id(92945448440865469)
,p_name=>'IS_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_ACTIVE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Active'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47575880927232110)
,p_use_group_for=>'BOTH'
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
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(92948048673865495)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(92945170052865466)
,p_internal_uid=>92945170052865466
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
 p_id=>wwv_flow_imp.id(92971572672058617)
,p_interactive_grid_id=>wwv_flow_imp.id(92945170052865466)
,p_static_id=>'464267'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(92971771246058617)
,p_report_id=>wwv_flow_imp.id(92971572672058617)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47006071484136753)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(47000126970134501)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>180
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47006934384136759)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(47000290580134502)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47007837093136763)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(47000375216134503)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47622977963129839)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(47575406358232106)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47623805918129843)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(47575526126232107)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47624747412129847)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(47575634265232108)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(92972983788058621)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(92945231888865467)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>240
,p_sort_order=>2
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(92973839728058624)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(92945334906865468)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>240
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(92974691126058626)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(92945448440865469)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(92991630474127896)
,p_view_id=>wwv_flow_imp.id(92971771246058617)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(92948048673865495)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48280136987043204)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(92944636943865461)
,p_button_name=>'REORDER_ROLES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Reorder Roles'
,p_button_position=>'RIGHT_OF_TITLE'
,p_icon_css_classes=>'fa-list-ol'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(46681691523104310)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(92944636943865461)
,p_button_name=>'ADD_ROLE_WIZARD'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70970074101975671)
,p_button_image_alt=>'Add Role Wizard'
,p_button_position=>'RIGHT_OF_TITLE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46574890151936493)
,p_name=>'CHANGE_FILTERS'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P960_CLIENT_ID,P960_ROLE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46575370057936495)
,p_event_id=>wwv_flow_imp.id(46574890151936493)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(46564247311936481)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(92944735956865462)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_ROLES'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>wwv_flow_string.join(wwv_flow_t_varchar2(
'tsk_p960.save_roles (',
'    io_role_id  => :ROLE_ID',
');'))
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48279797290040037)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REORDER_STATUSES'
,p_process_sql_clob=>'tsk_p960.reorder_roles();'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48280136987043204)
);
wwv_flow_imp.component_end;
end;
/
