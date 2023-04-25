CREATE OR REPLACE FORCE VIEW tsk_p952_map_users_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$CLIENT_ID')     AS client_id,
        --core.get_item('$PROJECT_ID')    AS project_id,
        core.get_item('$SHOW_ALL')      AS show_all
    FROM DUAL
)
SELECT
    x.client_id,
    t.user_id,
    t.user_name,
    t.user_mail,
    a.is_active
FROM tsk_users t
CROSS JOIN x
LEFT JOIN tsk_auth_users a
    ON a.client_id      = x.client_id
    AND a.user_id       = t.user_id
WHERE 1 = 1
    AND t.is_active     = 'Y'
    AND (
        x.show_all      IS NOT NULL
        OR a.user_id    IS NOT NULL
    );
--
COMMENT ON TABLE tsk_p952_map_users_v IS '';

