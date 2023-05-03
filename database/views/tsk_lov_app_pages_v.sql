CREATE OR REPLACE FORCE VIEW tsk_lov_app_pages_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$PAGE_GROUP')    AS page_group
    FROM DUAL
)
SELECT
    t.page_id,
    t.page_name,
    t.page_id || ' - ' || t.page_name   AS page,
    t.page_group
    --
FROM apex_application_pages t
JOIN x
    ON (x.page_group            = t.page_group OR x.page_group IS NULL)
WHERE t.application_id          = core.get_app_id()
    AND t.page_id               NOT IN (0, 9999)
    AND t.authorization_scheme  = 'IS_USER';
--
COMMENT ON TABLE tsk_lov_app_pages_v IS '';

