CREATE OR REPLACE PACKAGE BODY tsk_p400 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        NULL;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_clients
    AS
        rec                 tsk_clients%ROWTYPE;
        in_action           CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.client_id       := core.get_grid_data('CLIENT_ID');
        rec.client_name     := core.get_grid_data('CLIENT_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        --
        tsk_tapi.clients (rec,
            in_action       => in_action,
            in_client_id    => core.get_grid_data('OLD_CLIENT_ID')
        );
        --
        IF in_action = 'D' THEN
            COMMIT;     -- commit to catch possible error here, because all foreign keys are deferred
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_CLIENT_ID',     rec.client_id);

        -- just for the new records
        IF in_action = 'C' THEN
            -- overwrite user settings
            tsk_app.set_user_preferences (
                in_user_id          => core.get_user_id(),
                in_client_id        => rec.client_id,
                in_project_id       => NULL,
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

