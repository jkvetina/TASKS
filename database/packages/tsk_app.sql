CREATE OR REPLACE PACKAGE BODY tsk_app AS

    PROCEDURE update_task_on_drag
    AS
    BEGIN
        -- update task status (column)
        UPDATE tsk_tasks t
        SET t.status_id     = APEX_APPLICATION.G_X02,
            t.swimlane_id   = APEX_APPLICATION.G_X03
        WHERE t.task_id     = APEX_APPLICATION.G_X01;
        --
        IF SQL%ROWCOUNT = 1 THEN
            -- update order of passed tasks
            FOR s IN (
                SELECT
                    COLUMN_VALUE    AS task_id,
                    ROWNUM * 10     AS order#
                FROM APEX_STRING.SPLIT(APEX_APPLICATION.G_X04, ':')
            ) LOOP
                UPDATE tsk_tasks t
                SET t.order#        = s.order#
                WHERE t.task_id     = s.task_id
                    AND (t.order#   != s.order# OR t.order# IS NULL);
            END LOOP;

            -- message for app
            HTP.P('Task #' || APEX_APPLICATION.G_X01 || ' updated');
        END IF;
    END;



    PROCEDURE save_tasks_filters
    AS
    BEGIN
        -- store in global items
        core.set_item('P0_CLIENT_ID',   core.get_item('P100_CLIENT_ID'));
        core.set_item('P0_PROJECT_ID',  core.get_item('P100_PROJECT_ID'));
        core.set_item('P0_BOARD_ID',    core.get_item('P100_BOARD_ID'));

        -- store also in preferences for next session
        APEX_UTIL.SET_PREFERENCE (
            p_preference => 'P0_CLIENT_ID',
            p_value      => core.get_item('P0_CLIENT_ID'),
            p_user       => core.get_user_id()
        );
        --
        APEX_UTIL.SET_PREFERENCE (
            p_preference => 'P0_PROJECT_ID',
            p_value      => core.get_item('P0_PROJECT_ID'),
            p_user       => core.get_user_id()
        );
        --
        APEX_UTIL.SET_PREFERENCE (
            p_preference => 'P0_BOARD_ID',
            p_value      => core.get_item('P0_BOARD_ID'),
            p_user       => core.get_user_id()
        );
    END;



    PROCEDURE load_tasks_filters
    AS
    BEGIN
        core.set_item('P100_CLIENT_ID',     core.get_item('P0_CLIENT_ID'));
        core.set_item('P100_PROJECT_ID',    core.get_item('P0_PROJECT_ID'));
        core.set_item('P100_BOARD_ID',      core.get_item('P0_BOARD_ID'));

        -- also save them, they might be changed without submitting the page
        tsk_app.save_tasks_filters();
    END;

END;
/

