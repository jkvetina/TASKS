prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
--   Manifest
--     MENU: Breadcrumb
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(98776792421303600)
,p_name=>'Breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(34891279798102835)
,p_short_name=>'Tasks [RAW]'
,p_link=>'f?p=&APP_ID.:240:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>240
);
wwv_flow_imp.component_end;
end;
/
