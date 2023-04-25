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

        -- are we renaming the primary key?
        IF rec.client_id != io_client_id AND core.get_grid_action() = 'U' THEN
            -- first create new record
            INSERT INTO tsk_clients
            VALUES rec;
            --
            rename_client_id (
                in_old_client_id    => io_client_id,        -- old key
                in_new_client_id    => rec.client_id        -- new key
            );
            --
            DELETE FROM tsk_clients t
            WHERE t.client_id       = io_client_id;         -- old key
        ELSE
            -- proceed with update or insert
            UPDATE tsk_clients t
            SET ROW = rec
            WHERE t.client_id       = rec.client_id;
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_clients
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        io_client_id       := TO_CHAR(rec.client_id);

        -- for new records overwrite user settings
        IF core.get_grid_action() = 'C' THEN
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



    PROCEDURE rename_client_id (
        in_old_client_id        tsk_clients.client_id%TYPE,
        in_new_client_id        tsk_clients.client_id%TYPE
    )
    AS
        in_table_name           user_tab_cols.table_name%TYPE   := 'TSK_CLIENTS';
        in_column_name          user_tab_cols.column_name%TYPE  := 'CLIENT_ID';
    BEGIN
        -- rename in all related tables, need deferred foreign keys for this
        FOR c IN (
            SELECT c.table_name
            FROM all_tab_cols c
            JOIN all_tables t
                ON t.owner          = c.owner
                AND t.table_name    = c.table_name
            WHERE c.owner           = core.get_owner()
                AND c.table_name    LIKE 'TSK\_%' ESCAPE '\'
                AND c.column_name   = in_column_name
                AND c.table_name    != in_table_name
            ORDER BY 1
        ) LOOP
            BEGIN
                EXECUTE IMMEDIATE
                    'UPDATE ' || c.table_name                   || CHR(10) ||
                    'SET client_id          = :NEW_CLIENT_ID'   || CHR(10) ||
                    'WHERE client_id        = :OLD_CLIENT_ID'
                    USING
                        in_new_client_id,
                        in_old_client_id;
            EXCEPTION
            WHEN OTHERS THEN
                core.raise_error(NULL, c.table_name, in_old_client_id, in_new_client_id);
            END;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

