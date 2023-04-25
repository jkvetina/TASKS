CREATE OR REPLACE PACKAGE tsk_p962 AS

    PROCEDURE init_defaults;



    FUNCTION get_role_id (
        in_column       NUMBER
    )
    RETURN tsk_auth_pages.role_id%TYPE;



    PROCEDURE save_pages;

END;
/

