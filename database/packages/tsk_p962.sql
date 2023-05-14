CREATE OR REPLACE PACKAGE BODY tsk_p962 AS

    PROCEDURE init_defaults
    AS
        v_not_assigned          VARCHAR2(64);
    BEGIN
        tsk_p960.set_role_names();

        -- notify for new components
        SELECT NULLIF('(' || COUNT(*) || ')', '(0)') INTO v_not_assigned
        FROM tsk_p962_map_pages_v c
        WHERE c.is_used IS NULL;
        --
        core.set_item('$NOT_ASSIGNED', v_not_assigned);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE refresh_mv
    AS
    BEGIN
        -- delete non existing pages from map
        DELETE FROM tsk_auth_pages a
        WHERE a.page_id NOT IN (
            SELECT n.page_id
            FROM tsk_navigation n
        );

        -- refresh MV
        DBMS_MVIEW.REFRESH('TSK_NAVIGATION_MAP_MV', method => 'C');
    END;



    PROCEDURE save_pages
    AS
        rec                 tsk_auth_pages%ROWTYPE;
        nav                 tsk_navigation%ROWTYPE;
    BEGIN
        -- also update navigation
        IF tsk_auth.is_admin() = 'Y' THEN
            nav.page_id         := core.get_grid_data('PAGE_ID');
            nav.parent_id       := core.get_grid_data('PARENT_ID');
            nav.is_hidden       := core.get_grid_data('IS_HIDDEN');
            nav.is_reset        := core.get_grid_data('IS_RESET');
            nav.order#          := core.get_grid_data('ORDER#');
            nav.updated_by      := core.get_user_id();
            nav.updated_at      := SYSDATE;
            --
            UPDATE tsk_navigation n
            SET ROW = nav
            WHERE n.page_id     = nav.page_id;
            --
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO tsk_navigation
                VALUES nav;
            END IF;
        END IF;

        -- save roles
        rec.page_id         := core.get_grid_data('PAGE_ID');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- go through pivoted columns
        FOR i IN 1 .. tsk_p960.c_dynamic_roles LOOP
            -- get role_id and is_active flag based on column position
            rec.role_id     := tsk_p960.get_role_id(i);
            rec.is_active   := core.get_grid_data('ROLE_' || i);
            --
            CONTINUE WHEN rec.role_id IS NULL;

            -- delete or insert new record
            IF rec.is_active IS NULL THEN
                DELETE FROM tsk_auth_pages t
                WHERE t.page_id     = rec.page_id
                    AND t.role_id   = rec.role_id
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

