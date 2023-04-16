CREATE OR REPLACE PACKAGE BODY tsk_p105 AS

    PROCEDURE init_defaults
    AS
        rec                 tsk_tasks%ROWTYPE;
    BEGIN
        -- get tasks details
        BEGIN
            SELECT t.* INTO rec
            FROM tsk_tasks t
            WHERE t.task_id = core.get_number_item('P105_TASK_ID');
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
        END;

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

        -- generate task header
        core.set_item('P105_TASK_LINK', tsk_app.get_task_link(rec.task_id, 'EXTERNAL'));
        core.set_item('P105_UPDATED_AT', rec.updated_at);

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
            WHERE task_id = rec.task_id
        ) LOOP
            core.set_item('P105_PREV_TASK_ID', NULLIF(c.prev_task, c.task_id));
            core.set_item('P105_NEXT_TASK_ID', NULLIF(c.next_task, c.task_id));
        END LOOP;

        -- calculate page header
        core.set_item('P105_HEADER', CASE WHEN rec.task_id IS NOT NULL THEN 'Update Task ' || tsk_p100.c_task_prefix || rec.task_id ELSE core.get_page_name(105) END);

        -- calculate tab badges
        FOR c IN (
            SELECT
                'P105_BADGE_CHECKLIST'              AS item_name,
                tsk_p105.get_badge_icon(COUNT(*))   AS badge
            FROM tsk_task_checklist c
            WHERE c.task_id             = rec.task_id
                AND c.checklist_done    IS NULL
            UNION ALL
            SELECT
                'P105_BADGE_COMMENTS'               AS item_name,
                tsk_p105.get_badge_icon(COUNT(*))   AS badge
            FROM tsk_task_comments c
            WHERE c.task_id             = rec.task_id
        ) LOOP
            core.set_item(c.item_name, c.badge);
            --
            IF c.item_name = 'P105_BADGE_CHECKLIST' AND INSTR(c.badge, 'fa-number') >= 0 THEN
                core.set_item('P105_SHOW_SPLIT', 'Y');
            END IF;
        END LOOP;
        --
        core.set_item('P105_BADGE_DESC',    CASE WHEN LENGTH(rec.task_desc) > 0 THEN ' &nbsp;<span class="fa fa-arrow-circle-down"></span>' END);
        core.set_item('P105_BADGE_FILES',   '');
        core.set_item('P105_BADGE_COMMITS', '');
    END;



    PROCEDURE save_task
    AS
        v_action            VARCHAR2(64);
        rec                 tsk_tasks%ROWTYPE;
    BEGIN
        v_action            := APEX_APPLICATION.G_REQUEST;
        --
        rec.task_id         := core.get_item('P105_TASK_ID');
        rec.task_name       := core.get_item('P105_TASK_NAME');
        rec.task_desc       := core.get_item('P105_TASK_DESC');
        rec.board_id        := core.get_item('P105_BOARD_ID');
        rec.client_id       := core.get_item('P105_CLIENT_ID');
        rec.project_id      := core.get_item('P105_PROJECT_ID');
        rec.swimlane_id     := core.get_item('P105_SWIMLANE_ID');
        rec.status_id       := core.get_item('P105_STATUS_ID');
        rec.order#          := core.get_item('P105_ORDER#');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF v_action LIKE 'DELETE%' THEN
            DELETE FROM tsk_task_comments t
            WHERE t.task_id = rec.task_id;
            --
            DELETE FROM tsk_task_checklist t
            WHERE t.task_id = rec.task_id;
            --
            DELETE FROM tsk_tasks t
            WHERE t.task_id = rec.task_id;
            --
            RETURN;
        END IF;
        --
        UPDATE tsk_tasks t
        SET ROW = rec
        WHERE t.task_id         = rec.task_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            rec.task_id := tsk_task_id.NEXTVAL;
            --
            core.set_item('P105_TASK_ID', rec.task_id);
            --
            INSERT INTO tsk_tasks
            VALUES rec;
        END IF;
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
        rec.checklist_item  := NULLIF(LTRIM(RTRIM(APEX_UTIL.GET_SESSION_STATE('CHECKLIST_ITEM'))), '-');
        rec.checklist_done  := APEX_UTIL.GET_SESSION_STATE('CHECKLIST_DONE');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF rec.task_id IS NULL THEN
            rec.task_id     := core.get_item('P105_TASK_ID');
        END IF;

        -- verify if task exists
        BEGIN
            SELECT t.task_id INTO rec.task_id
            FROM tsk_tasks t
            WHERE t.task_id = rec.task_id;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN;
        END;

        -- proceed
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

        -- update also task
        UPDATE tsk_tasks t
        SET t.updated_at        = rec.updated_at,
            t.updated_by        = rec.updated_by
        WHERE t.task_id         = rec.task_id;
    END;



    FUNCTION get_badge_icon (
        in_value            NUMBER
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN CASE WHEN in_value > 0 THEN
            ' &nbsp;<span class="fa ' ||
            CASE
                WHEN in_value < 10
                    THEN 'fa-number-' || in_value  -- LOWER(TO_CHAR(TO_DATE(in_value, 'J'), 'JSP'))
                ELSE 'fa-arrow-circle-down'
                END ||
            '"></span>' END;
    END;



    PROCEDURE save_comment
    AS
        rec                 tsk_task_comments%ROWTYPE;
    BEGIN
        rec.task_id         := core.get_item('P105_TASK_ID');
        rec.comment_id      := core.get_item('P105_COMMENT_ID');
        rec.comment_payload := core.get_item('P105_COMMENT');
        --
        IF rec.comment_id IS NULL THEN
            rec.comment_id  := tsk_comment_id.NEXTVAL;
        END IF;
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF rec.comment_id IS NOT NULL AND rec.comment_payload IS NOT NULL THEN
            INSERT INTO tsk_task_comments
            VALUES rec;
            --
            core.set_item('P105_COMMENT_ID',    '');
            core.set_item('P105_COMMENT',       '');
        END IF;
    END;



    PROCEDURE ajax_delete_comment
    AS
        v_task_id           tsk_task_comments.task_id%TYPE;
        v_comment_id        tsk_task_comments.comment_id%TYPE;
    BEGIN
        v_task_id           := APEX_APPLICATION.G_X01;
        v_comment_id        := APEX_APPLICATION.G_X02;
        --
        IF v_task_id IS NOT NULL AND v_comment_id IS NOT NULL THEN
            DELETE FROM tsk_task_comments c
            WHERE c.task_id         = v_task_id
                AND c.comment_id    = v_comment_id;
            --
            IF SQL%ROWCOUNT = 1 THEN
                HTP.P('Comment deleted');
            END IF;
        END IF;
    END;



    PROCEDURE save_split_checklist
    AS
        rec                 tsk_tasks%ROWTYPE;
        v_source_task_id    tsk_tasks.task_id%TYPE;
    BEGIN
        v_source_task_id := core.get_item('P105_TASK_ID');
        --
        SELECT t.* INTO rec
        FROM tsk_tasks t
        WHERE t.task_id = v_source_task_id;
        --
        rec.task_id := tsk_task_id.NEXTVAL;
        --
        INSERT INTO tsk_tasks VALUES rec;
        --
        UPDATE tsk_task_checklist t
        SET t.task_id               = rec.task_id
        WHERE t.task_id             = v_source_task_id
            AND t.checklist_done    IS NULL;
        --
        core.set_item('P105_TASK_ID', rec.task_id);
    END;

END;
/

