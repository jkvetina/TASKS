CREATE OR REPLACE PACKAGE tsk_app AS

    PROCEDURE after_auth (
        in_user_id          VARCHAR2
    );



    PROCEDURE init_defaults;
    PROCEDURE init_defaults_p100;
    PROCEDURE init_defaults_p105;



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



    PROCEDURE update_task_on_drag;



    PROCEDURE save_user_preferences (
        in_user_id          VARCHAR2    := NULL
    );



    PROCEDURE load_user_preferences (
        in_user_id          VARCHAR2    := NULL
    );



    PROCEDURE reorder_task_statuses (
        in_client_id        tsk_task_statuses.client_id%TYPE    := NULL,
        in_project_id       tsk_task_statuses.project_id%TYPE   := NULL
    );



    PROCEDURE reorder_task_swimlanes (
        in_client_id        tsk_task_swimlanes.client_id%TYPE   := NULL,
        in_project_id       tsk_task_swimlanes.project_id%TYPE  := NULL
    );



    PROCEDURE generate_board (
        in_client_id        tsk_boards.client_id%TYPE           := NULL,
        in_project_id       tsk_boards.project_id%TYPE          := NULL,
        in_board_id         tsk_boards.board_id%TYPE            := NULL,
        in_swimlane_id      tsk_task_swimlanes.swimlane_id%TYPE := NULL
    );



    PROCEDURE save_checklist;



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

END;
/

