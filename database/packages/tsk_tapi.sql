CREATE OR REPLACE PACKAGE BODY tsk_tapi AS

    FUNCTION get_table_name
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN REGEXP_REPLACE(core.get_caller_name(3), '[^\.]+\.', 'TSK_');
    END;



    FUNCTION get_action (
        in_action               VARCHAR2 := NULL
    )
    RETURN CHAR
    AS
    BEGIN
        RETURN COALESCE(in_action, core.get_grid_action(), SUBSTR(core.get_request(), 1, 1));
    END;



    PROCEDURE clients (
        rec                     IN OUT NOCOPY   tsk_clients%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_client_id           IN OUT NOCOPY   tsk_clients.client_id%TYPE
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_clients t
            WHERE t.client_id   = NVL(old_client_id, rec.client_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF rec.client_id != old_client_id AND c_action = 'U' THEN
            -- first create new record
            INSERT INTO tsk_clients
            VALUES rec;
            --
            rename_client_id (
                in_old_client_id    => old_client_id,       -- old key
                in_new_client_id    => rec.client_id        -- new key
            );
            --
            DELETE FROM tsk_clients t
            WHERE t.client_id       = old_client_id;        -- old key
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
        old_client_id   := rec.client_id;
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



    PROCEDURE projects (
        rec                     IN OUT NOCOPY   tsk_projects%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_client_id           IN OUT NOCOPY   tsk_projects.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_projects.project_id%TYPE
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_projects t
            WHERE t.project_id      = rec.project_id;
            --
            RETURN;
        END IF;

        -- are we renaming the primary key?
        IF rec.project_id != old_project_id AND c_action = 'U' THEN
            -- first create new record
            INSERT INTO tsk_projects
            VALUES rec;
            --
            rename_project_id (
                in_old_project_id   => old_project_id,      -- old key
                in_new_project_id   => rec.project_id,      -- new key
                in_client_id        => rec.client_id
            );
            --
            DELETE FROM tsk_projects t
            WHERE t.project_id      = old_project_id;       -- old key
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
        old_client_id       := rec.client_id;
        old_project_id      := rec.project_id;
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



    PROCEDURE boards (
        rec                     IN OUT NOCOPY   tsk_boards%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_board_id            IN OUT NOCOPY   VARCHAR2                            -- apex item is a string
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_boards t
            WHERE t.board_id    = NVL(old_board_id, rec.board_id);
            --
            RETURN;
        END IF;

        -- generate primary key if needed
        IF c_action = 'C' AND rec.board_id IS NULL THEN
            rec.board_id := tsk_board_id.NEXTVAL;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- upsert record
        UPDATE tsk_boards t
        SET ROW             = rec
        WHERE t.board_id    = NVL(old_board_id, rec.board_id);
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_boards VALUES rec;
        END IF;

        -- update keys to APEX
        old_board_id    := TO_CHAR(rec.board_id);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE statuses (
        rec                     IN OUT NOCOPY   tsk_statuses%ROWTYPE,
        in_action                               CHAR                            := NULL,
        old_client_id           IN OUT NOCOPY   tsk_statuses.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_statuses.project_id%TYPE,
        old_status_id           IN OUT NOCOPY   tsk_statuses.status_id%TYPE     -- old key
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_statuses t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF rec.status_id != old_status_id AND c_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_statuses
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.status_id         = rec.status_id
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
            --
            DELETE FROM tsk_statuses t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
        ELSE
            -- proceed with update or insert
            UPDATE tsk_statuses t
            SET ROW = rec
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.status_id     = NVL(old_status_id,     rec.status_id);
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_statuses
                VALUES rec;
            END IF;
        END IF;

        -- keep just one is_default row
        IF rec.is_default = 'Y' THEN
            UPDATE tsk_statuses t
            SET t.is_default        = NULL
            WHERE t.client_id       = rec.client_id
                AND t.project_id    = rec.project_id
                AND t.status_id     != rec.status_id
                AND t.is_default    = 'Y';
        END IF;

        -- update keys to APEX
        old_client_id       := rec.client_id;
        old_project_id      := rec.project_id;
        old_status_id       := rec.status_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE swimlanes (
        rec                     IN OUT NOCOPY   tsk_swimlanes%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_client_id           IN OUT NOCOPY   tsk_swimlanes.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_swimlanes.project_id%TYPE,
        old_swimlane_id         IN OUT NOCOPY   tsk_swimlanes.swimlane_id%TYPE      -- old key
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_swimlanes t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF rec.swimlane_id != old_swimlane_id AND c_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_swimlanes
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.swimlane_id         = rec.swimlane_id
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
            --
            DELETE FROM tsk_swimlanes t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
        ELSE
            -- proceed with update or insert
            UPDATE tsk_swimlanes t
            SET ROW = rec
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.swimlane_id   = NVL(old_swimlane_id,   rec.swimlane_id);
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_swimlanes
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        old_client_id       := rec.client_id;
        old_project_id      := rec.project_id;
        old_swimlane_id     := rec.swimlane_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE categories (
        rec                     IN OUT NOCOPY   tsk_categories%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_client_id           IN OUT NOCOPY   tsk_categories.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_categories.project_id%TYPE,
        old_category_id         IN OUT NOCOPY   tsk_categories.category_id%TYPE     -- old key
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_categories t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF rec.category_id != old_category_id AND c_action = 'U' THEN
            -- create new status
            INSERT INTO tsk_categories
            VALUES rec;

            -- move old lines to the new status
            UPDATE tsk_tasks t
            SET t.category_id         = rec.category_id
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
            --
            DELETE FROM tsk_categories t
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
        ELSE
            -- proceed with update or insert
            UPDATE tsk_categories t
            SET ROW = rec
            WHERE t.client_id       = NVL(old_client_id,     rec.client_id)
                AND t.project_id    = NVL(old_project_id,    rec.project_id)
                AND t.category_id   = NVL(old_category_id,   rec.category_id);
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_categories
                VALUES rec;
            END IF;
        END IF;

        -- keep just one is_default row
        IF rec.is_default = 'Y' THEN
            UPDATE tsk_categories t
            SET t.is_default        = NULL
            WHERE t.client_id       = rec.client_id
                AND t.project_id    = rec.project_id
                AND t.category_id   != rec.category_id
                AND t.is_default    = 'Y';
        END IF;

        -- update keys to APEX
        old_client_id       := rec.client_id;
        old_project_id      := rec.project_id;
        old_category_id     := rec.category_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE tasks (
        rec                     IN OUT NOCOPY   tsk_tasks%ROWTYPE,
        in_action                               CHAR                                := NULL
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tasks_delete(rec.task_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by  := core.get_user_id();
        rec.updated_at  := SYSDATE;
        rec.tags        := NULLIF(':' || SUBSTR(REGEXP_REPLACE(LOWER(rec.tags), '[^a-z0-9]+', ':'), 1, 256) || ':', '::');

        -- proceed with update or insert
        IF rec.task_id IS NULL THEN
            rec.task_id := tsk_task_id.NEXTVAL;
            --
            INSERT INTO tsk_tasks
            VALUES rec;
        ELSE
            UPDATE tsk_tasks t
            SET ROW = rec
            WHERE t.task_id = rec.task_id;
            --
            IF SQL%ROWCOUNT = 0 THEN
                core.raise_error('UPDATE_FAILED');
            END IF;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE tasks_delete (
        in_task_id              tsk_tasks.task_id%TYPE
    )
    AS
    BEGIN
        /*
        -- keep here to quickly check if we are not missing any tables
        SELECT c.table_name c
        FROM user_tab_cols c
        JOIN user_tables t
            ON t.table_name = c.table_name
        WHERE c.column_name = 'TASK_ID'
        ORDER BY 1;
        */

        DELETE FROM tsk_task_comments t
        WHERE t.task_id = in_task_id;
        --
        DELETE FROM tsk_task_commits t
        WHERE t.task_id = in_task_id;
        --
        DELETE FROM tsk_task_checklist t
        WHERE t.task_id = in_task_id;
        --
        DELETE FROM tsk_task_files t
        WHERE t.task_id = in_task_id;
        --
        DELETE FROM tsk_tasks t
        WHERE t.task_id = in_task_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE user_fav_boards (
        rec                     IN OUT NOCOPY   tsk_user_fav_boards%ROWTYPE,
        in_action                               CHAR                                := NULL
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id,
            in_client_id        => tsk_app.get_client_id(),     -- lets check against context
            in_project_id       => tsk_app.get_project_id()
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_user_fav_boards b
            WHERE b.user_id     = rec.user_id
                AND b.board_id  = rec.board_id;
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by  := core.get_user_id();
        rec.updated_at  := SYSDATE;

        -- proceed with update or insert
        BEGIN
            INSERT INTO tsk_user_fav_boards VALUES rec;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            NULL;
        END;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

