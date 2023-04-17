CREATE OR REPLACE FORCE VIEW tsk_p105_files_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_number_item('P105_TASK_ID')    AS task_id,
        core.get_user_id()                      AS user_id
    FROM DUAL
)
SELECT
    f.file_id,
    f.file_name,
    f.file_size,
    f.updated_by,
    TO_CHAR(f.updated_at, 'YYYY-MM-DD HH24:MI') AS updated_at,
    --
    NULL AS download_link,
    NULL AS delete_link
    --
FROM tsk_task_files f
JOIN x
    ON x.task_id = f.task_id
ORDER BY
    f.file_id DESC;
--
COMMENT ON TABLE tsk_p105_files_v IS '';

