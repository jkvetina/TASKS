BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('tsk_repo_endpoints'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM tsk_repo_endpoints;
--
MERGE INTO tsk_repo_endpoints t
USING (
    SELECT 'tasks' AS repo_id, 'jkvetina' AS owner_id, 'COMMITS' AS endpoint_id, 'https://api.github.com/repos/#OWNER_ID#/#REPO_ID#/commits?since=#START_DATE#T00:00:00Z&per_page=100&page=#PAGE_ID##BRANCH_ID#' AS endpoint_url, NULL AS endpoint_body, 'GET' AS endpoint_method FROM DUAL
) s
ON (
    t.repo_id = s.repo_id
    AND t.owner_id = s.owner_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.endpoint_id = s.endpoint_id,
--        t.endpoint_url = s.endpoint_url,
--        t.endpoint_body = s.endpoint_body,
--        t.endpoint_method = s.endpoint_method
WHEN NOT MATCHED THEN
    INSERT (
        t.repo_id,
        t.owner_id,
        t.endpoint_id,
        t.endpoint_url,
        t.endpoint_body,
        t.endpoint_method
    )
    VALUES (
        s.repo_id,
        s.owner_id,
        s.endpoint_id,
        s.endpoint_url,
        s.endpoint_body,
        s.endpoint_method
    );
