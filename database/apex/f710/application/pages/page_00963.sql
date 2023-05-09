prompt --application/pages/page_00963
begin
--   Manifest
--     PAGE: 00963
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
 p_id=>963
,p_name=>'Map Components'
,p_alias=>'MAP-COMPONENTS'
,p_step_title=>'Map Components'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(48314253704596369)  -- ADMIN - USERS & ROLES
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(187541696974422604)
,p_plug_name=>'Map Components'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(187542799729422615)
,p_plug_name=>'Map Components &P963_NOT_ASSIGNED.'
,p_parent_plug_id=>wwv_flow_imp.id(187541696974422604)
,p_region_css_classes=>'FILTERS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(187542958257422616)
,p_plug_name=>'Map Components [GRID]'
,p_parent_plug_id=>wwv_flow_imp.id(187541696974422604)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70887424081975615)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_P963_MAP_COMPONENTS_V'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Map Pages [GRID]'
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
 p_id=>wwv_flow_imp.id(47742667532626936)
,p_name=>'COMPONENT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPONENT_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Component Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>30
,p_value_alignment=>'RIGHT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_is_required=>false
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
 p_id=>wwv_flow_imp.id(47742704423626937)
,p_name=>'COMPONENT_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPONENT_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Component Type'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
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
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47742878992626938)
,p_name=>'COMPONENT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPONENT_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Component Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'HTML'
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
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47743388624626943)
,p_name=>'PAGE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Page Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47743780195626947)
,p_name=>'ROLE_1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_1.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_1'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47743800310626948)
,p_name=>'ROLE_2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_2.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_2'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47743959429626949)
,p_name=>'ROLE_3'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_3'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_3.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_3'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47744038440626950)
,p_name=>'ROLE_4'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_4'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_4.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_4'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48049764090927101)
,p_name=>'ROLE_5'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_5'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_5.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_5'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48049880161927102)
,p_name=>'ROLE_6'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_6'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_6.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_6'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48049989226927103)
,p_name=>'ROLE_7'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_7'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_7.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_7'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48050017612927104)
,p_name=>'ROLE_8'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_8'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_8.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_8'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48050329999927107)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48051643083927120)
,p_name=>'PAGE_GROUP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE_GROUP'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Page Group'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
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
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48051787336927121)
,p_name=>'PAGE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Page'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
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
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48357359709512105)
,p_name=>'IS_USED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_USED'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Is Used'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48506535830203337)
,p_name=>'PATH_'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PATH_'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Path'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
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
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48506600964203338)
,p_name=>'DML_ACTIONS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DML_ACTIONS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>230
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(187545736224422644)
,p_internal_uid=>187545736224422644
,p_is_editable=>true
,p_edit_operations=>'u'
,p_edit_row_operations_column=>'DML_ACTIONS'
,p_lost_update_check_type=>'VALUES'
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
 p_id=>wwv_flow_imp.id(187610450670860981)
