CREATE OR REPLACE FORCE VIEW tsk_p562_map_pages_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$ROLE_GROUP')    AS role_group,
        core.get_item('$ROLE_ID')       AS role_id,
        core.get_app_id()               AS app_id
    FROM DUAL
)
SELECT
    a.page_id,
    a.page_name,
    a.page_group || ' - ' || a.authorization_scheme  AS page_group
FROM apex_application_pages a
CROSS JOIN tsk_roles r
CROSS JOIN x
WHERE 1 = 1
    AND a.application_id    = x.app_id
    AND a.page_id           NOT IN (0, 9999)
    AND (x.role_group       = r.role_group  OR x.role_group IS NULL)
    AND (x.role_id          = r.role_id     OR x.role_id IS NULL)
GROUP BY
    a.page_id,
    a.page_name,
    a.page_group,
    a.authorization_scheme;
--
COMMENT ON TABLE tsk_p562_map_pages_v IS '';

