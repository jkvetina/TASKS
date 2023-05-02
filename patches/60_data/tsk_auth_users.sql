BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_auth_users'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_auth_users;
--
MERGE INTO tsk_auth_users t
USING (
    SELECT 'JANK' AS user_id, 'NBL' AS client_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'JANK' AS user_id, 'PDI' AS client_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'JANK' AS user_id, 'Q' AS client_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'Q' AS user_id, 'NBL' AS client_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'Q' AS user_id, 'PDI' AS client_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'SAI' AS user_id, 'PDI' AS client_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'ZORAN' AS user_id, 'NBL' AS client_id, 'Y' AS is_active FROM DUAL
) s
ON (
    t.user_id = s.user_id
    AND t.client_id = s.client_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (
        t.user_id,
        t.client_id,
        t.is_active
    )
    VALUES (
        s.user_id,
        s.client_id,
        s.is_active
    );
