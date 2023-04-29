BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_auth_tables'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_auth_tables;
--
MERGE INTO tsk_auth_tables t
USING (
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_BOARDS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_CATEGORIES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_CLIENTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_COMMITS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_PROJECTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_REPOS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_REPO_ENDPOINTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_STATUSES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_SWIMLANES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_TASKS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_TASK_CHECKLIST' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_TASK_COMMENTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_TASK_COMMITS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_TASK_FILES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_USERS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'BOARDS_MANAGER' AS role_id, 'TSK_USER_FAV_BOARDS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_CLIENTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_COMMITS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_PROJECTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_REPOS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_REPO_ENDPOINTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_STATUSES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_SWIMLANES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_TASKS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_TASK_CHECKLIST' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_TASK_COMMENTS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_TASK_COMMITS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_TASK_FILES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_USERS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'DEFAULT_USER' AS role_id, 'TSK_USER_FAV_BOARDS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_CLIENTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_COMMITS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_PROJECTS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_REPOS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_REPO_ENDPOINTS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_STATUSES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_SWIMLANES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_TASKS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_TASK_CHECKLIST' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_TASK_COMMENTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_TASK_COMMITS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_TASK_FILES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_USERS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'PROJECT_MANAGER' AS role_id, 'TSK_USER_FAV_BOARDS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_AUTH_PAGES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_AUTH_ROLES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_AUTH_TABLES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_AUTH_USERS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_CLIENTS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_COMMITS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_PROJECTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_REPOS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_REPO_ENDPOINTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_ROLES' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, 'Y' AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_STATUSES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_SWIMLANES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_TASKS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_TASK_CHECKLIST' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_TASK_COMMENTS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_TASK_COMMITS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_TASK_FILES' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_USERS' AS table_name, 'Y' AS is_active, 'Y' AS is_allowed_create, 'Y' AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL UNION ALL
    SELECT 'USERS_MANAGER' AS role_id, 'TSK_USER_FAV_BOARDS' AS table_name, 'Y' AS is_active, NULL AS is_allowed_create, NULL AS is_allowed_update, NULL AS is_allowed_delete FROM DUAL
) s
ON (
    t.role_id = s.role_id
    AND t.table_name = s.table_name
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.is_active = s.is_active,
--        t.is_allowed_create = s.is_allowed_create,
--        t.is_allowed_update = s.is_allowed_update,
--        t.is_allowed_delete = s.is_allowed_delete
WHEN NOT MATCHED THEN
    INSERT (
        t.role_id,
        t.table_name,
        t.is_active,
        t.is_allowed_create,
        t.is_allowed_update,
        t.is_allowed_delete
    )
    VALUES (
        s.role_id,
        s.table_name,
        s.is_active,
        s.is_allowed_create,
        s.is_allowed_update,
        s.is_allowed_delete
    );
