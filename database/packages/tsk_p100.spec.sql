CREATE OR REPLACE PACKAGE tsk_p100 AS

    c_task_prefix           CONSTANT VARCHAR2(8) := '#';



    PROCEDURE init_defaults;



    PROCEDURE generate_board (
        in_client_id        tsk_boards.client_id%TYPE           := NULL,
        in_project_id       tsk_boards.project_id%TYPE          := NULL,
        in_board_id         tsk_boards.board_id%TYPE            := NULL,
        in_swimlane_id      tsk_swimlanes.swimlane_id%TYPE      := NULL
    );



    PROCEDURE ajax_update_task_on_drag;



    PROCEDURE add_to_favorites (
        in_board_id         tsk_user_fav_boards.board_id%TYPE   := NULL,
        in_user_id          tsk_user_fav_boards.user_id%TYPE    := NULL
    );



    PROCEDURE remove_from_favorites (
        in_board_id         tsk_user_fav_boards.board_id%TYPE   := NULL,
        in_user_id          tsk_user_fav_boards.user_id%TYPE    := NULL
    );

END;
/

