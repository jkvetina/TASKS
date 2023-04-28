prompt --application/pages/page_00980
begin
--   Manifest
--     PAGE: 00980
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
 p_id=>980
,p_name=>'<span class="fa fa-question-circle"></span>'
,p_alias=>'HELP'
,p_step_title=>'Help'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(44075748371802774)  -- USER_PROFILE
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45933040311991408)
,p_plug_name=>'Setup new Project'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(70897202010975620)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>2
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ol>',
'    <li>create Client</li>',
'    <li>create Project</li>',
'    <li>create Board</li>',
'    <li>create Statuses</li>',
'    <li>create Swimlanes</li>',
'    <li>start creating Tasks</li>',
'</ol>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47575019438232102)
,p_plug_name=>'Help'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47575260260232104)
,p_plug_name=>'Add Users'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(70897202010975620)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>2
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ol>',
'    <li>create user in Users</li>',
'    <li>assign user to Client under Map Clients</li>',
'    <li>assign Roles to the user under Map Roles</li>',
'</ol>',
'',
'If you want manage Client/Project users, you have to select that Client/Project first.'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47575329419232105)
,p_plug_name=>'Context'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(70897202010975620)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>2
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ol>',
'    <li>if you want to change Board/Project/Client, you have to select it first</li>',
'</ol>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp.component_end;
end;
/
