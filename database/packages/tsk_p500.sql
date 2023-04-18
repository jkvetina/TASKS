CREATE OR REPLACE PACKAGE BODY tsk_p500 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        NULL;
    END;



    PROCEDURE set_header (
        in_id           NUMBER,
        in_name         VARCHAR2,
        in_value        VARCHAR2
    )
    AS
    BEGIN
        IF in_id = 1 THEN
            APEX_WEB_SERVICE.CLEAR_REQUEST_HEADERS;
        END IF;
        --
        APEX_WEB_SERVICE.G_REQUEST_HEADERS(in_id).name  := in_name;
        APEX_WEB_SERVICE.G_REQUEST_HEADERS(in_id).value := in_value;
    END;



    PROCEDURE sync_commits
    AS
        in_project_id   CONSTANT tsk_projects.project_id%TYPE   := core.get_item('P0_PROJECT_ID');
        in_start_date   CONSTANT DATE                           := TRUNC(SYSDATE) - 1;
        in_page_id      CONSTANT NUMBER                         := 1;
        --
        v_response      CLOB;
        repo            tsk_repos%ROWTYPE;
        endpoint        tsk_repo_endpoints%ROWTYPE;
    BEGIN
        -- get repo setting
        BEGIN
            SELECT r.* INTO repo
            FROM tsk_repos r
            JOIN tsk_projects p
                ON p.project_id     = r.project_id
            WHERE p.project_id      = in_project_id;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            core.raise_error('REPO_NOT_FOUND');
        END;
        --
        BEGIN
            SELECT t.* INTO endpoint
            FROM tsk_repo_endpoints t
            WHERE t.repo_id         = repo.repo_id
                AND t.owner_id      = repo.owner_id
                AND t.endpoint_id   = 'COMMITS';
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            core.raise_error('ENDPOINT_NOT_FOUND');
        END;

        -- adjust request
        endpoint.endpoint_url := REPLACE(endpoint.endpoint_url, '#OWNER_ID#',       repo.owner_id);
        endpoint.endpoint_url := REPLACE(endpoint.endpoint_url, '#REPO_ID#',        repo.repo_id);
        endpoint.endpoint_url := REPLACE(endpoint.endpoint_url, '#BRANCH_ID#',      NULLIF('&' || 'sha=' || repo.branch_id, '&' || 'sha='));
        endpoint.endpoint_url := REPLACE(endpoint.endpoint_url, '#START_DATE#',     TO_CHAR(in_start_date, 'YYYY-MM-DD'));
        endpoint.endpoint_url := REPLACE(endpoint.endpoint_url, '#PAGE_ID#',        in_page_id);

        -- init request
        set_header(1, 'Authorization',  'Bearer ' || repo.api_token);
        set_header(2, 'User-Agent',     'Mozilla');
        set_header(3, 'Content-Type',   'application/json; charset=utf-8');

        -- get response
        v_response := APEX_WEB_SERVICE.MAKE_REST_REQUEST (
            p_url           => endpoint.endpoint_url,
            p_http_method   => endpoint.endpoint_method,
            p_body          => endpoint.endpoint_body
        );

        -- store response in table
        FOR c IN (
            SELECT
                t.commit_id,
                t.commit_message,
                t.commit_url,
                repo.repo_id,
                repo.owner_id,
                t.created_by,
                core.get_date(REPLACE(REPLACE(t.created_at, 'T', ' '), 'Z', '')) AS created_at
                --
            FROM JSON_TABLE(v_response, '$[*]'
                COLUMNS (
                    commit_id       VARCHAR2(64)    PATH '$.sha',
                    commit_message  VARCHAR2(2000)  PATH '$.commit.message',
                    commit_url      VARCHAR2(2000)  PATH '$.html_url',
                    created_by      VARCHAR2(128)   PATH '$.commit.author.email',
                    created_at      VARCHAR2(32)    PATH '$.commit.author.date'
                )
            ) AS t
        ) LOOP
            BEGIN
                INSERT INTO tsk_commits VALUES c;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;
            END;

            -- map commits to existing tasks if possible
            FOR t IN (
                SELECT t.task_id
                FROM tsk_tasks t
                WHERE t.project_id = in_project_id
                    AND REGEXP_LIKE(c.commit_message || ' ', '\#(' || TO_CHAR(t.task_id) || '\s)')
            ) LOOP
                BEGIN
                    INSERT INTO tsk_task_commits (task_id, commit_id, updated_by, updated_at)
                    VALUES (
                        t.task_id,
                        c.commit_id,
                        c.created_by,
                        c.created_at
                    );
                EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    NULL;
                END;
            END LOOP;
        END LOOP;

        -- update last sync date
        UPDATE tsk_repos r
        SET r.last_synced_at    = SYSDATE
        WHERE r.repo_id         = repo.repo_id
            AND r.owner_id      = repo.owner_id
            AND r.project_id    = in_project_id;
    END;



    PROCEDURE save_commits (
        io_commit_id        IN OUT NOCOPY   VARCHAR2,
        io_task_id          IN OUT NOCOPY   VARCHAR2
    )
    AS
        v_action            CHAR;
        rec                 tsk_task_commits%ROWTYPE;
    BEGIN
        v_action            := APEX_UTIL.GET_SESSION_STATE('APEX$ROW_STATUS');
        --
        rec.commit_id       := APEX_UTIL.GET_SESSION_STATE('COMMIT_ID');
        rec.task_id         := APEX_UTIL.GET_SESSION_STATE('TASK_ID');
        --
        rec.updated_by      := core.get_user_id();
        rec.updated_at      := SYSDATE;
        --
        IF (v_action = 'D' OR rec.task_id IS NULL) THEN
            DELETE FROM tsk_task_commits t
            WHERE t.commit_id   = io_commit_id
                AND t.task_id   = io_task_id;
            --
            RETURN;
        END IF;
        --
        BEGIN
            INSERT INTO tsk_task_commits
            VALUES rec;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            NULL;
        END;

        -- update keys to APEX
        io_commit_id        := rec.commit_id;
        io_task_id          := rec.task_id;
    END;

END;
/

