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
    SELECT 0 AS page_id, NULL AS parent_id, 666 AS order#, NULL AS is_hidden, NULL AS is_reset FROM DUAL UNION ALL
    SELECT 100 AS page_id, NULL AS parent_id, 100 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 105 AS page_id, 100 AS parent_id, 10 AS order#, 'Y' AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 200 AS page_id, NULL AS parent_id, 200 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 230 AS page_id, 200 AS parent_id, 10 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 250 AS page_id, 200 AS parent_id, 20 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 270 AS page_id, 200 AS parent_id, 30 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 300 AS page_id, NULL AS parent_id, 300 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 400 AS page_id, NULL AS parent_id, 400 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 500 AS page_id, NULL AS parent_id, 500 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 510 AS page_id, 500 AS parent_id, 10 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 900 AS page_id, NULL AS parent_id, 900 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 980 AS page_id, NULL AS parent_id, 899 AS order#, NULL AS is_hidden, 'Y' AS is_reset FROM DUAL UNION ALL
    SELECT 9999 AS page_id, 900 AS parent_id, 90 AS order#, NULL AS is_hidden, NULL AS is_reset FROM DUAL
) s
ON (
    t.page_id = s.page_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.parent_id = s.parent_id,
--        t.order# = s.order#,
--        t.is_hidden = s.is_hidden,
--        t.is_reset = s.is_reset
WHEN NOT MATCHED THEN
    INSERT (
        t.page_id,
        t.parent_id,
        t.order#,
        t.is_hidden,
        t.is_reset
    )
    VALUES (
        s.page_id,
        s.parent_id,
        s.order#,
        s.is_hidden,
        s.is_reset
    );
