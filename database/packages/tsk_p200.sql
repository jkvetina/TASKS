CREATE OR REPLACE PACKAGE BODY tsk_p200 AS

    PROCEDURE save_task_statuses (
        io_client_id        IN OUT NOCOPY   tsk_task_statuses.client_id%TYPE,
        io_project_id       IN OUT NOCOPY   tsk_task_statuses.project_id%TYPE,
        io_status_id        IN OUT NOCOPY   tsk_task_statuses.status_id%TYPE
    )
    AS
        v_action            CHAR;
        rec                 tsk_task_statuses%ROWTYPE;
    BEGIN
        v_action            := APEX_UTIL.GET_SESSION_STATE('APEX$ROW_STATUS');
        --
        rec.client_id       := tsk_app.get_grid_client_id(io_client_id);
        rec.project_id      := tsk_app.get_grid_project_id(io_project_id);
        --
        rec.status_id       := APEX_UTIL.GET_SESSION_STATE('STATUS_ID');
        rec.status_name     := APEX_UTIL.GET_SESSION_STATE('STATUS_NAME');
        rec.is_active       := APEX_UTIL.GET_SESSION_STATE('IS_ACTIVE');
        rec.order#          := APEX_UTIL.GET_SESSION_STATE('ORDER#');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF v_action = 'D' THEN
            DELETE FROM tsk_task_statuses t
            WHERE t.status_id       = rec.status_id
                AND t.client_id     = rec.client_id
                AND t.project_id    = rec.project_id;
            --
            RETURN;
        END IF;
        --
        UPDATE tsk_task_statuses t
        SET ROW = rec
        WHERE t.status_id       = rec.status_id
            AND t.client_id     = rec.client_id
            AND t.project_id    = rec.project_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_task_statuses
            VALUES rec;
        END IF;

        -- update keys to APEX
        io_client_id        := rec.client_id;
        io_project_id       := rec.project_id;
        io_status_id        := rec.status_id;
    END;

END;
/

