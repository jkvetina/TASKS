prompt --application/pages/page_00956
begin
--   Manifest
--     PAGE: 00956
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
 p_id=>956
,p_name=>'Map Projects'
,p_alias=>'MAP-PROJECTS'
,p_step_title=>'Map Projects'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(78950012693576929)  -- ADMIN
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(71258399003174376)  -- MASTER - IS_ADMIN
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(93242580670622973)
,p_plug_name=>'Map Projects'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(93242699374622974)
,p_plug_name=>'Map Projects'
,p_parent_plug_id=>wwv_flow_imp.id(93242580670622973)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(93242839821622975)
,p_plug_name=>'Map Projects [GRID]'
,p_parent_plug_id=>wwv_flow_imp.id(93242580670622973)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70831193948975578)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp.component_end;
end;
/