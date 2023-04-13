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
    TO_CHAR(c.updated_at, 'YYYY-MM-DD HH24:MI') AS comment_date,
    ''                  AS comment_modifiers,
    c.comment_payload   AS comment_text,
    --
    --'u-color-' || ORA_HASH(c.updated_by, 45) AS icon_modifier,
    '' AS icon_modifier,
    --
    APEX_STRING.GET_INITIALS(c.updated_by)  AS user_icon,
    INITCAP(c.updated_by)                   AS user_name
FROM tsk_task_comments c
CROSS JOIN x
ORDER BY
    c.task_id,
    c.comment_id DESC;
--
COMMENT ON TABLE tsk_p105_comments_v IS '';

