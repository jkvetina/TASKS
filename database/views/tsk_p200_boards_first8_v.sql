CREATE OR REPLACE FORCE VIEW tsk_p200_boards_first8_v AS
SELECT
    s.status_id,
    s.r#
FROM (
    SELECT
        s.status_id,
        ROW_NUMBER() OVER (ORDER BY s.order# NULLS LAST, s.status_id) AS r#
    FROM tsk_lov_statuses_all_v s
    WHERE s.is_active = 'Y'
) s
WHERE s.r# <= 8;
--
COMMENT ON TABLE tsk_p200_boards_first8_v IS '';

