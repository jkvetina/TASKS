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



    PROCEDURE save_projects
    AS
        rec                 tsk_projects%ROWTYPE;
        in_action           CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.client_id       := core.get_grid_data('CLIENT_ID');
        rec.project_id      := core.get_grid_data('PROJECT_ID');
        rec.project_name    := core.get_grid_data('PROJECT_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        --
        tsk_tapi.projects (rec,
            in_action           => in_action,
            in_client_id        => NVL(core.get_grid_data('OLD_CLIENT_ID'), rec.client_id),
            in_project_id       => NVL(core.get_grid_data('OLD_PROJECT_ID'), rec.project_id)
        );
        --
        IF in_action = 'D' THEN
            COMMIT;     -- commit to catch possible error here, because all foreign keys are deferred
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_CLIENT_ID',         rec.client_id);
        core.set_grid_data('OLD_PROJECT_ID',        rec.project_id);

        -- just for the new records
        IF in_action = 'C' THEN
            create_default_swimlane (
                in_client_id        => rec.client_id,
                in_project_id       => rec.project_id
            );

            -- overwrite user settings
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



    PROCEDURE create_default_swimlane (
        in_client_id        tsk_projects.client_id%TYPE,
        in_project_id       tsk_projects.project_id%TYPE
    )
    AS
        rec                 tsk_swimlanes%ROWTYPE;
    BEGIN
        rec.client_id       := in_client_id;
        rec.project_id      := in_project_id;
        rec.swimlane_id     := '-';
        rec.swimlane_name   := '-';
        rec.is_active       := 'Y';
        rec.order#          := 100;
        --
        tsk_tapi.swimlanes (rec,
            old_client_id       => rec.client_id,
            old_project_id      => rec.project_id,
            old_swimlane_id     => rec.swimlane_id
        );
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

