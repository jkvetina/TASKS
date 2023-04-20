CREATE OR REPLACE PACKAGE BODY tsk_p300 AS

    PROCEDURE save_projects (
        io_project_id       IN OUT NOCOPY   VARCHAR2
    )
    AS
        v_action            CHAR;
        rec                 tsk_projects%ROWTYPE;
    BEGIN
        v_action            := APEX_UTIL.GET_SESSION_STATE('APEX$ROW_STATUS');
        --
        rec.client_id       := tsk_app.get_grid_client_id();
        --
        rec.project_id      := APEX_UTIL.GET_SESSION_STATE('PROJECT_ID');
        rec.project_name    := APEX_UTIL.GET_SESSION_STATE('PROJECT_NAME');
        rec.is_active       := APEX_UTIL.GET_SESSION_STATE('IS_ACTIVE');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF v_action = 'D' THEN
            DELETE FROM tsk_projects t
            WHERE t.project_id      = rec.project_id;
            --
            RETURN;
        END IF;
        --
        UPDATE tsk_projects t
        SET ROW = rec
        WHERE t.project_id          = rec.project_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_projects
            VALUES rec;
        END IF;

        -- update keys to APEX
        io_project_id       := TO_CHAR(rec.project_id);
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

