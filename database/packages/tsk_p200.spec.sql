CREATE OR REPLACE PACKAGE tsk_p200 AS

    PROCEDURE save_boards (
        io_board_id         IN OUT NOCOPY   VARCHAR2
    );



    PROCEDURE save_task_statuses (
        io_client_id        IN OUT NOCOPY   tsk_task_statuses.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_task_statuses.project_id%TYPE,
        io_status_id        IN OUT NOCOPY   tsk_task_statuses.status_id%TYPE
    );



    PROCEDURE save_task_swimlanes (
        io_client_id        IN OUT NOCOPY   tsk_task_swimlanes.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_task_swimlanes.project_id%TYPE,
        io_swimlane_id      IN OUT NOCOPY   tsk_task_swimlanes.swimlane_id%TYPE
    );



    PROCEDURE reorder_task_statuses (
        in_client_id        tsk_task_statuses.client_id%TYPE    := NULL,
        in_project_id       tsk_task_statuses.project_id%TYPE   := NULL
    );



    PROCEDURE reorder_task_swimlanes (
        in_client_id        tsk_task_swimlanes.client_id%TYPE   := NULL,
        in_project_id       tsk_task_swimlanes.project_id%TYPE  := NULL
    );

END;
/

