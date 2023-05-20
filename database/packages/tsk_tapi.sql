CREATE OR REPLACE PACKAGE BODY tsk_tapi AS

    FUNCTION get_table_name
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN REGEXP_REPLACE(core.get_caller_name(3), '[^\.]+\.', g_app_prefix || '_');
    END;



    FUNCTION get_action (
        in_action               VARCHAR2        := NULL
    )
    RETURN CHAR
    AS
    BEGIN
        RETURN COALESCE(in_action, core.get_grid_action(), SUBSTR(core.get_request(), 1, 1));
    END;



    FUNCTION get_master_table (
        in_column_name          VARCHAR2
    )
    RETURN VARCHAR2
    AS
        out_table_name          all_constraints.table_name%TYPE;
    BEGIN
        SELECT n.table_name
        INTO out_table_name
        FROM all_constraints n
        JOIN all_cons_columns c
            ON c.owner              = n.owner
            AND c.constraint_name   = n.constraint_name
        WHERE n.owner               = core.get_owner()
            AND n.constraint_type   = 'P'
            AND c.table_name        LIKE g_app_prefix || '\_%' ESCAPE '\'
            AND c.column_name       = in_column_name
            AND c.position          = 1;
        --
        RETURN out_table_name;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION get_query (
        in_template             VARCHAR2,
        in_arg1                 VARCHAR2        := NULL,
        in_arg2                 VARCHAR2        := NULL,
        in_arg3                 VARCHAR2        := NULL,
        in_arg4                 VARCHAR2        := NULL,
        in_arg5                 VARCHAR2        := NULL,
        in_arg6                 VARCHAR2        := NULL,
        in_arg7                 VARCHAR2        := NULL,
        in_arg8                 VARCHAR2        := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        -- @TODO: check missing args
        RETURN TRIM(APEX_STRING.FORMAT(in_template,
            in_arg1,            -- %0
            in_arg2,            -- %1
            in_arg3,            -- %2
            in_arg4,            -- %3
            in_arg5,            -- %4
            in_arg6,            -- %5
            in_arg7,            -- %6
            in_arg8,            -- %7
            p_prefix => '!'));
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE rename_primary_key (
        in_column_name          VARCHAR2,
        in_old_key              VARCHAR2,
        in_new_key              VARCHAR2,
        in_merge                BOOLEAN         := TRUE
    )
    AS
        v_query                 VARCHAR2(2000);
    BEGIN
        -- rename in all related tables, need deferred foreign keys for this
        FOR c IN (
            SELECT c.table_name
            FROM all_tab_cols c
            JOIN all_tables t
                ON t.owner          = c.owner
                AND t.table_name    = c.table_name
            WHERE c.owner           = core.get_owner()
                AND c.table_name    LIKE g_app_prefix || '\_%' ESCAPE '\'
                AND c.column_name   = in_column_name
        ) LOOP
            -- @TODO: we should certainly log this
            BEGIN
                v_query := tsk_tapi.get_query(q'!
                    !UPDATE %0
                    !SET %1   = :NEW_KEY_ID
                    !WHERE %1 = :OLD_KEY_ID
                    !',
                    c.table_name,           -- %0
                    in_column_name          -- %1
                );
                --
                EXECUTE IMMEDIATE v_query USING in_new_key, in_old_key;
                --
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                -- if this is the master table, we could remove the original row
                IF in_merge AND c.table_name = tsk_tapi.get_master_table(in_column_name) THEN
                    v_query := tsk_tapi.get_query(q'!
                        !DELETE %0
                        !WHERE %1 = :OLD_KEY_ID
                        !',
                        c.table_name,           -- %0
                        in_column_name          -- %1
                    );
                    --
                    EXECUTE IMMEDIATE v_query USING in_old_key;
                    --
                ELSE
                    RAISE;
                END IF;
            WHEN OTHERS THEN
                core.raise_error(NULL, c.table_name, in_column_name, in_old_key, in_new_key);
            END;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE clients (
        rec                     IN OUT NOCOPY   tsk_clients%ROWTYPE,
        --
        in_action               CHAR                            := NULL,
        in_client_id            tsk_clients.client_id%TYPE      := NULL
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.clients_d(NVL(in_client_id, rec.client_id));
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_client_id != rec.client_id THEN
            tsk_tapi.rename_primary_key (
                in_column_name  => 'CLIENT_ID',
                in_old_key      => in_client_id,
                in_new_key      => rec.client_id
            );
        END IF;

        -- upsert record
        UPDATE tsk_clients t
        SET ROW             = rec
        WHERE t.client_id   = rec.client_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_clients VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE clients_d (
        in_client_id            tsk_clients.client_id%TYPE
    )
    AS
    BEGIN
        FOR c IN (
            SELECT p.client_id, p.project_id
            FROM tsk_projects p
            WHERE p.client_id = in_client_id
        ) LOOP
            tsk_tapi.projects_d(c.client_id, c.project_id);
        END LOOP;
        --
        DELETE FROM tsk_clients         WHERE client_id = in_client_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE projects (
        rec                 IN OUT NOCOPY   tsk_projects%ROWTYPE,
        --
        in_action           CHAR                                := NULL,
        in_client_id        tsk_projects.client_id%TYPE         := NULL,
        in_project_id       tsk_projects.project_id%TYPE        := NULL
    )
    AS
        c_action            CONSTANT CHAR                       := get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.projects_d(NVL(in_client_id, rec.client_id), NVL(in_project_id, rec.project_id));
            --
            RETURN;  -- exit procedure
        END IF;

        -- overwrite some values

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_project_id != rec.project_id THEN
            tsk_tapi.rename_primary_key (
                in_column_name  => 'PROJECT_ID',
                in_old_key      => in_project_id,
                in_new_key      => rec.project_id
            );
        END IF;
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- upsert record
        UPDATE tsk_projects t
        SET ROW = rec
        WHERE t.client_id           = rec.client_id
            AND t.project_id        = rec.project_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_projects
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE projects_d (
        in_client_id        tsk_projects.client_id%TYPE,
        in_project_id       tsk_projects.project_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM tsk_auth_roles                  WHERE client_id = in_client_id AND project_id = in_project_id;
        DELETE FROM tsk_boards                      WHERE client_id = in_client_id AND project_id = in_project_id;
        DELETE FROM tsk_categories                  WHERE client_id = in_client_id AND project_id = in_project_id;
        DELETE FROM tsk_projects                    WHERE client_id = in_client_id AND project_id = in_project_id;
        DELETE FROM tsk_repos                       WHERE client_id = in_client_id AND project_id = in_project_id;
        DELETE FROM tsk_statuses                    WHERE client_id = in_client_id AND project_id = in_project_id;
        DELETE FROM tsk_swimlanes                   WHERE client_id = in_client_id AND project_id = in_project_id;
        --DELETE FROM tsk_tasks                       WHERE client_id = in_client_id AND project_id = in_project_id;
        DELETE FROM tsk_user_fav_boards             WHERE client_id = in_client_id AND project_id = in_project_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE boards (
        rec                 IN OUT NOCOPY   tsk_boards%ROWTYPE,
        --
        in_action           CHAR                            := NULL,
        in_board_id         tsk_boards.board_id%TYPE        := NULL
    )
    AS
        c_action            CONSTANT CHAR                   := get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.boards_d(NVL(in_board_id, rec.board_id));
            --
            RETURN;  -- exit procedure
        END IF;

        -- generate primary key if needed
        IF c_action = 'C' AND rec.board_id IS NULL THEN
            rec.board_id := tsk_board_id.NEXTVAL;
        END IF;

        -- overwrite some values
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- upsert record
        UPDATE tsk_boards t
        SET ROW = rec
        WHERE t.board_id            = rec.board_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_boards
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE boards_d (
        in_board_id         tsk_boards.board_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM tsk_boards                      WHERE board_id = in_board_id;
        DELETE FROM tsk_user_fav_boards             WHERE board_id = in_board_id;
        --DELETE FROM tsk_tasks                       WHERE board_id = in_board_id;
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
            in_user_id          => core.get_user_id(),
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
            in_user_id          => core.get_user_id(),
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
            in_user_id          => core.get_user_id(),
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
            in_user_id          => core.get_user_id(),
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
            in_user_id          => core.get_user_id(),
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



    PROCEDURE commits (
        rec                     IN OUT NOCOPY   tsk_commits%ROWTYPE,
        --
        in_action               CHAR                            := NULL
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => NULL,
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_commits t
            WHERE t.commit_id   = rec.commit_id;
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.created_by := core.get_user_id();
        rec.created_at := SYSDATE;
        --
        BEGIN
            INSERT INTO tsk_commits VALUES rec;
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



    PROCEDURE task_commits (
        rec                     IN OUT NOCOPY   tsk_task_commits%ROWTYPE,
        --
        in_action               CHAR                            := NULL,
        in_commit_id            tsk_task_commits.commit_id%TYPE := NULL,
        in_task_id              tsk_task_commits.task_id%TYPE   := NULL
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => NULL,
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_task_commits t
            WHERE t.task_id         = NVL(in_task_id,       rec.task_id)
                AND t.commit_id     = NVL(in_commit_id,     rec.commit_id);
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- upsert record
        BEGIN
            INSERT INTO tsk_task_commits VALUES rec;
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



    PROCEDURE roles_d (
        in_role_id              tsk_roles.role_id%TYPE
    )
    AS
    BEGIN
        DELETE FROM tsk_auth_pages          WHERE role_id = in_role_id;
        DELETE FROM tsk_auth_components     WHERE role_id = in_role_id;
        DELETE FROM tsk_auth_tables         WHERE role_id = in_role_id;
        DELETE FROM tsk_auth_procedures     WHERE role_id = in_role_id;
        DELETE FROM tsk_auth_roles          WHERE role_id = in_role_id;
        DELETE FROM tsk_roles               WHERE role_id = in_role_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE roles (
        rec                     IN OUT NOCOPY tsk_roles%ROWTYPE,
        --
        in_action               CHAR                        := NULL,
        in_role_id              tsk_roles.role_id%TYPE      := NULL
    )
    AS
        c_action                CONSTANT CHAR   := get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => NULL,
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.roles_d(NVL(in_role_id, rec.role_id));
            --
            RETURN;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_role_id != rec.role_id THEN
            tsk_tapi.rename_primary_key (
                in_column_name  => 'ROLE_ID',
                in_old_key      => in_role_id,
                in_new_key      => rec.role_id
            );
        END IF;

        -- upsert record
        UPDATE tsk_roles t
        SET ROW             = rec
        WHERE t.role_id     = rec.role_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_roles VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

