CREATE OR REPLACE PACKAGE tsk_p500 AS

    PROCEDURE init_defaults;



    PROCEDURE set_header (
        in_id           NUMBER,
        in_name         VARCHAR2,
        in_value        VARCHAR2
    );



    PROCEDURE sync_commits;
    PROCEDURE sync_commits_job;



    PROCEDURE save_commits;



    PROCEDURE save_repos;



    PROCEDURE save_repo_endpoints;

END;
/

