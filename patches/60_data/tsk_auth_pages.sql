BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_auth_pages'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_auth_pages;
--
MERGE INTO tsk_auth_pages t
USING (
    SELECT 'BOARDS_MANAGER' AS role_id, 200 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 205 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 100 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 105 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 106 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 110 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 115 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 200 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 220 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 300 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 500 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 900 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 980 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 200 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 205 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 220 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 230 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 250 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 270 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 300 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 510 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 515 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 300 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 400 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 950 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 952 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 955 AS page_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 958 AS page_id, 'Y' AS is_active FROM DUAL
) s
ON (
    t.role_id = s.role_id
    AND t.page_id = s.page_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (
        t.role_id,
        t.page_id,
        t.is_active
    )
    VALUES (
        s.role_id,
        s.page_id,
        s.is_active
    );
