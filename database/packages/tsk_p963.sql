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
        v_count     PLS_INTEGER;
        v_cols      VARCHAR2(4000);
    BEGIN
        -- go through all APEX view and find out components with authorization_scheme
        FOR c IN (
            SELECT
                d.apex_view_name        AS table_name,
                MAX(n.comments)         AS comments
            FROM apex_dictionary d
            JOIN apex_dictionary n
                ON n.apex_view_name     = d.apex_view_name
                AND n.column_id         = 0
            WHERE d.column_name         IN ('AUTHORIZATION_SCHEME_ID', 'APPLICATION_ID')
                AND d.apex_view_name    NOT IN (
                    'APEX_APPLICATIONS',
                    'APEX_APPLICATION_AUTHORIZATION',
                    'APEX_APPLICATION_ALL_AUTH',
                    'APEX_APPLICATION_PAGES',
                    'APEX_DEBUG_MESSAGES',
                    'APEX_WORKSPACE_ACTIVITY_LOG'
                )
            GROUP BY d.apex_view_name
            HAVING COUNT(*) = 2
            ORDER BY 1
        ) LOOP
            -- add missing components
            BEGIN
                EXECUTE IMMEDIATE
                    'SELECT COUNT(*) FROM ' || c.table_name
                    || ' WHERE application_id = :app_id'
                    || ' AND authorization_scheme_id IS NOT NULL'
                    INTO v_count
                    USING IN core.get_app_id();
                --
                IF v_count > 0 THEN
                    DBMS_OUTPUT.PUT_LINE(c.table_name || ' = ' || v_count);
                    --
                    FOR d IN (
                        SELECT t.component_id, t.page_id
                        FROM tsk_auth_components_list_v t
                        WHERE t.component_type          = c.table_name
                            AND authorization_scheme_id IS NOT NULL
                    ) LOOP
                        DBMS_OUTPUT.PUT_LINE('    ' || d.component_id);
                        --
                        BEGIN
                            INSERT INTO tsk_auth_components (component_id, component_type, component_name, page_id, is_active)
                            VALUES (
                                d.component_id,
                                c.table_name,
                                '?',
                                d.page_id,
                                'Y'
                            );
                        EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                            NULL;
                        END;
                    END LOOP;
                    --
                    DBMS_OUTPUT.PUT_LINE('    --');
                END IF;
            EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR:' || c.table_name);
                RAISE;
            END;
        END LOOP;

        -- remove obsolete components
        DELETE FROM tsk_auth_components c
        WHERE c.component_id IN (
            SELECT c.component_id
            FROM tsk_auth_components c
            LEFT JOIN tsk_auth_components_list_v t
                ON t.component_id   = c.component_id
            WHERE t.component_id    IS NULL
        );

        -- update/shorten component type
        UPDATE tsk_auth_components c
        SET c.component_type    = tsk_auth.get_component_type(c.component_type)    
        WHERE c.component_type != tsk_auth.get_component_type(c.component_type);

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

