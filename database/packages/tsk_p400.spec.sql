CREATE OR REPLACE PACKAGE tsk_p400 AS

    PROCEDURE init_defaults;



    PROCEDURE save_clients (
        io_client_id        IN OUT NOCOPY   tsk_clients.client_id%TYPE
    );

END;
/

