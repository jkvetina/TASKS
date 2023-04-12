prompt --application/shared_components/navigation/lists/navigation_top
begin
--   Manifest
--     LIST: NAVIGATION_TOP
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(35451863240367303)
,p_name=>'NAVIGATION_TOP'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    t.lvl,',
'    t.label, ',
'    t.target, ',
'    t.is_current_list_entry,',
'    t.image, ',
'    t.image_attribute,',
'    t.image_alt_attribute,',
'    t.attribute01,',
'    t.attribute02,',
'    t.attribute03,',
'    t.attribute04,',
'    t.attribute05,',
'    t.attribute06,',
'    t.attribute07,',
'    t.attribute08,',
'    t.attribute09,',
'    t.attribute10',
'FROM tsk_navigation_top_v t',
'ORDER BY t.order#;'))
,p_list_status=>'PUBLIC'
);
wwv_flow_imp.component_end;
end;
/
