CREATE OR REPLACE FORCE VIEW tsk_lov_app_page_groups_v AS
SELECT
    t.page_group,
    MIN(t.page_id) AS r#,
    --
    INITCAP(REGEXP_SUBSTR(t.page_group, '^([A-Za-z0-9_]+)\s[-\s]?(.*)$', 1, 1, NULL, 2))    AS page_group_name,
    INITCAP(REGEXP_SUBSTR(t.page_group, '^([A-Za-z0-9_]+)\s', 1, 1, NULL, 1))               AS group_name,
    --
    LAG(t.page_group)   OVER (ORDER BY MIN(t.page_id)) AS prev_group,
    LEAD(t.page_group)  OVER (ORDER BY MIN(t.page_id)) AS next_group
    --
FROM apex_application_pages t
WHERE t.application_id          = core.get_app_id()
    AND t.page_id               NOT IN (0, 9999)
    AND t.authorization_scheme  = 'IS_USER'
GROUP BY
    t.page_group;
--
COMMENT ON TABLE tsk_lov_app_page_groups_v IS '';

