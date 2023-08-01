prompt --application/pages/page_00980
begin
--   Manifest
--     PAGE: 00980
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
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
,p_group_id=>wwv_flow_imp.id(44075748371802774)  -- USER - PROFILE
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'ul li,',
'ol li {',
'    font-size: 100%;',
'    line-height: 140%;',
'    margin-bottom: 0.25rem;',
'}',
'p {',
'    line-height: 140%;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(47196033359190547)  -- IS_USER
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45933040311991408)
,p_plug_name=>'About this Application'
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style="padding: 0 1.5rem 0 0.5rem;"'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This application was designed to easily track project tasks on Kanban style board. You can do sprints, but you dont have to. You can track everything on 1 board if you want to.</p>',
'',
'<p>There is a hierarchy present: Client - Project(s) - Board(s) - Task(s). In a nutshell that is all you need. You create a task, you add checklists (things needed to achieve the task or also acceptance criteria) and you can move tasks by drag and dr'
||'op in between status columns (and swimlanes).</p>',
'',
'</p>You can add description, attach files, add comments to the tasks if needed. You can also assign commits done to specific tasks (manually on Commits page or automatically by using task_id on commit message).',
'With Tags you can link related tasks together. And you can also do a bulk operations on group of tasks.</p>',
'',
'<p>You can define your own statuses, swimlanes, task categories and colors for each project.</p>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47575260260232104)
,p_plug_name=>'About Security'
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style="padding: 0 1.5rem 0 0.5rem;"'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This application has security based on roles with quite extensive setup. As an administrator you can create new role (or manage existing roles) and map:</p>',
'',
'<ul>',
'    <li>Pages accessible to the specific roles (and as everything per client and project)</li>',
'    <li>Finetune individual page components (regions, buttons, columns, items...)</li>',
'    <li>Database tables (form & grid) with create, update, delete actions mapped to IS_USER_C|U|D authzorization schemes</li>',
'    <li>Database procedures you can run with a role, plus when table name and action is provided it also check C|U|D schemes</li>',
'</ul>',
'',
'<p>You have a global list of users and you have to assign users to the clients. Then you can specify what roles will user have on specific client or project (you have both levels). If project role is not found, then the client role is checked.</p>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47575329419232105)
,p_plug_name=>'About Context'
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style="padding: 0 1.5rem 0 0.5rem;"'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>'<p>Most of the pages (and data you will see) are based on a Board/Project/Client combination which you can change on homepage.</p>'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47577984530232131)
,p_plug_name=>'Creating new Project'
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style="padding: 0 1.5rem 0 0.5rem;"'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>You can use the <a href="&P980_PROJECT_WIZARD.">Project Wizard</a>, or go through individual steps:</p>',
'',
'<ol>',
'    <li>create <a href="&P980_CLIENT_ADD.">Client</a></li>',
'    <li>create <a href="&P980_PROJECT_ADD.">Project</a></li>',
'    <li>create <a href="&P980_BOARD_ADD.">Board</a></li>',
'    <li>create <a href="&P980_STATUS_ADD.">Statuses</a></li>',
'    <li>create <a href="&P980_SWIMLANE_ADD.">Swimlanes</a></li>',
'    <li>start creating <a href="&P980_TASK_ADD.">Tasks</a></li>',
'</ol>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47578019339232132)
,p_plug_name=>'Creating new User'
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style="padding: 0 1.5rem 0 0.5rem;"'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>You can use the <a href="&P980_USER_WIZARD.">User Wizard</a>, or go through individual steps:</p>',
'',
'<ol>',
'    <li>create user in <a href="&P980_USER_ADD.">Users</a></li>',
'    <li>assign user to Client under <a href="&P980_MAP_CLIENTS.">Map Clients</a></li>',
'    <li>assign Roles to the user under <a href="&P980_MAP_ROLES.">Map Roles</a></li>',
'    <li>you can set Roles for Client (all Projects) or just specific Project</li>',
'</ol>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47579167303232143)
,p_plug_name=>'About this Application'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47579266113232144)
,p_plug_name=>'Creating new Project'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47579316466232145)
,p_plug_name=>'About Security'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47579417214232146)
,p_plug_name=>'Creating new User'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70864195177975601)
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578140696232133)
,p_name=>'P980_PROJECT_WIZARD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(47577984530232131)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578216785232134)
,p_name=>'P980_CLIENT_ADD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(47577984530232131)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578305002232135)
,p_name=>'P980_PROJECT_ADD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(47577984530232131)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578424565232136)
,p_name=>'P980_BOARD_ADD'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(47577984530232131)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578518283232137)
,p_name=>'P980_STATUS_ADD'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(47577984530232131)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578691108232138)
,p_name=>'P980_SWIMLANE_ADD'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(47577984530232131)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578744411232139)
,p_name=>'P980_TASK_ADD'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(47577984530232131)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578830472232140)
,p_name=>'P980_MAP_ROLES'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(47578019339232132)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47578905782232141)
,p_name=>'P980_MAP_CLIENTS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(47578019339232132)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47579037285232142)
,p_name=>'P980_USER_ADD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(47578019339232132)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47579509425232147)
,p_name=>'P980_USER_WIZARD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(47578019339232132)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp.component_end;
end;
/
