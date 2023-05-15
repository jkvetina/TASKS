prompt --application/pages/page_00962
begin
--   Manifest
--     PAGE: 00962
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
 p_id=>962
,p_name=>'Map Pages'
,p_alias=>'MAP-PAGES'
,p_step_title=>'Map Pages'
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
 p_id=>wwv_flow_imp.id(139764209730244750)
,p_plug_name=>'Map Pages'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(139765312485244761)
,p_plug_name=>'Map Pages &P962_NOT_ASSIGNED.'
,p_parent_plug_id=>wwv_flow_imp.id(139764209730244750)
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
 p_id=>wwv_flow_imp.id(139765471013244762)
,p_plug_name=>'Map Pages [GRID]'
,p_parent_plug_id=>wwv_flow_imp.id(139764209730244750)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70887424081975615)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_P962_MAP_PAGES_V'
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
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(48360617433512138)
,p_heading=>'Page Info'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(48360741907512139)
,p_heading=>'Roles'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(48360816141512140)
,p_heading=>'Navigation'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47000955964134509)
,p_name=>'PAGE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Page Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(48360617433512138)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(47001011882134510)
,p_name=>'PAGE_GROUP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE_GROUP'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Page Group'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(48360617433512138)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(47001281825134512)
,p_name=>'ROLE_1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_1.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(47001354825134513)
,p_name=>'ROLE_2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_2.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(47001408415134514)
,p_name=>'ROLE_3'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_3'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_3.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(47001552602134515)
,p_name=>'ROLE_4'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_4'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_4.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(47002828036134528)
,p_name=>'ROLE_5'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_5'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_5.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(47002958155134529)
,p_name=>'ROLE_6'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_6'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_6.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(47003034400134530)
,p_name=>'ROLE_7'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_7'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_7.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(47003186705134531)
,p_name=>'ROLE_8'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_8'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P0_ROLE_8.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360741907512139)
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
 p_id=>wwv_flow_imp.id(48358233167512114)
,p_name=>'PARENT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARENT_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Parent Page'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(48360816141512140)
,p_use_group_for=>'BOTH'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(46513847178582916)  -- LOV_APP_PAGES
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
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48358361221512115)
,p_name=>'IS_HIDDEN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_HIDDEN'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Hidden'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360816141512140)
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48358474688512116)
,p_name=>'IS_RESET'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_RESET'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'Reset'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360816141512140)
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48358560863512117)
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
,p_group_id=>wwv_flow_imp.id(48360816141512140)
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
,p_readonly_condition_type=>'EXPRESSION'
,p_readonly_condition=>':IS_HIDDEN = ''Y'''
,p_readonly_condition2=>'PLSQL'
,p_readonly_for_each_row=>true
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48361002055512142)
,p_name=>'IS_MODAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_MODAL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Modal'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(48360617433512138)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'HTML'
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
 p_id=>wwv_flow_imp.id(48361165296512143)
,p_name=>'IS_USED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_USED'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>210
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(139768407775244792)
,p_name=>'PAGE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Page'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>40
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_imp.id(48360617433512138)
,p_use_group_for=>'BOTH'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(46513847178582916)  -- LOV_APP_PAGES
,p_lov_display_extra=>true
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
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(139826255037676156)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(139768248980244790)
,p_internal_uid=>139768248980244790
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
 p_id=>wwv_flow_imp.id(139832963426683127)
,p_interactive_grid_id=>wwv_flow_imp.id(139768248980244790)
,p_static_id=>'464687'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>50
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(139833116175683127)
,p_report_id=>wwv_flow_imp.id(139832963426683127)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47016763647321496)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(47000955964134509)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47017674192321499)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(47001011882134510)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>240
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47024616735413222)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(47001281825134512)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47025566722413240)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(47001354825134513)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47026468734413243)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(47001408415134514)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47027354507413246)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(47001552602134515)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47036988679592588)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(47002828036134528)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47037876277592591)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(47002958155134529)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47038750193592593)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(47003034400134530)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47039625039592596)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(47003186705134531)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48412204905456032)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(48358233167512114)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>160
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48413117308456040)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(48358361221512115)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>60
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48414053508456045)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(48358474688512116)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>60
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48414922467456047)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(48358560863512117)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48472829278678155)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(48361002055512142)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>60
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48473757067678158)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(48361165296512143)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(139840139064683168)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(139768407775244792)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
,p_sort_order=>2
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(139871446998804998)
,p_view_id=>wwv_flow_imp.id(139833116175683127)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(139826255037676156)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47219705769950931)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_imp.id(139765312485244761)
,p_button_name=>'REFRESH_MV'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70969417180975670)
,p_button_image_alt=>'Refresh MV'
,p_button_position=>'RIGHT_OF_TITLE'
,p_icon_css_classes=>'fa-cloud-upload'
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47000440051134504)
,p_name=>'P962_ROLE_GROUP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(139765312485244761)
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
 p_id=>wwv_flow_imp.id(47000563371134505)
,p_name=>'P962_ROLE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(139765312485244761)
,p_prompt=>'Role'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ROLES'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P962_ROLE_GROUP'
,p_ajax_items_to_submit=>'P962_ROLE_GROUP'
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
 p_id=>wwv_flow_imp.id(48054045562927144)
,p_name=>'P962_PAGE_GROUP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(139765312485244761)
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
 p_id=>wwv_flow_imp.id(48360909973512141)
,p_name=>'P962_NOT_ASSIGNED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(139764209730244750)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(46840627339379310)
,p_name=>'CHANGE_FILTERS'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P962_ROLE_ID,P962_PAGE_GROUP'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(47000841686134508)
,p_event_id=>wwv_flow_imp.id(46840627339379310)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(139765471013244762)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(46841100740379310)
,p_event_id=>wwv_flow_imp.id(46840627339379310)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(46823989540379294)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(139765471013244762)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_MAP_PAGES'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'tsk_p962.save_pages();'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47405677838201653)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REFRESH_MV'
,p_process_sql_clob=>'tsk_p962.refresh_mv();'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(47219705769950931)
,p_security_scheme=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
);
wwv_flow_imp.component_end;
end;
/
