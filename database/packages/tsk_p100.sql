CREATE OR REPLACE PACKAGE BODY tsk_p100 AS

    PROCEDURE init_defaults
    AS
        v_client_id         tsk_tasks.client_id%TYPE    := tsk_app.get_client_id();
        v_project_id        tsk_tasks.project_id%TYPE   := tsk_app.get_project_id();
        v_board_id          tsk_tasks.board_id%TYPE     := tsk_app.get_board_id();
        v_swimlane_id       tsk_tasks.swimlane_id%TYPE  := tsk_app.get_swimlane_id();
        v_task_id           tsk_tasks.task_id%TYPE;
    BEGIN
        -- check if specific task was requested
        v_task_id := core.get_item('P100_TASK_ID');
        --
        IF v_task_id IS NOT NULL THEN
            BEGIN
                SELECT
                    t.client_id,
                    t.project_id,
                    t.board_id
                INTO
                    v_client_id,
                    v_project_id,
                    v_board_id
                FROM tsk_tasks t
                WHERE t.task_id = v_task_id;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                core.raise_error('INVALID_TASK');
            END;

            -- update also board below task detail
            tsk_app.set_user_preferences (
                in_user_id          => core.get_user_id(),
                in_client_id        => v_client_id,
                in_project_id       => v_project_id,
                in_board_id         => v_board_id,
                in_swimlane_id      => v_swimlane_id
            );

            -- generate task link
            IF v_task_id IS NOT NULL THEN
                core.set_item('P100_TASK_LINK', tsk_app.get_task_link(v_task_id));
            END IF;
            --
        ELSE
            -- overwrite settings if new are passed in url
            IF core.get_request_url() LIKE '%p100_board_id=%' THEN
                v_client_id     := core.get_item('P100_CLIENT_ID');
                v_project_id    := core.get_item('P100_PROJECT_ID');
                v_board_id      := core.get_item('P100_BOARD_ID');
                --
                tsk_app.set_user_preferences (
                    in_user_id          => core.get_user_id(),
                    in_client_id        => v_client_id,
                    in_project_id       => v_project_id,
                    in_board_id         => v_board_id,
                    in_swimlane_id      => v_swimlane_id
                );
            END IF;
        END IF;

        -- set page items
        core.set_item('P100_CLIENT_ID',     v_client_id);
        core.set_item('P100_PROJECT_ID',    v_project_id);
        core.set_item('P100_BOARD_ID',      v_board_id);
        core.set_item('P100_TASKS_LINK',    core.get_page_url(100));
        --
        FOR c IN (
            WITH d AS (
                SELECT 'HEADER'         AS item_name FROM DUAL UNION ALL
                SELECT 'IS_FAVORITE'    AS item_name FROM DUAL
            ),
            t AS (
                -- calculate page header
                SELECT
                    'HEADER'            AS item_name,
                    'Tasks for ' || p.project_name || ' - ' || b.board_name AS item_value
                FROM tsk_boards b
                JOIN tsk_projects p
                    ON b.project_id     = p.project_id
                WHERE b.board_id        = v_board_id
                UNION ALL
                -- check favorite status
                SELECT
                    'IS_FAVORITE'       AS item_name,
                    'Y'                 AS item_value
                FROM tsk_user_fav_boards b
                WHERE b.user_id         = core.get_user_id()
                    AND b.client_id     = v_client_id
                    AND b.project_id    = v_project_id
                    AND b.board_id      = v_board_id
            )
            SELECT
                d.item_name,
                t.item_value
            FROM d
            LEFT JOIN t
                ON t.item_name = d.item_name
        ) LOOP
            core.set_item('P100_' || c.item_name, c.item_value);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE generate_board
    AS
        in_client_id        CONSTANT tsk_tasks.client_id%TYPE       := tsk_app.get_client_id();
        in_project_id       CONSTANT tsk_tasks.project_id%TYPE      := tsk_app.get_project_id();
        in_board_id         CONSTANT tsk_tasks.board_id%TYPE        := tsk_app.get_board_id();
        in_swimlane_id      CONSTANT tsk_tasks.swimlane_id%TYPE     := core.get_item('P100_SWIMLANE_ID');
        in_owner_id         CONSTANT tsk_tasks.owner_id%TYPE        := core.get_item('P100_OWNER_ID');
        --
        v_statuses          PLS_INTEGER;
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

        -- generate grid
        FOR w IN (
            SELECT
                w.*,
                ROW_NUMBER() OVER (ORDER BY CASE WHEN w.swimlane_id = '-' THEN NULL ELSE w.order# END NULLS LAST) AS r#
            FROM tsk_swimlanes w
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
                    s.is_show_user,
                    s.is_show_swimlane,
                    u.user_name
                FROM tsk_lov_statuses_v s
                LEFT JOIN tsk_users u
                    ON u.user_id        = in_owner_id
                ORDER BY s.order#
            ) LOOP
                HTP.P('<div class="TARGET_LIKE">');
                HTP.P('<h3>' || s.status_name ||
                    CASE WHEN s.is_show_user        = 'Y' THEN RTRIM(' @' || s.user_name, ' @') END ||
                    CASE WHEN s.is_show_swimlane    = 'Y' THEN RTRIM(' @' || NULLIF(w.swimlane_name, '-'), ' @') END ||
                    '</h3>');
                HTP.P('</div>');
            END LOOP;

            -- create swimlanes
            FOR s IN (
                SELECT
                    s.status_id,
                    s.is_colored
                FROM tsk_lov_statuses_v s
                ORDER BY s.order#
            ) LOOP
                HTP.P('<div class="TARGET" id="STATUS_' || s.status_id || '_SWIMLANE_' || w.swimlane_id || '">');
                --
                FOR t IN (
                    SELECT
                        t.task_id,
                        t.task_name,
                        t.deadline_at,
                        t.task_link,
                        t.task_progress,
                        t.color_bg
                    FROM tsk_p100_tasks_grid_v t
                    WHERE t.client_id       = in_client_id
                        AND t.project_id    = in_project_id
                        AND t.board_id      = in_board_id
                        AND t.status_id     = s.status_id
                        AND t.swimlane_id   = w.swimlane_id
                    ORDER BY t.order#
                ) LOOP
                    HTP.P(
                        '<div class="TASK" draggable="true" id="TASK_' || t.task_id || '" style="' ||
                            CASE WHEN s.is_colored = 'Y' AND t.color_bg IS NOT NULL             THEN 'border-left: 5px solid ' || t.color_bg || '; ' END ||
                            CASE WHEN s.is_colored = 'Y' AND t.deadline_at <= TRUNC(SYSDATE)    THEN 'border-left: 5px solid ' || '#111' || '; ' END ||
                            '">' ||
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE add_to_favorites
    AS
        rec                 tsk_user_fav_boards%ROWTYPE;
    BEGIN
        rec.user_id         := core.get_user_id();
        rec.client_id       := core.get_item('$CLIENT_ID');
        rec.project_id      := core.get_item('$PROJECT_ID');
        rec.board_id        := core.get_item('$BOARD_ID');
        rec.swimlane_id     := core.get_item('$SWIMLANE_ID');
        rec.owner_id        := core.get_item('$OWNER_ID');
        --
        tsk_tapi.user_fav_boards(rec, 'C');
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE remove_from_favorites
    AS
        rec                 tsk_user_fav_boards%ROWTYPE;
    BEGIN
        rec.user_id         := core.get_user_id();
        rec.client_id       := core.get_item('$CLIENT_ID');
        rec.project_id      := core.get_item('$PROJECT_ID');
        rec.board_id        := core.get_item('$BOARD_ID');
        --
        tsk_tapi.user_fav_boards(rec, 'D');
        --
        core.set_item('P100_IS_FAVORITE', '');
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

