CREATE OR REPLACE FORCE VIEW tsk_lov_swimlanes_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id
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

