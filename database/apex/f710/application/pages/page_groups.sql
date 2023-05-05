prompt --application/pages/page_groups
begin
--   Manifest
--     PAGE GROUPS: 710
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(78950012693576929)  -- ADMIN
,p_group_name=>'ADMIN'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(48314253704596369)  -- ADMIN - USERS & ROLES
,p_group_name=>'ADMIN - USERS & ROLES'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(48313716242591318)  -- MAIN - BOARDS
,p_group_name=>'MAIN - BOARDS'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(48317416017603440)  -- MAIN - COMMITS
,p_group_name=>'MAIN - COMMITS'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(48314172391593638)  -- MAIN - PROJECTS & CLIENTS
,p_group_name=>'MAIN - PROJECTS & CLIENTS'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(78949836938576475)  -- MAIN - TASKS
,p_group_name=>'MAIN - TASKS'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(44075748371802774)  -- USER - PROFILE
,p_group_name=>'USER - PROFILE'
);
wwv_flow_imp.component_end;
end;
/
