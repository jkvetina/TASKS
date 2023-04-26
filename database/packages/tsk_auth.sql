CREATE OR REPLACE PACKAGE BODY tsk_auth AS

    PROCEDURE after_auth (
        in_user_id          VARCHAR2
    )
    AS
        rec                 tsk_users%ROWTYPE;
    BEGIN
        -- create user record
        rec.user_id         := core.get_user_id();
        rec.user_name       := rec.user_id;
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
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
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION is_user (
        in_user_id          tsk_auth_roles.user_id%TYPE,
        in_page_id          tsk_auth_pages.page_id%TYPE,
        in_client_id        tsk_auth_roles.client_id%TYPE,
        in_project_id       tsk_auth_roles.project_id%TYPE
    )
    RETURN CHAR
    --RESULT_CACHE
    AS
        v_authorized    CHAR(1);
    BEGIN
        BEGIN
            SELECT 'Y' INTO v_authorized
            FROM tsk_navigation_auth_v n
            WHERE n.client_id       = in_client_id
                AND n.project_id    = in_project_id
                AND n.user_id       = in_user_id
                AND n.page_id       = in_page_id;
            --
            RETURN v_authorized;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
        END;
        --
        RETURN 'N';
    END;



    FUNCTION is_user
    RETURN CHAR
    AS
    BEGIN
        RETURN tsk_auth.is_user (
            in_user_id          => core.get_user_id(),
            in_page_id          => core.get_page_id(),
            in_client_id        => COALESCE(core.get_item('$CLIENT_ID'),   tsk_app.get_client_id()),
            in_project_id       => COALESCE(core.get_item('$PROJECT_ID'),  tsk_app.get_project_id())
        );
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
    END;

END;
/

