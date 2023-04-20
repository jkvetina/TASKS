CREATE OR REPLACE PACKAGE BODY tsk_p900 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        core.set_item('P900_USER_ID', core.get_user_id());
    END;

END;
/

