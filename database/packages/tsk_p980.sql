CREATE OR REPLACE PACKAGE BODY tsk_p980 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        core.set_item('P980_PROJECT_WIZARD',    '#');
        core.set_item('P980_USER_WIZARD',       '#');
        --
        core.set_item('P090_CLIENT_ADD',        core.get_page_url(400));
        core.set_item('P980_PROJECT_ADD',       core.get_page_url(300));
        core.set_item('P980_BOARD_ADD',         core.get_page_url(200));
        core.set_item('P980_TASK_ADD',          core.get_page_url(100));
        core.set_item('P980_STATUS_ADD',        core.get_page_url(230));
        core.set_item('P980_SWIMLANE_ADD',      core.get_page_url(250));
        core.set_item('P980_USER_ADD',          core.get_page_url(950));
        core.set_item('P980_MAP_CLIENTS',       core.get_page_url(952));
        core.set_item('P980_MAP_ROLES',         core.get_page_url(955));
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

