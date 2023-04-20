CREATE OR REPLACE PACKAGE BODY tsk_app AS

    PROCEDURE after_auth (
        in_user_id          VARCHAR2
    )
    AS
        rec                 tsk_users%ROWTYPE;
    BEGIN
        -- create user record
        rec.user_id         := core.get_user_id();
        rec.user_name       := rec.user_id;
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        BEGIN
            INSERT INTO tsk_users VALUES rec;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE tsk_users u
            SET u.updated_by    = rec.updated_by,
                u.updated_at    = rec.updated_at
            WHERE u.user_id     = rec.user_id;
        END;

        -- load stored preferences
        tsk_app.load_user_preferences(in_user_id);
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE init_defaults
    AS
        v_procedure_name        VARCHAR2(61);
    BEGIN
        -- make sure client and project is set correctly
        --
        --

        -- save new preference when passed in address
        FOR c IN (
            SELECT 'P0_CLIENT_ID'   AS item_name FROM DUAL UNION ALL
            SELECT 'P0_PROJECT_ID'  AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_ID'    AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_TYPE'  AS item_name FROM DUAL
        ) LOOP
            IF INSTR(core.get_request_url(TRUE), LOWER(c.item_name) || '=') > 0 THEN
                APEX_UTIL.SET_PREFERENCE (
                    p_preference => c.item_name,
                    p_value      => core.get_item(c.item_name),
                    p_user       => core.get_user_id()
                );
            END IF;
        END LOOP;

        -- find init block for specific/current page
        v_procedure_name := get_init_defaults_procedure(core.get_page_id());
        --
        IF v_procedure_name IS NOT NULL THEN
            EXECUTE IMMEDIATE 'BEGIN ' || v_procedure_name || '(); END;';
        END IF;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION get_init_defaults_procedure (
        in_page_id      NUMBER
    )
    RETURN VARCHAR2
    RESULT_CACHE
    AS
        out_procedure   VARCHAR2(61);
    BEGIN
        SELECT MAX(p.object_name || '.' || p.procedure_name)
        INTO out_procedure
        FROM user_procedures p
        WHERE ((
                p.object_name           = $$PLSQL_UNIT
                AND p.procedure_name    = 'INIT_DEFAULTS_P' || TO_CHAR(in_page_id)
            )
            OR (
                p.object_name           = REPLACE($$PLSQL_UNIT, '_APP', '_P') || TO_CHAR(in_page_id)
                AND p.procedure_name    = 'INIT_DEFAULTS'
            ));
        --
        RETURN out_procedure;
    END;



    FUNCTION get_task_link (
        in_task_id          tsk_tasks.task_id%TYPE,
        in_external         CHAR                        := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        IF in_external IS NOT NULL THEN
            RETURN
                REGEXP_REPLACE(APEX_MAIL.GET_INSTANCE_URL, '/ords/.*$', '') ||
                APEX_PAGE.GET_URL (
                    p_application       => core.get_app_id(),
                    p_session           => core.get_session_id(),
                    p_page              => 100,
                    p_clear_cache       => 100,
                    p_items             => 'P100_TASK_ID',
                    p_values            => in_task_id,
                    p_plain_url         => TRUE
                );
        END IF;
        --
        FOR c IN (
            SELECT
                t.task_id,
                t.client_id,
                t.project_id,
                t.board_id
            FROM tsk_tasks t
            WHERE t.task_id = in_task_id
        ) LOOP
            RETURN
                APEX_PAGE.GET_URL (
                    p_page              => 105,
                    p_clear_cache       => 105,
                    p_items             => 'P0_CLIENT_ID,P0_PROJECT_ID,P0_BOARD_ID,P105_TASK_ID',
                    p_values            =>
                        c.client_id     || ',' ||
                        c.project_id    || ',' ||
                        c.board_id      || ',' ||
                        c.task_id
                );
        END LOOP;
        --
        RETURN NULL;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_user_preferences (
        in_user_id          VARCHAR2    := NULL
    )
    AS
    BEGIN
        -- store in global items and in preferences for next session
        FOR c IN (
            SELECT 'P0_CLIENT_ID'   AS item_name FROM DUAL UNION ALL
            SELECT 'P0_PROJECT_ID'  AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_ID'    AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_TYPE'  AS item_name FROM DUAL
        ) LOOP
            core.set_item (
                c.item_name,
                core.get_item(REPLACE(c.item_name, 'P0_', 'P100_'))
            );
            --
            APEX_UTIL.SET_PREFERENCE (
                p_preference => c.item_name,
                p_value      => core.get_item(c.item_name),
                p_user       => COALESCE(in_user_id, core.get_user_id())
            );
        END LOOP;
    END;



    PROCEDURE load_user_preferences (
        in_user_id          VARCHAR2    := NULL
    )
    AS
    BEGIN
        FOR c IN (
            SELECT 'P0_CLIENT_ID'   AS item_name FROM DUAL UNION ALL
            SELECT 'P0_PROJECT_ID'  AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_ID'    AS item_name FROM DUAL UNION ALL
            SELECT 'P0_BOARD_TYPE'  AS item_name FROM DUAL
        ) LOOP
            core.set_item (
                c.item_name,
                APEX_UTIL.GET_PREFERENCE (
                    p_preference => c.item_name,
                    p_user       => COALESCE(in_user_id, core.get_user_id())
                )
            );
            --
            core.set_item (
                REPLACE(c.item_name, 'P0_', 'P100_'),
                core.get_item(c.item_name)
            );
/*
            core.raise_error(core.get_item(c.item_name) || '|' || APEX_UTIL.GET_PREFERENCE (
                p_preference => c.item_name,
                p_user       => COALESCE(in_user_id, core.get_user_id())
            ));
            */
        END LOOP;

        -- also save them, they might be changed without submitting the page
        --tsk_app.save_user_preferences();
        --
        -- @TODO: optimize
        --
    END;



    FUNCTION validate_client_id (
        in_client_id        tsk_clients.client_id%TYPE
    )
    RETURN tsk_clients.client_id%TYPE
    AS
        out_client_id       tsk_clients.client_id%TYPE;
    BEGIN
        SELECT t.client_id INTO out_client_id
        FROM tsk_clients t
        WHERE t.client_id = in_client_id;
        --
        RETURN out_client_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION validate_project_id (
        in_project_id       tsk_projects.project_id%TYPE
    )
    RETURN tsk_projects.project_id%TYPE
    AS
        out_project_id      tsk_projects.project_id%TYPE;
    BEGIN
        SELECT t.project_id INTO out_project_id
        FROM tsk_projects t
        WHERE t.project_id = in_project_id;
        --
        RETURN out_project_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION validate_board_id (
        in_board_id         tsk_boards.board_id%TYPE
    )
    RETURN tsk_boards.board_id%TYPE
    AS
        out_board_id        tsk_boards.board_id%TYPE;
    BEGIN
        SELECT t.board_id INTO out_board_id
        FROM tsk_boards t
        WHERE t.board_id = in_board_id;
        --
        RETURN out_board_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION get_grid_client_id (
        in_client_id        tsk_clients.client_id%TYPE := NULL
    )
    RETURN tsk_clients.client_id%TYPE
    AS
    BEGIN
        RETURN COALESCE (
            tsk_app.validate_client_id(in_client_id),
            tsk_app.validate_client_id(APEX_UTIL.GET_SESSION_STATE('CLIENT_ID')),
            core.get_item('P200_CLIENT_ID'),
            core.get_item('P0_CLIENT_ID')
        );
    END;



    FUNCTION get_grid_project_id (
        in_project_id       tsk_projects.project_id%TYPE := NULL
    )
    RETURN tsk_projects.project_id%TYPE
    AS
    BEGIN
        RETURN COALESCE (
            tsk_app.validate_client_id(in_project_id),
            tsk_app.validate_project_id(APEX_UTIL.GET_SESSION_STATE('PROJECT_ID')),
            core.get_item('P200_PROJECT_ID'),
            core.get_item('P0_PROJECT_ID')
        );
    END;



    PROCEDURE download_file (
        in_file_name                        VARCHAR2,
        in_file_mime                        VARCHAR2,
        in_file_payload     IN OUT NOCOPY   BLOB
    ) AS
    BEGIN
        HTP.INIT;
        OWA_UTIL.MIME_HEADER(in_file_mime, FALSE);
        --
        HTP.P('Content-Type: application/octet-stream');
        HTP.P('Content-Length: ' || DBMS_LOB.GETLENGTH(in_file_payload));
        HTP.P('Content-Disposition: attachment; filename="' || REGEXP_SUBSTR(in_file_name, '([^/]*)$') || '"');
        HTP.P('Cache-Control: max-age=0');
        --
        OWA_UTIL.HTTP_HEADER_CLOSE;
        WPG_DOCLOAD.DOWNLOAD_FILE(in_file_payload);
        APEX_APPLICATION.STOP_APEX_ENGINE;              -- throws ORA-20876 Stop APEX Engine
    EXCEPTION
    WHEN APEX_APPLICATION.E_STOP_APEX_ENGINE THEN
        NULL;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

