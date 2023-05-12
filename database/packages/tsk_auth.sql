CREATE OR REPLACE PACKAGE BODY tsk_auth AS

    c_admin_role                CONSTANT tsk_roles.role_id%TYPE := 'ADMIN';



    PROCEDURE after_auth (
        in_user_id              VARCHAR2
    )
    AS
        rec                     tsk_users%ROWTYPE;
        fav                     tsk_user_fav_boards%ROWTYPE;
    BEGIN
        -- convert email address to the login if needed
        BEGIN
            SELECT u.* INTO rec
            FROM tsk_users u
            WHERE u.user_mail = LOWER(in_user_id);--SYS_CONTEXT('APEX$SESSION', 'APP_USER'));

            -- check if account is active
            IF rec.is_active IS NULL THEN
                core.raise_error('ACCOUNT_DISABLED');
            END IF;

            -- change user_mail to user_id
            IF rec.user_id != rec.user_mail THEN
                APEX_CUSTOM_AUTH.SET_USER (
                    p_user => rec.user_id
                );
            END IF;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --
            -- @TODO: check if we can auto create new account
            -- we should not allow everyone in
            --

            -- create user record
            rec.user_id         := core.get_user_id();
            rec.user_name       := rec.user_id;
            rec.user_mail       := rec.user_id;
            rec.is_active       := 'Y';
            rec.updated_by      := rec.user_id;
            rec.updated_at      := SYSDATE;
            --
            BEGIN
                INSERT INTO tsk_users VALUES rec;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;
            END;
        END;

        -- update account
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        UPDATE tsk_users u
        SET u.updated_by    = rec.updated_by,
            u.updated_at    = rec.updated_at
        WHERE u.user_id     = rec.user_id;

        -- check users preferences, find project
        IF tsk_app.get_client_id() IS NULL THEN
            SELECT MAX(u.client_id)
            INTO fav.client_id
            FROM tsk_auth_users u
            JOIN tsk_clients c
                ON c.client_id      = u.client_id
            WHERE u.user_id         = rec.user_id
                AND u.is_active     = 'Y'
                AND c.is_active     = 'Y';
            --
            SELECT MAX(r.project_id)
            INTO fav.project_id
            FROM tsk_auth_roles r
            JOIN tsk_projects p
                ON p.client_id      = r.client_id
                AND p.project_id    = r.project_id
            WHERE r.client_id       = fav.client_id
                AND r.user_id       = rec.user_id
                AND r.is_active     = 'Y'
                AND p.is_active     = 'Y';
            --
            SELECT MAX(b.board_id)
            INTO fav.board_id
            FROM tsk_boards b
            WHERE b.client_id       = fav.client_id
                AND b.project_id    = fav.project_id
                AND b.is_active     = 'Y';
            --
            tsk_app.set_user_preferences (
                in_user_id          => rec.user_id,
                in_client_id        => fav.client_id,
                in_project_id       => fav.project_id,
                in_board_id         => fav.board_id,
                in_swimlane_id      => fav.swimlane_id
            );
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION get_component_type (
        in_component_type       VARCHAR2
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN CASE in_component_type
            WHEN 'APEX_APPLICATION_PAGES'           THEN 'PAGE'
            WHEN 'APEX_APPLICATION_PAGE_REGIONS'    THEN 'REGION'
            WHEN 'APEX_APPLICATION_PAGE_PROCESS'    THEN 'PROCESS'
            WHEN 'APEX_APPLICATION_BUTTONS'         THEN 'BUTTON'
            WHEN 'APEX_APPLICATION_PAGE_ITEMS'      THEN 'ITEM'
            WHEN 'APEX_APPL_PAGE_IG_COLUMNS'        THEN 'GRID_COLUMN'
            ELSE in_component_type END;
    END;



    PROCEDURE discover_component (
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_page_id              tsk_auth_pages.page_id%TYPE,
        --
        in_component_id         NUMBER      := NULL,
        in_component_type       VARCHAR2    := NULL,
        in_component_name       VARCHAR2    := NULL
    )
    AS
        PRAGMA AUTONOMOUS_TRANSACTION;
        --
        rec                     tsk_auth_components%ROWTYPE;
    BEGIN
        IF in_component_type IN (
            'APEX_APPLICATION_PAGES'  -- dont track pages
        )
        THEN
            RETURN;
        END IF;
        --
        rec.component_id        := in_component_id;
        rec.component_type      := get_component_type(in_component_type);
        rec.component_name      := in_component_name;
        rec.page_id             := in_page_id;
        rec.is_active           := NULL;
        rec.updated_by          := in_user_id;
        rec.updated_at          := SYSDATE;

        -- add component to the list
        BEGIN
            INSERT INTO tsk_auth_components VALUES rec;

            -- mark it as accessible for administrators
            rec.role_id         := c_admin_role;
            rec.is_active       := 'Y';
            --
            BEGIN
                INSERT INTO tsk_auth_components VALUES rec;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;
            END;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
        END;
        --
        COMMIT;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        ROLLBACK;
        core.raise_error();
    END;



    FUNCTION is_user (
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_page_id              tsk_auth_pages.page_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE,
        in_project_id           tsk_auth_roles.project_id%TYPE,
        --
        in_component_id         NUMBER      := NULL,
        in_component_type       VARCHAR2    := NULL,
        in_component_name       VARCHAR2    := NULL,
        in_action               CHAR        := NULL
    )
    RETURN CHAR
    --RESULT_CACHE
    AS
        v_authorized            CHAR;
        v_authorized_row#       PLS_INTEGER;
    BEGIN
        -- check access to the page
        v_authorized_row# := $$PLSQL_LINE;
        --
        SELECT MAX('Y') INTO v_authorized
        FROM tsk_navigation_auth_v n
        WHERE n.client_id       = in_client_id
            AND (n.project_id   = in_project_id OR n.project_id IS NULL)
            AND n.user_id       = in_user_id
            AND n.page_id       = in_page_id;

        -- access to page granted
        IF v_authorized = 'Y' AND in_component_type NOT IN ('APEX_APPLICATION_PAGES') THEN
            v_authorized_row# := $$PLSQL_LINE;

            -- check access to the component
            IF in_component_id IS NOT NULL THEN
                v_authorized_row# := $$PLSQL_LINE;

                -- check access to page component for users roles
                SELECT MAX('Y') INTO v_authorized
                FROM tsk_auth_components_v r
                WHERE r.user_id         = in_user_id
                    AND r.client_id     = in_client_id
                    AND (r.project_id   = in_project_id OR r.project_id IS NULL)
                    AND r.component_id  = in_component_id;
                --
                -- @TODO: if this fails, we could evaluate IS_USER_U action on the related component
                -- so you can set IS_USER_U|D roles on grid columns
                --

                -- we can access page, we can access component
                IF v_authorized = 'Y' THEN
                    v_authorized_row# := $$PLSQL_LINE;

                    -- can we do requested operation too?
                    IF in_action IS NOT NULL THEN
                        v_authorized := NULL;
                        --
                        FOR c IN (
                            SELECT t.table_name
                            FROM tsk_auth_region_tables_v t
                            WHERE t.page_id         = in_page_id
                                AND t.region_id     = in_component_id
                        ) LOOP
                            v_authorized_row# := $$PLSQL_LINE;
                            v_authorized := CASE WHEN INSTR(tsk_auth.is_allowed_dml (
                                    in_table_name       => c.table_name,
                                    in_action           => in_action,
                                    in_user_id          => in_user_id,
                                    in_client_id        => in_client_id,
                                    in_project_id       => in_project_id
                                ), in_action) > 0       -- returns C|U|D string
                                THEN 'Y' END;
                            --
                            IF v_authorized = 'Y' THEN
                                EXIT;
                            END IF;
                        END LOOP;
                    END IF;
                ELSE
                    -- on failure add component to the list
                    tsk_auth.discover_component (
                        in_user_id          => in_user_id,
                        in_page_id          => in_page_id,
                        in_component_id     => in_component_id,
                        in_component_type   => in_component_type,
                        in_component_name   => in_component_name
                    );
                END IF;
            END IF;
        END IF;
        --
        IF in_component_type IS NOT NULL OR v_authorized IS NULL THEN
            APEX_DEBUG.WARN (RTRIM(CASE WHEN v_authorized = 'Y' THEN 'IS_' ELSE 'NOT_' END || 'AUTHORIZED|IS_USER_' || in_action, '_')
                || ' #' || v_authorized_row#
                || ' |USER='     || in_user_id
                || ' |PAGE='     || in_page_id
                || ' |CLIENT='   || in_client_id
                || ' |PROJECT='  || in_project_id
                || CASE WHEN in_component_type IS NOT NULL
                    THEN ' |' || get_component_type(in_component_type) || '=' || in_component_id || '=' || in_component_name END
            );
        END IF;
        --
        RETURN v_authorized;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION is_user (
        in_component_id         NUMBER      := NULL,
        in_component_type       VARCHAR2    := NULL,
        in_component_name       VARCHAR2    := NULL,
        in_action               CHAR        := NULL
    )
    RETURN CHAR
    AS
    BEGIN
        RETURN tsk_auth.is_user (
            in_user_id          => core.get_user_id(),
            in_page_id          => core.get_page_id(),
            in_client_id        => COALESCE(core.get_item('$CLIENT_ID'),   tsk_app.get_client_id()),
            in_project_id       => COALESCE(core.get_item('$PROJECT_ID'),  tsk_app.get_project_id()),
            in_component_id     => in_component_id,
            in_component_type   => in_component_type,
            in_component_name   => in_component_name,
            in_action           => in_action
        );
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION is_admin
    RETURN CHAR
    AS
    BEGIN
        RETURN 'Y';
    END;



    FUNCTION is_page_available (
        -- pass args so we can cache the result
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_page_id              tsk_auth_pages.page_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE,
        in_project_id           tsk_auth_roles.project_id%TYPE,
        in_auth_scheme          VARCHAR2,
        in_procedure_name       VARCHAR2
    )
    RETURN CHAR
    --RESULT_CACHE
    AS
        out_result              CHAR;
        --
        PRAGMA UDF;             -- SQL only
    BEGIN
        -- skip global page and login/logout page
        IF in_page_id IN (0, 9999) THEN
            RETURN 'Y';  -- always show
        END IF;

        -- check scheme and procedure
        IF in_auth_scheme IS NULL OR in_auth_scheme = 'MUST_NOT_BE_PUBLIC_USER' THEN
            RETURN 'Y';  -- no authorization or public access
        END IF;

        -- check auth procedure
        IF in_procedure_name IS NULL THEN
            RETURN 'N';  -- hide, auth function is set on page but missing in AUTH package
        END IF;

        -- call procedure
        IF in_auth_scheme LIKE 'IS_USER%' THEN
            EXECUTE IMMEDIATE
                'BEGIN :out_result := ' || in_procedure_name || '(:user_id, :page_id, :client_id, :project_id); END;'
                USING OUT out_result,
                    IN in_user_id, IN in_page_id, IN in_client_id, IN in_project_id;
        ELSE
            EXECUTE IMMEDIATE
                'BEGIN :out_result := ' || in_procedure_name || '(); END;'
                USING OUT out_result;
        END IF;
        --
        RETURN NVL(out_result, 'N');
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE check_allowed_dml (
        in_table_name           tsk_auth_tables.table_name%TYPE,
        in_action               CHAR,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    )
    AS
    BEGIN
        IF tsk_auth.is_allowed_dml (
                in_table_name       => in_table_name,
                in_action           => in_action,
                in_user_id          => in_user_id,
                in_client_id        => in_client_id,
                in_project_id       => in_project_id
            ) IS NULL
        THEN
            core.raise_error('NOT_AUTH', in_action, REPLACE(in_table_name, 'TSK_', ''), in_user_id, in_client_id, in_project_id);
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION is_allowed_dml (
        in_table_name           tsk_auth_tables.table_name%TYPE,
        in_action               CHAR,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    )
    RETURN VARCHAR2
    AS
        v_authorized            VARCHAR2(4);
    BEGIN
        SELECT
            MAX(CASE WHEN t.is_allowed_create = 'Y' THEN 'C' END) ||
            MAX(CASE WHEN t.is_allowed_update = 'Y' THEN 'U' END) ||
            MAX(CASE WHEN t.is_allowed_delete = 'Y' THEN 'D' END)
        INTO v_authorized
        FROM tsk_auth_tables t
        JOIN tsk_auth_roles r
            ON r.client_id      = in_client_id
            AND (r.project_id   = in_project_id OR r.project_id IS NULL)
            AND r.user_id       = in_user_id
            AND r.role_id       = t.role_id
            AND (r.role_id      != 'ADMIN' OR core.get_page_id() >= 900)
            AND r.is_active     = 'Y'
        JOIN tsk_auth_users a
            ON a.user_id        = r.user_id
            AND a.client_id     = r.client_id
            AND a.is_active     = 'Y'
        JOIN tsk_users u
            ON u.user_id        = r.user_id
            AND u.is_active     = 'Y'
        WHERE t.table_name      = in_table_name
            AND t.is_active     = 'Y'
            AND (
                (t.is_allowed_create = 'Y' AND NULLIF(in_action, 'C') IS NULL) OR
                (t.is_allowed_update = 'Y' AND NULLIF(in_action, 'U') IS NULL) OR
                (t.is_allowed_delete = 'Y' AND NULLIF(in_action, 'D') IS NULL)
            );
        --
        RETURN v_authorized;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE check_executable (
        in_procedure_name       VARCHAR2,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    )
    --RESULT_CACHE
    AS
    BEGIN
        IF tsk_auth.is_executable (
                in_object_name          => SUBSTR(in_procedure_name, 1, INSTR(in_procedure_name, '.') - 1),
                in_procedure_name       => SUBSTR(in_procedure_name, INSTR(in_procedure_name, '.') + 1),
                in_user_id              => in_user_id,
                in_client_id            => in_client_id,
                in_project_id           => in_project_id
            ) IS NULL
        THEN
            core.raise_error('NOT_AUTH_PROC_' || in_procedure_name);
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE check_executable
    AS
        v_procedure_name        VARCHAR2(96);
    BEGIN
        v_procedure_name        := core.get_caller_name(3);
        --
        IF tsk_auth.is_executable (
                in_object_name          => SUBSTR(v_procedure_name, 1, INSTR(v_procedure_name, '.') - 1),
                in_procedure_name       => SUBSTR(v_procedure_name, INSTR(v_procedure_name, '.') + 1),
                in_user_id              => core.get_user_id(),
                in_client_id            => tsk_app.get_client_id(),
                in_project_id           => tsk_app.get_project_id()
            ) IS NULL
        THEN
            core.raise_error('NOT_AUTH_PROC_' || v_procedure_name);
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION is_executable (
        in_object_name          tsk_auth_procedures.object_name%TYPE,
        in_procedure_name       tsk_auth_procedures.object_name%TYPE,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    )
    RETURN CHAR
    AS
        v_authorized            CHAR;
    BEGIN
        SELECT MAX('Y') INTO v_authorized
        FROM tsk_auth_procedures t
        JOIN tsk_auth_roles r
            ON r.client_id      = in_client_id
            AND (r.project_id   = in_project_id OR r.project_id IS NULL)
            AND r.user_id       = in_user_id
            AND r.role_id       = t.role_id
            AND r.is_active     = 'Y'
        JOIN tsk_auth_users a
            ON a.user_id        = r.user_id
            AND a.is_active     = 'Y'
        JOIN tsk_users u
            ON u.user_id            = r.user_id
            AND u.is_active         = 'Y'
        WHERE t.object_name         = in_object_name
            AND t.procedure_name    = in_procedure_name
            AND t.is_active         = 'Y';
        --
        RETURN v_authorized;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

