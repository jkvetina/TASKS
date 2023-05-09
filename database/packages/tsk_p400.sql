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



    PROCEDURE save_clients (
        io_client_id        IN OUT NOCOPY   tsk_clients.client_id%TYPE
    )
    AS
        rec                 tsk_clients%ROWTYPE;
        v_action            CONSTANT CHAR   := core.get_grid_action();
    BEGIN
        rec.client_id       := core.get_grid_data('CLIENT_ID');
        rec.client_name     := core.get_grid_data('CLIENT_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        --
        tsk_tapi.clients (rec, v_action,
            old_client_id   => io_client_id
        );

        -- for new records overwrite user settings
        IF v_action = 'C' THEN
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