,p_interactive_grid_id=>wwv_flow_imp.id(187545736224422644)
,p_static_id=>'464687'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>1000
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(187610603419860981)
,p_report_id=>wwv_flow_imp.id(187610450670860981)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(7077010049177)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(47743780195626947)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8085095049180)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(47743800310626948)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(9112470049182)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(47743959429626949)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(10044091049185)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(47744038440626950)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(11061138049187)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(48049764090927101)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12106109049190)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(48049880161927102)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(13122558049198)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(48049989226927103)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14041342049201)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(48050017612927104)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48037671945548033)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(47742667532626936)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>180
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48038548536548037)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(47742704423626937)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
,p_sort_order=>2
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48039474288548040)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(47742878992626938)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>3
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48045746629808490)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(47743388624626943)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48082614058356506)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(48050329999927107)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48111584173624752)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(48051643083927120)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48120554214771929)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(48051787336927121)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48385287927640562)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(48357359709512105)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48603802576077622)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(48506535830203337)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>500
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48604756429077627)
,p_view_id=>wwv_flow_imp.id(187610603419860981)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(48506600964203338)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(235996572700505256)
,p_interactive_grid_id=>wwv_flow_imp.id(187545736224422644)
,p_name=>'Not Assigned'
,p_static_id=>'483863'
,p_type=>'ALTERNATIVE'
,p_default_view=>'GRID'
,p_rows_per_page=>1000
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(235996725449505256)
,p_report_id=>wwv_flow_imp.id(235996572700505256)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48393199039693452)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(47743780195626947)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48394207124693455)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(47743800310626948)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48395234499693457)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(47743959429626949)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48396166120693460)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(47744038440626950)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48397183167693462)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(48049764090927101)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48398228138693465)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(48049880161927102)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48399244587693473)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(48049989226927103)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48400163371693476)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(48050017612927104)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96423793975192308)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(47742667532626936)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>180
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96424670566192312)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(47742704423626937)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>180
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96425596318192315)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(47742878992626938)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>2
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96431868659452765)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(47743388624626943)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96468736088000781)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(48050329999927107)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96497706203269027)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(48051643083927120)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96506676244416204)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(48051787336927121)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96771409957284837)
,p_view_id=>wwv_flow_imp.id(235996725449505256)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(48357359709512105)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_filter(
 p_id=>wwv_flow_imp.id(48386215461644289)
,p_report_id=>wwv_flow_imp.id(235996572700505256)
,p_type=>'COLUMN'
,p_column_id=>wwv_flow_imp.id(48357359709512105)
,p_operator=>'N'
,p_is_case_sensitive=>false
,p_is_enabled=>true
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48506752507203339)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_button_name=>'PREV_PAGE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Previous Page'
,p_button_redirect_url=>'f?p=&APP_ID.:963:&SESSION.::&DEBUG.::P963_PAGE_ID:&P963_PREV_PAGE.'
,p_button_condition=>'P963_PREV_PAGE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-left'
,p_button_cattributes=>'style="margin-top: 0.8rem;"'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48506840708203340)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_button_name=>'NEXT_PAGE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Next Page'
,p_button_redirect_url=>'f?p=&APP_ID.:963:&SESSION.::&DEBUG.::P963_PAGE_ID:&P963_NEXT_PAGE.'
,p_button_condition=>'P963_NEXT_PAGE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-right'
,p_button_cattributes=>'style="margin-top: 0.8rem;"'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48613506902365406)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_button_name=>'PREV_GROUP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Previous Group'
,p_button_redirect_url=>'f?p=&APP_ID.:963:&SESSION.::&DEBUG.::P963_PAGE_GROUP:&P963_PREV_GROUP.'
,p_button_condition=>'P963_PREV_GROUP'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-left'
,p_button_cattributes=>'style="margin-top: 0.8rem;"'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48613672355365407)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_button_name=>'NEXT_GROUP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Next Page'
,p_button_redirect_url=>'f?p=&APP_ID.:963:&SESSION.::&DEBUG.::P963_PAGE_GROUP:&P963_NEXT_GROUP.'
,p_button_condition=>'P963_NEXT_GROUP'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-right'
,p_button_cattributes=>'style="margin-top: 0.8rem;"'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48658486533689420)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_button_name=>'REFRESH_MV'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Refresh MV'
,p_button_position=>'RIGHT_OF_TITLE'
,p_icon_css_classes=>'fa-cloud-upload'
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(48050183510927105)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_button_name=>'SYNC_REGIONS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70970074101975671)
,p_button_image_alt=>'Sync Regions'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_condition_type=>'NEVER'
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053973222927143)
,p_name=>'P963_PAGE_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_prompt=>'Page'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_APP_PAGES'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P963_PAGE_GROUP'
,p_ajax_items_to_submit=>'P963_PAGE_GROUP'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp.component_end;
end;
/
begin
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48105703811554331)
,p_name=>'P963_ROLE_GROUP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_prompt=>'Role Group'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ROLE_GROUPS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48106028893555839)
,p_name=>'P963_ROLE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_prompt=>'Role'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ROLES'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P963_ROLE_GROUP'
,p_ajax_items_to_submit=>'P963_ROLE_GROUP'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48312617221530558)
,p_name=>'P963_PAGE_GROUP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(187542799729422615)
,p_prompt=>'Page Group'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_APP_PAGE_GROUPS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48357439729512106)
,p_name=>'P963_NOT_ASSIGNED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(187541696974422604)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48613169596365402)
,p_name=>'P963_PREV_PAGE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(187541696974422604)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48613243181365403)
,p_name=>'P963_NEXT_PAGE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(187541696974422604)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48613397614365404)
,p_name=>'P963_PREV_GROUP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(187541696974422604)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48613491595365405)
,p_name=>'P963_NEXT_GROUP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(187541696974422604)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(48106267678558267)
,p_name=>'CHANGE_FILTERS'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P963_ROLE_ID,P963_PAGE_GROUP,P963_PAGE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48106687222558280)
,p_event_id=>wwv_flow_imp.id(48106267678558267)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(48107142694558281)
,p_event_id=>wwv_flow_imp.id(48106267678558267)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48050530460927109)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(187542958257422616)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_COMPONENTS'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'tsk_p963.save_components();'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48051562080927119)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SYNC_REGIONS'
,p_process_sql_clob=>'tsk_p963.sync_regions();'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48050183510927105)
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(48658679601691008)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REFRESH_MV'
,p_process_sql_clob=>'tsk_p963.refresh_mv();'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(48658486533689420)
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp.component_end;
end;
/
