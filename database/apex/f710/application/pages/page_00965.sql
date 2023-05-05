prompt --application/pages/page_00965
begin
--   Manifest
--     PAGE: 00965
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
 p_id=>965
,p_name=>'Map Tables'
,p_alias=>'MAP-TABLES'
,p_step_title=>'Map Tables'
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
 p_id=>wwv_flow_imp.id(233718813694237344)
,p_plug_name=>'Map Tables'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47412748283554624)
,p_plug_name=>'Map Tables [GRID]'
,p_parent_plug_id=>wwv_flow_imp.id(233718813694237344)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70887424081975615)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_P965_MAP_TABLES_V'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Map Tables [GRID]'
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
 p_id=>wwv_flow_imp.id(47508692815863704)
,p_heading=>'&P0_ROLE_1.'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47508775165863705)
,p_heading=>'&P0_ROLE_3.'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47508854175863706)
,p_heading=>'&P0_ROLE_5.'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47508923151863707)
,p_heading=>'&P0_ROLE_7.'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47576813522232120)
,p_heading=>'&P0_ROLE_2.'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47576953205232121)
,p_heading=>'&P0_ROLE_4.'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47577016998232122)
,p_heading=>'&P0_ROLE_6.'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(47577186599232123)
,p_heading=>'&P0_ROLE_8.'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47412992172554626)
,p_name=>'TABLE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TABLE_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Table Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
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
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413052429554627)
,p_name=>'ROLE_1C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_1C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508692815863704)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_1'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413122830554628)
,p_name=>'ROLE_1U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_1U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508692815863704)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_1'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413237905554629)
,p_name=>'ROLE_1D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_1D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508692815863704)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_1'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413340418554630)
,p_name=>'ROLE_2C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_2C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47576813522232120)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_2'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413476905554631)
,p_name=>'ROLE_2U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_2U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47576813522232120)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_2'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413555791554632)
,p_name=>'ROLE_2D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_2D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47576813522232120)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_2'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413639882554633)
,p_name=>'ROLE_3C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_3C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508775165863705)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_3'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413707405554634)
,p_name=>'ROLE_3U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_3U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508775165863705)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_3'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413816806554635)
,p_name=>'ROLE_3D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_3D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508775165863705)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_3'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47413937650554636)
,p_name=>'ROLE_4C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_4C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47576953205232121)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_4'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414058311554637)
,p_name=>'ROLE_4U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_4U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47576953205232121)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_4'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414187874554638)
,p_name=>'ROLE_4D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_4D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47576953205232121)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_4'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414289261554639)
,p_name=>'ROLE_5C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_5C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508854175863706)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_5'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414363393554640)
,p_name=>'ROLE_5U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_5U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508854175863706)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_5'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414422703554641)
,p_name=>'ROLE_5D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_5D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508854175863706)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_5'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414506940554642)
,p_name=>'ROLE_6C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_6C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47577016998232122)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_6'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414618485554643)
,p_name=>'ROLE_6U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_6U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47577016998232122)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_6'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414791496554644)
,p_name=>'ROLE_6D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_6D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>220
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47577016998232122)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_6'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414824474554645)
,p_name=>'ROLE_7C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_7C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>230
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508923151863707)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_7'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47414900578554646)
,p_name=>'ROLE_7U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_7U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>240
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508923151863707)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_7'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47415031045554647)
,p_name=>'ROLE_7D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_7D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>250
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47508923151863707)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_7'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47415104642554648)
,p_name=>'ROLE_8C'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_8C'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'C'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>260
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47577186599232123)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_8'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47415298969554649)
,p_name=>'ROLE_8U'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_8U'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'U'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>270
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47577186599232123)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_8'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47415314394554650)
,p_name=>'ROLE_8D'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_8D'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'D'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>280
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(47577186599232123)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_is_required=>false
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
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P0_ROLE_8'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47508305216863701)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47577262461232124)
,p_name=>'PROCEDURE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROCEDURE_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Procedure Name'
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
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(47412866390554625)
,p_internal_uid=>47412866390554625
,p_is_editable=>true
,p_edit_operations=>'u'
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
 p_id=>wwv_flow_imp.id(47485198374859515)
,p_interactive_grid_id=>wwv_flow_imp.id(47412866390554625)
,p_static_id=>'474852'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>50
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(47485330370859515)
,p_report_id=>wwv_flow_imp.id(47485198374859515)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(6096484003962)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(47508305216863701)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47485888358859517)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(47412992172554626)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47486787155859520)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(47413052429554627)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47487601428859523)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(47413122830554628)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47488506910859526)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(47413237905554629)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47489417663859529)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(47413340418554630)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47490357786859531)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(47413476905554631)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47491255813859534)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(47413555791554632)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47492152241859537)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(47413639882554633)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47493064413859540)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(47413707405554634)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47493966939859543)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(47413816806554635)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47494810202859546)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(47413937650554636)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47495725856859549)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(47414058311554637)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47496639277859551)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(47414187874554638)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
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
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47497519190859554)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(47414289261554639)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47498426057859557)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(47414363393554640)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47499361441859559)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(47414422703554641)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47500217567859562)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>19
,p_column_id=>wwv_flow_imp.id(47414506940554642)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47501147455859565)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>20
,p_column_id=>wwv_flow_imp.id(47414618485554643)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47502027188859568)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>21
,p_column_id=>wwv_flow_imp.id(47414791496554644)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47502949023859571)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>22
,p_column_id=>wwv_flow_imp.id(47414824474554645)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47503850448859574)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>23
,p_column_id=>wwv_flow_imp.id(47414900578554646)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47504726810859577)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>24
,p_column_id=>wwv_flow_imp.id(47415031045554647)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47505677114859579)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>25
,p_column_id=>wwv_flow_imp.id(47415104642554648)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47506529612859582)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>26
,p_column_id=>wwv_flow_imp.id(47415298969554649)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47507495221859585)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>27
,p_column_id=>wwv_flow_imp.id(47415314394554650)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47654168307914600)
,p_view_id=>wwv_flow_imp.id(47485330370859515)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(47577262461232124)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>240
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(233719605550237352)
,p_plug_name=>'Map Tables'
,p_parent_plug_id=>wwv_flow_imp.id(233718813694237344)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47508553836863703)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(47412748283554624)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_TABLES'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'tsk_p965.save_tables();'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp.component_end;
end;
/
