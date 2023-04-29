CREATE OR REPLACE FORCE VIEW tsk_p105_tags_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P105_TASK_ID')   AS task_id
    FROM DUAL
),
g AS (
    SELECT /*+ MATERIALIZE */
        t.task_id,
        i.COLUMN_VALUE AS tag
    FROM tsk_tasks t
    CROSS JOIN APEX_STRING.SPLIT(LTRIM(RTRIM(t.tags, ':'), ':'), ':') i
),
f AS (
    SELECT /*+ MATERIALIZE */
        g.task_id
    FROM g
    CROSS JOIN x
    JOIN g m
        ON m.tag        = g.tag
        AND m.task_id   != g.task_id
        AND m.task_id   = x.task_id
)
SELECT
    t.task_id,
    --
    '#' || t.task_id || ' ' || t.task_name || ' ' || t.task_progress AS list_text,
    --
    t.updated_at || ' ' || t.updated_by AS list_supplemental,
    --
    NULL                AS list_counter,
    t.task_link         AS list_link
    --
FROM tsk_p100_tasks_grid_v t
JOIN f
    ON f.task_id        = t.task_id
ORDER BY
    t.task_id DESC;
--
COMMENT ON TABLE tsk_p105_tags_v IS '';

