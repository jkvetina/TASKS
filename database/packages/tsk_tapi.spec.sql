CREATE OR REPLACE PACKAGE tsk_tapi AS

    PROCEDURE boards (
        rec                 IN OUT NOCOPY tsk_boards%ROWTYPE,
        in_action           CHAR                                := NULL,
        in_old_board_id     tsk_boards.board_id%TYPE            := NULL
    );

END;
/

