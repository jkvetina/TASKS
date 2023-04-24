BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_navigation'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_navigation;
--
MERGE INTO tsk_navigation t
USING (
    SELECT 0 AS page_id, NULL AS parent_id, NULL AS is_hidden, NULL AS is_reset, 666 AS order# FROM DUAL UNION ALL
    SELECT 100 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 100 AS order# FROM DUAL UNION ALL
    SELECT 105 AS page_id, 100 AS parent_id, 'Y' AS is_hidden, 'Y' AS is_reset, 10 AS order# FROM DUAL UNION ALL
    SELECT 200 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 200 AS order# FROM DUAL UNION ALL
    SELECT 230 AS page_id, 200 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 10 AS order# FROM DUAL UNION ALL
    SELECT 250 AS page_id, 200 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 20 AS order# FROM DUAL UNION ALL
    SELECT 270 AS page_id, 200 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 30 AS order# FROM DUAL UNION ALL
    SELECT 300 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 300 AS order# FROM DUAL UNION ALL
    SELECT 400 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 400 AS order# FROM DUAL UNION ALL
    SELECT 500 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 500 AS order# FROM DUAL UNION ALL
    SELECT 510 AS page_id, 500 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 10 AS order# FROM DUAL UNION ALL
    SELECT 515 AS page_id, 500 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 20 AS order# FROM DUAL UNION ALL
    SELECT 900 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 900 AS order# FROM DUAL UNION ALL
    SELECT 950 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 650 AS order# FROM DUAL UNION ALL
    SELECT 952 AS page_id, 950 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 10 AS order# FROM DUAL UNION ALL
    SELECT 956 AS page_id, 950 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 20 AS order# FROM DUAL UNION ALL
    SELECT 958 AS page_id, 950 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 30 AS order# FROM DUAL UNION ALL
    SELECT 960 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 660 AS order# FROM DUAL UNION ALL
    SELECT 962 AS page_id, 960 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 10 AS order# FROM DUAL UNION ALL
    SELECT 964 AS page_id, 960 AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 20 AS order# FROM DUAL UNION ALL
    SELECT 980 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 899 AS order# FROM DUAL UNION ALL
    SELECT 9999 AS page_id, 900 AS parent_id, NULL AS is_hidden, NULL AS is_reset, 90 AS order# FROM DUAL
) s
ON (
    t.page_id = s.page_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.parent_id = s.parent_id,
--        t.is_hidden = s.is_hidden,
--        t.is_reset = s.is_reset,
--        t.order# = s.order#
WHEN NOT MATCHED THEN
    INSERT (
        t.page_id,
        t.parent_id,
        t.is_hidden,
        t.is_reset,
        t.order#
    )
    VALUES (
        s.page_id,
        s.parent_id,
        s.is_hidden,
        s.is_reset,
        s.order#
    );
