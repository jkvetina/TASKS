CREATE OR REPLACE FORCE VIEW tsk_p250_swimlanes_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')           AS client_id,
        core.get_item('P0_PROJECT_ID')          AS project_id,
        core.get_number_item('P0_BOARD_ID')     AS board_id
    FROM DUAL
),
c AS (
    SELECT
        t.swimlane_id,
        --
        SUM(CASE WHEN t.board_id    = x.board_id    THEN 1 ELSE 0 END) AS count_board,
        SUM(CASE WHEN t.project_id  = x.project_id  THEN 1 ELSE 0 END) AS count_project,
        SUM(CASE WHEN t.client_id   = x.client_id   THEN 1 ELSE 0 END) AS count_client
    FROM tsk_tasks t
    CROSS JOIN x
    GROUP BY t.swimlane_id
)
SELECT
    t.swimlane_id       AS pk_swimlane_id,    -- to allow PK changes
    --
    t.client_id,
    t.project_id,
    t.swimlane_id,
    t.swimlane_name,
    t.order#,
    t.is_active,
    --
    c.count_board,
    c.count_project,
    c.count_client
    --
FROM tsk_swimlanes t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
JOIN c
    ON c.swimlane_id    = t.swimlane_id;
--
COMMENT ON TABLE tsk_p250_swimlanes_v IS '';

