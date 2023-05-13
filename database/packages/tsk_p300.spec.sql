CREATE OR REPLACE PACKAGE tsk_p300 AS

    PROCEDURE init_defaults;



    PROCEDURE save_projects;



    PROCEDURE create_default_swimlane (
        in_client_id        tsk_projects.client_id%TYPE,
        in_project_id       tsk_projects.project_id%TYPE
    );

END;
/

