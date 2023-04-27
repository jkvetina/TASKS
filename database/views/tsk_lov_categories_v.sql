CREATE OR REPLACE FORCE VIEW tsk_lov_categories_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id
    FROM DUAL
)
SELECT
    t.category_id,
    t.category_name,
    t.is_default,
    --
    ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.category_id) AS order#
    --
FROM tsk_categories t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
WHERE t.is_active       = 'Y';
--
COMMENT ON TABLE tsk_lov_categories_v IS '';

