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
        io_project_id       IN OUT NOCOPY   VARCHAR2
    )
    AS
        rec                 tsk_projects%ROWTYPE;
    BEGIN
        rec.client_id       := COALESCE(core.get_grid_data('CLIENT_ID'), tsk_app.get_client_id());
        --
        rec.project_id      := core.get_grid_data('PROJECT_ID');
        rec.project_name    := core.get_grid_data('PROJECT_NAME');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF core.get_grid_action() = 'D' THEN
            DELETE FROM tsk_projects t
            WHERE t.project_id      = rec.project_id;
            --
            RETURN;
        END IF;

        -- are we renaming the primary key?
        IF rec.project_id != io_project_id AND core.get_grid_action() = 'U' THEN
            -- first create new record
            INSERT INTO tsk_projects
            VALUES rec;
            --
            rename_project_id (
                in_old_project_id   => io_project_id,       -- old key
                in_new_project_id   => rec.project_id,      -- new key
                in_client_id        => rec.client_id
            );
            --
            DELETE FROM tsk_projects t
            WHERE t.project_id      = io_project_id;        -- old key
        ELSE
            -- proceed with update or insert
            UPDATE tsk_projects t
            SET ROW = rec
            WHERE t.project_id      = rec.project_id;
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_projects
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        io_project_id       := TO_CHAR(rec.project_id);

        -- for new records overwrite user settings
        IF core.get_grid_action() = 'C' THEN
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



    PROCEDURE rename_project_id (
        in_old_project_id       tsk_projects.project_id%TYPE,
        in_new_project_id       tsk_projects.project_id%TYPE,
        in_client_id            tsk_projects.client_id%TYPE
    )
    AS
        in_table_name           user_tab_cols.table_name%TYPE   := 'TSK_PROJECTS';
        in_column_name          user_tab_cols.column_name%TYPE  := 'PROJECT_ID';
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
                    'SET project_id         = :NEW_PROJECT_ID'  || CHR(10) ||
                    'WHERE client_id        = :CLIENT_ID'       || CHR(10) ||
                    '     AND project_id    = :OLD_PROJECT_ID'
                    USING
                        in_new_project_id,
                        in_client_id,
                        in_old_project_id;
            EXCEPTION
            WHEN OTHERS THEN
                core.raise_error(NULL, c.table_name, in_old_project_id, in_new_project_id, in_client_id);
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

