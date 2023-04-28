CREATE OR REPLACE PACKAGE BODY tsk_tapi AS

    PROCEDURE boards (
        rec                     IN OUT NOCOPY   tsk_boards%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_board_id            IN OUT NOCOPY   VARCHAR2                            -- apex item is a string
    )
    AS
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => REGEXP_REPLACE(core.get_caller_name(2), '[^\.]+\.', 'TSK_'),
            in_action           => in_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF in_action = 'D' THEN
            DELETE FROM tsk_boards t
            WHERE t.board_id    = NVL(old_board_id, rec.board_id);
            --
            RETURN;
        END IF;

        -- generate primary key if needed
        IF in_action = 'C' AND rec.board_id IS NULL THEN
            rec.board_id := tsk_board_id.NEXTVAL;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- upsert record
        UPDATE tsk_boards t
        SET ROW             = rec
        WHERE t.board_id    = NVL(old_board_id, rec.board_id);
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_boards VALUES rec;
        END IF;

        -- update keys to APEX
        old_board_id    := TO_CHAR(rec.board_id);
    END;



    PROCEDURE statuses (
        rec                     IN OUT NOCOPY   tsk_statuses%ROWTYPE,
        in_action                               CHAR                            := NULL,
        old_client_id           IN OUT NOCOPY   tsk_statuses.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_statuses.project_id%TYPE,
        old_status_id           IN OUT NOCOPY   tsk_statuses.status_id%TYPE     -- old key
    )
    AS
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => REGEXP_REPLACE(core.get_caller_name(2), '[^\.]+\.', 'TSK_'),
            in_action           => in_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF in_action = 'D' THEN
            DELETE FROM tsk_statuses t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF rec.status_id != old_status_id AND in_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_statuses
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.status_id         = rec.status_id
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
            --
            DELETE FROM tsk_statuses t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
        ELSE
            -- proceed with update or insert
            UPDATE tsk_statuses t
            SET ROW = rec
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_statuses
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        old_client_id       := rec.client_id;
        old_project_id      := rec.project_id;
        old_status_id       := rec.status_id;
    END;



    PROCEDURE swimlanes (
        rec                     IN OUT NOCOPY   tsk_swimlanes%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_client_id           IN OUT NOCOPY   tsk_swimlanes.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_swimlanes.project_id%TYPE,
        old_swimlane_id         IN OUT NOCOPY   tsk_swimlanes.swimlane_id%TYPE      -- old key
    )
    AS
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => REGEXP_REPLACE(core.get_caller_name(2), '[^\.]+\.', 'TSK_'),
            in_action           => in_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF in_action = 'D' THEN
            DELETE FROM tsk_swimlanes t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF rec.swimlane_id != old_swimlane_id AND in_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_swimlanes
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.swimlane_id         = rec.swimlane_id
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
            --
            DELETE FROM tsk_swimlanes t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
        ELSE
            -- proceed with update or insert
            UPDATE tsk_swimlanes t
            SET ROW = rec
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_swimlanes
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        old_client_id       := rec.client_id;
        old_project_id      := rec.project_id;
        old_swimlane_id     := rec.swimlane_id;
    END;



    PROCEDURE categories (
        rec                     IN OUT NOCOPY   tsk_categories%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_client_id           IN OUT NOCOPY   tsk_categories.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_categories.project_id%TYPE,
        old_category_id         IN OUT NOCOPY   tsk_categories.category_id%TYPE     -- old key
    )
    AS
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => REGEXP_REPLACE(core.get_caller_name(2), '[^\.]+\.', 'TSK_'),
            in_action           => in_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF in_action = 'D' THEN
            DELETE FROM tsk_categories t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF rec.category_id != old_category_id AND in_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_categories
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.category_id         = rec.category_id
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
            --
            DELETE FROM tsk_categories t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
        ELSE
            -- proceed with update or insert
            UPDATE tsk_categories t
            SET ROW = rec
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_categories
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        old_client_id       := rec.client_id;
        old_project_id      := rec.project_id;
        old_category_id     := rec.category_id;
    END;

END;
/

