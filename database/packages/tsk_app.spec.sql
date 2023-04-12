CREATE OR REPLACE PACKAGE tsk_app AS

    PROCEDURE update_task_on_drag;

    PROCEDURE save_tasks_filters;

    PROCEDURE load_tasks_filters;



    PROCEDURE generate_board (
        in_client_id        tsk_boards.client_id%TYPE           := NULL,
        in_project_id       tsk_boards.project_id%TYPE          := NULL,
        in_board_id         tsk_boards.board_id%TYPE            := NULL,
        in_swimlane_id      tsk_task_swimlanes.swimlane_id%TYPE := NULL
    );

END;
/

