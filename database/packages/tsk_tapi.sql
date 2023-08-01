CREATE OR REPLACE PACKAGE BODY tsk_tapi AS

    PROCEDURE clients (
        rec                     IN OUT NOCOPY   tsk_clients%ROWTYPE,
        --
        in_action               CHAR                            := NULL,
        in_client_id            tsk_clients.client_id%TYPE      := NULL
    )
    AS
        c_action                CONSTANT CHAR   := gen_tapi.get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
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
            gen_tapi.rename_primary_key (
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
        c_action            CONSTANT CHAR                       := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.projects_d (
                in_client_id        => NVL(in_client_id, rec.client_id),
                in_project_id       => NVL(in_project_id, rec.project_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- overwrite some values

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_project_id != rec.project_id THEN
            gen_tapi.rename_primary_key (
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
        c_action            CONSTANT CHAR                   := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.boards_d (
                in_board_id         => NVL(in_board_id, rec.board_id)
            );
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
        --
        in_action               CHAR                                    := NULL,
        in_client_id            tsk_statuses.client_id%TYPE             := NULL,
        in_project_id           tsk_statuses.project_id%TYPE            := NULL,
        in_status_id            tsk_statuses.status_id%TYPE             := NULL
    )
    AS
        c_action                CONSTANT CHAR                           := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.statuses_d (
                in_client_id            => NVL(in_client_id, rec.client_id),
                in_project_id           => NVL(in_project_id, rec.project_id),
                in_status_id            => NVL(in_status_id, rec.status_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_status_id != rec.status_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'STATUS_ID',
                in_old_key      => in_status_id,
                in_new_key      => rec.status_id
            );
        END IF;

        -- overwrite some values
        rec.updated_by          := core.get_user_id();
        rec.updated_at          := SYSDATE;

        -- upsert record
        UPDATE tsk_statuses t
        SET ROW = rec
        WHERE t.client_id               = rec.client_id
            AND t.project_id            = rec.project_id
            AND t.status_id             = rec.status_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_statuses
            VALUES rec;
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE statuses_d (
        in_client_id            tsk_statuses.client_id%TYPE,
        in_project_id           tsk_statuses.project_id%TYPE,
        in_status_id            tsk_statuses.status_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM tsk_statuses                    WHERE client_id = in_client_id AND project_id = in_project_id AND status_id = in_status_id;
        --DELETE FROM tsk_tasks                       WHERE client_id = in_client_id AND project_id = in_project_id AND status_id = in_status_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE swimlanes (
        rec                     IN OUT NOCOPY   tsk_swimlanes%ROWTYPE,
        --
        in_action               CHAR                                    := NULL,
        in_client_id            tsk_swimlanes.client_id%TYPE            := NULL,
        in_project_id           tsk_swimlanes.project_id%TYPE           := NULL,
        in_swimlane_id          tsk_swimlanes.swimlane_id%TYPE          := NULL
    )
    AS
        c_action                CONSTANT CHAR                           := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.swimlanes_d (
                in_client_id            => NVL(in_client_id, rec.client_id),
                in_project_id           => NVL(in_project_id, rec.project_id),
                in_swimlane_id          => NVL(in_swimlane_id, rec.swimlane_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_swimlane_id != rec.swimlane_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'SWIMLANE_ID',
                in_old_key      => in_swimlane_id,
                in_new_key      => rec.swimlane_id
            );
        END IF;

        -- overwrite some values
        rec.updated_by          := core.get_user_id();
        rec.updated_at          := SYSDATE;

        -- upsert record
        UPDATE tsk_swimlanes t
        SET ROW = rec
        WHERE t.client_id               = rec.client_id
            AND t.project_id            = rec.project_id
            AND t.swimlane_id           = rec.swimlane_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_swimlanes
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE swimlanes_d (
        in_client_id            tsk_swimlanes.client_id%TYPE,
        in_project_id           tsk_swimlanes.project_id%TYPE,
        in_swimlane_id          tsk_swimlanes.swimlane_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM tsk_swimlanes                   WHERE client_id = in_client_id AND project_id = in_project_id AND swimlane_id = in_swimlane_id;
        DELETE FROM tsk_user_fav_boards             WHERE client_id = in_client_id AND project_id = in_project_id AND swimlane_id = in_swimlane_id;
        --DELETE FROM tsk_tasks                       WHERE client_id = in_client_id AND project_id = in_project_id AND swimlane_id = in_swimlane_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE categories (
        rec                     IN OUT NOCOPY   tsk_categories%ROWTYPE,
        --
        in_action               CHAR                                    := NULL,
        in_client_id            tsk_categories.client_id%TYPE           := NULL,
        in_project_id           tsk_categories.project_id%TYPE          := NULL,
        in_category_id          tsk_categories.category_id%TYPE         := NULL
    )
    AS
        c_action                CONSTANT CHAR                           := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.categories_d (
                in_client_id            => NVL(in_client_id, rec.client_id),
                in_project_id           => NVL(in_project_id, rec.project_id),
                in_category_id          => NVL(in_category_id, rec.category_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_category_id != rec.category_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'CATEGORY_ID',
                in_old_key      => in_category_id,
                in_new_key      => rec.category_id
            );
        END IF;

        -- overwrite some values
        rec.updated_by          := core.get_user_id();
        rec.updated_at          := SYSDATE;

        -- upsert record
        UPDATE tsk_categories t
        SET ROW = rec
        WHERE t.client_id               = rec.client_id
            AND t.project_id            = rec.project_id
            AND t.category_id           = rec.category_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_categories
            VALUES rec;
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE categories_d (
        in_client_id            tsk_categories.client_id%TYPE,
        in_project_id           tsk_categories.project_id%TYPE,
        in_category_id          tsk_categories.category_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM tsk_categories                  WHERE client_id = in_client_id AND project_id = in_project_id AND category_id = in_category_id;
        --DELETE FROM tsk_tasks                       WHERE client_id = in_client_id AND project_id = in_project_id AND category_id = in_category_id;
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
        c_action                CONSTANT CHAR   := gen_tapi.get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
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
        c_action                CONSTANT CHAR   := gen_tapi.get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
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
        c_action                CONSTANT CHAR   := gen_tapi.get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
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
        c_action                CONSTANT CHAR   := gen_tapi.get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
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



    PROCEDURE task_comments (
        rec                     IN OUT NOCOPY   tsk_task_comments%ROWTYPE,
        --
        in_action               CHAR                                        := NULL,
        in_task_id              tsk_task_comments.task_id%TYPE              := NULL,
        in_comment_id           tsk_task_comments.comment_id%TYPE           := NULL
    )
    AS
        c_action                CONSTANT CHAR                               := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => NULL,
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_task_comments
            WHERE task_id       = NVL(in_task_id, rec.task_id)
                AND comment_id  = NVL(in_comment_id, rec.comment_id);
            --
            RETURN;  -- exit procedure
        END IF;

        -- generate primary key if needed
        IF c_action = 'C' AND rec.comment_id IS NULL THEN
            rec.comment_id := tsk_comment_id.NEXTVAL;
        END IF;

        -- overwrite some values
        rec.updated_by          := core.get_user_id();
        rec.updated_at          := SYSDATE;

        -- upsert record
        UPDATE tsk_task_comments t
        SET ROW = rec
        WHERE t.task_id                 = rec.task_id
            AND t.comment_id            = rec.comment_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_task_comments
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE task_files (
        rec                 IN OUT NOCOPY   tsk_task_files%ROWTYPE,
        --
        in_action           CHAR                                    := NULL,
        in_file_id          tsk_task_files.file_id%TYPE             := NULL
    )
    AS
        c_action            CONSTANT CHAR                           := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => NULL,
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            DELETE FROM tsk_task_files
            WHERE file_id = NVL(in_file_id, rec.file_id);
            --
            RETURN;  -- exit procedure
        END IF;

        -- generate primary key if needed
        IF c_action = 'C' AND rec.file_id IS NULL THEN
            rec.file_id := tsk_file_id.NEXTVAL;
        END IF;

        -- overwrite some values
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- upsert record
        UPDATE tsk_task_files t
        SET ROW = rec
        WHERE t.file_id             = rec.file_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_task_files
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE repos (
        rec                     IN OUT NOCOPY   tsk_repos%ROWTYPE,
        --
        in_action               CHAR                                := NULL,
        in_repo_id              tsk_repos.repo_id%TYPE              := NULL,
        in_owner_id             tsk_repos.owner_id%TYPE             := NULL
    )
    AS
        c_action                CONSTANT CHAR                       := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => rec.project_id,
            in_project_id       => rec.client_id
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.repos_d (
                in_repo_id              => NVL(in_repo_id, rec.repo_id),
                in_owner_id             => NVL(in_owner_id, rec.owner_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_repo_id != rec.repo_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'REPO_ID',
                in_old_key      => in_repo_id,
                in_new_key      => rec.repo_id
            );
        END IF;
        --
        IF c_action = 'U' AND in_owner_id != rec.owner_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'OWNER_ID',
                in_old_key      => in_owner_id,
                in_new_key      => rec.owner_id
            );
        END IF;

        -- overwrite some values
        rec.updated_by          := core.get_user_id();
        rec.updated_at          := SYSDATE;

        -- upsert record
        UPDATE tsk_repos t
        SET ROW = rec
        WHERE t.repo_id                 = rec.repo_id
            AND t.owner_id              = rec.owner_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_repos
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE repos_d (
        in_repo_id              tsk_repos.repo_id%TYPE,
        in_owner_id             tsk_repos.owner_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM tsk_repo_endpoints              WHERE repo_id = in_repo_id AND owner_id = in_owner_id;
        DELETE FROM tsk_repos                       WHERE repo_id = in_repo_id AND owner_id = in_owner_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE repo_endpoints (
        rec                     IN OUT NOCOPY   tsk_repo_endpoints%ROWTYPE,
        --
        in_action               CHAR                                        := NULL,
        in_repo_id              tsk_repo_endpoints.repo_id%TYPE             := NULL,
        in_owner_id             tsk_repo_endpoints.owner_id%TYPE            := NULL
    )
    AS
        c_action                CONSTANT CHAR                               := gen_tapi.get_action(in_action);
    BEGIN
        -- evaluate access to this table
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
            in_action           => c_action,
            in_user_id          => core.get_user_id(),
            in_client_id        => NULL,
            in_project_id       => NULL
        );

        -- delete record
        IF c_action = 'D' THEN
            tsk_tapi.repo_endpoints_d (
                in_repo_id              => NVL(in_repo_id, rec.repo_id),
                in_owner_id             => NVL(in_owner_id, rec.owner_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- overwrite some values
        rec.updated_by          := core.get_user_id();
        rec.updated_at          := SYSDATE;

        -- upsert record
        UPDATE tsk_repo_endpoints t
        SET ROW = rec
        WHERE t.repo_id                 = rec.repo_id
            AND t.owner_id              = rec.owner_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_repo_endpoints
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE repo_endpoints_d (
        in_repo_id              tsk_repo_endpoints.repo_id%TYPE,
        in_owner_id             tsk_repo_endpoints.owner_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM tsk_repo_endpoints              WHERE repo_id = in_repo_id AND owner_id = in_owner_id;
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
        c_action                CONSTANT CHAR   := gen_tapi.get_action(in_action);
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => gen_tapi.get_table_name(),
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
            gen_tapi.rename_primary_key (
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

END;
/

