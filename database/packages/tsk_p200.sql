CREATE OR REPLACE PACKAGE BODY tsk_p200 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        -- calculate page header
        FOR c IN (
            SELECT 'Boards for ' || p.project_name AS name
            FROM tsk_projects p
            WHERE p.project_id = tsk_app.get_project_id()
        ) LOOP
            core.set_item('P200_HEADER', c.name);
        END LOOP;

        -- calculate dynamic header
        FOR c IN (
            SELECT
                s.status_name_1,
                s.status_name_2,
                s.status_name_3,
                s.status_name_4,
                s.status_name_5,
                s.status_name_6,
                s.status_name_7,
                s.status_name_8
            FROM tsk_p200_boards_v s
            WHERE ROWNUM = 1
        ) LOOP
            core.set_item('P200_STATUS_1', c.status_name_1);
            core.set_item('P200_STATUS_2', c.status_name_2);
            core.set_item('P200_STATUS_3', c.status_name_3);
            core.set_item('P200_STATUS_4', c.status_name_4);
            core.set_item('P200_STATUS_5', c.status_name_5);
            core.set_item('P200_STATUS_6', c.status_name_6);
            core.set_item('P200_STATUS_7', c.status_name_7);
            core.set_item('P200_STATUS_8', c.status_name_8);
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
        v_action            CONSTANT CHAR   := core.get_grid_action();
    BEGIN
        rec.client_id       := core.get_grid_data('CLIENT_ID');
        rec.project_id      := core.get_grid_data('PROJECT_ID');
        rec.board_id        := core.get_grid_data('BOARD_ID');
        rec.board_name      := core.get_grid_data('BOARD_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.order#          := core.get_grid_data('ORDER#');
        --
        tsk_tapi.boards (rec, v_action,
            old_board_id    => io_board_id
        );

        -- for new records overwrite user settings
        IF v_action = 'C' THEN
            tsk_app.set_user_preferences (
                in_user_id          => core.get_user_id(),
                in_client_id        => rec.client_id,
                in_project_id       => rec.project_id,
                in_board_id         => rec.board_id
            );
        END IF;
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
        v_action            CONSTANT CHAR   := core.get_grid_action();
    BEGIN
        rec.client_id       := COALESCE(core.get_grid_data('CLIENT_ID'),    tsk_app.get_client_id());
        rec.project_id      := COALESCE(core.get_grid_data('PROJECT_ID'),   tsk_app.get_project_id());
        --
        rec.status_id       := core.get_grid_data('STATUS_ID');        -- new key
        rec.status_name     := core.get_grid_data('STATUS_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.is_default      := core.get_grid_data('IS_DEFAULT');
        rec.is_named        := core.get_grid_data('IS_NAMED');
        rec.order#          := core.get_grid_data('ORDER#');
        --
        tsk_tapi.statuses (rec, v_action,
            old_client_id       => io_client_id,
            old_project_id      => io_project_id,
            old_status_id       => io_status_id
        );
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
        v_action            CONSTANT CHAR   := core.get_grid_action();
    BEGIN
        rec.client_id       := COALESCE(core.get_grid_data('CLIENT_ID'),    tsk_app.get_client_id());
        rec.project_id      := COALESCE(core.get_grid_data('PROJECT_ID'),   tsk_app.get_project_id());
        --
        rec.swimlane_id     := core.get_grid_data('SWIMLANE_ID');
        rec.swimlane_name   := core.get_grid_data('SWIMLANE_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.order#          := core.get_grid_data('ORDER#');
        --
        tsk_tapi.swimlanes (rec, v_action,
            old_client_id       => io_client_id,
            old_project_id      => io_project_id,
            old_swimlane_id     => io_swimlane_id
        );
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_task_categories (
        io_client_id        IN OUT NOCOPY   tsk_categories.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_categories.project_id%TYPE,
        io_category_id      IN OUT NOCOPY   tsk_categories.category_id%TYPE     -- old key
    )
    AS
        rec                 tsk_categories%ROWTYPE;
        v_action            CONSTANT CHAR   := core.get_grid_action();
    BEGIN
        rec.client_id       := COALESCE(core.get_grid_data('CLIENT_ID'),    tsk_app.get_client_id());
        rec.project_id      := COALESCE(core.get_grid_data('PROJECT_ID'),   tsk_app.get_project_id());
        --
        rec.category_id     := core.get_grid_data('CATEGORY_ID');       -- new key
        rec.category_name   := core.get_grid_data('CATEGORY_NAME');
        rec.color_bg        := core.get_grid_data('COLOR_BG');
        rec.color_fg        := core.get_grid_data('COLOR_FG');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.is_default      := core.get_grid_data('IS_DEFAULT');
        rec.order#          := core.get_grid_data('ORDER#');
        --
        tsk_tapi.categories (rec, v_action,
            old_client_id       => io_client_id,
            old_project_id      => io_project_id,
            old_category_id     => io_category_id
        );
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

