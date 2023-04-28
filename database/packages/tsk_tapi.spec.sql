CREATE OR REPLACE PACKAGE tsk_tapi AS

    PROCEDURE boards (
        rec                     IN OUT NOCOPY   tsk_boards%ROWTYPE,
        in_action                               CHAR                    := NULL,
        old_board_id            IN OUT NOCOPY   VARCHAR2                            -- apex item is a string
    );



    PROCEDURE statuses (
        rec                     IN OUT NOCOPY   tsk_statuses%ROWTYPE,
        in_action                               CHAR                            := NULL,
        old_client_id           IN OUT NOCOPY   tsk_statuses.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_statuses.project_id%TYPE,
        old_status_id           IN OUT NOCOPY   tsk_statuses.status_id%TYPE     -- old key
    );



    PROCEDURE swimlanes (
        rec                     IN OUT NOCOPY   tsk_swimlanes%ROWTYPE,
        in_action                               CHAR                            := NULL,
        old_client_id           IN OUT NOCOPY   tsk_swimlanes.client_id%TYPE,
        old_project_id          IN OUT NOCOPY   tsk_swimlanes.project_id%TYPE,
        old_swimlane_id         IN OUT NOCOPY   tsk_swimlanes.swimlane_id%TYPE     -- old key
    );

END;
/

