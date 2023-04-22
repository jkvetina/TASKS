CREATE OR REPLACE PACKAGE BODY tsk_p200 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        FOR c IN (
            SELECT p.project_name || ' - Projects' AS name
            FROM tsk_projects p
            WHERE p.project_id = tsk_app.get_project_id()
        ) LOOP
            core.set_item('P200_HEADER', c.name);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_boards (
        io_board_id         IN OUT NOCOPY   VARCHAR2
    )
    AS
        rec                 tsk_boards%ROWTYPE;
    BEGIN
        rec.client_id       := tsk_app.get_client_id();
        rec.project_id      := tsk_app.get_project_id();
        --
        rec.board_id        := core.get_grid_data('BOARD_ID');
        rec.board_name      := core.get_grid_data('BOARD_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF core.get_grid_action() = 'D' THEN
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
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_task_statuses (
        io_client_id        IN OUT NOCOPY   tsk_statuses.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_statuses.project_id%TYPE,
        io_status_id        IN OUT NOCOPY   tsk_statuses.status_id%TYPE         -- old key
    )
    AS
        rec                 tsk_statuses%ROWTYPE;
    BEGIN
        rec.client_id       := tsk_app.get_client_id();
        rec.project_id      := tsk_app.get_project_id();
        --
        rec.status_id       := core.get_grid_data('STATUS_ID');        -- new key
        rec.status_name     := core.get_grid_data('STATUS_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.is_default      := core.get_grid_data('IS_DEFAULT');
        rec.is_named        := core.get_grid_data('IS_NAMED');
        rec.order#          := core.get_grid_data('ORDER#');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- are we deleting the status?
        IF core.get_grid_action() = 'D' THEN
            DELETE FROM tsk_statuses t
            WHERE t.status_id       = io_status_id          -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            RETURN;
        END IF;

        -- are we renaming the primary key?
        IF rec.status_id != io_status_id AND core.get_grid_action() = 'U' THEN
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
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_task_swimlanes (
        io_client_id        IN OUT NOCOPY   tsk_swimlanes.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_swimlanes.project_id%TYPE,
        io_swimlane_id      IN OUT NOCOPY   tsk_swimlanes.swimlane_id%TYPE
    )
    AS
        rec                 tsk_swimlanes%ROWTYPE;
    BEGIN
        rec.client_id       := tsk_app.get_client_id();
        rec.project_id      := tsk_app.get_project_id();
        --
        rec.swimlane_id     := core.get_grid_data('SWIMLANE_ID');
        rec.swimlane_name   := core.get_grid_data('SWIMLANE_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.order#          := core.get_grid_data('ORDER#');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF core.get_grid_action() = 'D' THEN
            DELETE FROM tsk_swimlanes t
            WHERE t.swimlane_id     = io_swimlane_id        -- old key
                AND t.client_id     = io_client_id
                AND t.project_id    = io_project_id;
            --
            RETURN;
        END IF;

        -- are we renaming the primary key?
        IF rec.swimlane_id != io_swimlane_id AND core.get_grid_action() = 'U' THEN
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
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE reorder_task_statuses
    AS
        in_client_id        CONSTANT tsk_statuses.client_id%TYPE    := tsk_app.get_client_id();
        in_project_id       CONSTANT tsk_statuses.project_id%TYPE   := tsk_app.get_project_id();
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
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE reorder_task_swimlanes
    AS
        in_client_id        CONSTANT tsk_statuses.client_id%TYPE    := tsk_app.get_client_id();
        in_project_id       CONSTANT tsk_statuses.project_id%TYPE   := tsk_app.get_project_id();
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
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

