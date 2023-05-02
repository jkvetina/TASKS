BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_auth_components'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_auth_components;
--
MERGE INTO tsk_auth_components t
USING (
    SELECT 3.4744427648440316e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Tasks [CONTENT]' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4744427648440316e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Tasks [CONTENT]' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4798486722743636e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'ADD_TASK' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4798486722743636e+16 AS component_id, 'BUTTONS' AS component_type, 'ADD_TASK' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.479879783974364e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'CREATE_TASK' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.479879783974364e+16 AS component_id, 'BUTTONS' AS component_type, 'CREATE_TASK' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4905220916116348e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P100_CLIENT_ID' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4905220916116348e+16 AS component_id, 'PAGE_ITEMS' AS component_type, 'P100_CLIENT_ID' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4905691081116348e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P100_PROJECT_ID' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4905691081116348e+16 AS component_id, 'PAGE_ITEMS' AS component_type, 'P100_PROJECT_ID' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4906072735116348e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P100_BOARD_ID' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4906072735116348e+16 AS component_id, 'PAGE_ITEMS' AS component_type, 'P100_BOARD_ID' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4949339576065804e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'UPDATE_ONLY' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4949339576065804e+16 AS component_id, 'BUTTONS' AS component_type, 'UPDATE_ONLY' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4949592599065804e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'DELETE_TASK' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4949592599065804e+16 AS component_id, 'BUTTONS' AS component_type, 'DELETE_TASK' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.495242224206583e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'REFRESH_TASKS' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.495242224206583e+16 AS component_id, 'BUTTONS' AS component_type, 'REFRESH_TASKS' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.512755419193705e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P100_SWIMLANE_ID' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.512755419193705e+16 AS component_id, 'PAGE_ITEMS' AS component_type, 'P100_SWIMLANE_ID' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.4090106596578e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'UPDATE_AND_CLOSE' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.4090106596578e+16 AS component_id, 'BUTTONS' AS component_type, 'UPDATE_AND_CLOSE' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409048663457801e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'CREATE_AND_CLOSE' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409048663457801e+16 AS component_id, 'BUTTONS' AS component_type, 'CREATE_AND_CLOSE' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409057392257801e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'CREATE_ANOTHER' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409057392257801e+16 AS component_id, 'BUTTONS' AS component_type, 'CREATE_ANOTHER' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409105048957802e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Tasks [GRID]' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409105048957802e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Tasks [GRID]' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409275191057803e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'SHOW_LIST' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409275191057803e+16 AS component_id, 'BUTTONS' AS component_type, 'SHOW_LIST' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409285592657803e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'SHOW_COLUMNS' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409285592657803e+16 AS component_id, 'BUTTONS' AS component_type, 'SHOW_COLUMNS' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409313910757803e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Status' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409313910757803e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Status' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409331080357803e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Comments &P105_BADGE_COMMENTS.' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409331080357803e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Comments &P105_BADGE_COMMENTS.' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409415789257805e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Checklist &P105_BADGE_CHECKLIST.' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409415789257805e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Checklist &P105_BADGE_CHECKLIST.' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409420247057805e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Description &P105_BADGE_DESC.' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409420247057805e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Description &P105_BADGE_DESC.' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409431653557805e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Attachements &P105_BADGE_FILES.' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409431653557805e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Attachements &P105_BADGE_FILES.' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409446751857805e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Commits &P105_BADGE_COMMITS.' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409446751857805e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Commits &P105_BADGE_COMMITS.' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417210939991473e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'GOTO_NEXT_TASK' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417210939991473e+16 AS component_id, 'BUTTONS' AS component_type, 'GOTO_NEXT_TASK' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417228240191473e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'GOTO_PREV_TASK' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417228240191473e+16 AS component_id, 'BUTTONS' AS component_type, 'GOTO_PREV_TASK' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417255847091474e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P100_TASK_ID' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417255847091474e+16 AS component_id, 'PAGE_ITEMS' AS component_type, 'P100_TASK_ID' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417272852291474e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'COPY_LINK' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417272852291474e+16 AS component_id, 'BUTTONS' AS component_type, 'COPY_LINK' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42852025724947e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'SEARCH' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.42852025724947e+16 AS component_id, 'BUTTONS' AS component_type, 'SEARCH' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42853628834947e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'BULK_OPERATIONS' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.42853628834947e+16 AS component_id, 'BUTTONS' AS component_type, 'BULK_OPERATIONS' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42854324374947e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'SPLIT_TASK' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.42854324374947e+16 AS component_id, 'BUTTONS' AS component_type, 'SPLIT_TASK' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.551733194083602e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.551733194083602e+16 AS component_id, 'BUTTONS' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.551922094883603e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Project Boards [GRID]' AS component_name, 200 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.551922094883603e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Project Boards [GRID]' AS component_name, 200 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.551922094883603e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Project Boards [GRID]' AS component_name, 200 AS page_id, NULL AS region_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.564152459630283e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'REORDER_STATUSES' AS component_name, 230 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.576015555779402e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'ADD_BOARD' AS component_name, 200 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.576015555779402e+16 AS component_id, 'BUTTONS' AS component_type, 'ADD_BOARD' AS component_name, 200 AS page_id, NULL AS region_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.58921868325416e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.58921868325416e+16 AS component_id, 'BUTTONS' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.6664603162363816e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'ADD_USER_WIZARD' AS component_name, 950 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.670671486720286e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P952_CLIENT_ID' AS component_name, 952 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.670781452320286e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'SHOW_ALL_USERS' AS component_name, 952 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.707515073413431e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P955_PROJECT_ID' AS component_name, 955 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7106166497570776e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P955_CLIENT_ID' AS component_name, 955 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.71163306486437e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'SHOW_ALL_USERS' AS component_name, 955 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.711837238066946e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P955_ROLE_GROUP' AS component_name, 955 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.711879985266947e+16 AS component_id, 'APEX_APPLICATION_PAGE_ITEMS' AS component_type, 'P955_ROLE_ID' AS component_name, 955 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7739135794626904e+16 AS component_id, 'APEX_APPLICATION_PAGE_REGIONS' AS component_type, 'Tags &P105_BADGE_TAGS.' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7739135794626904e+16 AS component_id, 'PAGE_REGIONS' AS component_type, 'Tags &P105_BADGE_TAGS.' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7739587996626904e+16 AS component_id, 'APEX_APPLICATION_BUTTONS' AS component_type, 'JOIN_TASK' AS component_name, 105 AS page_id, NULL AS region_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7739587996626904e+16 AS component_id, 'BUTTONS' AS component_type, 'JOIN_TASK' AS component_name, 105 AS page_id, NULL AS region_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL
) s
ON (
    t.component_id = s.component_id
    AND t.role_id = s.role_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.component_type = s.component_type,
--        t.component_name = s.component_name,
--        t.page_id = s.page_id,
--        t.region_id = s.region_id,
--        t.is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (
        t.component_id,
        t.component_type,
        t.component_name,
        t.page_id,
        t.region_id,
        t.role_id,
        t.is_active
    )
    VALUES (
        s.component_id,
        s.component_type,
        s.component_name,
        s.page_id,
        s.region_id,
        s.role_id,
        s.is_active
    );
