CREATE OR REPLACE PACKAGE BODY tsk_p965 AS

    c_dynamic_roles         CONSTANT PLS_INTEGER := 8;



    PROCEDURE init_defaults
    AS
    BEGIN
        -- gather role names
        FOR c IN (
            SELECT
                d.r#,
                r.role_name
            FROM (
                SELECT LEVEL AS r#
                FROM DUAL
                CONNECT BY LEVEL <= c_dynamic_roles
            ) d
            LEFT JOIN tsk_p962_map_pages_cols_v r
                ON r.r# = d.r#
        ) LOOP
            core.set_item('P965_ROLE_' || c.r#, c.role_name);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_tables
    AS
        rec                 tsk_auth_tables%ROWTYPE;
    BEGIN
        rec.table_name      := core.get_grid_data('TABLE_NAME');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- go through pivoted columns
        FOR i IN 1 .. c_dynamic_roles LOOP
            -- get role_id and is_active flag based on column position
            rec.role_id             := tsk_p962.get_role_id(i);
            --
            CONTINUE WHEN rec.role_id IS NULL;
            --
            rec.is_allowed_create   := core.get_grid_data('ROLE_' || i || 'C');
            rec.is_allowed_update   := core.get_grid_data('ROLE_' || i || 'U');
            rec.is_allowed_delete   := core.get_grid_data('ROLE_' || i || 'D');
            rec.is_active           := 'Y';

            -- delete or insert new record
            IF COALESCE(rec.is_allowed_create, rec.is_allowed_update, rec.is_allowed_delete) IS NULL THEN
                DELETE FROM tsk_auth_tables t
                WHERE t.role_id         = rec.role_id
                    AND t.table_name    = rec.table_name;
            ELSE
                BEGIN
                    INSERT INTO tsk_auth_tables
                    VALUES rec;
                EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    NULL;
                when others then
            core.raise_error('X', i, rec.table_name, rec.role_id, tsk_p962.get_role_id(i), rec.is_allowed_create, rec.is_allowed_update, rec.is_allowed_delete);
                END;
            END IF;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

