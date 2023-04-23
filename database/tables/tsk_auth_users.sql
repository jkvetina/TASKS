CREATE TABLE tsk_auth_users (
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_auth_users_client NOT NULL,
    user_id                         VARCHAR2(128)   CONSTRAINT nn_tsk_auth_users_user NOT NULL,
    role_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_auth_users_role NOT NULL,
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_auth_users_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_auth_users
        PRIMARY KEY (client_id, user_id, role_id),
    --
    CONSTRAINT fk_tsk_auth_users_role
        FOREIGN KEY (role_id)
        REFERENCES tsk_roles (role_id)
        DEFERRABLE INITIALLY DEFERRED,
    --
    CONSTRAINT fk_tsk_auth_users_user
        FOREIGN KEY (user_id)
        REFERENCES tsk_users (user_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_auth_users IS '';
--
COMMENT ON COLUMN tsk_auth_users.client_id      IS '';
COMMENT ON COLUMN tsk_auth_users.user_id        IS '';
COMMENT ON COLUMN tsk_auth_users.role_id        IS '';
COMMENT ON COLUMN tsk_auth_users.is_active      IS '';

