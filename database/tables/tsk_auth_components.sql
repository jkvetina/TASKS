CREATE TABLE tsk_auth_components (
    component_id                    NUMBER          CONSTRAINT nn_tsk_auth_components_id NOT NULL,
    component_type                  VARCHAR2(30)    CONSTRAINT nn_tsk_auth_components_type NOT NULL,
    component_name                  VARCHAR2(256)   CONSTRAINT nn_tsk_auth_components_name NOT NULL,
    page_id                         NUMBER(8,0),
    role_id                         VARCHAR2(64),
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_auth_components_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT uq_tsk_auth_components
        UNIQUE (component_id, role_id),
    --
    CONSTRAINT fk_tsk_auth_components_role
        FOREIGN KEY (role_id)
        REFERENCES tsk_roles (role_id)
        DEFERRABLE INITIALLY DEFERRED,
    --
    CONSTRAINT fk_tsk_auth_components_page
        FOREIGN KEY (page_id)
        REFERENCES tsk_navigation (page_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_auth_components IS '';
--
COMMENT ON COLUMN tsk_auth_components.component_id      IS '';
COMMENT ON COLUMN tsk_auth_components.component_type    IS '';
COMMENT ON COLUMN tsk_auth_components.component_name    IS '';
COMMENT ON COLUMN tsk_auth_components.page_id           IS '';
COMMENT ON COLUMN tsk_auth_components.role_id           IS '';
COMMENT ON COLUMN tsk_auth_components.is_active         IS '';

