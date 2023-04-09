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
 p_id=>wwv_flow_imp.id(78949836938576475)  -- MAIN
,p_group_name=>'MAIN'
);
wwv_flow_imp.component_end;
end;
/
