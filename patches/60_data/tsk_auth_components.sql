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
    SELECT 3.4744427648440316e+16 AS component_id, 'REGION' AS component_type, 'Tasks [CONTENT]' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4744427648440316e+16 AS component_id, 'REGION' AS component_type, 'Tasks [CONTENT]' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4744427648440316e+16 AS component_id, 'REGION' AS component_type, 'Tasks [CONTENT]' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4798486722743636e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_TASK' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4798486722743636e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_TASK' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4798486722743636e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_TASK' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.479879783974364e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_TASK' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.479879783974364e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_TASK' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.479879783974364e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_TASK' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4905220916116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_CLIENT_ID' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4905220916116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_CLIENT_ID' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4905220916116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_CLIENT_ID' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4905691081116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_PROJECT_ID' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4905691081116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_PROJECT_ID' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4905691081116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_PROJECT_ID' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4906072735116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_BOARD_ID' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4906072735116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_BOARD_ID' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4906072735116348e+16 AS component_id, 'ITEM' AS component_type, 'P100_BOARD_ID' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4949339576065804e+16 AS component_id, 'BUTTON' AS component_type, 'UPDATE_ONLY' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4949339576065804e+16 AS component_id, 'BUTTON' AS component_type, 'UPDATE_ONLY' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4949339576065804e+16 AS component_id, 'BUTTON' AS component_type, 'UPDATE_ONLY' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4949592599065804e+16 AS component_id, 'BUTTON' AS component_type, 'DELETE_TASK' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4949592599065804e+16 AS component_id, 'BUTTON' AS component_type, 'DELETE_TASK' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4949592599065804e+16 AS component_id, 'BUTTON' AS component_type, 'DELETE_TASK' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.495242224206583e+16 AS component_id, 'BUTTON' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; REFRESH_TASKS<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;"></span>' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.495242224206583e+16 AS component_id, 'BUTTON' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; REFRESH_TASKS<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;"></span>' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.495242224206583e+16 AS component_id, 'BUTTON' AS component_type, 'REFRESH_TASKS' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.4952570819065836e+16 AS component_id, 'PROCESS' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>SAVE_FORM<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;"></span>' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4952570819065836e+16 AS component_id, 'PROCESS' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>SAVE_FORM<span class="fa fa-warning" style="color: orange; margin: 0.125rem 0.5rem 0;"></span>' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.4952570819065836e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_FORM' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 3.512755419193705e+16 AS component_id, 'ITEM' AS component_type, 'P100_SWIMLANE_ID' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.512755419193705e+16 AS component_id, 'ITEM' AS component_type, 'P100_SWIMLANE_ID' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 3.512755419193705e+16 AS component_id, 'ITEM' AS component_type, 'P100_SWIMLANE_ID' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.4090106596578e+16 AS component_id, 'BUTTON' AS component_type, 'UPDATE_AND_CLOSE' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.4090106596578e+16 AS component_id, 'BUTTON' AS component_type, 'UPDATE_AND_CLOSE' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.4090106596578e+16 AS component_id, 'BUTTON' AS component_type, 'UPDATE_AND_CLOSE' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409048663457801e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_AND_CLOSE' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409048663457801e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_AND_CLOSE' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409048663457801e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_AND_CLOSE' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409057392257801e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_ANOTHER' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409057392257801e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_ANOTHER' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409057392257801e+16 AS component_id, 'BUTTON' AS component_type, 'CREATE_ANOTHER' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409105048957802e+16 AS component_id, 'REGION' AS component_type, 'Tasks [GRID]' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409105048957802e+16 AS component_id, 'REGION' AS component_type, 'Tasks [GRID]' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409105048957802e+16 AS component_id, 'REGION' AS component_type, 'Tasks [GRID]' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409275191057803e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_LIST' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409275191057803e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_LIST' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409275191057803e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_LIST' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409285592657803e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_COLUMNS' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409285592657803e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_COLUMNS' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409285592657803e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_COLUMNS' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409313910757803e+16 AS component_id, 'REGION' AS component_type, 'Status' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409313910757803e+16 AS component_id, 'REGION' AS component_type, 'Status' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409313910757803e+16 AS component_id, 'REGION' AS component_type, 'Status' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409331080357803e+16 AS component_id, 'REGION' AS component_type, 'Comments &P105_BADGE_COMMENTS.' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409331080357803e+16 AS component_id, 'REGION' AS component_type, 'Comments &P105_BADGE_COMMENTS.' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409331080357803e+16 AS component_id, 'REGION' AS component_type, 'Comments &P105_BADGE_COMMENTS.' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409415789257805e+16 AS component_id, 'REGION' AS component_type, 'Checklist &P105_BADGE_CHECKLIST.' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409415789257805e+16 AS component_id, 'REGION' AS component_type, 'Checklist &P105_BADGE_CHECKLIST.' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409415789257805e+16 AS component_id, 'REGION' AS component_type, 'Checklist &P105_BADGE_CHECKLIST.' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409420247057805e+16 AS component_id, 'REGION' AS component_type, 'Description &P105_BADGE_DESC.' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409420247057805e+16 AS component_id, 'REGION' AS component_type, 'Description &P105_BADGE_DESC.' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409420247057805e+16 AS component_id, 'REGION' AS component_type, 'Description &P105_BADGE_DESC.' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409431653557805e+16 AS component_id, 'REGION' AS component_type, 'Attachements &P105_BADGE_FILES.' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409431653557805e+16 AS component_id, 'REGION' AS component_type, 'Attachements &P105_BADGE_FILES.' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409431653557805e+16 AS component_id, 'REGION' AS component_type, 'Attachements &P105_BADGE_FILES.' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.409446751857805e+16 AS component_id, 'REGION' AS component_type, 'Commits &P105_BADGE_COMMITS.' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409446751857805e+16 AS component_id, 'REGION' AS component_type, 'Commits &P105_BADGE_COMMITS.' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.409446751857805e+16 AS component_id, 'REGION' AS component_type, 'Commits &P105_BADGE_COMMITS.' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.41696423739147e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_COMMENT' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.41696423739147e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_COMMENT' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.41696423739147e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_COMMENT' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417210939991473e+16 AS component_id, 'BUTTON' AS component_type, 'GOTO_NEXT_TASK' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417210939991473e+16 AS component_id, 'BUTTON' AS component_type, 'GOTO_NEXT_TASK' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417210939991473e+16 AS component_id, 'BUTTON' AS component_type, 'GOTO_NEXT_TASK' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417228240191473e+16 AS component_id, 'BUTTON' AS component_type, 'GOTO_PREV_TASK' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417228240191473e+16 AS component_id, 'BUTTON' AS component_type, 'GOTO_PREV_TASK' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417228240191473e+16 AS component_id, 'BUTTON' AS component_type, 'GOTO_PREV_TASK' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417255847091474e+16 AS component_id, 'ITEM' AS component_type, 'P100_TASK_ID' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417255847091474e+16 AS component_id, 'ITEM' AS component_type, 'P100_TASK_ID' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417255847091474e+16 AS component_id, 'ITEM' AS component_type, 'P100_TASK_ID' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.417272852291474e+16 AS component_id, 'BUTTON' AS component_type, 'COPY_LINK' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417272852291474e+16 AS component_id, 'BUTTON' AS component_type, 'COPY_LINK' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.417272852291474e+16 AS component_id, 'BUTTON' AS component_type, 'COPY_LINK' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.42852025724947e+16 AS component_id, 'BUTTON' AS component_type, 'SEARCH' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42852025724947e+16 AS component_id, 'BUTTON' AS component_type, 'SEARCH' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42852025724947e+16 AS component_id, 'BUTTON' AS component_type, 'SEARCH' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.42853628834947e+16 AS component_id, 'BUTTON' AS component_type, 'BULK_OPERATIONS' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42853628834947e+16 AS component_id, 'BUTTON' AS component_type, 'BULK_OPERATIONS' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42853628834947e+16 AS component_id, 'BUTTON' AS component_type, 'BULK_OPERATIONS' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.42854324374947e+16 AS component_id, 'BUTTON' AS component_type, 'SPLIT_TASK' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42854324374947e+16 AS component_id, 'BUTTON' AS component_type, 'SPLIT_TASK' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.42854324374947e+16 AS component_id, 'BUTTON' AS component_type, 'SPLIT_TASK' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428620623249471e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_STATUS' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428620623249471e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_STATUS' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428620623249471e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_STATUS' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428630634949471e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_SWIMLANE' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428630634949471e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_SWIMLANE' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428630634949471e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_SWIMLANE' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428643780349472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_CLIENT' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428643780349472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_CLIENT' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428643780349472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_CLIENT' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428650213149472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_PROJECT' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428650213149472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_PROJECT' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428650213149472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_PROJECT' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428666561449472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_BOARD' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428666561449472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_BOARD' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428666561449472e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_BOARD' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428700490849472e+16 AS component_id, 'ITEM' AS component_type, 'P110_CLIENT_ID' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428700490849472e+16 AS component_id, 'ITEM' AS component_type, 'P110_CLIENT_ID' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428700490849472e+16 AS component_id, 'ITEM' AS component_type, 'P110_CLIENT_ID' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428713301549472e+16 AS component_id, 'ITEM' AS component_type, 'P110_PROJECT_ID' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428713301549472e+16 AS component_id, 'ITEM' AS component_type, 'P110_PROJECT_ID' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428713301549472e+16 AS component_id, 'ITEM' AS component_type, 'P110_PROJECT_ID' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428728240649472e+16 AS component_id, 'ITEM' AS component_type, 'P110_BOARD_ID' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428728240649472e+16 AS component_id, 'ITEM' AS component_type, 'P110_BOARD_ID' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428728240649472e+16 AS component_id, 'ITEM' AS component_type, 'P110_BOARD_ID' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428736976049473e+16 AS component_id, 'ITEM' AS component_type, 'P110_STATUS_ID' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428736976049473e+16 AS component_id, 'ITEM' AS component_type, 'P110_STATUS_ID' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428736976049473e+16 AS component_id, 'ITEM' AS component_type, 'P110_STATUS_ID' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.428749648749473e+16 AS component_id, 'ITEM' AS component_type, 'P110_SWIMLANE_ID' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428749648749473e+16 AS component_id, 'ITEM' AS component_type, 'P110_SWIMLANE_ID' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.428749648749473e+16 AS component_id, 'ITEM' AS component_type, 'P110_SWIMLANE_ID' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.528106341745793e+16 AS component_id, 'PROCESS' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>PROCESS_BULK_TASK_FILTERS' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528106341745793e+16 AS component_id, 'PROCESS' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>PROCESS_BULK_TASK_FILTERS' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528148170245793e+16 AS component_id, 'PROCESS' AS component_type, '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>PROCESS_BULK_REQUEST' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528148170245793e+16 AS component_id, 'PROCESS' AS component_type, '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>PROCESS_BULK_REQUEST' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528151959645793e+16 AS component_id, 'PROCESS' AS component_type, '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>PROCESS_BULK_INIT' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528151959645793e+16 AS component_id, 'PROCESS' AS component_type, '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>PROCESS_BULK_INIT' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528173675745794e+16 AS component_id, 'PROCESS' AS component_type, 'DELETE_COMMENT' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528173675745794e+16 AS component_id, 'PROCESS' AS component_type, 'DELETE_COMMENT' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528173675745794e+16 AS component_id, 'PROCESS' AS component_type, 'DELETE_COMMENT' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.528224954845794e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_SPLIT_CHECKLIST' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528224954845794e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_SPLIT_CHECKLIST' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.528224954845794e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_SPLIT_CHECKLIST' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.5282650022457944e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_ATTACHEMENTS' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.5282650022457944e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_ATTACHEMENTS' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.5282650022457944e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_ATTACHEMENTS' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.541504970500563e+16 AS component_id, 'BUTTON' AS component_type, 'SYNC_GITHUB' AS component_name, 500 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.541504970500563e+16 AS component_id, 'BUTTON' AS component_type, 'SYNC_GITHUB' AS component_name, 500 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.541504970500563e+16 AS component_id, 'BUTTON' AS component_type, 'SYNC_GITHUB' AS component_name, 500 AS page_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.541504970500563e+16 AS component_id, 'BUTTON' AS component_type, 'SYNC_GITHUB' AS component_name, 500 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.541519090900563e+16 AS component_id, 'PROCESS' AS component_type, 'SYNC_GITHUB' AS component_name, 500 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.541519090900563e+16 AS component_id, 'PROCESS' AS component_type, 'SYNC_GITHUB' AS component_name, 500 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.551733194083602e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.551733194083602e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.551733194083602e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.551922094883603e+16 AS component_id, 'REGION' AS component_type, '&nbsp; &nbsp; &nbsp; Project Boards [GRID] &mdash; Interactive Report' AS component_name, 200 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.551922094883603e+16 AS component_id, 'REGION' AS component_type, '&nbsp; &nbsp; &nbsp; Project Boards [GRID] &mdash; Interactive Report' AS component_name, 200 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.551922094883603e+16 AS component_id, 'REGION' AS component_type, 'Project Boards [GRID]' AS component_name, 200 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.564152459630283e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_STATUSES' AS component_name, 230 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.564152459630283e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_STATUSES' AS component_name, 230 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.564152459630283e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_STATUSES' AS component_name, 230 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.564653193430285e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_STATUSES' AS component_name, 230 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.564653193430285e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_STATUSES' AS component_name, 230 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.564653193430285e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_STATUSES' AS component_name, 230 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.565903577030544e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_SWIMLANES' AS component_name, 250 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.565903577030544e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_SWIMLANES' AS component_name, 250 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.565903577030544e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_SWIMLANES' AS component_name, 250 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.566549823630545e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_SWIMLANES' AS component_name, 250 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.566549823630545e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_SWIMLANES' AS component_name, 250 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.566549823630545e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_SWIMLANES' AS component_name, 250 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.576015555779402e+16 AS component_id, 'BUTTON' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ADD_BOARD' AS component_name, 200 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.576015555779402e+16 AS component_id, 'BUTTON' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ADD_BOARD' AS component_name, 200 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.576015555779402e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_BOARD' AS component_name, 200 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.576291396979405e+16 AS component_id, 'GRID_COLUMN' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; EDIT_BUTTON' AS component_name, 200 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.576291396979405e+16 AS component_id, 'GRID_COLUMN' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; EDIT_BUTTON' AS component_name, 200 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.576291396979405e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'EDIT_BUTTON' AS component_name, 200 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.58921868325416e+16 AS component_id, 'BUTTON' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.58921868325416e+16 AS component_id, 'BUTTON' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.58921868325416e+16 AS component_id, 'BUTTON' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.58923178555416e+16 AS component_id, 'PROCESS' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.58923178555416e+16 AS component_id, 'PROCESS' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.58923178555416e+16 AS component_id, 'PROCESS' AS component_type, 'ADD_TO_FAVORITES' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.58924898305416e+16 AS component_id, 'PROCESS' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.58924898305416e+16 AS component_id, 'PROCESS' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.58924898305416e+16 AS component_id, 'PROCESS' AS component_type, 'REMOVE_FROM_FAVORITES' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.626041792430782e+16 AS component_id, 'REGION' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Checklist [GRID]' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.626041792430782e+16 AS component_id, 'REGION' AS component_type, '&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Checklist [GRID]' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.626041792430782e+16 AS component_id, 'REGION' AS component_type, 'Checklist [GRID]' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.626141653430783e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_CHECKLIST' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.626141653430783e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_CHECKLIST' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.626141653430783e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_CHECKLIST' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.656424731193648e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_ROLES' AS component_name, 960 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.656424731193648e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_ROLES' AS component_name, 960 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.6664603162363816e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_USER_WIZARD' AS component_name, 950 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.6664603162363816e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_USER_WIZARD' AS component_name, 950 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.6664603162363816e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_USER_WIZARD' AS component_name, 950 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.666561639236382e+16 AS component_id, 'ITEM' AS component_type, 'P510_CLIENT_ID' AS component_name, 510 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666561639236382e+16 AS component_id, 'ITEM' AS component_type, 'P510_CLIENT_ID' AS component_name, 510 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666561639236382e+16 AS component_id, 'ITEM' AS component_type, 'P510_CLIENT_ID' AS component_name, 510 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.666573125036382e+16 AS component_id, 'ITEM' AS component_type, 'P510_PROJECT_ID' AS component_name, 510 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666573125036382e+16 AS component_id, 'ITEM' AS component_type, 'P510_PROJECT_ID' AS component_name, 510 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666573125036382e+16 AS component_id, 'ITEM' AS component_type, 'P510_PROJECT_ID' AS component_name, 510 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.666615026936382e+16 AS component_id, 'ITEM' AS component_type, 'P515_OWNER_ID' AS component_name, 515 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666615026936382e+16 AS component_id, 'ITEM' AS component_type, 'P515_OWNER_ID' AS component_name, 515 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666615026936382e+16 AS component_id, 'ITEM' AS component_type, 'P515_OWNER_ID' AS component_name, 515 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.666621004436383e+16 AS component_id, 'ITEM' AS component_type, 'P515_REPO_ID' AS component_name, 515 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666621004436383e+16 AS component_id, 'ITEM' AS component_type, 'P515_REPO_ID' AS component_name, 515 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666621004436383e+16 AS component_id, 'ITEM' AS component_type, 'P515_REPO_ID' AS component_name, 515 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.666639369236383e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ENDPOINTS' AS component_name, 510 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666639369236383e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ENDPOINTS' AS component_name, 510 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.666639369236383e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ENDPOINTS' AS component_name, 510 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.668169152310431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_ROLE_WIZARD' AS component_name, 960 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.668169152310431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_ROLE_WIZARD' AS component_name, 960 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.670671486720286e+16 AS component_id, 'ITEM' AS component_type, 'P952_CLIENT_ID' AS component_name, 952 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.670671486720286e+16 AS component_id, 'ITEM' AS component_type, 'P952_CLIENT_ID' AS component_name, 952 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.670671486720286e+16 AS component_id, 'ITEM' AS component_type, 'P952_CLIENT_ID' AS component_name, 952 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.670781452320286e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ALL_USERS' AS component_name, 952 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.670781452320286e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ALL_USERS' AS component_name, 952 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.670781452320286e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ALL_USERS' AS component_name, 952 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.68239895403793e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_MAP_PAGES' AS component_name, 962 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.68239895403793e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_MAP_PAGES' AS component_name, 962 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.696145457577318e+16 AS component_id, 'ITEM' AS component_type, 'P515_CLIENT_ID' AS component_name, 515 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.696145457577318e+16 AS component_id, 'ITEM' AS component_type, 'P515_CLIENT_ID' AS component_name, 515 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.696145457577318e+16 AS component_id, 'ITEM' AS component_type, 'P515_CLIENT_ID' AS component_name, 515 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.696177364577512e+16 AS component_id, 'ITEM' AS component_type, 'P515_PROJECT_ID' AS component_name, 515 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.696177364577512e+16 AS component_id, 'ITEM' AS component_type, 'P515_PROJECT_ID' AS component_name, 515 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.696177364577512e+16 AS component_id, 'ITEM' AS component_type, 'P515_PROJECT_ID' AS component_name, 515 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.707492760713431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_CLIENT_WIZARD' AS component_name, 400 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.707492760713431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_CLIENT_WIZARD' AS component_name, 400 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.707492760713431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_CLIENT_WIZARD' AS component_name, 400 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.707506995213431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_PROJECT_WIZARD' AS component_name, 300 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.707506995213431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_PROJECT_WIZARD' AS component_name, 300 AS page_id, 'PROJECT_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.707506995213431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_PROJECT_WIZARD' AS component_name, 300 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.707506995213431e+16 AS component_id, 'BUTTON' AS component_type, 'ADD_PROJECT_WIZARD' AS component_name, 300 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.707515073413431e+16 AS component_id, 'ITEM' AS component_type, 'P955_PROJECT_ID' AS component_name, 955 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.707515073413431e+16 AS component_id, 'ITEM' AS component_type, 'P955_PROJECT_ID' AS component_name, 955 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.707515073413431e+16 AS component_id, 'ITEM' AS component_type, 'P955_PROJECT_ID' AS component_name, 955 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7078131334134344e+16 AS component_id, 'ITEM' AS component_type, 'P900_CLIENT_ID' AS component_name, 900 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7078131334134344e+16 AS component_id, 'ITEM' AS component_type, 'P900_CLIENT_ID' AS component_name, 900 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7078131334134344e+16 AS component_id, 'ITEM' AS component_type, 'P900_CLIENT_ID' AS component_name, 900 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7078596180134344e+16 AS component_id, 'ITEM' AS component_type, 'P900_PROJECT_ID' AS component_name, 900 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7078596180134344e+16 AS component_id, 'ITEM' AS component_type, 'P900_PROJECT_ID' AS component_name, 900 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7078596180134344e+16 AS component_id, 'ITEM' AS component_type, 'P900_PROJECT_ID' AS component_name, 900 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7106166497570776e+16 AS component_id, 'ITEM' AS component_type, 'P955_CLIENT_ID' AS component_name, 955 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7106166497570776e+16 AS component_id, 'ITEM' AS component_type, 'P955_CLIENT_ID' AS component_name, 955 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7106166497570776e+16 AS component_id, 'ITEM' AS component_type, 'P955_CLIENT_ID' AS component_name, 955 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.71163306486437e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ALL_USERS' AS component_name, 955 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.71163306486437e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ALL_USERS' AS component_name, 955 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.71163306486437e+16 AS component_id, 'BUTTON' AS component_type, 'SHOW_ALL_USERS' AS component_name, 955 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.711837238066946e+16 AS component_id, 'ITEM' AS component_type, 'P955_ROLE_GROUP' AS component_name, 955 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.711837238066946e+16 AS component_id, 'ITEM' AS component_type, 'P955_ROLE_GROUP' AS component_name, 955 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.711837238066946e+16 AS component_id, 'ITEM' AS component_type, 'P955_ROLE_GROUP' AS component_name, 955 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.711879985266947e+16 AS component_id, 'ITEM' AS component_type, 'P955_ROLE_ID' AS component_name, 955 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.711879985266947e+16 AS component_id, 'ITEM' AS component_type, 'P955_ROLE_ID' AS component_name, 955 AS page_id, 'USERS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.711879985266947e+16 AS component_id, 'ITEM' AS component_type, 'P955_ROLE_ID' AS component_name, 955 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.721970576995093e+16 AS component_id, 'BUTTON' AS component_type, 'REFRESH_MV' AS component_name, 962 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.721970576995093e+16 AS component_id, 'BUTTON' AS component_type, 'REFRESH_MV' AS component_name, 962 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.737393187387249e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_CATEGORIES' AS component_name, 220 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.737393187387249e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_CATEGORIES' AS component_name, 220 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.737393187387249e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_CATEGORIES' AS component_name, 220 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.738174680487251e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_CATEGORIES' AS component_name, 220 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.738174680487251e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_CATEGORIES' AS component_name, 220 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.738174680487251e+16 AS component_id, 'PROCESS' AS component_type, 'REORDER_CATEGORIES' AS component_name, 220 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7405677838201656e+16 AS component_id, 'PROCESS' AS component_type, 'REFRESH_MV' AS component_name, 962 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7405677838201656e+16 AS component_id, 'PROCESS' AS component_type, 'REFRESH_MV' AS component_name, 962 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7508553836863704e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_TABLES' AS component_name, 965 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7508553836863704e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_TABLES' AS component_name, 965 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.757666821523212e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_CATEGORY' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.757666821523212e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_CATEGORY' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.757666821523212e+16 AS component_id, 'ITEM' AS component_type, 'P110_SOURCE_CATEGORY' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.757671205123212e+16 AS component_id, 'ITEM' AS component_type, 'P110_CATEGORY_ID' AS component_name, 110 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.757671205123212e+16 AS component_id, 'ITEM' AS component_type, 'P110_CATEGORY_ID' AS component_name, 110 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.757671205123212e+16 AS component_id, 'ITEM' AS component_type, 'P110_CATEGORY_ID' AS component_name, 110 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7739135794626904e+16 AS component_id, 'REGION' AS component_type, 'Tags &P105_BADGE_TAGS.' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7739135794626904e+16 AS component_id, 'REGION' AS component_type, 'Tags &P105_BADGE_TAGS.' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7739135794626904e+16 AS component_id, 'REGION' AS component_type, 'Tags &P105_BADGE_TAGS.' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7739587996626904e+16 AS component_id, 'BUTTON' AS component_type, 'JOIN_TASK' AS component_name, 105 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7739587996626904e+16 AS component_id, 'BUTTON' AS component_type, 'JOIN_TASK' AS component_name, 105 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7739587996626904e+16 AS component_id, 'BUTTON' AS component_type, 'JOIN_TASK' AS component_name, 105 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.7742418320626936e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_PROCEDURES' AS component_name, 966 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.7742418320626936e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_PROCEDURES' AS component_name, 966 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.80501835109271e+16 AS component_id, 'BUTTON' AS component_type, '&nbsp; &nbsp; &nbsp; ' AS component_name, 963 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.80501835109271e+16 AS component_id, 'BUTTON' AS component_type, 'SYNC_REGIONS' AS component_name, 963 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.805053046092711e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_COMPONENTS' AS component_name, 963 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.805053046092711e+16 AS component_id, 'PROCESS' AS component_type, 'SAVE_COMPONENTS' AS component_name, 963 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.805156208092712e+16 AS component_id, 'PROCESS' AS component_type, '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>SYNC_REGIONS' AS component_name, 963 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.827979729004004e+16 AS component_id, 'PROCESS' AS component_type, '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>REORDER_STATUSES' AS component_name, 960 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.827979729004004e+16 AS component_id, 'PROCESS' AS component_type, '<span class="fa fa-play-circle" style="color: #555; margin: 0.125rem 0.5rem 0 0;"></span>REORDER_STATUSES' AS component_name, 960 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.82801369870432e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_ROLES' AS component_name, 960 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.82801369870432e+16 AS component_id, 'BUTTON' AS component_type, 'REORDER_ROLES' AS component_name, 960 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.835823316751211e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'PARENT_ID' AS component_name, 962 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.835823316751211e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'PARENT_ID' AS component_name, 962 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.835836122151211e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'IS_HIDDEN' AS component_name, 962 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.835836122151211e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'IS_HIDDEN' AS component_name, 962 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.835847468851211e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'IS_RESET' AS component_name, 962 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.835847468851211e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'IS_RESET' AS component_name, 962 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.835856086351212e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'ORDER#' AS component_name, 962 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.835856086351212e+16 AS component_id, 'GRID_COLUMN' AS component_type, 'ORDER#' AS component_name, 962 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.8387700539767256e+16 AS component_id, 'ITEM' AS component_type, 'P500_CLIENT_ID' AS component_name, 500 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.8387700539767256e+16 AS component_id, 'ITEM' AS component_type, 'P500_CLIENT_ID' AS component_name, 500 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.8387700539767256e+16 AS component_id, 'ITEM' AS component_type, 'P500_CLIENT_ID' AS component_name, 500 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.838807265876884e+16 AS component_id, 'ITEM' AS component_type, 'P500_PROJECT_ID' AS component_name, 500 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.838807265876884e+16 AS component_id, 'ITEM' AS component_type, 'P500_PROJECT_ID' AS component_name, 500 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.838807265876884e+16 AS component_id, 'ITEM' AS component_type, 'P500_PROJECT_ID' AS component_name, 500 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.8503448101203304e+16 AS component_id, 'BUTTON' AS component_type, 'COPY_STATUSES' AS component_name, 230 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.8503448101203304e+16 AS component_id, 'BUTTON' AS component_type, 'COPY_STATUSES' AS component_name, 230 AS page_id, 'BOARDS_MANAGER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.8503448101203304e+16 AS component_id, 'BUTTON' AS component_type, 'COPY_STATUSES' AS component_name, 230 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.850445222820331e+16 AS component_id, 'ITEM' AS component_type, 'P100_OWNER_ID' AS component_name, 100 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.850445222820331e+16 AS component_id, 'ITEM' AS component_type, 'P100_OWNER_ID' AS component_name, 100 AS page_id, 'DEFAULT_USER' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.850445222820331e+16 AS component_id, 'ITEM' AS component_type, 'P100_OWNER_ID' AS component_name, 100 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.865848653368942e+16 AS component_id, 'BUTTON' AS component_type, 'REFRESH_MV' AS component_name, 963 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.865848653368942e+16 AS component_id, 'BUTTON' AS component_type, 'REFRESH_MV' AS component_name, 963 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL UNION ALL
    SELECT 4.865867960169101e+16 AS component_id, 'PROCESS' AS component_type, 'REFRESH_MV' AS component_name, 963 AS page_id, 'ADMIN' AS role_id, 'Y' AS is_active FROM DUAL UNION ALL
    SELECT 4.865867960169101e+16 AS component_id, 'PROCESS' AS component_type, 'REFRESH_MV' AS component_name, 963 AS page_id, NULL AS role_id, NULL AS is_active FROM DUAL
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
--        t.is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (
        t.component_id,
        t.component_type,
        t.component_name,
        t.page_id,
        t.role_id,
        t.is_active
    )
    VALUES (
        s.component_id,
        s.component_type,
        s.component_name,
        s.page_id,
        s.role_id,
        s.is_active
    );
