CREATE OR REPLACE PACKAGE BODY tsk_p400 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        NULL;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_clients (
        io_client_id        IN OUT NOCOPY   VARCHAR2
    )
    AS
        rec                 tsk_clients%ROWTYPE;
    BEGIN
        rec.client_id       := core.get_grid_data('CLIENT_ID');
        rec.client_name     := core.get_grid_data('CLIENT_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF core.get_grid_action() = 'D' THEN
            DELETE FROM tsk_clients t
            WHERE t.client_id       = rec.client_id;
            --
            RETURN;
        END IF;
        --
        UPDATE tsk_clients t
        SET ROW = rec
        WHERE t.client_id           = rec.client_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_clients
            VALUES rec;
        END IF;

        -- update keys to APEX
        io_client_id       := TO_CHAR(rec.client_id);
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

