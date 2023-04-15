CREATE OR REPLACE PACKAGE tsk_p105 AS

    PROCEDURE init_defaults;



    PROCEDURE save_checklist;



    FUNCTION get_badge_icon (
        in_value            NUMBER
    )
    RETURN VARCHAR2;

END;
/

