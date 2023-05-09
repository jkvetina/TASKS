CREATE OR REPLACE PACKAGE BODY tsk_p300 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        -- calculate page header
        FOR c IN (
            SELECT 'Projects for ' || c.client_name AS name
            FROM tsk_clients c
            WHERE c.client_id = tsk_app.get_client_id()
        ) LOOP
            core.set_item('P300_HEADER', c.name);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_projects (
        io_client_id        IN OUT NOCOPY   tsk_projects.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_projects.project_id%TYPE
    )
    AS
        rec                 tsk_projects%ROWTYPE;
        rec_swim            tsk_swimlanes%ROWTYPE;
        --
        v_action            CONSTANT CHAR   := core.get_grid_action();
    BEGIN
        rec.client_id       := COALESCE(core.get_grid_data('CLIENT_ID'), tsk_app.get_client_id());
        --
        rec.project_id      := core.get_grid_data('PROJECT_ID');
        rec.project_name    := core.get_grid_data('PROJECT_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        --
        tsk_tapi.projects (rec, v_action,
            old_client_id   => io_client_id,
            old_project_id  => io_project_id
        );

        -- create default swimlane
        IF v_action = 'C' THEN
            rec_swim.client_id      := rec.client_id;
            rec_swim.project_id     := rec.project_id;
            rec_swim.swimlane_id    := '-';
            rec_swim.swimlane_name  := '-';
            rec_swim.is_active      := 'Y';
            rec_swim.order#         := 100;
            --
            tsk_tapi.swimlanes (rec_swim,
                old_client_id       => rec_swim.client_id,
                old_project_id      => rec_swim.project_id,
                old_swimlane_id     => rec_swim.swimlane_id
            );
        END IF;

        -- for new records overwrite user settings
        IF v_action = 'C' THEN
            tsk_app.set_user_preferences (
                in_user_id          => core.get_user_id(),
                in_client_id        => rec.client_id,
                in_project_id       => rec.project_id,
                in_board_id         => NULL
            );
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

