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

END;
/

