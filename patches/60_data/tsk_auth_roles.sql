BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_auth_roles'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_auth_roles;
--
MERGE INTO tsk_auth_roles t
USING (
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'JANK' AS user_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'JANK' AS user_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'JANK' AS user_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'Q' AS user_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'Q' AS user_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'Q' AS user_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'ZORAN' AS user_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'ZORAN' AS user_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'NBL' AS client_id, 'DR' AS project_id, 'ZORAN' AS user_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PDI' AS client_id, NULL AS project_id, 'JANK' AS user_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PDI' AS client_id, NULL AS project_id, 'JANK' AS user_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PDI' AS client_id, NULL AS project_id, 'Q' AS user_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PDI' AS client_id, NULL AS project_id, 'Q' AS user_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PDI' AS client_id, NULL AS project_id, 'SAI' AS user_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'PDI' AS client_id, NULL AS project_id, 'SAI' AS user_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'Q' AS client_id, 'TASX' AS project_id, 'JANK' AS user_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'Q' AS client_id, NULL AS project_id, 'JANK' AS user_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'Q' AS client_id, NULL AS project_id, 'JANK' AS user_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'Q' AS client_id, NULL AS project_id, 'JANK' AS user_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL
) s
ON (
    t.client_id = s.client_id
    AND t.project_id = s.project_id
    AND t.user_id = s.user_id
    AND t.role_id = s.role_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (
        t.client_id,
        t.project_id,
        t.user_id,
        t.role_id,
        t.is_active
    )
    VALUES (
        s.client_id,
        s.project_id,
        s.user_id,
        s.role_id,
        s.is_active
    );
