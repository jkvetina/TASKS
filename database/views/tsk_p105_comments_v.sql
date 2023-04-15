CREATE OR REPLACE FORCE VIEW tsk_p105_comments_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_user_id() AS user_id
    FROM DUAL
)
SELECT
    -- https://apex.oracle.com/pls/apex/apex_pm/r/ut/comments-report
    c.task_id,
    c.comment_id,
    --
    CASE
        WHEN c.updated_by = x.user_id
            THEN '<span class="fa fa-trash-o" style="color: gray !important; font-size: 100%;"></span>'
        END AS actions,
    --
    '' AS attribute_1,
    '' AS attribute_2,
    '' AS attribute_3,
    '' AS attribute_4,
    --
    CASE WHEN c.updated_at < TRUNC(SYSDATE)
        THEN TO_CHAR(c.updated_at, 'YYYY-MM-DD HH24:MI')
        ELSE APEX_UTIL.GET_SINCE(c.updated_at)
        END AS comment_date,
    --
    CASE WHEN c.updated_by != x.user_id
        THEN 'OTHERS'
        END AS comment_modifiers,
    --
    c.comment_payload   AS comment_text,
    --
    --'u-color-' || ORA_HASH(c.updated_by, 45) AS icon_modifier,
    CASE WHEN c.updated_by = x.user_id
        THEN 'u-color-5'
        ELSE 'u-color-6'
        END AS icon_modifier,
    --
    APEX_STRING.GET_INITIALS(c.updated_by)  AS user_icon,
    --
    CASE WHEN c.updated_by = x.user_id
        THEN NULL
        ELSE INITCAP(c.updated_by)
        END AS user_name
    --
FROM tsk_task_comments c
CROSS JOIN x
ORDER BY
    c.task_id,
    c.comment_id DESC;
--
COMMENT ON TABLE tsk_p105_comments_v IS '';

