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
        core.set_item('P105_HEADER', CASE WHEN rec.task_id IS NOT NULL THEN 'Update Task ' || rec.task_id ELSE core.get_page_name(105) END);

        -- calculate tab badges
        FOR c IN (
            SELECT tsk_p105.get_badge_icon(COUNT(*)) AS badge
            FROM tsk_task_comments c
            WHERE c.task_id = rec.task_id
        ) LOOP
            core.set_item('P105_BADGE_COMMENTS', c.badge);
        END LOOP;
        --
        core.set_item('P105_BADGE_DESC',        CASE WHEN LENGTH(rec.task_desc) > 0 THEN ' &nbsp;<span class="fa fa-arrow-circle-down"></span>' END);
        core.set_item('P105_BADGE_CHECKLIST',   '');
        core.set_item('P105_BADGE_FILES',       '');
        core.set_item('P105_BADGE_GIT',         '');
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



    PROCEDURE delete_comment (
        in_task_id          tsk_task_comments.task_id%TYPE,
        in_comment_id       tsk_task_comments.comment_id%TYPE
    )
    AS
    BEGIN
        IF in_task_id IS NOT NULL THEN
            DELETE FROM tsk_task_comments c
            WHERE c.task_id         = in_task_id
                AND c.comment_id    = in_comment_id;
        END IF;
    END;

END;
/

