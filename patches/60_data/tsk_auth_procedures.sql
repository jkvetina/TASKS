BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_auth_procedures'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_auth_procedures;
--
MERGE INTO tsk_auth_procedures t
USING (
    SELECT 'TSK_P100' AS object_name, 'ADD_TO_FAVORITES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P100' AS object_name, 'ADD_TO_FAVORITES' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P100' AS object_name, 'AJAX_UPDATE_TASK_ON_DRAG' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P100' AS object_name, 'AJAX_UPDATE_TASK_ON_DRAG' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P100' AS object_name, 'GENERATE_BOARD' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P100' AS object_name, 'GENERATE_BOARD' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P100' AS object_name, 'REMOVE_FROM_FAVORITES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P100' AS object_name, 'REMOVE_FROM_FAVORITES' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'AJAX_DELETE_COMMENT' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'AJAX_DELETE_COMMENT' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'DOWNLOAD_ATTACHEMENT' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'DOWNLOAD_ATTACHEMENT' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'GET_BADGE_ICON' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'GET_BADGE_ICON' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_ATTACHEMENTS' AS procedure_name, 'TSK_TASK_FILES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_ATTACHEMENTS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_ATTACHEMENTS' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_CHECKLIST' AS procedure_name, 'TSK_TASK_CHECKLIST' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_CHECKLIST' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_CHECKLIST' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_COMMENT' AS procedure_name, 'TSK_TASK_COMMENTS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_COMMENT' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_COMMENT' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_MERGE_CHECKLIST' AS procedure_name, 'TSK_TASK_CHECKLIST' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_MERGE_CHECKLIST' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_MERGE_CHECKLIST' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_SPLIT_CHECKLIST' AS procedure_name, 'TSK_TASK_CHECKLIST' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_SPLIT_CHECKLIST' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_SPLIT_CHECKLIST' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_TASK' AS procedure_name, 'TSK_TASKS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_TASK' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P105' AS object_name, 'SAVE_TASK' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P110' AS object_name, 'PROCESS_BULK_INIT' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P110' AS object_name, 'PROCESS_BULK_INIT' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P110' AS object_name, 'PROCESS_BULK_REQUEST' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P110' AS object_name, 'PROCESS_BULK_REQUEST' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P110' AS object_name, 'PROCESS_BULK_TASK_FILTERS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P110' AS object_name, 'PROCESS_BULK_TASK_FILTERS' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'REORDER_CATEGORIES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'REORDER_CATEGORIES' AS procedure_name, NULL AS table_name, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'REORDER_TASK_STATUSES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'REORDER_TASK_STATUSES' AS procedure_name, NULL AS table_name, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'REORDER_TASK_SWIMLANES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'REORDER_TASK_SWIMLANES' AS procedure_name, NULL AS table_name, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_BOARDS' AS procedure_name, 'TSK_BOARDS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_BOARDS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_BOARDS' AS procedure_name, NULL AS table_name, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_CATEGORIES' AS procedure_name, 'TSK_CATEGORIES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_CATEGORIES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_CATEGORIES' AS procedure_name, NULL AS table_name, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_STATUSES' AS procedure_name, 'TSK_STATUSES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_STATUSES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_STATUSES' AS procedure_name, NULL AS table_name, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_SWIMLANES' AS procedure_name, 'TSK_SWIMLANES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_SWIMLANES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P200' AS object_name, 'SAVE_TASK_SWIMLANES' AS procedure_name, NULL AS table_name, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P300' AS object_name, 'RENAME_PROJECT_ID' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P300' AS object_name, 'RENAME_PROJECT_ID' AS procedure_name, NULL AS table_name, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P300' AS object_name, 'SAVE_PROJECTS' AS procedure_name, 'TSK_PROJECTS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P300' AS object_name, 'SAVE_PROJECTS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P300' AS object_name, 'SAVE_PROJECTS' AS procedure_name, NULL AS table_name, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P400' AS object_name, 'RENAME_CLIENT_ID' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P400' AS object_name, 'RENAME_CLIENT_ID' AS procedure_name, NULL AS table_name, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P400' AS object_name, 'SAVE_CLIENTS' AS procedure_name, 'TSK_CLIENTS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P400' AS object_name, 'SAVE_CLIENTS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P400' AS object_name, 'SAVE_CLIENTS' AS procedure_name, NULL AS table_name, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SAVE_COMMITS' AS procedure_name, 'TSK_COMMITS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SAVE_COMMITS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SAVE_COMMITS' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SET_HEADER' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SET_HEADER' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SYNC_COMMITS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SYNC_COMMITS' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SYNC_COMMITS_JOB' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P500' AS object_name, 'SYNC_COMMITS_JOB' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P952' AS object_name, 'SAVE_USERS' AS procedure_name, 'TSK_AUTH_USERS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P952' AS object_name, 'SAVE_USERS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P952' AS object_name, 'SAVE_USERS' AS procedure_name, NULL AS table_name, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P955' AS object_name, 'SAVE_ROLES' AS procedure_name, 'TSK_AUTH_ROLES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P955' AS object_name, 'SAVE_ROLES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P955' AS object_name, 'SAVE_ROLES' AS procedure_name, NULL AS table_name, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'DELETE_ROLE_CASCADE' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'GET_ROLE_ID' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'GET_ROLE_ID' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'RENAME_ROLE_ID' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'REORDER_ROLES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'SAVE_ROLES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'SET_ROLE_NAMES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P960' AS object_name, 'SET_ROLE_NAMES' AS procedure_name, NULL AS table_name, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P962' AS object_name, 'REFRESH_MV' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P962' AS object_name, 'SAVE_PAGES' AS procedure_name, 'TSK_AUTH_PAGES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P962' AS object_name, 'SAVE_PAGES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P963' AS object_name, 'SAVE_COMPONENTS' AS procedure_name, 'TSK_AUTH_COMPONENTS' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P963' AS object_name, 'SAVE_COMPONENTS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P963' AS object_name, 'SYNC_REGIONS' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P965' AS object_name, 'SAVE_TABLES' AS procedure_name, 'TSK_AUTH_TABLES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P965' AS object_name, 'SAVE_TABLES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P966' AS object_name, 'SAVE_PROCEDURES' AS procedure_name, 'TSK_AUTH_PROCEDURES' AS table_name, NULL AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 'TSK_P966' AS object_name, 'SAVE_PROCEDURES' AS procedure_name, NULL AS table_name, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL
) s
ON (
    t.object_name = s.object_name
    AND t.procedure_name = s.procedure_name
    AND t.role_id = s.role_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.table_name = s.table_name,
--        t.is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (
        t.object_name,
        t.procedure_name,
        t.table_name,
        t.role_id,
        t.is_active
    )
    VALUES (
        s.object_name,
        s.procedure_name,
        s.table_name,
        s.role_id,
        s.is_active
    );
