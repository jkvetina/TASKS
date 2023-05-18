CREATE OR REPLACE PACKAGE BODY tsk_p963 AS

    PROCEDURE init_defaults
    AS
        v_not_assigned          VARCHAR2(64);
    BEGIN
        tsk_p960.set_role_names();

        -- notify for new components
        SELECT NULLIF('(' || COUNT(*) || ')', '(0)') INTO v_not_assigned
        FROM tsk_p963_map_components_v c
        WHERE c.component_type  != 'PAGE'
            AND c.is_used       IS NULL
            AND c.dml_actions   IS NOT NULL;
        --
        core.set_item('$NOT_ASSIGNED', v_not_assigned);

        -- calculate prev/next pages
        tsk_app.set_prev_next_pages();

        -- auto refresh mview
        IF INSTR(core.get_request_url(in_arguments_only => TRUE), 'clear=' || core.get_page_id() || '&') IS NOT NULL THEN
            tsk_p963.refresh_mv();
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE refresh_mv
    AS
    BEGIN
        -- remove components which dont exists on page anymore
        DELETE FROM tsk_auth_components a
        WHERE a.component_id IN (
            SELECT a.component_id
            FROM tsk_auth_components a
            JOIN tsk_p963_map_components_v m
                ON m.component_id   = a.component_id
            WHERE m.dml_actions     NOT LIKE '%U%'
        );

        -- refresh regions
        DBMS_MVIEW.REFRESH('TSK_P963_REGIONS_MV', method => 'C');
    END;



    PROCEDURE save_components
    AS
        rec                 tsk_auth_components%ROWTYPE;
    BEGIN
        rec.component_id    := core.get_grid_data('COMPONENT_ID');
        rec.component_type  := core.get_grid_data('COMPONENT_TYPE');
        rec.component_name  := NVL(core.get_grid_data('COMPONENT_NAME__'), '-');
        rec.page_id         := core.get_grid_data('PAGE_ID');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- delete whole component
        IF core.get_grid_action() = 'D' THEN
            DELETE tsk_auth_components t
            WHERE t.component_id    = rec.component_id;
            --
            RETURN;
        END IF;

        -- go through pivoted columns
        FOR i IN 1 .. tsk_p960.c_dynamic_roles LOOP
            rec.role_id     := tsk_p960.get_role_id(i);
            rec.is_active   := core.get_grid_data('ROLE_' || i);
            --
            CONTINUE WHEN rec.role_id IS NULL;
            --
            IF rec.component_type = 'PAGE' THEN
                -- update page setup from here
                UPDATE tsk_auth_pages t
                SET t.is_active         = rec.is_active
                WHERE t.page_id         = rec.page_id
                    AND t.role_id       = rec.role_id;
                --
                IF SQL%ROWCOUNT = 0 THEN
                    INSERT INTO tsk_auth_pages (page_id, role_id, is_active, updated_by, updated_at)
                    VALUES (
                        rec.page_id,
                        rec.role_id,
                        rec.is_active,
                        rec.updated_by,
                        rec.updated_at
                    );
                END IF;
            ELSE
                -- page components
                DELETE tsk_auth_components t
                WHERE t.component_id    = rec.component_id
                    AND t.role_id       = rec.role_id
                    AND t.is_active     = 'Y';
                --
                IF rec.is_active = 'Y' THEN
                    UPDATE tsk_auth_components t
                    SET t.is_active         = rec.is_active
                    WHERE t.component_id    = rec.component_id
                        AND t.role_id       = rec.role_id;
                    --
                    IF SQL%ROWCOUNT = 0 THEN
                        INSERT INTO tsk_auth_components
                        VALUES rec;
                    END IF;
                END IF;
            END IF;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE sync_regions
    AS
    BEGIN
        NULL;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

