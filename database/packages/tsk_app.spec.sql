CREATE OR REPLACE PACKAGE tsk_app AS

    PROCEDURE after_auth (
        in_user_id          VARCHAR2
    );



    PROCEDURE init_defaults;



    PROCEDURE update_task_on_drag;



    PROCEDURE save_user_preferences (
        in_user_id          VARCHAR2    := NULL
    );



    PROCEDURE load_user_preferences (
        in_user_id          VARCHAR2    := NULL
    );






    PROCEDURE generate_board (
        in_client_id        tsk_boards.client_id%TYPE           := NULL,
        in_project_id       tsk_boards.project_id%TYPE          := NULL,
        in_board_id         tsk_boards.board_id%TYPE            := NULL,
        in_swimlane_id      tsk_task_swimlanes.swimlane_id%TYPE := NULL
    );

END;
/

