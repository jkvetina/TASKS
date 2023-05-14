CREATE TABLE tsk_auth_users (
    user_id                         VARCHAR2(128)   CONSTRAINT nn_tsk_auth_users_user NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_auth_users_client NOT NULL,
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_auth_users_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_auth_users
        PRIMARY KEY (user_id, client_id),
    --
    CONSTRAINT fk_tsk_auth_users_user
        FOREIGN KEY (user_id)
        REFERENCES tsk_users (user_id)
        DEFERRABLE INITIALLY DEFERRED,
    --
    CONSTRAINT fk_tsk_auth_users_client
        FOREIGN KEY (client_id)
        REFERENCES tsk_clients (client_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_auth_users IS '';
--
COMMENT ON COLUMN tsk_auth_users.user_id        IS '';
COMMENT ON COLUMN tsk_auth_users.client_id      IS '';
COMMENT ON COLUMN tsk_auth_users.is_active      IS '';

