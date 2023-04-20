CREATE OR REPLACE PACKAGE tsk_p300 AS

    PROCEDURE init_defaults;



    PROCEDURE save_projects (
        io_project_id       IN OUT NOCOPY   VARCHAR2
    );

END;
/

