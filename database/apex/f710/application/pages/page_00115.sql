prompt --application/pages/page_00115
begin
--   Manifest
--     PAGE: 00115
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
 p_id=>115
,p_name=>'Searching'
,p_alias=>'SEARCHING'
,p_page_mode=>'MODAL'
,p_step_title=>'Searching'
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
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(89525778213683337)
,p_plug_name=>'Searching [FORM]'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(153629537031198893)
,p_plug_name=>'Searching'
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
 p_id=>wwv_flow_imp.id(45240770564188627)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(153629537031198893)
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
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(45241195474188628)
,p_name=>'CLOSE_DIALOG'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(45240770564188627)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(45241617692188628)
,p_event_id=>wwv_flow_imp.id(45241195474188628)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp.component_end;
end;
/