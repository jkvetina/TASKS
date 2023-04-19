CREATE OR REPLACE FORCE VIEW tsk_lov_swimlanes_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id,
        core.get_item('P0_PROJECT_ID')  AS project_id
    FROM DUAL
)
SELECT
    t.swimlane_id,
    t.swimlane_name,
    ROW_NUMBER() OVER (ORDER BY t.order# NULLS LAST, t.swimlane_id) AS order#
    --
FROM tsk_swimlanes t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
WHERE t.is_active       = 'Y';
--
COMMENT ON TABLE tsk_lov_swimlanes_v IS '';

