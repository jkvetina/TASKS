CREATE OR REPLACE PACKAGE tsk_p100 AS

    c_task_prefix           CONSTANT VARCHAR2(8) := '#';



    PROCEDURE init_defaults;



    PROCEDURE generate_board;



    PROCEDURE ajax_update_task_on_drag;



    PROCEDURE add_to_favorites;



    PROCEDURE remove_from_favorites;

END;
/

