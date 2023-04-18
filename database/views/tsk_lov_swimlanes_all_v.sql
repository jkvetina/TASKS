CREATE OR REPLACE FORCE VIEW tsk_lov_swimlanes_all_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        core.get_item('$PROJECT_ID')    AS project_id
    FROM DUAL
)
SELECT
    t.swimlane_id,
    t.swimlane_name,
    t.is_active
FROM tsk_swimlanes t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
ORDER BY
    t.order# NULLS LAST,
    t.swimlane_id;
--
COMMENT ON TABLE tsk_lov_task_swimlanes_all_v IS '';

