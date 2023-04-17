CREATE OR REPLACE FORCE VIEW tsk_p105_commits_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_number_item('P105_TASK_ID')    AS task_id
    FROM DUAL
)
SELECT
    t.commit_id,
    t.commit_message,
    t.commit_url,
    t.created_by,
    t.created_at
    --
FROM tsk_p500_commits_v t
JOIN x
    ON x.task_id        = t.task_id
ORDER BY
    t.created_at DESC;
--
COMMENT ON TABLE tsk_p105_commits_v IS '';

