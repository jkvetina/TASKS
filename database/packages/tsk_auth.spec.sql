CREATE OR REPLACE PACKAGE tsk_auth AS

    PROCEDURE after_auth (
        in_user_id              VARCHAR2
    );



    PROCEDURE preselect_recent_project (
        in_user_id              tsk_users.user_id%TYPE
    );



    FUNCTION get_component_type (
        in_component_type       VARCHAR2
    )
    RETURN VARCHAR2;



    PROCEDURE discover_component (
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_page_id              tsk_auth_pages.page_id%TYPE,
        --
        in_component_id         NUMBER      := NULL,
        in_component_type       VARCHAR2    := NULL,
        in_component_name       VARCHAR2    := NULL
    );



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
    RETURN CHAR;



    FUNCTION is_user (
        in_component_id         NUMBER      := NULL,
        in_component_type       VARCHAR2    := NULL,
        in_component_name       VARCHAR2    := NULL,
        in_action               CHAR        := NULL
    )
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



    PROCEDURE check_allowed_dml (
        in_table_name           tsk_auth_tables.table_name%TYPE,
        in_action               CHAR,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    );



    FUNCTION is_allowed_dml (
        in_table_name           tsk_auth_tables.table_name%TYPE,
        in_action               CHAR,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    )
    RETURN VARCHAR2;



    PROCEDURE check_executable (
        in_procedure_name       VARCHAR2,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    );



    PROCEDURE check_executable;



    FUNCTION is_executable (
        in_object_name          tsk_auth_procedures.object_name%TYPE,
        in_procedure_name       tsk_auth_procedures.object_name%TYPE,
        in_user_id              tsk_auth_roles.user_id%TYPE,
        in_client_id            tsk_auth_roles.client_id%TYPE       := NULL,
        in_project_id           tsk_auth_roles.project_id%TYPE      := NULL
    )
    RETURN CHAR;

END;
/

