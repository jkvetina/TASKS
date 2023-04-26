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
    a.application_id            AS app_id,
    a.page_id,
    a.page_alias,
    a.page_name,
    --
    NULLIF(MIN(s.owner || '.' || s.object_name || '.' || s.procedure_name), '..') AS procedure_name,
    --
    a.authorization_scheme      AS auth_scheme
    --
FROM apex_application_pages a
LEFT JOIN all_procedures s
    ON s.owner                  = SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA')
    AND s.object_name           = 'TSK_AUTH'
    AND s.procedure_name        = REGEXP_SUBSTR(a.authorization_scheme, '\S+$')
WHERE a.application_id          = 710
GROUP BY
    a.application_id,
    a.page_id,
    a.page_alias,
    a.page_name,
    a.authorization_scheme;
--

