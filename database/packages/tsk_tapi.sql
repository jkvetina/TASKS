CREATE OR REPLACE PACKAGE BODY tsk_tapi AS

    PROCEDURE boards (
        rec                 IN OUT NOCOPY tsk_boards%ROWTYPE,
        in_action           CHAR                                := NULL,
        in_old_board_id     tsk_boards.board_id%TYPE            := NULL
    )
    AS
    BEGIN
        tsk_auth.check_allowed_dml (
            in_table_name       => REGEXP_REPLACE(core.get_caller_name(2), '[^\.]+\.', 'TSK_'),
            in_action           => in_action,
            in_user_id          => core.get_user_id,
            in_client_id        => rec.client_id,       -- lets check against new values
            in_project_id       => rec.project_id
        );

        -- delete record
        IF in_action = 'D' THEN
            DELETE FROM tsk_boards t
            WHERE t.board_id    = NVL(in_old_board_id, rec.board_id);
            --
            RETURN;
        END IF;

        -- generate primary key if needed
        IF in_action = 'C' AND rec.board_id IS NULL THEN
            rec.board_id := tsk_board_id.NEXTVAL;
        END IF;

        -- overwrite some values
        rec.updated_by := core.get_user_id();
        rec.updated_at := SYSDATE;

        -- upsert record
        UPDATE tsk_boards t
        SET ROW             = rec
        WHERE t.board_id    = NVL(in_old_board_id, rec.board_id);
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO tsk_boards VALUES rec;
        END IF;
    END;

END;
/

