CREATE OR REPLACE FORCE VIEW tsk_lov_statuses_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id,
        core.get_item('P0_PROJECT_ID')  AS project_id
    FROM DUAL
)
SELECT
    t.status_id,
    t.status_name
FROM tsk_statuses t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
WHERE t.is_active       = 'Y'
ORDER BY
    t.order# NULLS LAST,
    t.status_id;
--
COMMENT ON TABLE tsk_lov_statuses_v IS '';

