CREATE OR REPLACE PACKAGE BODY tsk_p960 AS

    FUNCTION get_role_id (
        in_column       NUMBER
    )
    RETURN tsk_auth_pages.role_id%TYPE
    AS
        out_role_id     tsk_auth_pages.role_id%TYPE;
    BEGIN
        SELECT c.role_id
        INTO out_role_id
        FROM tsk_p960_roles_columns_v c
        WHERE c.r# = in_column;
        --
        RETURN out_role_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    PROCEDURE set_role_names
    AS
    BEGIN
        FOR c IN (
            SELECT
                d.r#,
                r.role_name
            FROM (
                SELECT LEVEL AS r#
                FROM DUAL
                CONNECT BY LEVEL <= tsk_p960.c_dynamic_roles
            ) d
            LEFT JOIN tsk_p960_roles_columns_v r
                ON r.r# = d.r#
        ) LOOP
            core.set_item('$ROLE_' || c.r#, c.role_name);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE reorder_roles
    AS
        in_client_id            CONSTANT tsk_tasks.client_id%TYPE   := tsk_app.get_client_id();
        in_project_id           CONSTANT tsk_tasks.project_id%TYPE  := tsk_app.get_project_id();
    BEGIN
        FOR s IN (
            SELECT
                t.role_id,
                --
                ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.role_id) * 10 AS order#
            FROM tsk_roles t
        ) LOOP
            UPDATE tsk_roles t
            SET t.order#        = s.order#
            WHERE t.role_id     = s.role_id
                AND (t.order#   != s.order# OR t.order# IS NULL);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE delete_role_cascade (
        in_role_id          tsk_roles.role_id%TYPE
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



    PROCEDURE rename_role_id (
        in_old_role_id          tsk_roles.role_id%TYPE,
        in_new_role_id          tsk_roles.role_id%TYPE
    )
    AS
        in_table_name           user_tab_cols.table_name%TYPE   := 'TSK_ROLES';
        in_column_name          user_tab_cols.column_name%TYPE  := 'ROLE_ID';
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
                    'UPDATE ' || c.table_name               || CHR(10) ||
                    'SET role_id        = :NEW_ROLE_ID'     || CHR(10) ||
                    'WHERE role_id      = :OLD_ROLE_ID'
                    USING
                        in_new_role_id,
                        in_old_role_id;
            EXCEPTION
            WHEN OTHERS THEN
                core.raise_error(NULL, c.table_name, in_old_role_id, in_new_role_id);
            END;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_roles (
        io_role_id          IN OUT NOCOPY   tsk_roles.role_id%TYPE
    )
    AS
        rec                 tsk_roles%ROWTYPE;
    BEGIN
        rec.role_id         := core.get_grid_data('ROLE_ID');
        rec.role_name       := core.get_grid_data('ROLE_NAME');
        rec.role_group      := core.get_grid_data('ROLE_GROUP');
        rec.role_desc       := core.get_grid_data('ROLE_DESC');
        rec.is_active       := core.get_grid_data('IS_ACTIVE');
        rec.order#          := core.get_grid_data('ORDER#');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF core.get_grid_action() = 'D' THEN
            delete_role_cascade(io_role_id);
            --
            RETURN;
        END IF;

        -- are we renaming the primary key?
        IF rec.role_id != io_role_id AND core.get_grid_action() = 'U' THEN
            -- first create new record
            INSERT INTO tsk_roles
            VALUES rec;
            --
            rename_role_id (
                in_old_role_id  => io_role_id,      -- old key
                in_new_role_id  => rec.role_id      -- new key
            );
            --
            DELETE FROM tsk_roles t
            WHERE t.role_id     = io_role_id;       -- old key
        ELSE
            -- proceed with update or insert
            UPDATE tsk_roles t
            SET ROW = rec
            WHERE t.role_id     = io_role_id;
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_roles
                VALUES rec;
            END IF;
        END IF;

        -- update keys to APEX
        io_role_id      := rec.role_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

