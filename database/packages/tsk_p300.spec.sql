CREATE OR REPLACE PACKAGE tsk_p300 AS

    PROCEDURE init_defaults;



    PROCEDURE save_projects (
        io_client_id        IN OUT NOCOPY   tsk_projects.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_projects.project_id%TYPE
    );

END;
/

