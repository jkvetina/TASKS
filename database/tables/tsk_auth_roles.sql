CREATE TABLE tsk_auth_roles (
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_auth_roles_client NOT NULL,
    user_id                         VARCHAR2(128)   CONSTRAINT nn_tsk_auth_roles_user NOT NULL,
    role_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_auth_roles_role NOT NULL,
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_auth_roles_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_auth_roles
        PRIMARY KEY (client_id, user_id, role_id),
    --
    CONSTRAINT fk_tsk_auth_roles_user
        FOREIGN KEY (client_id, user_id)
        REFERENCES tsk_auth_users (client_id, user_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_auth_roles IS '';
--
COMMENT ON COLUMN tsk_auth_roles.client_id      IS '';
COMMENT ON COLUMN tsk_auth_roles.user_id        IS '';
COMMENT ON COLUMN tsk_auth_roles.role_id        IS '';
COMMENT ON COLUMN tsk_auth_roles.is_active      IS '';
