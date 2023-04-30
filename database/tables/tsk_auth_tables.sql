CREATE TABLE tsk_auth_tables (
    table_name                      VARCHAR2(64)    CONSTRAINT nn_tsk_auth_tables_name NOT NULL,
    role_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_auth_tables_role NOT NULL,
    is_active                       CHAR(1),
    is_allowed_create               CHAR(1),
    is_allowed_update               CHAR(1),
    is_allowed_delete               CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_auth_tables_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT ch_tsk_auth_tables_create
        CHECK (is_allowed_create = 'Y' OR is_allowed_create IS NULL),
    --
    CONSTRAINT ch_tsk_auth_tables_update
        CHECK (is_allowed_update = 'Y' OR is_allowed_update IS NULL),
    --
    CONSTRAINT ch_tsk_auth_tables_delete
        CHECK (is_allowed_delete = 'Y' OR is_allowed_delete IS NULL),
    --
    CONSTRAINT pk_tsk_auth_tables
        PRIMARY KEY (table_name, role_id),
    --
    CONSTRAINT fk_tsk_auth_tables_role
        FOREIGN KEY (role_id)
        REFERENCES tsk_roles (role_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_auth_tables IS '';
--
COMMENT ON COLUMN tsk_auth_tables.table_name            IS '';
COMMENT ON COLUMN tsk_auth_tables.role_id               IS '';
COMMENT ON COLUMN tsk_auth_tables.is_active             IS '';
COMMENT ON COLUMN tsk_auth_tables.is_allowed_create     IS '';
COMMENT ON COLUMN tsk_auth_tables.is_allowed_update     IS '';
COMMENT ON COLUMN tsk_auth_tables.is_allowed_delete     IS '';

