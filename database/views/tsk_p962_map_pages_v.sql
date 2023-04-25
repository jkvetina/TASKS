CREATE OR REPLACE FORCE VIEW tsk_p962_map_pages_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_app_id()   AS app_id
    FROM DUAL
)
SELECT
    a.page_id,
    a.page_name,
    a.page_group,
    a.authorization_scheme  AS auth_scheme,
    --
    MAX(CASE WHEN r.r# = 1 THEN p.is_active END) AS role_1,
    MAX(CASE WHEN r.r# = 2 THEN p.is_active END) AS role_2,
    MAX(CASE WHEN r.r# = 3 THEN p.is_active END) AS role_3,
    MAX(CASE WHEN r.r# = 4 THEN p.is_active END) AS role_4,
    MAX(CASE WHEN r.r# = 5 THEN p.is_active END) AS role_5,
    MAX(CASE WHEN r.r# = 6 THEN p.is_active END) AS role_6,
    MAX(CASE WHEN r.r# = 7 THEN p.is_active END) AS role_7,
    MAX(CASE WHEN r.r# = 8 THEN p.is_active END) AS role_8
    --
FROM apex_application_pages a
JOIN x
    ON a.application_id     = x.app_id
    AND a.page_id           NOT IN (0, 9999)
CROSS JOIN tsk_p962_map_pages_cols_v r
LEFT JOIN tsk_auth_pages p
    ON p.role_id        = r.role_id
    AND p.page_id       = a.page_id
GROUP BY
    a.page_id,
    a.page_name,
    a.page_group,
    a.authorization_scheme;
--
COMMENT ON TABLE tsk_p962_map_pages_v IS '';

