CREATE TABLE tsk_users (
    user_id                         VARCHAR2(128)   CONSTRAINT nn_tsk_users_id NOT NULL,
    user_name                       VARCHAR2(64),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_users
        PRIMARY KEY (user_id)
);
--
COMMENT ON TABLE tsk_users IS '';
--
COMMENT ON COLUMN tsk_users.user_id     IS '';
COMMENT ON COLUMN tsk_users.user_name   IS '';

