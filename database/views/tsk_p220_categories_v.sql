CREATE OR REPLACE FORCE VIEW tsk_p220_categories_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id,
        tsk_app.get_board_id()      AS board_id
    FROM DUAL
)
SELECT
    t.category_id       AS pk_category_id,      -- to allow PK changes
    --
    t.client_id,
    t.project_id,
    t.category_id,
    t.category_name,
    t.color_bg,
    t.color_fg,
    t.is_active,
    t.is_default,
    t.order#
    --
FROM tsk_categories t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id;
--
COMMENT ON TABLE tsk_p220_categories_v IS '';

