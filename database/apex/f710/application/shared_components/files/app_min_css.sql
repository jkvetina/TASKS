prompt --application/shared_components/files/app_min_css
begin
--   Manifest
--     APP STATIC FILES: 710
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.4'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>710
,p_default_id_offset=>84847035874187356
,p_default_owner=>'APPS'
);
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E424F4152447B77696474683A313030253B646973706C61793A677269643B677269642D74656D706C6174652D636F6C756D6E733A31303070782072657065617428362C6D696E6D61782833303070782C31667229293B677269642D6175746F2D726F77';
wwv_flow_imp.g_varchar2_table(2) := '733A6D61782D636F6E74656E743B677269642D636F6C756D6E2D6761703A3172656D3B677269642D726F772D6761703A3172656D3B70616464696E673A30203172656D203172656D20307D2E5441524745542C2E5441524745545F4C494B457B6D617267';
wwv_flow_imp.g_varchar2_table(3) := '696E3A303B626F726465722D7261646975733A3570783B626F782D736861646F773A30203570782031307078207267626128302C302C302C2E3135293B6261636B67726F756E643A236639663966397D2E424F4152442068332C2E5441524745545F4C49';
wwv_flow_imp.g_varchar2_table(4) := '4B452C2E5441524745545F4C494B452068337B70616464696E673A30202E3572656D3B626F726465723A303B626F782D736861646F773A6E6F6E653B6261636B67726F756E643A3020303B746578742D616C69676E3A63656E7465723B666F6E742D7369';
wwv_flow_imp.g_varchar2_table(5) := '7A653A313030257D2E5441524745545F4C494B452068337B6D617267696E2D626F74746F6D3A307D2E5441534B7B6D617267696E3A2E3572656D3B70616464696E673A2E3872656D3B626F726465722D7261646975733A3470783B626F782D736861646F';
wwv_flow_imp.g_varchar2_table(6) := '773A30203570782031307078207267626128302C302C302C2E3035293B637572736F723A6D6F76653B666F6E742D73697A653A3930253B6261636B67726F756E643A236666663B636F6C6F723A233030307D2E5441534B20612C2E5441534B20613A686F';
wwv_flow_imp.g_varchar2_table(7) := '7665727B636F6C6F723A233030303B746578742D6465636F726174696F6E3A6E6F6E657D2E4452414747494E477B626F782D736861646F773A30203570782031307078207267626128302C302C302C2E32293B6261636B67726F756E643A233430343034';
wwv_flow_imp.g_varchar2_table(8) := '307D2E4452414747494E472C2E4452414747494E4720617B636F6C6F723A2366666621696D706F7274616E747D';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(44089643111330798)
,p_file_name=>'app.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
wwv_flow_imp.component_end;
end;
/
