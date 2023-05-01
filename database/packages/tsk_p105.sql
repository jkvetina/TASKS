CREATE OR REPLACE PACKAGE BODY tsk_p105 AS

    PROCEDURE init_defaults
    AS
        rec                 tsk_tasks%ROWTYPE;
    BEGIN
        -- get tasks details
        rec.task_id := core.get_item('P105_TASK_ID');

        -- for existing task
        IF rec.task_id IS NOT NULL THEN
            BEGIN
                SELECT t.* INTO rec
                FROM tsk_tasks t
                --
                -- @TODO: AUTH
                --
                WHERE t.task_id = rec.task_id;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                core.raise_error('INVALID_TASK');
            END;

            -- calculate prev/next tasks
            FOR c IN (
                SELECT t.task_id, t.prev_task, t.next_task
                FROM tsk_p100_tasks_grid_v t
                WHERE t.task_id = rec.task_id
            ) LOOP
                core.set_item('P105_PREV_TASK_ID', NULLIF(c.prev_task, c.task_id));
                core.set_item('P105_NEXT_TASK_ID', NULLIF(c.next_task, c.task_id));
            END LOOP;

            -- calculate tab badges
            FOR c IN (
                SELECT
                    b.item_name,
                    b.badge
                FROM tsk_p105_badges_v b
            ) LOOP
                core.set_item(c.item_name, c.badge);

                -- offer task split when there are unfinished items on checklist
                IF c.item_name = 'P105_BADGE_CHECKLIST' AND INSTR(c.badge, 'fa-number') >= 0 THEN
                    core.set_item('P105_SHOW_SPLIT', 'Y');
                END IF;
            END LOOP;
            --
            core.set_item('P105_BADGE_DESC',    CASE WHEN LENGTH(rec.task_desc) > 0 THEN ' &nbsp;<span class="fa fa-arrow-circle-down"></span>' END);
            --
        ELSE
            -- get defaults for new task
            core.set_item('P105_CLIENT_ID',     tsk_app.get_client_id());
            core.set_item('P105_PROJECT_ID',    tsk_app.get_project_id());
            core.set_item('P105_BOARD_ID',      tsk_app.get_board_id());
            core.set_item('P105_OWNER_ID',      core.get_user_id());
            --
            FOR c IN (
                SELECT s.status_id
                FROM tsk_lov_statuses_v s
                WHERE s.is_default = 'Y'
            ) LOOP
                core.set_item('P105_STATUS_ID', c.status_id);
            END LOOP;
            --
            FOR c IN (
                SELECT s.category_id AS category_id
                FROM tsk_lov_categories_v s
                WHERE s.is_default = 'Y'
            ) LOOP
                core.set_item('P105_CATEGORY_ID', c.category_id);
            END LOOP;
        END IF;

        -- overwrite some page items
        core.set_item('P105_TASK_LINK',     tsk_app.get_task_link(rec.task_id, 'EXTERNAL'));
        core.set_item('P105_AUDIT',         TO_CHAR(rec.updated_at, 'YYYY-MM-DD HH24:MI') || ' ' || rec.updated_by);
        core.set_item('P105_TAGS',          LTRIM(RTRIM(REPLACE(rec.tags, ':', ' '))));

        -- calculate page header
        core.set_item('P105_HEADER', CASE WHEN rec.task_id IS NOT NULL THEN 'Update Task ' || tsk_p100.c_task_prefix || rec.task_id ELSE core.get_page_name(105) END);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_task
    AS
        v_action            VARCHAR2(64);
        rec                 tsk_tasks%ROWTYPE;
    BEGIN
        v_action            := core.get_request();
        --
        rec.task_id         := core.get_item('P105_TASK_ID');
        rec.task_name       := core.get_item('P105_TASK_NAME');
        rec.task_desc       := core.get_item('P105_TASK_DESC');
        rec.board_id        := core.get_item('P105_BOARD_ID');
        rec.client_id       := core.get_item('P105_CLIENT_ID');
        rec.project_id      := core.get_item('P105_PROJECT_ID');
        rec.status_id       := core.get_item('P105_STATUS_ID');
        rec.swimlane_id     := core.get_item('P105_SWIMLANE_ID');
        rec.category_id     := core.get_item('P105_CATEGORY_ID');
        rec.owner_id        := core.get_item('P105_OWNER_ID');
        rec.deadline_at     := core.get_date_item('P105_DEADLINE_AT');
        rec.tags            := NULLIF(':' || SUBSTR(REGEXP_REPLACE(LOWER(core.get_item('P105_TAGS')), '[^a-z0-9]+', ':'), 1, 256) || ':', '::');
        rec.order#          := core.get_item('P105_ORDER');
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_checklist
    AS
        rec                 tsk_task_checklist%ROWTYPE;
    BEGIN
        rec.task_id         := core.get_grid_data('TASK_ID');
        rec.checklist_id    := core.get_grid_data('CHECKLIST_ID');
        rec.checklist_item  := NULLIF(LTRIM(RTRIM(core.get_grid_data('CHECKLIST_ITEM'))), '-');
        rec.checklist_done  := core.get_grid_data('CHECKLIST_DONE');
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
            core.raise_error('INVALID_TASK');
        END;

        -- proceed
        IF (core.get_grid_action() = 'D' OR rec.checklist_item IS NULL) THEN
            DELETE FROM tsk_task_checklist t
            WHERE t.task_id         = rec.task_id
                AND t.checklist_id  = rec.checklist_id;
            --
            RETURN;
        END IF;
        --
        IF rec.checklist_id > 0 THEN
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_merge_checklist
    AS
        v_source_task_id    tsk_tasks.task_id%TYPE;
        v_target_task_id    tsk_tasks.task_id%TYPE;
    BEGIN
        v_source_task_id    := core.get_item('$TASK_ID');
        v_target_task_id    := core.get_item('$TARGET_TASK_ID');
        --
        UPDATE tsk_task_checklist t
        SET t.task_id       = v_target_task_id
        WHERE t.task_id     = v_source_task_id;
        --
        -- @TODO: move description, attachements, comments, commits, tags...
        --
        DELETE FROM tsk_tasks t
        WHERE t.task_id     = v_source_task_id;
        --
        -- and now we should redirect user to the target task
        --
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_attachements
    AS
        rec         tsk_task_files%ROWTYPE;
    BEGIN
        FOR c IN (
            SELECT f.*
            FROM apex_application_temp_files f
            JOIN APEX_STRING.SPLIT(core.get_item('P105_ATTACHED_FILES'), ':') i
                ON i.column_value   = f.name
            WHERE f.application_id  = core.get_app_id()
        ) LOOP
            rec.file_id         := tsk_file_id.NEXTVAL;
            rec.file_name       := c.filename;
            rec.file_mime       := c.mime_type;
            rec.file_size       := DBMS_LOB.GETLENGTH(c.blob_content);
            rec.file_payload    := c.blob_content;
            --
            rec.task_id         := core.get_item('P105_TASK_ID');
            rec.updated_by      := core.get_user_id();
            rec.updated_at      := SYSDATE;
            --
            INSERT INTO tsk_task_files VALUES rec;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE download_attachement (
        in_file_id              tsk_task_files.file_id%TYPE
    ) AS
        rec                     tsk_task_files%ROWTYPE;
    BEGIN
        BEGIN
            SELECT f.* INTO rec
            FROM tsk_task_files f
            JOIN tsk_tasks t
                ON t.task_id        = f.task_id
            WHERE f.file_id         = in_file_id
                AND t.project_id    = tsk_app.get_project_id();
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            core.raise_error('FILE_NOT_FOUND');
        END;
        --
        core.download_file (
            in_file_name        => rec.file_name,
            in_file_mime        => rec.file_mime,
            in_file_payload     => rec.file_payload
        );
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

