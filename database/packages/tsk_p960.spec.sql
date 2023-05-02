CREATE OR REPLACE PACKAGE tsk_p960 AS

    c_dynamic_roles         CONSTANT PLS_INTEGER := 8;



    FUNCTION get_role_id (
        in_column       NUMBER
    )
    RETURN tsk_auth_pages.role_id%TYPE;



    PROCEDURE set_role_names;



    PROCEDURE reorder_roles;

END;
/

