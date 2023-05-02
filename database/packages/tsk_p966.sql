CREATE OR REPLACE PACKAGE BODY tsk_p966 AS

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



    PROCEDURE save_procedures
    AS
        rec                 tsk_auth_procedures%ROWTYPE;
    BEGIN
        rec.object_name     := core.get_grid_data('OBJECT_NAME');
        rec.procedure_name  := core.get_grid_data('PROCEDURE_NAME');
        rec.table_name      := core.get_grid_data('TABLE_NAME');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- store assigned table name without role
        IF rec.table_name IS NOT NULL THEN
            BEGIN
                rec.role_id     := NULL;
                rec.is_active   := 'Y';
                --
                INSERT INTO tsk_auth_procedures
                VALUES rec;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                UPDATE tsk_auth_procedures t
                SET t.table_name            = rec.table_name
                WHERE t.object_name         = rec.object_name
                    AND t.procedure_name    = rec.procedure_name;
            END;
            --
            rec.table_name  := NULL;
        END IF;

        -- go through pivoted columns
        FOR i IN 1 .. tsk_p960.c_dynamic_roles LOOP
            rec.role_id     := tsk_p960.get_role_id(i);
            rec.is_active   := core.get_grid_data('ROLE_' || i);
            --
            CONTINUE WHEN rec.role_id IS NULL;

            -- delete or insert new record
            IF rec.is_active IS NULL THEN
                DELETE FROM tsk_auth_procedures t
                WHERE t.object_name         = rec.object_name
                    AND t.procedure_name    = rec.procedure_name
                    AND t.role_id           = rec.role_id
                    AND t.is_active         = 'Y';
            ELSE
                BEGIN
                    INSERT INTO tsk_auth_procedures
                    VALUES rec;
                EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    NULL;
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

