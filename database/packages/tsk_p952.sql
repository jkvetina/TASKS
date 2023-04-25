CREATE OR REPLACE PACKAGE BODY tsk_p952 AS

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



    PROCEDURE save_users
    AS
        rec                 tsk_auth_users%ROWTYPE;
    BEGIN
        rec.client_id       := COALESCE(core.get_grid_data('CLIENT_ID'),    tsk_app.get_client_id());
        --
        rec.user_id         := core.get_grid_data('USER_ID');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- delete or insert new record
        IF rec.is_active IS NULL THEN
            DELETE FROM tsk_auth_roles t
            WHERE t.client_id       = rec.client_id
                AND t.user_id       = rec.user_id;
            --
            DELETE FROM tsk_auth_users t
            WHERE t.client_id       = rec.client_id
                AND t.user_id       = rec.user_id;
        ELSE
            BEGIN
                INSERT INTO tsk_auth_users
                VALUES rec;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;
            END;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

