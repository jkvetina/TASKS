CREATE OR REPLACE FORCE VIEW tsk_p105_checklist_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_number_item('P105_TASK_ID')    AS task_id
    FROM DUAL
)
SELECT
    t.task_id,
    t.checklist_id,
    RTRIM(LTRIM(t.checklist_item))      AS checklist_item,
    t.checklist_done
FROM tsk_task_checklist t
JOIN x
    ON x.task_id    = t.task_id
UNION ALL
--
SELECT
    x.task_id,
    NULL        AS checklist_id,
    NULL        AS checklist_item,
    NULL        AS checklist_done
FROM x
ORDER BY checklist_done NULLS LAST, checklist_item, checklist_id;
--
COMMENT ON TABLE tsk_p105_checklist_v IS '';

