CREATE TABLE tsk_permissions (
    table_name                      VARCHAR2(64),
    table_action                    VARCHAR2(16),
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_permissions_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_permissions
        PRIMARY KEY (table_name, table_action)
);
--
COMMENT ON TABLE tsk_permissions IS '';
--
COMMENT ON COLUMN tsk_permissions.table_name        IS '';
COMMENT ON COLUMN tsk_permissions.table_action      IS '';
COMMENT ON COLUMN tsk_permissions.is_active         IS '';

