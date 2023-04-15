CREATE OR REPLACE PACKAGE tsk_p400 AS

    PROCEDURE save_clients (
        io_client_id        IN OUT NOCOPY   VARCHAR2
    );

END;
/

