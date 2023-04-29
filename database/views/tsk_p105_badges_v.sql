CREATE OR REPLACE FORCE VIEW tsk_p105_badges_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P105_TASK_ID')   AS task_id
    FROM DUAL
)
SELECT
    'P105_BADGE_CHECKLIST'              AS item_name,
    tsk_p105.get_badge_icon(COUNT(*))   AS badge
FROM tsk_task_checklist c
JOIN x
    ON x.task_id            = c.task_id
WHERE c.checklist_done      IS NULL
--
UNION ALL
SELECT
    'P105_BADGE_COMMENTS'               AS item_name,
    tsk_p105.get_badge_icon(COUNT(*))   AS badge
FROM tsk_task_comments c
JOIN x
    ON x.task_id            = c.task_id
--
UNION ALL
SELECT
    'P105_BADGE_COMMITS'                AS item_name,
    tsk_p105.get_badge_icon(COUNT(*))   AS badge
FROM tsk_task_commits c
JOIN x
    ON x.task_id            = c.task_id
--
UNION ALL
SELECT
    'P105_BADGE_TAGS'                   AS item_name,
    tsk_p105.get_badge_icon(COUNT(*))   AS badge
FROM tsk_p105_tags_v c
--
UNION ALL
SELECT
    'P105_BADGE_FILES'                  AS item_name,
    tsk_p105.get_badge_icon(COUNT(*))   AS badge
FROM tsk_task_files c
JOIN x
    ON x.task_id            = c.task_id;
--
COMMENT ON TABLE tsk_p105_badges_v IS '';

