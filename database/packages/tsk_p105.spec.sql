CREATE OR REPLACE PACKAGE tsk_p105 AS

    PROCEDURE init_defaults;



    PROCEDURE save_task;



    PROCEDURE save_checklist;



    FUNCTION get_badge_icon (
        in_value            NUMBER
    )
    RETURN VARCHAR2;



    PROCEDURE save_comment (
        in_task_id          tsk_task_comments.task_id%TYPE,
        in_comment_id       tsk_task_comments.comment_id%TYPE
    );



    PROCEDURE delete_comment (
        in_task_id          tsk_task_comments.task_id%TYPE,
        in_comment_id       tsk_task_comments.comment_id%TYPE
    );

END;
/

