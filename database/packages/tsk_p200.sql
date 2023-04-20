CREATE OR REPLACE PACKAGE BODY tsk_p200 AS

    PROCEDURE save_boards (
        io_board_id         IN OUT NOCOPY   VARCHAR2
    )
    AS
        v_action            CHAR;
        rec                 tsk_boards%ROWTYPE;
    BEGIN
        v_action            := APEX_UTIL.GET_SESSION_STATE('APEX$ROW_STATUS');
        --
        rec.client_id       := tsk_app.get_grid_client_id();
        rec.project_id      := tsk_app.get_grid_project_id();
        --
        rec.board_id        := APEX_UTIL.GET_SESSION_STATE('BOARD_ID');
        rec.board_name      := APEX_UTIL.GET_SESSION_STATE('BOARD_NAME');
        rec.is_active       := APEX_UTIL.GET_SESSION_STATE('IS_ACTIVE');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF v_action = 'D' THEN
            DELETE FROM tsk_boards t
            WHERE t.board_id    = rec.board_id;
            --
            RETURN;
        END IF;
        --
        UPDATE tsk_boards t
        SET ROW = rec
        WHERE t.board_id        = rec.board_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_boards
            VALUES rec;
        END IF;

        -- update keys to APEX
        io_board_id         := TO_CHAR(rec.board_id);
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_task_statuses (
        io_client_id        IN OUT NOCOPY   tsk_statuses.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_statuses.project_id%TYPE,
        io_status_id        IN OUT NOCOPY   tsk_statuses.status_id%TYPE         -- old key
    )
    AS
        v_action            CHAR;
        rec                 tsk_statuses%ROWTYPE;
    BEGIN
        v_action            := APEX_UTIL.GET_SESSION_STATE('APEX$ROW_STATUS');
        --
        rec.client_id       := tsk_app.get_grid_client_id(io_client_id);
        rec.project_id      := tsk_app.get_grid_project_id(io_project_id);
        --
        rec.status_id       := APEX_UTIL.GET_SESSION_STATE('STATUS_ID');        -- new key
        rec.status_name     := APEX_UTIL.GET_SESSION_STATE('STATUS_NAME');
        rec.is_active       := APEX_UTIL.GET_SESSION_STATE('IS_ACTIVE');
        rec.order#          := APEX_UTIL.GET_SESSION_STATE('ORDER#');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- are we deleting the status?
        IF v_action = 'D' THEN
            DELETE FROM tsk_statuses t
            WHERE t.status_id       = io_status_id          -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            RETURN;
        END IF;

        -- are we renaming the primary key?
        IF rec.status_id != io_status_id AND v_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_statuses
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.status_id         = rec.status_id         -- new key
            WHERE t.status_id       = io_status_id          -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            DELETE FROM tsk_statuses t
            WHERE t.status_id       = io_status_id          -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
        ELSE
            -- proceed with update or insert
            UPDATE tsk_statuses t
            SET ROW = rec
            WHERE t.status_id       = io_status_id
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_statuses
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        io_client_id        := rec.client_id;
        io_project_id       := rec.project_id;
        io_status_id        := rec.status_id;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_task_swimlanes (
        io_client_id        IN OUT NOCOPY   tsk_swimlanes.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_swimlanes.project_id%TYPE,
        io_swimlane_id      IN OUT NOCOPY   tsk_swimlanes.swimlane_id%TYPE
    )
    AS
        v_action            CHAR;
        rec                 tsk_swimlanes%ROWTYPE;
    BEGIN
        v_action            := APEX_UTIL.GET_SESSION_STATE('APEX$ROW_STATUS');
        --
        rec.client_id       := tsk_app.get_grid_client_id(io_client_id);
        rec.project_id      := tsk_app.get_grid_project_id(io_project_id);
        --
        rec.swimlane_id     := APEX_UTIL.GET_SESSION_STATE('SWIMLANE_ID');
        rec.swimlane_name   := APEX_UTIL.GET_SESSION_STATE('SWIMLANE_NAME');
        rec.is_active       := APEX_UTIL.GET_SESSION_STATE('IS_ACTIVE');
        rec.order#          := APEX_UTIL.GET_SESSION_STATE('ORDER#');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF v_action = 'D' THEN
            DELETE FROM tsk_swimlanes t
            WHERE t.swimlane_id     = io_swimlane_id        -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            RETURN;
        END IF;

        -- are we renaming the primary key?
        IF rec.swimlane_id != io_swimlane_id AND v_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_swimlanes
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.swimlane_id       = rec.swimlane_id       -- new key
            WHERE t.swimlane_id     = io_swimlane_id        -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            DELETE FROM tsk_swimlanes t
            WHERE t.swimlane_id     = io_swimlane_id        -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
        ELSE
            UPDATE tsk_swimlanes t
            SET ROW = rec
            WHERE t.swimlane_id     = io_swimlane_id
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_swimlanes
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        io_client_id        := rec.client_id;
        io_project_id       := rec.project_id;
        io_swimlane_id      := rec.swimlane_id;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE reorder_task_statuses (
        in_client_id        tsk_statuses.client_id%TYPE    := NULL,
        in_project_id       tsk_statuses.project_id%TYPE   := NULL
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
            FROM tsk_statuses t
            WHERE 1 = 1
                AND (t.client_id    = in_client_id  OR in_client_id  IS NULL)
                AND (t.project_id   = in_project_id OR in_project_id IS NULL)
        ) LOOP
            UPDATE tsk_statuses t
            SET t.order#            = s.order#
            WHERE t.status_id       = s.status_id
                AND t.client_id     = s.client_id
                AND t.project_id    = s.project_id
                AND (t.order#       != s.order# OR t.order# IS NULL);
        END LOOP;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE reorder_task_swimlanes (
        in_client_id        tsk_swimlanes.client_id%TYPE   := NULL,
        in_project_id       tsk_swimlanes.project_id%TYPE  := NULL
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
            FROM tsk_swimlanes t
            WHERE 1 = 1
                AND (t.client_id    = in_client_id  OR in_client_id  IS NULL)
                AND (t.project_id   = in_project_id OR in_project_id IS NULL)
        ) LOOP
            UPDATE tsk_swimlanes t
            SET t.order#            = s.order#
            WHERE t.swimlane_id     = s.swimlane_id
                AND t.client_id     = s.client_id
                AND t.project_id    = s.project_id
                AND (t.order#       != s.order# OR t.order# IS NULL);
        END LOOP;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

