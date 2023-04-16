CREATE OR REPLACE PACKAGE BODY tsk_p110 AS

    c_coll_task_filter      CONSTANT VARCHAR2(30) := 'TSK_P110_TASK_FILTERS';



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
        -- init collection to gather moving tasks
        APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(c_coll_task_filter);
    END;



    PROCEDURE process_bulk_task_filters
    AS
    BEGIN
        -- store grid lines into collection
        IF APEX_UTIL.GET_SESSION_STATE('TASK_SELECTED') IS NULL THEN
            APEX_COLLECTION.ADD_MEMBER (
                p_collection_name   => c_coll_task_filter,
                p_c001              => APEX_UTIL.GET_SESSION_STATE('TASK_ID')
            );
        END IF;
    END;



    PROCEDURE process_bulk_request
    AS
        v_source            tsk_tasks%ROWTYPE;
        v_target            tsk_tasks%ROWTYPE;
    BEGIN
        v_source.client_id      := core.get_item('P110_SOURCE_CLIENT');
        v_source.project_id     := core.get_item('P110_SOURCE_PROJECT');
        v_source.board_id       := core.get_item('P110_SOURCE_BOARD');
        v_source.status_id      := core.get_item('P110_SOURCE_STATUS');
        v_source.swimlane_id    := core.get_item('P110_SOURCE_SWIMLANE');
        --
        v_target.client_id      := core.get_item('P110_CLIENT_ID');
        v_target.project_id     := core.get_item('P110_PROJECT_ID');
        v_target.board_id       := core.get_item('P110_BOARD_ID');
        v_target.status_id      := core.get_item('P110_STATUS_ID');
        v_target.swimlane_id    := core.get_item('P110_SWIMLANE_ID');
        --
        v_target.updated_by     := core.get_user_id();
        v_target.updated_at     := SYSDATE;

        -- process tasks, skip tasks not marked in collection
        UPDATE tsk_tasks t
        SET t.client_id         = v_target.client_id,
            t.project_id        = v_target.project_id,
            t.board_id          = v_target.board_id,
            t.status_id         = v_target.status_id,
            t.swimlane_id       = v_target.swimlane_id,
            t.updated_by        = v_target.updated_by,
            t.updated_at        = v_target.updated_at
        WHERE 1 = 1
            AND t.client_id     = v_source.client_id
            AND t.project_id    = v_source.project_id
            AND t.board_id      = v_source.board_id
            AND t.status_id     = v_source.status_id
            AND t.swimlane_id   = v_source.swimlane_id
            AND t.task_id NOT IN (
                SELECT
                    c.c001 AS task_id
                FROM apex_collections c
                WHERE c.collection_name = c_coll_task_filter
            );

        -- clear collection
        APEX_COLLECTION.TRUNCATE_COLLECTION(c_coll_task_filter);
    END;

END;
/

