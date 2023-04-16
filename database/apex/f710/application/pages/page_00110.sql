prompt --application/pages/page_00110
begin
--   Manifest
--     PAGE: 00110
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
 p_id=>110
,p_name=>'Bulk Operations'
,p_alias=>'BULK-OPERATIONS'
,p_page_mode=>'MODAL'
,p_step_title=>'Bulk Operations'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(78949836938576475)  -- MAIN
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* HIDE DESC LABEL */',
'#P105_TASK_DESC_CONTAINER .t-Form-labelContainer {',
'  display: none;',
'}',
'#P105_TASK_DESC_CONTAINER .t-Form-itemWrapper {',
'  margin: 0 !important;',
'}',
'',
'',
'',
'/* HIDE EVERYTHING RELATED TO GRID */',
'#CHECKLIST .a-IG-header,',
'#CHECKLIST .a-GV-footer,',
'#CHECKLIST_ig_content_container .a-GV-hdr,',
'#CHECKLIST_ig_content_container .a-GV-footer,',
'#CHECKLIST_ig_content_container .js-stickyWidget-placeholder {',
'    display         : none !important;',
'}',
'#CHECKLIST_ig_content_container .a-IG {',
'    border          : 0 !important;',
'}',
'#CHECKLIST * {',
'    border          : 0 !important;',
'    box-shadow      : none !important;',
'    background      : transparent !important;',
'}',
'#CHECKLIST .CHECKLIST_BOX {',
'    margin-bottom   : -0.5rem;',
'}',
'#CHECKLIST .CHECKLIST_ITEM {',
'    border-bottom   : 1px dotted #333 !important;',
'    padding-left    : 0;',
'    padding-right   : 0;',
'}',
'#CHECKLIST .CHECKLIST_BOX .apex-item-single-checkbox {',
'    padding         : 3px 0 0 0.6rem;',
'}',
'#CHECKLIST .a-GV-cell.is-changed:not(.is-active):before,',
'#CHECKLIST .a-GV-row.is-updated .a-GV-selHeader:before {',
'    display         : none !important;',
'}',
'#CHECKLIST .a-GV-w-scroll {',
'    margin-left     : -0.6rem;',
'}',
'',
'',
'',
'/* RIGHT ALIGN USER COMMENTS */',
'#COMMENTS .t-Comments--chat li.OTHERS .t-Comments-icon {',
'    margin-left     : 2rem;',
'}',
'',
'/* FIX TRASH ICON ALIGNMENT */',
'span.t-Comments-actions {',
'    display         : block;',
'    float           : right;',
'    margin          : 0.25rem 0 -0.25rem;',
'}',
'',
''))
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(71258645843174377)  -- MASTER - IS_USER
,p_dialog_width=>'1280'
,p_protection_level=>'C'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44285977800494711)
,p_plug_name=>'Bulk Operations [FORM]'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44286090683494712)
,p_plug_name=>'LEFT'
,p_parent_plug_id=>wwv_flow_imp.id(44285977800494711)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(44286194908494713)
,p_plug_name=>'RIGHT'
,p_parent_plug_id=>wwv_flow_imp.id(44285977800494711)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(108389736618010267)
,p_plug_name=>'Bulk Operations'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(44286883866494720)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(108389736618010267)
,p_button_name=>'MAKE_CHANGES'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(70970074101975671)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Make Changes on &P110_AFFECTED_TASKS. tasks'
,p_button_position=>'RIGHT_OF_TITLE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(45188962868165718)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(108389736618010267)
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
 p_id=>wwv_flow_imp.id(44286206232494714)
,p_name=>'P110_SOURCE_STATUS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(44286090683494712)
,p_prompt=>'Source Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TASK_STATUSES'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44286306349494715)
,p_name=>'P110_SOURCE_SWIMLANE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(44286090683494712)
,p_prompt=>'Source Swimlanes'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TASK_SWIMLANES'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44286437803494716)
,p_name=>'P110_SOURCE_CLIENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(44286090683494712)
,p_item_default=>'P0_CLIENT_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Source Client'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CLIENTS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44286502131494717)
,p_name=>'P110_SOURCE_PROJECT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(44286090683494712)
,p_item_default=>'P0_PROJECT_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Source Project'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PROJECTS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44286665614494718)
,p_name=>'P110_SOURCE_BOARD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(44286090683494712)
,p_item_default=>'P0_BOARD_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Source Board'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_BOARDS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44287004908494722)
,p_name=>'P110_TARGET_CLIENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(44286194908494713)
,p_item_default=>'P0_CLIENT_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Target Client'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CLIENTS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44287133015494723)
,p_name=>'P110_TARGET_PROJECT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(44286194908494713)
,p_item_default=>'P0_PROJECT_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Target Project'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PROJECTS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44287282406494724)
,p_name=>'P110_TARGET_BOARD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(44286194908494713)
,p_item_default=>'P0_BOARD_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Target Board'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_BOARDS'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44287369760494725)
,p_name=>'P110_TARGET_STATUS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(44286194908494713)
,p_prompt=>'Target Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TASK_STATUSES'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44287496487494726)
,p_name=>'P110_TARGET_SWIMLANE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(44286194908494713)
,p_prompt=>'Target Swimlanes'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TASK_SWIMLANES'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(70967669576975668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(44287582624494727)
,p_name=>'P110_AFFECTED_TASKS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(108389736618010267)
,p_item_default=>'0'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(45209390022165756)
,p_name=>'CLOSE_DIALOG'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(45188962868165718)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(45209849904165757)
,p_event_id=>wwv_flow_imp.id(45209390022165756)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp.component_end;
end;
/
