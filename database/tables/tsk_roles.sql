CREATE TABLE tsk_roles (
    role_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_roles_role NOT NULL,
    role_name                       VARCHAR2(64),
    role_group                      VARCHAR2(64),
    role_desc                       VARCHAR2(512),
    is_active                       CHAR(1),
    order#                          NUMBER(4,0),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_roles
        PRIMARY KEY (role_id),
    --
    CONSTRAINT ch_tsk_roles_active
        CHECK (is_active = 'Y' OR is_active IS NULL)
);
--
COMMENT ON TABLE tsk_roles IS '';
--
COMMENT ON COLUMN tsk_roles.role_id         IS '';
COMMENT ON COLUMN tsk_roles.role_name       IS '';
COMMENT ON COLUMN tsk_roles.role_group      IS '';
COMMENT ON COLUMN tsk_roles.role_desc       IS '';
COMMENT ON COLUMN tsk_roles.is_active       IS '';
COMMENT ON COLUMN tsk_roles.order#          IS '';

