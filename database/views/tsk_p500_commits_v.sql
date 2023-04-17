CREATE OR REPLACE FORCE VIEW tsk_p500_commits_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('P0_CLIENT_ID')   AS client_id,
        core.get_item('P0_PROJECT_ID')  AS project_id
    FROM DUAL
),
d AS (
    SELECT /*+ MATERIALIZE */
        t.task_id,
        SUBSTR(c.commit_id, 1, 8) AS commit_id,
        c.commit_message,
        c.commit_url,
        c.created_by,
        TO_CHAR(c.created_at, 'YYYY-MM-DD HH24:MI') AS created_at,
        TO_CHAR(c.created_at, 'YYYY-MM-DD')         AS today
    FROM tsk_commits c
    CROSS JOIN x
    JOIN tsk_commit_repos r
        ON r.client_id      = x.client_id
        AND r.project_id    = x.project_id
    LEFT JOIN tsk_task_commits t
        ON t.commit_id      = c.commit_id
),
z AS (
    SELECT
        d.today,
        LPAD(' ', ROW_NUMBER() OVER (ORDER BY d.today), ' ') || d.today AS today_desc
    FROM d
    GROUP BY d.today
)
SELECT
    d.task_id,
    d.commit_id,
    d.commit_message,
    d.commit_url,
    d.created_by,
    d.created_at,
    z.today_desc        AS today
FROM d
JOIN z
    ON z.today = d.today;
--
COMMENT ON TABLE tsk_p500_commits_v IS '';

