CREATE OR REPLACE FORCE VIEW tsk_p230_statuses_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id,
        core.get_item('P0_PROJECT_ID')  AS project_id,
        core.get_item('P0_BOARD_ID')    AS board_id
    FROM DUAL
),
c AS (
    SELECT
        t.status_id,
        --
        SUM(CASE WHEN t.board_id    = x.board_id    THEN 1 ELSE 0 END) AS count_board,
        SUM(CASE WHEN t.project_id  = x.project_id  THEN 1 ELSE 0 END) AS count_project,
        SUM(CASE WHEN t.client_id   = x.client_id   THEN 1 ELSE 0 END) AS count_client
    FROM tsk_tasks t
    CROSS JOIN x
    GROUP BY t.status_id
)
SELECT
    t.status_id         AS pk_status_id,    -- to allow PK changes
    --
    t.client_id,
    t.project_id,
    t.status_id,
    t.status_name,
    t.order#,
    t.is_active,
    --
    c.count_board,
    c.count_project,
    c.count_client
    --
FROM tsk_statuses t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
JOIN c
    ON c.status_id      = t.status_id;
--
COMMENT ON TABLE tsk_p230_statuses_v IS '';

