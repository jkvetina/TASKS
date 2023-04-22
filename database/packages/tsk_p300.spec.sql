CREATE OR REPLACE PACKAGE tsk_p300 AS

    PROCEDURE init_defaults;



    PROCEDURE save_projects (
        io_project_id       IN OUT NOCOPY   VARCHAR2
    );



    PROCEDURE rename_project_id (
        in_old_project_id       tsk_projects.project_id%TYPE,
        in_new_project_id       tsk_projects.project_id%TYPE,
        in_client_id            tsk_projects.client_id%TYPE
    );

END;
/

