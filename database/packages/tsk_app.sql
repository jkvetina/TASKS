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


    PROCEDURE generate_board (
        in_client_id        tsk_boards.client_id%TYPE           := NULL,
        in_project_id       tsk_boards.project_id%TYPE          := NULL,
        in_board_id         tsk_boards.board_id%TYPE            := NULL,
        in_swimlane_id      tsk_task_swimlanes.swimlane_id%TYPE := NULL
    )
    AS
        v_statuses     PLS_INTEGER;
    BEGIN
        -- calculate number of columns
        SELECT COUNT(s.status_id)
        INTO v_statuses
        FROM tsk_task_statuses s
        WHERE s.client_id       = in_client_id
            AND s.project_id    = in_project_id
            AND s.is_active     = 'Y';
        --
        HTP.P('<div class="BOARD" style="' ||
            'grid-template-columns: repeat(' || v_statuses || ', minmax(300px, 1fr)); ' ||
            '">');

        -- generate grid
        FOR w IN (
            SELECT
                w.*,
                ROW_NUMBER() OVER (ORDER BY CASE WHEN w.swimlane_id = '-' THEN NULL ELSE w.order# END NULLS LAST) AS r#
            FROM tsk_task_swimlanes w
            WHERE w.client_id       = in_client_id
                AND w.project_id    = in_project_id
                AND (w.swimlane_id  = in_swimlane_id OR in_swimlane_id IS NULL)
                AND w.is_active     = 'Y'
            ORDER BY r#
        ) LOOP
            -- create column names
            FOR s IN (
                SELECT
                    s.status_id,
                    s.status_name,
                    ROWNUM AS r#
                FROM tsk_task_statuses s
                WHERE s.client_id       = in_client_id
                    AND s.project_id    = in_project_id
                    AND s.is_active     = 'Y'
                ORDER BY s.order#
            ) LOOP
                HTP.P('<div class="TARGET_LIKE">');
                HTP.P('<h3>' || s.status_name || CASE WHEN s.r# = 1 THEN NULLIF(' @' || w.swimlane_name, ' @-') END || '</h3>');
                HTP.P('</div>');
            END LOOP;

            -- create swimlanes
            FOR s IN (
                SELECT
                    s.status_id
                FROM tsk_task_statuses s
                WHERE s.client_id       = in_client_id
                    AND s.project_id    = in_project_id
                    AND s.is_active     = 'Y'
                ORDER BY s.order#
            ) LOOP
                HTP.P('<div class="TARGET" id="STATUS_' || s.status_id || '_SWIMLANE_' || w.swimlane_id || '">');
                --
                FOR t IN (
                    SELECT
                        t.task_id,
                        t.task_name,
                        --
                        APEX_PAGE.GET_URL (
                            p_page          => 105,
                            p_clear_cache   => 105,
                            p_items         => 'P105_TASK_ID,P105_SOURCE_PAGE',
                            p_values        => '' || t.task_id || ',100'
                        ) AS task_link,
                        --
                        NULLIF(SUM(CASE WHEN l.checklist_done = 'Y' THEN 1 ELSE 0 END) || '/' || COUNT(l.checklist_id), '0/0') AS task_progress
                    FROM tsk_tasks t
                    LEFT JOIN tsk_task_checklist l
                        ON l.task_id        = t.task_id
                    WHERE t.client_id       = in_client_id
                        AND t.project_id    = in_project_id
                        AND t.board_id      = in_board_id
                        AND t.status_id     = s.status_id
                        AND t.swimlane_id   = w.swimlane_id
                    GROUP BY
                        t.task_id,
                        t.task_name,
                        t.order#
                    ORDER BY t.order# NULLS LAST, t.task_id
                ) LOOP
                    HTP.P(
                        '<div class="TASK" draggable="true" id="TASK_' || t.task_id || '">' ||
                        '<a href="' || t.task_link || '">' ||
                        CASE WHEN t.task_progress IS NOT NULL
                            THEN '<span style="float: right;">' || t.task_progress || '</span>'
                            END ||
                        '#' || t.task_id || ' ' || t.task_name ||
                        '</a></div>'
                    );
                END LOOP;
                --
                HTP.P('</div>');
            END LOOP;
        END LOOP;
        --
        HTP.P('</div>');
    END;

END;
/

