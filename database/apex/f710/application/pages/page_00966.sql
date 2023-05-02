prompt --application/pages/page_00966
begin
--   Manifest
--     PAGE: 00966
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
 p_id=>966
,p_name=>'Map Procedures'
,p_alias=>'MAP-PROCEDURES'
,p_step_title=>'Map Procedures'
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
 p_id=>wwv_flow_imp.id(235343864849609931)
,p_plug_name=>'Map Procedures'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(235344967604609942)
,p_plug_name=>'Map Procedures'
,p_parent_plug_id=>wwv_flow_imp.id(235343864849609931)
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
 p_id=>wwv_flow_imp.id(235345126132609943)
,p_plug_name=>'Map Procedures [GRID]'
,p_parent_plug_id=>wwv_flow_imp.id(235343864849609931)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70887424081975615)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_P966_MAP_PROCEDURES_V'
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
 p_id=>wwv_flow_imp.id(47740434224626914)
,p_name=>'OBJECT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OBJECT_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Object Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
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
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47740580343626915)
,p_name=>'PROCEDURE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROCEDURE_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
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
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47740645583626916)
,p_name=>'ROLE_1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_1.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
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
,p_display_condition=>'P966_ROLE_1'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47740791334626917)
,p_name=>'ROLE_2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_2.'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P966_ROLE_2'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47740895410626918)
,p_name=>'ROLE_3'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_3'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_3.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
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
,p_display_condition=>'P966_ROLE_3'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47740990712626919)
,p_name=>'ROLE_4'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_4'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_4.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
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
,p_display_condition=>'P966_ROLE_4'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47741090040626920)
,p_name=>'ROLE_5'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_5'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_5.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
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
,p_display_condition=>'P966_ROLE_5'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47741197604626921)
,p_name=>'ROLE_6'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_6'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_6.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
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
,p_display_condition=>'P966_ROLE_6'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47741277036626922)
,p_name=>'ROLE_7'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_7'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_7.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
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
,p_display_condition=>'P966_ROLE_7'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47741392838626923)
,p_name=>'ROLE_8'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROLE_8'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SINGLE_CHECKBOX'
,p_heading=>'&P966_ROLE_8.'
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
,p_display_condition=>'P966_ROLE_8'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(47742233805626932)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(48052847546927132)
,p_name=>'TABLE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TABLE_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Table Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(46514006412586236)  -- LOV_APP_TABLES
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
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(235347904099609971)
,p_internal_uid=>235347904099609971
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
 p_id=>wwv_flow_imp.id(235412618546048308)
,p_interactive_grid_id=>wwv_flow_imp.id(235347904099609971)
,p_static_id=>'464687'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>50
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(235412771295048308)
,p_report_id=>wwv_flow_imp.id(235412618546048308)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47996657367600876)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(47740434224626914)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>180
,p_sort_order=>1
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47997560347600884)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(47740580343626915)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>2
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47998402995600887)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(47740645583626916)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(47999256696600889)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(47740791334626917)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48000187395600892)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(47740895410626918)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48001032459600894)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(47740990712626919)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48001929021600897)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(47741090040626920)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48002867314600900)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(47741197604626921)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48003784589600902)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(47741277036626922)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48004623203600905)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(47741392838626923)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48025140666807422)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(47742233805626932)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(48238224050853586)
,p_view_id=>wwv_flow_imp.id(235412771295048308)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(48052847546927132)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>240
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(283655392850911572)
,p_interactive_grid_id=>wwv_flow_imp.id(235347904099609971)
,p_name=>'Grid/Form Handlers'
,p_static_id=>'482429'
,p_type=>'ALTERNATIVE'
,p_default_view=>'GRID'
,p_rows_per_page=>50
,p_show_row_number=>false
,p_settings_area_expanded=>false
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(283655545599911572)
,p_report_id=>wwv_flow_imp.id(283655392850911572)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96239431672464140)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(47740434224626914)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>240
,p_sort_order=>1
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96240334652464148)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(47740580343626915)
,p_is_visible=>true
,p_is_frozen=>false
,p_sort_order=>2
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96241177300464151)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(47740645583626916)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96242031001464153)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(47740791334626917)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96242961700464156)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(47740895410626918)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96243806764464158)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(47740990712626919)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96244703326464161)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(47741090040626920)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96245641619464164)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(47741197604626921)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96246558894464166)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(47741277036626922)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96247397508464169)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(47741392838626923)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96267914971670686)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(47742233805626932)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(96480998355716850)
,p_view_id=>wwv_flow_imp.id(283655545599911572)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(48052847546927132)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>300
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47741427775626924)
,p_name=>'P966_ROLE_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47741597753626925)
,p_name=>'P966_ROLE_2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47741616118626926)
,p_name=>'P966_ROLE_3'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47741715760626927)
,p_name=>'P966_ROLE_4'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47741807498626928)
,p_name=>'P966_ROLE_5'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47741976949626929)
,p_name=>'P966_ROLE_6'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47742091157626930)
,p_name=>'P966_ROLE_7'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47742129917626931)
,p_name=>'P966_ROLE_8'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48018272930746686)
,p_name=>'P966_ROLE_GROUP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
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
 p_id=>wwv_flow_imp.id(48018590563748516)
,p_name=>'P966_ROLE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(235344967604609942)
,p_prompt=>'Role'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ROLES'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P966_ROLE_GROUP'
,p_ajax_items_to_submit=>'P966_ROLE_GROUP'
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
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(47806454934187333)
,p_name=>'CHANGE_FILTERS'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P966_ROLE_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(47806996532187333)
,p_event_id=>wwv_flow_imp.id(47806454934187333)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(235345126132609943)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(47807448283187333)
,p_event_id=>wwv_flow_imp.id(47806454934187333)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(47742418320626934)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(235345126132609943)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'SAVE_PROCEDURES'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>'tsk_p966.save_procedures();'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp.component_end;
end;
/
