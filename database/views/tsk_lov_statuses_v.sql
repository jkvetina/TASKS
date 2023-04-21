CREATE OR REPLACE FORCE VIEW tsk_lov_statuses_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id,
        core.get_item('P0_PROJECT_ID')  AS project_id
    FROM DUAL
)
SELECT
    t.status_id,
    t.status_name,
    t.is_default,
    t.is_with_name,
    ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.status_id) AS order#
    --
FROM tsk_statuses t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
WHERE t.is_active       = 'Y';
--
COMMENT ON TABLE tsk_lov_statuses_v IS '';

