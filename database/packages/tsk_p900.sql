CREATE OR REPLACE PACKAGE BODY tsk_p900 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        core.set_item('P900_USER_ID', core.get_user_id());
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

