CREATE TABLE tsk_user_fav_boards (
    user_id                         VARCHAR2(128)   CONSTRAINT nn_tsk_user_fav_user NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_user_fav_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_user_fav_project NOT NULL,
    board_id                        NUMBER(10,0)    CONSTRAINT nn_tsk_user_fav_board NOT NULL,
    swimlane_id                     VARCHAR2(32),
    owner_id                        VARCHAR2(128),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_user_fav_boards
        PRIMARY KEY (user_id, client_id, project_id, board_id),
    --
    CONSTRAINT fk_tsk_user_fav_boards_board
        FOREIGN KEY (board_id)
        REFERENCES tsk_boards (board_id)
        DEFERRABLE INITIALLY DEFERRED,
    --
    CONSTRAINT fk_tsk_user_fav_boards_swim
        FOREIGN KEY (client_id, project_id, swimlane_id)
        REFERENCES tsk_swimlanes (client_id, project_id, swimlane_id)
        DEFERRABLE INITIALLY DEFERRED,
    --
    CONSTRAINT fk_tsk_user_fav_boards_owner
        FOREIGN KEY (owner_id, client_id)
        REFERENCES tsk_auth_users (user_id, client_id)
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
COMMENT ON COLUMN tsk_user_fav_boards.client_id     IS '';
COMMENT ON COLUMN tsk_user_fav_boards.project_id    IS '';
COMMENT ON COLUMN tsk_user_fav_boards.board_id      IS '';
COMMENT ON COLUMN tsk_user_fav_boards.swimlane_id   IS '';
COMMENT ON COLUMN tsk_user_fav_boards.owner_id      IS '';

