CREATE TABLE tsk_auth_procedures (
    object_name                     VARCHAR2(30)    CONSTRAINT nn_tsk_auth_procedures_obj NOT NULL,
    procedure_name                  VARCHAR2(30)    CONSTRAINT nn_tsk_auth_procedures_proc NOT NULL,
    table_name                      VARCHAR2(64),
    role_id                         VARCHAR2(64),
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_auth_procedures_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT uq_tsk_auth_procedures
        UNIQUE (object_name, procedure_name, role_id),
    --
    CONSTRAINT fk_tsk_auth_procedures_role
        FOREIGN KEY (role_id)
        REFERENCES tsk_roles (role_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_auth_procedures IS '';
--
COMMENT ON COLUMN tsk_auth_procedures.object_name       IS '';
COMMENT ON COLUMN tsk_auth_procedures.procedure_name    IS '';
COMMENT ON COLUMN tsk_auth_procedures.table_name        IS '';
COMMENT ON COLUMN tsk_auth_procedures.role_id           IS '';
COMMENT ON COLUMN tsk_auth_procedures.is_active         IS '';

