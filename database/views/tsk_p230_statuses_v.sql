CREATE OR REPLACE FORCE VIEW tsk_p230_statuses_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        tsk_app.get_client_id()     AS client_id,
        tsk_app.get_project_id()    AS project_id,
        tsk_app.get_board_id()      AS board_id
    FROM DUAL
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
    t.is_default,
    t.is_named,
    --
    c.count_board,
    c.count_project,
    c.count_client
    --
FROM tsk_statuses t
JOIN x
    ON x.client_id      = t.client_id
    AND x.project_id    = t.project_id
LEFT JOIN tsk_p230_statuses_counts_v c
    ON c.status_id      = t.status_id;
--
COMMENT ON TABLE tsk_p230_statuses_v IS '';

