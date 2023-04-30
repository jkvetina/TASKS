CREATE OR REPLACE PACKAGE BODY tsk_p965 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        tsk_p960.set_role_names();
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
        FOR i IN 1 .. tsk_p960.c_dynamic_roles LOOP
            -- get role_id and is_active flag based on column position
            rec.role_id             := tsk_p960.get_role_id(i);
            rec.is_allowed_create   := core.get_grid_data('ROLE_' || i || 'C');
            rec.is_allowed_update   := core.get_grid_data('ROLE_' || i || 'U');
            rec.is_allowed_delete   := core.get_grid_data('ROLE_' || i || 'D');
            rec.is_active           := 'Y';
            --
            CONTINUE WHEN rec.role_id IS NULL;
            --
            DELETE FROM tsk_auth_tables t
            WHERE t.role_id         = rec.role_id
                AND t.table_name    = rec.table_name;
            --
            BEGIN
                INSERT INTO tsk_auth_tables
                VALUES rec;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;
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

