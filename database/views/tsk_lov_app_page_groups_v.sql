CREATE OR REPLACE FORCE VIEW tsk_lov_app_page_groups_v AS
SELECT
    t.page_group,
    MIN(t.page_id)      AS r#
    --
FROM apex_application_pages t
WHERE t.application_id          = core.get_app_id()
    AND t.page_id               NOT IN (0, 9999)
    AND t.authorization_scheme  = 'IS_USER'
GROUP BY
    t.page_group;
--
COMMENT ON TABLE tsk_lov_app_page_groups_v IS '';

