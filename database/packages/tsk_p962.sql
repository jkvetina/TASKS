CREATE OR REPLACE PACKAGE BODY tsk_p962 AS

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
            LEFT JOIN tsk_p962_map_pages_cols_v r
                ON r.r# = d.r#
        ) LOOP
            core.set_item('P962_ROLE_NAME_' || c.r#, c.role_name);
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE refresh_mv
    AS
    BEGIN
        DBMS_MVIEW.REFRESH('TSK_NAVIGATION_MAP_MV', method => 'C');
    END;



    FUNCTION get_role_id (
        in_column       NUMBER
    )
    RETURN tsk_auth_pages.role_id%TYPE
    AS
        out_role_id     tsk_auth_pages.role_id%TYPE;
    BEGIN
        SELECT c.role_id
        INTO out_role_id
        FROM tsk_p962_map_pages_cols_v c
        WHERE c.r# = in_column;
        --
        RETURN out_role_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    PROCEDURE save_pages
    AS
        rec                 tsk_auth_pages%ROWTYPE;
    BEGIN
        rec.page_id         := core.get_grid_data('PAGE_ID');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- go through pivoted columns
        FOR i IN 1 .. c_dynamic_roles LOOP
            -- get role_id and is_active flag based on column position
            rec.role_id     := get_role_id(i);
            rec.is_active   := core.get_grid_data('ROLE_' || i);

            -- delete or insert new record
            IF rec.is_active IS NULL THEN
                DELETE FROM tsk_auth_pages t
                WHERE t.role_id     = rec.role_id
                    AND t.page_id   = rec.page_id
                    AND t.is_active = 'Y';
            ELSE
                BEGIN
                    INSERT INTO tsk_auth_pages
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

