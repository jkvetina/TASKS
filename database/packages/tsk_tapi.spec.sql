CREATE OR REPLACE PACKAGE tsk_tapi AS

    g_app_prefix            CONSTANT VARCHAR2(16)   := 'TSK';



    FUNCTION get_table_name
    RETURN VARCHAR2;



    FUNCTION get_action (
        in_action               VARCHAR2        := NULL
    )
    RETURN CHAR;



    FUNCTION get_master_table (
        in_column_name          VARCHAR2
    )
    RETURN VARCHAR2;



    FUNCTION get_query (
        in_template             VARCHAR2,
        in_arg1                 VARCHAR2        := NULL,
        in_arg2                 VARCHAR2        := NULL,
        in_arg3                 VARCHAR2        := NULL,
        in_arg4                 VARCHAR2        := NULL,
        in_arg5                 VARCHAR2        := NULL,
        in_arg6                 VARCHAR2        := NULL,
        in_arg7                 VARCHAR2        := NULL,
        in_arg8                 VARCHAR2        := NULL
    )
    RETURN VARCHAR2;



    PROCEDURE rename_primary_key (
        in_column_name          VARCHAR2,
        in_old_key              VARCHAR2,
        in_new_key              VARCHAR2,
        in_merge                BOOLEAN         := TRUE
    );



    PROCEDURE clients (
        rec                     IN OUT NOCOPY   tsk_clients%ROWTYPE,
        --
        in_action               CHAR                            := NULL,
        in_client_id            tsk_clients.client_id%TYPE      := NULL
    );



    PROCEDURE clients_d (
        in_client_id            tsk_clients.client_id%TYPE
    );



    PROCEDURE projects (
        rec                 IN OUT NOCOPY   tsk_projects%ROWTYPE,
        --
        in_action           CHAR                                := NULL,
        in_client_id        tsk_projects.client_id%TYPE         := NULL,
        in_project_id       tsk_projects.project_id%TYPE        := NULL
    );



    PROCEDURE projects_d (
        in_client_id        tsk_projects.client_id%TYPE,
        in_project_id       tsk_projects.project_id%TYPE
    );



    PROCEDURE boards (
        rec                 IN OUT NOCOPY   tsk_boards%ROWTYPE,
        --
        in_action           CHAR                            := NULL,
        in_board_id         tsk_boards.board_id%TYPE        := NULL
    );



    PROCEDURE boards_d (
        in_board_id         tsk_boards.board_id%TYPE
    );



    PROCEDURE statuses (
        rec                     IN OUT NOCOPY   tsk_statuses%ROWTYPE,
        --
        in_action               CHAR                                    := NULL,
        in_client_id            tsk_statuses.client_id%TYPE             := NULL,
        in_project_id           tsk_statuses.project_id%TYPE            := NULL,
        in_status_id            tsk_statuses.status_id%TYPE             := NULL
    );



    PROCEDURE statuses_d (
        in_client_id            tsk_statuses.client_id%TYPE,
        in_project_id           tsk_statuses.project_id%TYPE,
        in_status_id            tsk_statuses.status_id%TYPE
    );



    PROCEDURE swimlanes (
        rec                     IN OUT NOCOPY   tsk_swimlanes%ROWTYPE,
        --
        in_action               CHAR                                    := NULL,
        in_client_id            tsk_swimlanes.client_id%TYPE            := NULL,
        in_project_id           tsk_swimlanes.project_id%TYPE           := NULL,
        in_swimlane_id          tsk_swimlanes.swimlane_id%TYPE          := NULL
    );



    PROCEDURE swimlanes_d (
        in_client_id            tsk_swimlanes.client_id%TYPE,
        in_project_id           tsk_swimlanes.project_id%TYPE,
        in_swimlane_id          tsk_swimlanes.swimlane_id%TYPE
    );



    PROCEDURE categories (
        rec                     IN OUT NOCOPY   tsk_categories%ROWTYPE,
        in_action                               CHAR                                := NULL,
        old_client_id           IN OUT NOCOPY   tsk_categories.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_categories.project_id%TYPE,
        old_category_id         IN OUT NOCOPY   tsk_categories.category_id%TYPE     -- old key
    );



    PROCEDURE tasks (
        rec                     IN OUT NOCOPY   tsk_tasks%ROWTYPE,
        in_action                               CHAR                                := NULL
    );



    PROCEDURE tasks_delete (
        in_task_id              tsk_tasks.task_id%TYPE
    );



    PROCEDURE user_fav_boards (
        rec                     IN OUT NOCOPY   tsk_user_fav_boards%ROWTYPE,
        in_action                               CHAR                                := NULL
    );



    PROCEDURE commits (
        rec                     IN OUT NOCOPY   tsk_commits%ROWTYPE,
        --
        in_action               CHAR                            := NULL
    );



    PROCEDURE task_commits (
        rec                     IN OUT NOCOPY   tsk_task_commits%ROWTYPE,
        --
        in_action               CHAR                            := NULL,
        in_commit_id            tsk_task_commits.commit_id%TYPE := NULL,
        in_task_id              tsk_task_commits.task_id%TYPE   := NULL
    );



    PROCEDURE roles_d (
        in_role_id              tsk_roles.role_id%TYPE
    );



    PROCEDURE roles (
        rec                     IN OUT NOCOPY tsk_roles%ROWTYPE,
        --
        in_action               CHAR                        := NULL,
        in_role_id              tsk_roles.role_id%TYPE      := NULL
    );

END;
/

