CREATE TABLE tsk_user_fav_boards (
    user_id                         VARCHAR2(128)   CONSTRAINT nn_tsk_user_fav_boards_user NOT NULL,
    board_id                        NUMBER(10,0)    CONSTRAINT nn_tsk_user_fav_boards_id NOT NULL,
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_user_fav_boards
        PRIMARY KEY (user_id, board_id),
    --
    CONSTRAINT fk_tsk_user_fav_boards_board
        FOREIGN KEY (board_id)
        REFERENCES tsk_boards (board_id)
        DEFERRABLE INITIALLY DEFERRED,
    --
    CONSTRAINT fk_tsk_user_fav_boards_user
        FOREIGN KEY (user_id)
        REFERENCES tsk_users (user_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_user_fav_boards IS '';
--
COMMENT ON COLUMN tsk_user_fav_boards.user_id       IS '';
COMMENT ON COLUMN tsk_user_fav_boards.board_id      IS '';

