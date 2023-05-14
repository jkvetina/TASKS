CREATE TABLE tsk_auth_pages (
    page_id                         NUMBER(8,0)     CONSTRAINT nn_tsk_auth_pages_page NOT NULL,
    role_id                         VARCHAR2(64)    CONSTRAINT nn_tsk_auth_pages_role NOT NULL,
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_auth_pages_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_tsk_auth_pages
        PRIMARY KEY (page_id, role_id),
    --
    CONSTRAINT fk_tsk_auth_pages_role
        FOREIGN KEY (role_id)
        REFERENCES tsk_roles (role_id)
        DEFERRABLE INITIALLY DEFERRED,
    --
    CONSTRAINT fk_tsk_auth_pages_nav
        FOREIGN KEY (page_id)
        REFERENCES tsk_navigation (page_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_auth_pages IS '';
--
COMMENT ON COLUMN tsk_auth_pages.page_id        IS '';
COMMENT ON COLUMN tsk_auth_pages.role_id        IS '';
COMMENT ON COLUMN tsk_auth_pages.is_active      IS '';

