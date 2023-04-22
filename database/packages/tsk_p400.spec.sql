CREATE OR REPLACE PACKAGE tsk_p400 AS

    PROCEDURE init_defaults;



    PROCEDURE save_clients (
        io_client_id        IN OUT NOCOPY   VARCHAR2
    );



    PROCEDURE rename_client_id (
        in_old_client_id        tsk_clients.client_id%TYPE,
        in_new_client_id        tsk_clients.client_id%TYPE
    );

END;
/

