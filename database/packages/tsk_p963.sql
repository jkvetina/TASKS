CREATE OR REPLACE PACKAGE BODY tsk_p963 AS

    PROCEDURE init_defaults
    AS
        v_not_assigned          VARCHAR2(64);
    BEGIN
        tsk_p960.set_role_names();

        -- notify for new components
        SELECT NULLIF('(' || COUNT(*) || ')', '(0)') INTO v_not_assigned
        FROM tsk_p963_map_components_v c
        WHERE c.is_used         IS NULL
            AND c.dml_actions   IS NOT NULL;
        --
        core.set_item('$NOT_ASSIGNED', v_not_assigned);

        -- calculate prev/next pages
        core.set_item('$PREV_PAGE', '');
        core.set_item('$NEXT_PAGE', '');
        core.set_item('$PREV_GROUP', '');
        core.set_item('$NEXT_GROUP', '');
        --
        IF core.get_item('$PAGE_ID') IS NOT NULL THEN
            FOR c IN (
                SELECT
                    p.prev_page,
                    p.next_page
                FROM tsk_lov_app_pages_v p
                WHERE p.page_id = core.get_number_item('$PAGE_ID')
            ) LOOP
                core.set_item('$PREV_PAGE', c.prev_page);
                core.set_item('$NEXT_PAGE', c.next_page);
            END LOOP;
        END IF;

        -- calculate prev/next groups
        IF core.get_item('$PAGE_GROUP') IS NOT NULL THEN
            FOR c IN (
                SELECT
                    p.prev_group,
                    p.next_group
                FROM tsk_lov_app_page_groups_v p
                WHERE p.page_group = core.get_item('$PAGE_GROUP')
            ) LOOP
                core.set_item('$PREV_GROUP', c.prev_group);
                core.set_item('$NEXT_GROUP', c.next_group);
            END LOOP;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_components
    AS
        rec                 tsk_auth_components%ROWTYPE;
    BEGIN
        rec.component_id    := core.get_grid_data('COMPONENT_ID');
        rec.component_type  := core.get_grid_data('COMPONENT_TYPE');
        rec.component_name  := core.get_grid_data('COMPONENT_NAME');
        rec.page_id         := core.get_grid_data('PAGE_ID');
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;

        -- go through pivoted columns
        FOR i IN 1 .. tsk_p960.c_dynamic_roles LOOP
            rec.role_id     := tsk_p960.get_role_id(i);
            rec.is_active   := core.get_grid_data('ROLE_' || i);
            --
            CONTINUE WHEN rec.role_id IS NULL;
            --
            DELETE tsk_auth_components t
            WHERE t.component_id    = rec.component_id
                AND t.role_id       = rec.role_id
                AND t.is_active     = 'Y';
            --
            IF rec.is_active = 'Y' THEN
                UPDATE tsk_auth_components t
                SET t.is_active         = rec.is_active
                WHERE t.component_id    = rec.component_id
                    AND t.role_id       = rec.role_id;
                --
                IF SQL%ROWCOUNT = 0 THEN
                    INSERT INTO tsk_auth_components
                    VALUES rec;
                END IF;
            END IF;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE sync_regions
    AS
    BEGIN
        NULL;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

