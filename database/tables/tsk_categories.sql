CREATE TABLE tsk_categories (
    category_id                     VARCHAR2(32)    CONSTRAINT nn_tsk_categories_id NOT NULL,
    category_name                   VARCHAR2(64)    CONSTRAINT nn_tsk_categories_name NOT NULL,
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_categories_client NOT NULL,
    project_id                      VARCHAR2(32)    CONSTRAINT nn_tsk_categories_project NOT NULL,
    color_bg                        VARCHAR2(8),
    color_fg                        VARCHAR2(8),
    is_active                       CHAR(1),
    is_default                      CHAR(1),
    order#                          NUMBER(4,0),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_tsk_categories
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT ch_tsk_categories_default
        CHECK (is_default = 'Y' OR is_default IS NULL),
    --
    CONSTRAINT pk_tsk_categories
        PRIMARY KEY (client_id, project_id, category_id),
    --
    CONSTRAINT fk_tsk_categories_project
        FOREIGN KEY (client_id, project_id)
        REFERENCES tsk_projects (client_id, project_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE tsk_categories IS '';
--
COMMENT ON COLUMN tsk_categories.category_id        IS '';
COMMENT ON COLUMN tsk_categories.category_name      IS '';
COMMENT ON COLUMN tsk_categories.client_id          IS '';
COMMENT ON COLUMN tsk_categories.project_id         IS '';
COMMENT ON COLUMN tsk_categories.color_bg           IS '';
COMMENT ON COLUMN tsk_categories.color_fg           IS '';
COMMENT ON COLUMN tsk_categories.is_active          IS '';
COMMENT ON COLUMN tsk_categories.is_default         IS '';
COMMENT ON COLUMN tsk_categories.order#             IS '';

