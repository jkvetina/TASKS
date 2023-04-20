CREATE OR REPLACE PACKAGE tsk_p400 AS

    PROCEDURE init_defaults;



    PROCEDURE save_clients (
        io_client_id        IN OUT NOCOPY   VARCHAR2
    );

END;
/

