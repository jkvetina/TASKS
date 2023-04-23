CREATE OR REPLACE FORCE VIEW tsk_lov_app_pages_v AS
SELECT
    t.page_id,
    t.page_id       || ' - ' || t.page_name             AS page_name,
    t.page_group    || ' - ' || t.authorization_scheme  AS page_group
FROM apex_application_pages t
WHERE t.application_id  = core.get_app_id()
    AND t.page_id       NOT IN (0, 9999);
--
COMMENT ON TABLE tsk_lov_app_pages_v IS '';

