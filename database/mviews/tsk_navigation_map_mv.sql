BEGIN
    DBMS_UTILITY.EXEC_DDL_STATEMENT('DROP MATERIALIZED VIEW TSK_NAVIGATION_MAP_MV');
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MATERIALIZED VIEW TSK_NAVIGATION_MAP_MV DROPPED');
    DBMS_OUTPUT.PUT_LINE('--');
EXCEPTION
WHEN OTHERS THEN
    NULL;
END;
/
--
CREATE MATERIALIZED VIEW tsk_navigation_map_mv
TABLESPACE "DATA"
BUILD IMMEDIATE
REFRESH FORCE ON DEMAND
AS
SELECT
    -- procedures handling authorization on each page
    p.application_id            AS app_id,
    p.page_id,
    p.page_alias,
    p.page_name,
    p.page_title,
    p.page_group,
    p.page_css_classes,
    p.page_mode,
    p.page_template,
    p.page_comment,
    --
    NULLIF(MIN(s.owner || '.' || s.object_name || '.' || s.procedure_name), '..') AS procedure_name,
    --
    p.authorization_scheme      AS auth_scheme
    --
FROM apex_application_pages p
LEFT JOIN all_procedures s
    ON s.owner                  = SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA')
    AND s.object_name           = 'TSK_AUTH'
    AND s.procedure_name        = REGEXP_SUBSTR(p.authorization_scheme, '\S+$')
WHERE p.application_id          = 710
GROUP BY
    p.application_id,
    p.page_id,
    p.page_alias,
    p.page_name,
    p.page_title,
    p.page_group,
    p.page_css_classes,
    p.page_mode,
    p.page_template,
    p.page_comment,
    p.authorization_scheme;
--

