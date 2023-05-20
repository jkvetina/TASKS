CREATE OR REPLACE PACKAGE tsk_p200 AS

    PROCEDURE init_defaults;



    PROCEDURE save_boards;



    PROCEDURE save_task_statuses (
        io_client_id        IN OUT NOCOPY   tsk_statuses.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_statuses.project_id%TYPE,
        io_status_id        IN OUT NOCOPY   tsk_statuses.status_id%TYPE
    );



    PROCEDURE save_task_swimlanes (
        io_client_id        IN OUT NOCOPY   tsk_swimlanes.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_swimlanes.project_id%TYPE,
        io_swimlane_id      IN OUT NOCOPY   tsk_swimlanes.swimlane_id%TYPE
    );



    PROCEDURE save_task_categories (
        io_client_id        IN OUT NOCOPY   tsk_categories.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_categories.project_id%TYPE,
        io_category_id      IN OUT NOCOPY   tsk_categories.category_id%TYPE
    );



    PROCEDURE reorder_task_statuses;



    PROCEDURE reorder_task_swimlanes;



    PROCEDURE reorder_categories;

END;
/

