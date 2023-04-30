CREATE OR REPLACE PACKAGE BODY tsk_auth AS

    PROCEDURE after_auth (
        in_user_id              VARCHAR2
    )
    AS
        rec                     tsk_users%ROWTYPE;
    BEGIN
        -- create user record
        rec.user_id             := core.get_user_id();
        rec.user_name           := rec.user_id;
        --
        rec.updated_by          := core.get_user_id();
        rec.updated_at          := SYSDATE;
        --
        BEGIN
            INSERT INTO tsk_users VALUES rec;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE tsk_users u
            SET u.updated_by    = rec.updated_by,
                u.updated_at    = rec.updated_at
            WHERE u.user_id     = rec.user_id;
        END;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE mark_component (
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
        rec.component_type      := in_component_type;
        rec.component_name      := in_component_name;
        rec.page_id             := in_page_id;
        rec.updated_by          := in_user_id;
        rec.updated_at          := SYSDATE;
        --
        INSERT INTO tsk_auth_components VALUES rec;
        --
        COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
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
    BEGIN
        -- check access to the page
        SELECT MAX('Y') INTO v_authorized
        FROM tsk_navigation_auth_v n
        WHERE n.client_id       = in_client_id
            AND (n.project_id   = in_project_id OR n.project_id IS NULL)
            AND n.user_id       = in_user_id
            AND n.page_id       = in_page_id;
        --
        IF v_authorized IS NULL THEN
            RETURN NULL;
        END IF;

        -- check access to the component
        IF in_component_id IS NOT NULL THEN
            tsk_auth.mark_component (
                in_user_id          => in_user_id,
                in_page_id          => in_page_id,
                in_component_id     => in_component_id,
                in_component_type   => in_component_type,
                in_component_name   => in_component_name
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
        --IF core.is_developer() THEN
        --    RETURN 'Y';
        --END IF;
        --
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
            IF core.is_developer() THEN  -- show in menu, allow access
                RETURN 'Y';
            END IF;
            --
            RETURN 'N';  -- hide, auth function is set on page but missing in AUTH package
        END IF;

        -- call procedure
        IF in_auth_scheme = 'IS_USER' THEN
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
            core.raise_error('NOT_AUTH_DML_' || in_action || '_ON_' || in_table_name);
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
            AND r.is_active     = 'Y'
        JOIN tsk_auth_users a
            ON a.user_id        = r.user_id
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

