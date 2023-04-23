CREATE TABLE tsk_boards (
    board_id                        NUMBER(10,0)    CONSTRAINT nn_tsk_boards_id NOT NULL,
    board_name                      VARCHAR2(64)    CONSTRAINT nn_tsk_boards_name NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_boards_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_boards_project NOT NULL,
    is_active                       CHAR(1),
    order#                          NUMBER(4,0),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_boards
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_boards
        PRIMARY KEY (board_id),
    --
    CONSTRAINT uq_tsk_boards
        UNIQUE (client_id, project_id, board_name),
    --
    CONSTRAINT fk_tsk_boards_project
        FOREIGN KEY (client_id, project_id)
        REFERENCES tsk_projects (client_id, project_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_boards IS '';
--
COMMENT ON COLUMN tsk_boards.board_id       IS '';
COMMENT ON COLUMN tsk_boards.board_name     IS '';
COMMENT ON COLUMN tsk_boards.client_id      IS '';
COMMENT ON COLUMN tsk_boards.project_id     IS '';
COMMENT ON COLUMN tsk_boards.is_active      IS '';
COMMENT ON COLUMN tsk_boards.order#         IS '';

