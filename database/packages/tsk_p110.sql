CREATE OR REPLACE PACKAGE BODY tsk_p110 AS

    c_coll_task_filter      CONSTANT VARCHAR2(30) := 'TSK_P110_TASK_FILTERS';



    PROCEDURE init_defaults
    AS
        in_client_id        CONSTANT tsk_tasks.client_id%TYPE   := tsk_app.get_client_id();
        in_project_id       CONSTANT tsk_tasks.project_id%TYPE  := tsk_app.get_project_id();
        in_board_id         CONSTANT tsk_tasks.board_id%TYPE    := tsk_app.get_board_id();
        in_swimlane_id      CONSTANT tsk_tasks.swimlane_id%TYPE := tsk_app.get_swimlane_id();
    BEGIN
        --v_board_type        := COALESCE(NULLIF(NULLIF(in_swimlane_id, 'MY'), 'MY+'), core.get_user_id());
        --v_swimlane_id       := COALESCE(v_board_type, core.get_item('P100_SWIMLANE_ID'), '-');
        --
        core.set_item('P110_SOURCE_CLIENT',     COALESCE(core.get_item('P110_SOURCE_CLIENT'),   in_client_id));
        core.set_item('P110_SOURCE_PROJECT',    COALESCE(core.get_item('P110_SOURCE_PROJECT'),  in_project_id));
        core.set_item('P110_SOURCE_BOARD',      COALESCE(core.get_item('P110_SOURCE_BOARD'),    in_board_id));
        core.set_item('P110_SOURCE_STATUS',     COALESCE(core.get_item('P110_SOURCE_STATUS'),   NULL));
        core.set_item('P110_SOURCE_SWIMLANE',   COALESCE(core.get_item('P110_SOURCE_SWIMLANE'), in_swimlane_id));
        --
        core.set_item('P110_CLIENT_ID',     COALESCE(core.get_item('P110_CLIENT_ID'),   core.get_item('P110_SOURCE_CLIENT')));
        core.set_item('P110_PROJECT_ID',    COALESCE(core.get_item('P110_PROJECT_ID'),  core.get_item('P110_SOURCE_PROJECT')));
        core.set_item('P110_BOARD_ID',      COALESCE(core.get_item('P110_BOARD_ID'),    core.get_item('P110_SOURCE_BOARD')));
        core.set_item('P110_STATUS_ID',     COALESCE(core.get_item('P110_STATUS_ID'),   core.get_item('P110_SOURCE_STATUS')));
        core.set_item('P110_SWIMLANE_ID',   COALESCE(core.get_item('P110_SWIMLANE_ID'), core.get_item('P110_SOURCE_SWIMLANE')));
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE process_bulk_init
    AS
    BEGIN
        -- init collection to gather moving tasks
        APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(c_coll_task_filter);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
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
        v_source.category_id    := core.get_item('P110_SOURCE_CATEGORY');
        --
        v_target.client_id      := core.get_item('P110_CLIENT_ID');
        v_target.project_id     := core.get_item('P110_PROJECT_ID');
        v_target.board_id       := core.get_item('P110_BOARD_ID');
        v_target.status_id      := core.get_item('P110_STATUS_ID');
        v_target.swimlane_id    := core.get_item('P110_SWIMLANE_ID');
        v_target.category_id    := core.get_item('P110_CATEGORY');
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
            t.category_id       = CASE WHEN COALESCE(v_source.category_id, v_target.category_id) IS NOT NULL THEN v_target.category_id ELSE t.category_id END,
            t.updated_by        = v_target.updated_by,
            t.updated_at        = v_target.updated_at,
            t.order#            = t.order# + 1000
        WHERE 1 = 1
            AND t.client_id     = v_source.client_id
            AND t.project_id    = v_source.project_id
            AND t.board_id      = v_source.board_id
            AND t.status_id     = v_source.status_id
            AND t.swimlane_id   = v_source.swimlane_id
            AND (t.category_id  = v_source.category_id OR v_source.category_id IS NULL)
            AND t.task_id NOT IN (
                SELECT
                    c.c001 AS task_id
                FROM apex_collections c
                WHERE c.collection_name = c_coll_task_filter
            );

        -- resort targets
        FOR s IN (
            SELECT
                t.task_id,
                ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.task_id) * 10 AS order#
            FROM tsk_tasks t
            WHERE 1 = 1
                AND t.client_id     = v_target.client_id
                AND t.project_id    = v_target.project_id
                AND t.board_id      = v_target.board_id
                AND t.status_id     = v_target.status_id
                AND t.swimlane_id   = v_target.swimlane_id
        ) LOOP
            UPDATE tsk_tasks t
            SET t.order#        = s.order#
            WHERE t.task_id     = s.task_id
                AND (t.order#   != s.order# OR t.order# IS NULL);
        END LOOP;

        -- clear collection
        APEX_COLLECTION.TRUNCATE_COLLECTION(c_coll_task_filter);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

