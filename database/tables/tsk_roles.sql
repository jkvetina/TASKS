CREATE TABLE tsk_roles (
    role_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_roles_role NOT NULL,
    role_name                       VARCHAR2(64),
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_roles_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_roles
        PRIMARY KEY (role_id)
);
--
COMMENT ON TABLE tsk_roles IS '';
--
COMMENT ON COLUMN tsk_roles.role_id     IS '';
COMMENT ON COLUMN tsk_roles.role_name   IS '';
COMMENT ON COLUMN tsk_roles.is_active   IS '';

