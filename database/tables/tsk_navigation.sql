CREATE TABLE tsk_navigation (
    page_id                         NUMBER(8,0)     CONSTRAINT nn_navigation_page_id NOT NULL,
    parent_id                       NUMBER(8,0),
    order#                          NUMBER(4,0),
    is_hidden                       CHAR(1),
    is_reset                        CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_navigation_is_hidden
        CHECK (is_hidden = 'Y' OR is_hidden IS NULL),
    --
    CONSTRAINT ch_navigation_is_reset
        CHECK (is_reset = 'Y' OR is_reset IS NULL),
    --
    CONSTRAINT pk_navigation
        PRIMARY KEY (page_id),
    --
    CONSTRAINT fk_navigation_parent
        FOREIGN KEY (parent_id)
        REFERENCES tsk_navigation (page_id)
);
--
COMMENT ON TABLE tsk_navigation IS '';
--
COMMENT ON COLUMN tsk_navigation.page_id        IS '';
COMMENT ON COLUMN tsk_navigation.parent_id      IS '';
COMMENT ON COLUMN tsk_navigation.order#         IS '';
COMMENT ON COLUMN tsk_navigation.is_hidden      IS '';
COMMENT ON COLUMN tsk_navigation.is_reset       IS '';

