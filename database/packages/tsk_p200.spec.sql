CREATE OR REPLACE PACKAGE tsk_p200 AS

    PROCEDURE init_defaults;



    PROCEDURE save_boards;



    PROCEDURE save_statuses;



    PROCEDURE save_swimlanes;



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

