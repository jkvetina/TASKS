CREATE OR REPLACE PACKAGE BODY tsk_p100 AS

    PROCEDURE init_defaults
    AS
        v_board_id          tsk_boards.board_id%TYPE;
        v_board_type        tsk_lov_board_types_v.id%TYPE;
        v_project_id        tsk_boards.project_id%TYPE;
        v_client_id         tsk_boards.client_id%TYPE;
        v_task_id           tsk_tasks.task_id%TYPE;
    BEGIN
        -- load preferences
        tsk_app.load_user_preferences();

        -- get global items
        v_board_id          := core.get_number_item('P0_BOARD_ID');
        v_board_type        := core.get_item('P100_BOARD_TYPE');
        v_project_id        := core.get_item('P0_PROJECT_ID');
        v_client_id         := core.get_item('P0_CLIENT_ID');
        v_task_id           := core.get_item('P100_TASK_ID');

        -- get board header
        FOR c IN (
            SELECT NVL(l.name, 'Tasks') || ' for ' || b.board_name AS name
            FROM tsk_boards b
            LEFT JOIN tsk_lov_board_types_v l
                ON l.id         = v_board_type
            WHERE b.board_id    = v_board_id
        ) LOOP
            core.set_item('P100_HEADER', c.name);
        END LOOP;

        -- generate task link
        IF v_task_id IS NOT NULL THEN
            core.set_item('P100_TASK_LINK', tsk_app.get_task_link(v_task_id));
        END IF;
        --
        core.set_item('P100_TASKS_LINK', core.get_page_url(100));
    END;



    PROCEDURE generate_board (
        in_client_id        tsk_boards.client_id%TYPE           := NULL,
        in_project_id       tsk_boards.project_id%TYPE          := NULL,
        in_board_id         tsk_boards.board_id%TYPE            := NULL,
        in_swimlane_id      tsk_swimlanes.swimlane_id%TYPE      := NULL
    )
    AS
        v_statuses          PLS_INTEGER;
        v_board_type        VARCHAR2(128);
    BEGIN
        -- calculate number of columns
        SELECT COUNT(s.status_id)
        INTO v_statuses
        FROM tsk_statuses s
        WHERE s.client_id       = in_client_id
            AND s.project_id    = in_project_id
            AND s.is_active     = 'Y';
        --
        HTP.P('<div class="BOARD" style="' ||
            'grid-template-columns: repeat(' || v_statuses || ', minmax(300px, 1fr)); ' ||
            '">');
        --
        v_board_type := core.get_item('P0_BOARD_TYPE');

        -- generate grid
        FOR w IN (
            SELECT
                w.*,
                ROW_NUMBER() OVER (ORDER BY CASE WHEN w.swimlane_id = '-' THEN NULL ELSE w.order# END NULLS LAST) AS r#
            FROM tsk_swimlanes w
            WHERE w.client_id       = in_client_id
                AND w.project_id    = in_project_id
                AND (w.swimlane_id  = in_swimlane_id OR in_swimlane_id IS NULL)
                AND (
                    v_board_type IS NULL
                    OR v_board_type = w.swimlane_id
                    OR (v_board_type = 'MY'     AND w.swimlane_id IN (core.get_user_id()))
                    OR (v_board_type = 'MY+'    AND w.swimlane_id IN (core.get_user_id(), '-'))
                )
                AND w.is_active     = 'Y'
            ORDER BY r#
        ) LOOP
            -- create column names
            FOR s IN (
                SELECT
                    s.status_id,
                    s.status_name,
                    ROWNUM AS r#
                FROM tsk_statuses s
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
                FROM tsk_statuses s
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
                        c_task_prefix || t.task_id || ' ' || t.task_name ||
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



    PROCEDURE ajax_update_task_on_drag
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
            HTP.P('Task ' || c_task_prefix || APEX_APPLICATION.G_X01 || ' updated');
        END IF;
    END;

END;
/

