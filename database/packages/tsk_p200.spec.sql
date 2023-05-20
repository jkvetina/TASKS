CREATE OR REPLACE PACKAGE tsk_p200 AS

    PROCEDURE init_defaults;



    PROCEDURE save_boards;



    PROCEDURE save_statuses;



    PROCEDURE save_swimlanes;



    PROCEDURE save_categories;



    PROCEDURE reorder_task_statuses;



    PROCEDURE reorder_task_swimlanes;



    PROCEDURE reorder_categories;

END;
/

