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
    SELECT 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 106 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 108 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 115 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 200 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 200 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 205 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 220 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 230 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 250 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 270 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 300 AS page_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 300 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 400 AS page_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 400 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 500 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 500 AS page_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 510 AS page_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 515 AS page_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 900 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 950 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 952 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 955 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 958 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 980 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL
) s
ON (
    t.page_id = s.page_id
    AND t.role_id = s.role_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (
        t.page_id,
        t.role_id,
        t.is_active
    )
    VALUES (
        s.page_id,
        s.role_id,
        s.is_active
    );
