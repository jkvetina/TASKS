prompt --application/pages/page_00000
begin
--   Manifest
--     PAGE: 00000
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
 p_id=>0
,p_name=>'Global Page'
,p_step_title=>'Global Page'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_page_component_map=>'14'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48053020203927134)
,p_plug_name=>'ITEMS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(84937722349740906)
,p_plug_name=>'JS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<script>',
'',
'//',
'// WAIT FOR ELEMENT TO EXIST',
'//',
'var wait_for_element = function(search, start, fn, disconnect) {',
'    var ob  = new MutationObserver(function(mutations) {',
'        if ($(search).length) {',
'            fn(search, start);',
'            if (disconnect) {',
'                observer.disconnect();  // keep observing',
'            }',
'        }',
'    });',
'    //',
'    ob.observe(document.getElementById(start), {',
'        childList: true,',
'        subtree: true',
'    });',
'};',
'',
'//',
'// HIDE SUCCESS MESSAGE',
'//',
'var hide_success_message = function(search, start) {',
'    var $start = $(''#'' + start);',
'    //',
'    setTimeout(function() {',
'        apex.message.hidePageSuccess();  // hide message',
'        var content = $start.text().trim();',
'        if (content.length) {',
'            console.log(''MESSAGE CLOSED:'', content);',
'        }',
'        $start.html('''').removeClass(''u-visible'');  // clean APEX mess',
'    }, 2000);',
'};',
'',
'</script>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(99337972662899178)
,p_plug_name=>'CSS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(70832601486975579)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'',
'ul.DASH_LIST {',
'  list-style-type: none;',
'  margin: 0.5rem 0 0.5rem 3rem;',
'}',
'ul.DASH_LIST li:before {',
'  content: ''\2014'';',
'  position: absolute;',
'  margin: 0 3rem 0 -1.5rem;',
'}',
'',
'</style>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053126900927135)
,p_name=>'P0_ROLE_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053279884927136)
,p_name=>'P0_ROLE_7'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053373436927137)
,p_name=>'P0_ROLE_8'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053441886927138)
,p_name=>'P0_ROLE_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053598114927139)
,p_name=>'P0_ROLE_4'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053678063927140)
,p_name=>'P0_ROLE_5'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053746091927141)
,p_name=>'P0_ROLE_6'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48053819240927142)
,p_name=>'P0_ROLE_3'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(48053020203927134)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(30749497144683909)
,p_name=>'AUTOHIDE_SUCCESS'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(30749530360683910)
,p_event_id=>wwv_flow_imp.id(30749497144683909)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.theme42.util.configAPEXMsgs({',
'    autoDismiss : true,',
'    duration    : 2000',
'});'))
);
wwv_flow_imp.component_end;
end;
/
