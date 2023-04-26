CREATE OR REPLACE PACKAGE tsk_auth AS

    PROCEDURE after_auth (
        in_user_id          VARCHAR2
    );



    FUNCTION is_user (
        in_user_id          tsk_auth_roles.user_id%TYPE,
        in_page_id          tsk_auth_pages.page_id%TYPE,
        in_client_id        tsk_auth_roles.client_id%TYPE,
        in_project_id       tsk_auth_roles.project_id%TYPE
    )
    RETURN CHAR;



    FUNCTION is_user
    RETURN CHAR;



    FUNCTION is_admin
    RETURN CHAR;



    FUNCTION is_page_available (
        -- pass args so we can cache the result
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_page_id              tsk_auth_pages.page_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE,
        in_project_id           tsk_auth_roles.project_id%TYPE,
        in_auth_scheme          VARCHAR2,
        in_procedure_name       VARCHAR2
    )
    RETURN CHAR;
    --RESULT_CACHE

END;
/

