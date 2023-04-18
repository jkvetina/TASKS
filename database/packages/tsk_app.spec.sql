CREATE OR REPLACE PACKAGE tsk_app AS

    PROCEDURE after_auth (
        in_user_id          VARCHAR2
    );



    PROCEDURE init_defaults;



    FUNCTION get_init_defaults_procedure (
        in_page_id      NUMBER
    )
    RETURN VARCHAR2
    RESULT_CACHE;



    FUNCTION get_task_link (
        in_task_id          tsk_tasks.task_id%TYPE,
        in_external         CHAR                        := NULL
    )
    RETURN VARCHAR2;



    PROCEDURE save_user_preferences (
        in_user_id          VARCHAR2    := NULL
    );



    PROCEDURE load_user_preferences (
        in_user_id          VARCHAR2    := NULL
    );



    FUNCTION validate_client_id (
        in_client_id        tsk_clients.client_id%TYPE
    )
    RETURN tsk_clients.client_id%TYPE;



    FUNCTION validate_project_id (
        in_project_id       tsk_projects.project_id%TYPE
    )
    RETURN tsk_projects.project_id%TYPE;



    FUNCTION validate_board_id (
        in_board_id         tsk_boards.board_id%TYPE
    )
    RETURN tsk_boards.board_id%TYPE;



    FUNCTION get_grid_client_id (
        in_client_id        tsk_clients.client_id%TYPE := NULL
    )
    RETURN tsk_clients.client_id%TYPE;



    FUNCTION get_grid_project_id (
        in_project_id       tsk_projects.project_id%TYPE := NULL
    )
    RETURN tsk_projects.project_id%TYPE;



    PROCEDURE download_file (
        in_file_name                        VARCHAR2,
        in_file_mime                        VARCHAR2,
        in_file_payload     IN OUT NOCOPY   BLOB
    );

END;
/

