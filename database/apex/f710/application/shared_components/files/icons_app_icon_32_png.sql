prompt --application/shared_components/files/icons_app_icon_32_png
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
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF4000000017352474200AECE1CE9000000E1494441545847636CDC1DFF9F610001E3A8034643603404864C0888B3CB3348722BE12C314EDF3EC4F083E13303AF301749A5';
wwv_flow_imp.g_varchar2_table(2) := '0AD1E58081902383BD86374EC3E71FE906CB3D7D7F9F244750D501CA32EA0C779FDC24C9115473C0994707182E3F3A0D0E851B77AF3148A90A131515547300B26D076F6C65B8F06E3FED1DF0E8DD6D063921550C8BE8E200902520004A9830B6A2981AD8';
wwv_flow_imp.g_varchar2_table(3) := '41347500CC3298E5201A5D8CA60E0059882BE86171417307104A5D7473C068228415CDA389103D51D2241112AA8E911D71F8F656A26B44A2EB0242598F5CF951078C86C068080C78080000D39DD9612191DCD00000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(98978636326303790)
,p_file_name=>'icons/app-icon-32.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
wwv_flow_imp.component_end;
end;
/
