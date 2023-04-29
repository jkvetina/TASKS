BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_roles'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_roles;
--
MERGE INTO tsk_roles t
USING (
    SELECT 'BOARDS_MANAGER' AS role_id, 'Boards Manager' AS role_name, 'MANAGEMENT' AS role_group, 'Create/update/delete Boards and Statuses, Swimlanes, Sequences, Categories' AS role_desc, 'Y' AS is_active, 10 AS order# FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'Default User' AS role_name, 'TASKS' AS role_group, 'Needed so user can access and use the app (create/update tasks)' AS role_desc, 'Y' AS is_active, 10 AS order# FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'Project Manager' AS role_name, 'MANAGEMENT' AS role_group, 'Create/update/delete any Projects for specific Client' AS role_desc, 'Y' AS is_active, 20 AS order# FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'Users Manager' AS role_name, 'MANAGEMENT' AS role_group, 'Can add/remove any Users for specific Client and assign/remove Roles to them' AS role_desc, 'Y' AS is_active, 30 AS order# FROM DUAL
) s
ON (
    t.role_id = s.role_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.role_name = s.role_name,
--        t.role_group = s.role_group,
--        t.role_desc = s.role_desc,
--        t.is_active = s.is_active,
--        t.order# = s.order#
WHEN NOT MATCHED THEN
    INSERT (
        t.role_id,
        t.role_name,
        t.role_group,
        t.role_desc,
        t.is_active,
        t.order#
    )
    VALUES (
        s.role_id,
        s.role_name,
        s.role_group,
        s.role_desc,
        s.is_active,
        s.order#
    );
