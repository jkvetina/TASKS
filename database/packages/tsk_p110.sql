CREATE OR REPLACE PACKAGE BODY tsk_p110 AS

    PROCEDURE init_defaults
    AS
        v_client_id         tsk_tasks.client_id%TYPE;
        v_project_id        tsk_tasks.project_id%TYPE;
        v_board_id          tsk_tasks.board_id%TYPE;
        v_board_type        tsk_lov_board_types_v.id%TYPE;
        v_status_id         tsk_tasks.status_id%TYPE;
        v_swimlane_id       tsk_tasks.swimlane_id%TYPE;
    BEGIN
        -- get global items
        v_client_id         := core.get_item('P0_CLIENT_ID');
        v_project_id        := core.get_item('P0_PROJECT_ID');
        v_board_id          := core.get_item('P0_BOARD_ID');
        v_board_type        := COALESCE(NULLIF(NULLIF(core.get_item('P0_BOARD_TYPE'), 'MY'), 'MY+'), core.get_user_id());
        v_swimlane_id       := COALESCE(v_board_type, core.get_item('P100_SWIMLANE_ID'), '-');
        --
        core.set_item('P110_SOURCE_CLIENT',     COALESCE(core.get_item('P110_SOURCE_CLIENT'),   v_client_id));
        core.set_item('P110_SOURCE_PROJECT',    COALESCE(core.get_item('P110_SOURCE_PROJECT'),  v_project_id));
        core.set_item('P110_SOURCE_BOARD',      COALESCE(core.get_item('P110_SOURCE_BOARD'),    v_board_id));
        core.set_item('P110_SOURCE_STATUS',     COALESCE(core.get_item('P110_SOURCE_STATUS'),   v_status_id));
        core.set_item('P110_SOURCE_SWIMLANE',   COALESCE(core.get_item('P110_SOURCE_SWIMLANE'), v_swimlane_id));
        --
        core.set_item('P110_CLIENT_ID',     COALESCE(core.get_item('P110_CLIENT_ID'),   core.get_item('P110_SOURCE_CLIENT')));
        core.set_item('P110_PROJECT_ID',    COALESCE(core.get_item('P110_PROJECT_ID'),  core.get_item('P110_SOURCE_PROJECT')));
        core.set_item('P110_BOARD_ID',      COALESCE(core.get_item('P110_BOARD_ID'),    core.get_item('P110_SOURCE_BOARD')));
        core.set_item('P110_STATUS_ID',     COALESCE(core.get_item('P110_STATUS_ID'),   core.get_item('P110_SOURCE_STATUS')));
        core.set_item('P110_SWIMLANE_ID',   COALESCE(core.get_item('P110_SWIMLANE_ID'), core.get_item('P110_SOURCE_SWIMLANE')));
    END;



    PROCEDURE process_bulk_init
    AS
    BEGIN
        NULL;
    END;



    PROCEDURE process_bulk_task_filters
    AS
    BEGIN
        NULL;
    END;



    PROCEDURE process_bulk_request
    AS
    BEGIN
        NULL;
    END;

END;
/

