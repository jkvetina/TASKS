CREATE OR REPLACE PACKAGE BODY tsk_p955 AS

    c_dynamic_roles         CONSTANT PLS_INTEGER := 8;



    PROCEDURE init_defaults
    AS
    BEGIN
        FOR c IN (
            SELECT
                d.r#,
                r.role_name
            FROM (
                SELECT LEVEL AS r#
                FROM DUAL
                CONNECT BY LEVEL <= c_dynamic_roles
            ) d
            LEFT JOIN tsk_p960_roles_columns_v r
                ON r.r# = d.r#
        ) LOOP
            core.set_item('P955_ROLE_NAME_' || c.r#, c.role_name);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_roles
    AS
        rec                 tsk_auth_roles%ROWTYPE;
    BEGIN
        rec.client_id       := core.get_grid_data('CLIENT_ID');
        rec.project_id      := core.get_grid_data('PROJECT_ID');
        rec.user_id         := core.get_grid_data('USER_ID');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- go through pivoted columns
        FOR i IN 1 .. c_dynamic_roles LOOP
            -- get role_id and is_active flag based on column position
            rec.role_id     := tsk_p962.get_role_id(i);
            rec.is_active   := core.get_grid_data('ROLE_' || i);

            -- delete or insert new record
            IF rec.is_active IS NULL THEN
                DELETE FROM tsk_auth_roles t
                WHERE t.client_id       = rec.client_id
                    AND t.project_id    = rec.project_id
                    AND t.user_id       = rec.user_id
                    AND t.role_id       = rec.role_id
                    AND t.is_active     = 'Y';
            ELSE
                BEGIN
                    INSERT INTO tsk_auth_roles
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

