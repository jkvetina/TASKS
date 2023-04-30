CREATE OR REPLACE FORCE VIEW tsk_lov_board_types_v AS
SELECT
    'MY+'                       AS id,
    'My tasks + unassigned'     AS name,
    1                           AS order#
FROM DUAL
--
UNION ALL
SELECT
    'MY'                        AS id,
    'My tasks'                  AS name,
    2                           AS order#
--
-- add actual swimlanes
--
FROM DUAL;
--
COMMENT ON TABLE tsk_lov_board_types_v IS '';

