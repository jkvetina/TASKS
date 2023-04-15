CREATE OR REPLACE PACKAGE BODY tsk_app AS

    PROCEDURE after_auth (
        in_user_id          VARCHAR2
    )
    AS
    BEGIN
        -- load stored preferences
        tsk_app.load_user_preferences(in_user_id);
    END;



    PROCEDURE init_defaults
    AS
        v_procedure_name        VARCHAR2(61);
    BEGIN
        -- save new preference when passed in address
        FOR c IN (
            SELECT 'P0_CLIENT_ID'   AS item_name FROM DUAL UNION ALL
            SELECT 'P0_PROJECT_ID'  AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_ID'    AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_TYPE'  AS item_name FROM DUAL
        ) LOOP
            IF INSTR(core.get_request_url(TRUE), LOWER(c.item_name) || '=') > 0 THEN
                APEX_UTIL.SET_PREFERENCE (
                    p_preference => c.item_name,
                    p_value      => core.get_item(c.item_name),
                    p_user       => core.get_user_id()
                );
            END IF;
        END LOOP;

        -- find init block for specific/current page
        v_procedure_name := get_init_defaults_procedure(core.get_page_id());
        --
        IF v_procedure_name IS NOT NULL THEN
            EXECUTE IMMEDIATE 'BEGIN ' || v_procedure_name || '(); END;';
        END IF;
    END;



    PROCEDURE init_defaults_p100
    AS
    BEGIN
        -- load preferences
        tsk_app.load_user_preferences();


        -- generate task link
        core.set_item('P100_TASK_LINK', tsk_app.get_task_link(core.get_item('P100_TASK_ID')));
    END;



    PROCEDURE init_defaults_p105
    AS
    BEGIN
        -- use globals as defaults
        IF core.get_item('P105_CLIENT_ID') IS NULL THEN
            core.set_item('P105_CLIENT_ID', core.get_item('P0_CLIENT_ID'));
        END IF;
        --
        IF core.get_item('P105_PROJECT_ID') IS NULL THEN
            core.set_item('P105_PROJECT_ID', core.get_item('P0_PROJECT_ID'));
        END IF;
        --
        IF core.get_item('P105_BOARD_ID') IS NULL THEN
            core.set_item('P105_BOARD_ID', core.get_item('P0_BOARD_ID'));
        END IF;

        -- generate task link
        core.set_item('P105_TASK_LINK', tsk_app.get_task_link(core.get_item('P105_TASK_ID'), 'EXTERNAL'));

        -- calculate prev/next tasks
        FOR c IN (
            SELECT task_id, prev_task, next_task
            FROM (
                SELECT
                    t.task_id,
                    LAG(t.task_id)  OVER (ORDER BY t.swimlane_order# NULLS LAST, t.status_order# NULLS LAST, t.task_order# NULLS LAST) AS prev_task,
                    LEAD(t.task_id) OVER (ORDER BY t.swimlane_order# NULLS LAST, t.status_order# NULLS LAST, t.task_order# NULLS LAST) AS next_task
                    --
                FROM tsk_p100_tasks_grid_v t
            )
            WHERE task_id = core.get_number_item('P105_TASK_ID')
        ) LOOP
            core.set_item('P105_PREV_TASK_ID', NULLIF(c.prev_task, c.task_id));
            core.set_item('P105_NEXT_TASK_ID', NULLIF(c.next_task, c.task_id));
        END LOOP;
    END;



    FUNCTION get_init_defaults_procedure (
        in_page_id      NUMBER
    )
    RETURN VARCHAR2
    RESULT_CACHE
    AS
        out_procedure   VARCHAR2(61);
    BEGIN
        SELECT MAX(p.object_name || '.' || p.procedure_name)
        INTO out_procedure
        FROM user_procedures p
        WHERE ((
                p.object_name           = $$PLSQL_UNIT
                AND p.procedure_name    = 'INIT_DEFAULTS_P' || TO_CHAR(in_page_id)
            )
            OR (
                p.object_name           = REPLACE($$PLSQL_UNIT, '_APP', '_P') || TO_CHAR(in_page_id)
                AND p.procedure_name    = 'INIT_DEFAULTS'
            ));
        --
        RETURN out_procedure;
    END;



    FUNCTION get_task_link (
        in_task_id          tsk_tasks.task_id%TYPE,
        in_external         CHAR                        := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        IF in_external IS NOT NULL THEN
            RETURN
                REGEXP_REPLACE(APEX_MAIL.GET_INSTANCE_URL, '/ords/.*$', '') ||
                APEX_PAGE.GET_URL (
                    p_application       => core.get_app_id(),
                    p_session           => core.get_session_id(),
                    p_page              => 100,
                    p_clear_cache       => 100,
                    p_items             => 'P100_TASK_ID',
                    p_values            => in_task_id,
                    p_plain_url         => TRUE
                );
        END IF;
        --
        FOR c IN (
            SELECT
                t.task_id,
                t.client_id,
                t.project_id,
                t.board_id
            FROM tsk_tasks t
            WHERE t.task_id = in_task_id
        ) LOOP
            RETURN
                APEX_PAGE.GET_URL (
                    p_page              => 105,
                    p_clear_cache       => 105,
                    p_items             => 'P0_CLIENT_ID,P0_PROJECT_ID,P0_BOARD_ID,P105_TASK_ID',
                    p_values            =>
                        c.client_id     || ',' ||
                        c.project_id    || ',' ||
                        c.board_id      || ',' ||
                        c.task_id
                );
        END LOOP;
        --
        RETURN NULL;
    END;



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



    PROCEDURE save_user_preferences (
        in_user_id          VARCHAR2    := NULL
    )
    AS
    BEGIN
        -- store in global items and in preferences for next session
        FOR c IN (
            SELECT 'P0_CLIENT_ID'   AS item_name FROM DUAL UNION ALL
            SELECT 'P0_PROJECT_ID'  AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_ID'    AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_TYPE'  AS item_name FROM DUAL
        ) LOOP
            core.set_item (
                c.item_name,
                core.get_item(REPLACE(c.item_name, 'P0_', 'P100_'))
            );
            --
            APEX_UTIL.SET_PREFERENCE (
                p_preference => c.item_name,
                p_value      => core.get_item(c.item_name),
                p_user       => COALESCE(in_user_id, core.get_user_id())
            );
        END LOOP;
    END;



    PROCEDURE load_user_preferences (
        in_user_id          VARCHAR2    := NULL
    )
    AS
    BEGIN
        FOR c IN (
            SELECT 'P0_CLIENT_ID'   AS item_name FROM DUAL UNION ALL
            SELECT 'P0_PROJECT_ID'  AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_ID'    AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_TYPE'  AS item_name FROM DUAL
        ) LOOP
            core.set_item (
                c.item_name,
                APEX_UTIL.GET_PREFERENCE (
                    p_preference => c.item_name,
                    p_user       => COALESCE(in_user_id, core.get_user_id())
                )
            );
            --
            core.set_item (
                REPLACE(c.item_name, 'P0_', 'P100_'),
                core.get_item(c.item_name)
            );
/*
            core.raise_error(core.get_item(c.item_name) || '|' || APEX_UTIL.GET_PREFERENCE (
                p_preference => c.item_name,
                p_user       => COALESCE(in_user_id, core.get_user_id())
            ));
            */
        END LOOP;

        -- also save them, they might be changed without submitting the page
        --tsk_app.save_user_preferences();
        --
        -- @TODO: optimize
        --
    END;



    PROCEDURE reorder_task_statuses (
        in_client_id        tsk_task_statuses.client_id%TYPE    := NULL,
        in_project_id       tsk_task_statuses.project_id%TYPE   := NULL
    )
    AS
    BEGIN
        FOR s IN (
            SELECT
                t.status_id,
                t.client_id,
                t.project_id,
                --
                ROW_NUMBER() OVER (PARTITION BY t.client_id, t.project_id ORDER BY t.order# NULLS LAST, t.status_name, t.status_id) * 10 AS order#
            FROM tsk_task_statuses t
            WHERE 1 = 1
                AND (t.client_id    = in_client_id  OR in_client_id  IS NULL)
                AND (t.project_id   = in_project_id OR in_project_id IS NULL)
        ) LOOP
            UPDATE tsk_task_statuses t
            SET t.order#            = s.order#
            WHERE t.status_id       = s.status_id
                AND t.client_id     = s.client_id
                AND t.project_id    = s.project_id
                AND (t.order#       != s.order# OR t.order# IS NULL);
        END LOOP;
    END;



    PROCEDURE reorder_task_swimlanes (
        in_client_id        tsk_task_swimlanes.client_id%TYPE   := NULL,
        in_project_id       tsk_task_swimlanes.project_id%TYPE  := NULL
    )
    AS
    BEGIN
        FOR s IN (
            SELECT
                t.swimlane_id,
                t.client_id,
                t.project_id,
                --
                ROW_NUMBER() OVER (PARTITION BY t.client_id, t.project_id ORDER BY t.order# NULLS LAST, t.swimlane_name, t.swimlane_id) * 10 AS order#
            FROM tsk_task_swimlanes t
            WHERE 1 = 1
                AND (t.client_id    = in_client_id  OR in_client_id  IS NULL)
                AND (t.project_id   = in_project_id OR in_project_id IS NULL)
        ) LOOP
            UPDATE tsk_task_swimlanes t
            SET t.order#            = s.order#
            WHERE t.swimlane_id     = s.swimlane_id
                AND t.client_id     = s.client_id
                AND t.project_id    = s.project_id
                AND (t.order#       != s.order# OR t.order# IS NULL);
        END LOOP;
    END;



    PROCEDURE generate_board (
        in_client_id        tsk_boards.client_id%TYPE           := NULL,
        in_project_id       tsk_boards.project_id%TYPE          := NULL,
        in_board_id         tsk_boards.board_id%TYPE            := NULL,
        in_swimlane_id      tsk_task_swimlanes.swimlane_id%TYPE := NULL
    )
    AS
        v_statuses          PLS_INTEGER;
        v_board_type        VARCHAR2(128);
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

        --
        v_board_type := core.get_item('P0_BOARD_TYPE');

        -- generate grid
        FOR w IN (
            SELECT
                w.*,
                ROW_NUMBER() OVER (ORDER BY CASE WHEN w.swimlane_id = '-' THEN NULL ELSE w.order# END NULLS LAST) AS r#
            FROM tsk_task_swimlanes w
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



    PROCEDURE save_checklist
    AS
        v_action            CHAR;
        rec                 tsk_task_checklist%ROWTYPE;
    BEGIN
        v_action            := APEX_UTIL.GET_SESSION_STATE('APEX$ROW_STATUS');
        --
        rec.task_id         := APEX_UTIL.GET_SESSION_STATE('TASK_ID');
        rec.checklist_id    := APEX_UTIL.GET_SESSION_STATE('CHECKLIST_ID');
        rec.checklist_item  := APEX_UTIL.GET_SESSION_STATE('CHECKLIST_ITEM');
        rec.checklist_done  := APEX_UTIL.GET_SESSION_STATE('CHECKLIST_DONE');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF rec.task_id IS NULL THEN
            rec.task_id     := APEX_UTIL.GET_SESSION_STATE('P105_TASK_ID');
        END IF;
        --
        IF (v_action = 'D' OR rec.checklist_item IS NULL) THEN
            DELETE FROM tsk_task_checklist t
            WHERE t.task_id         = rec.task_id
                AND t.checklist_id  = rec.checklist_id;
            --
            RETURN;
        END IF;
        --
        IF rec.checklist_id IS NOT NULL THEN
            UPDATE tsk_task_checklist t
            SET ROW = rec
            WHERE t.task_id         = rec.task_id
                AND t.checklist_id  = rec.checklist_id;
        ELSE
            rec.checklist_id := tsk_checklist_id.NEXTVAL;
            --
            INSERT INTO tsk_task_checklist
            VALUES rec;
        END IF;
    END;



    FUNCTION validate_client_id (
        in_client_id        tsk_clients.client_id%TYPE
    )
    RETURN tsk_clients.client_id%TYPE
    AS
        out_client_id       tsk_clients.client_id%TYPE;
    BEGIN
        SELECT t.client_id INTO out_client_id
        FROM tsk_clients t
        WHERE t.client_id = in_client_id;
        --
        RETURN out_client_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION validate_project_id (
        in_project_id       tsk_projects.project_id%TYPE
    )
    RETURN tsk_projects.project_id%TYPE
    AS
        out_project_id      tsk_projects.project_id%TYPE;
    BEGIN
        SELECT t.project_id INTO out_project_id
        FROM tsk_projects t
        WHERE t.project_id = in_project_id;
        --
        RETURN out_project_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION validate_board_id (
        in_board_id         tsk_boards.board_id%TYPE
    )
    RETURN tsk_boards.board_id%TYPE
    AS
        out_board_id        tsk_boards.board_id%TYPE;
    BEGIN
        SELECT t.board_id INTO out_board_id
        FROM tsk_boards t
        WHERE t.board_id = in_board_id;
        --
        RETURN out_board_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION get_grid_client_id (
        in_client_id        tsk_clients.client_id%TYPE := NULL
    )
    RETURN tsk_clients.client_id%TYPE
    AS
    BEGIN
        RETURN COALESCE (
            tsk_app.validate_client_id(in_client_id),
            tsk_app.validate_client_id(APEX_UTIL.GET_SESSION_STATE('CLIENT_ID')),
            core.get_item('P200_CLIENT_ID'),
            core.get_item('P0_CLIENT_ID')
        );
    END;



    FUNCTION get_grid_project_id (
        in_project_id       tsk_projects.project_id%TYPE := NULL
    )
    RETURN tsk_projects.project_id%TYPE
    AS
    BEGIN
        RETURN COALESCE (
            tsk_app.validate_client_id(in_project_id),
            tsk_app.validate_project_id(APEX_UTIL.GET_SESSION_STATE('PROJECT_ID')),
            core.get_item('P200_PROJECT_ID'),
            core.get_item('P0_PROJECT_ID')
        );
    END;

END;
/

