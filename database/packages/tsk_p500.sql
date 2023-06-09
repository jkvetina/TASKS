CREATE OR REPLACE PACKAGE BODY tsk_p500 AS

    PROCEDURE init_defaults
    AS
    BEGIN
        NULL;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE sync_commits
    AS
        in_project_id   CONSTANT tsk_projects.project_id%TYPE   := tsk_app.get_project_id();
        in_start_date   CONSTANT DATE                           := TRUNC(SYSDATE) - 1;
        in_page_id      CONSTANT NUMBER                         := 1;
        --
        v_response      CLOB;
        repo            tsk_repos%ROWTYPE;
        endpoint        tsk_repo_endpoints%ROWTYPE;
        commits         tsk_task_commits%ROWTYPE;
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
            tsk_tapi.commits(c);

            -- map commits to existing tasks if possible
            FOR t IN (
                SELECT t.task_id
                FROM tsk_tasks t
                WHERE t.project_id = in_project_id
                    AND REGEXP_LIKE(c.commit_message || ' ', '\#(' || TO_CHAR(t.task_id) || '\s)')
            ) LOOP
                commits.task_id     := t.task_id;
                commits.commit_id   := c.commit_id;
                --
                tsk_tapi.task_commits(commits,
                    in_commit_id    => commits.commit_id,
                    in_task_id      => commits.task_id
                );
            END LOOP;
        END LOOP;

        -- update last sync date
        UPDATE tsk_repos r
        SET r.last_synced_at    = SYSDATE
        WHERE r.repo_id         = repo.repo_id
            AND r.owner_id      = repo.owner_id
            AND r.project_id    = in_project_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE sync_commits_job
    AS
    BEGIN
        core.create_session(core.get_owner(), 710, 500);    -- user, app, page
        --
        FOR c IN (
            SELECT
                r.client_id,
                r.project_id
            FROM tsk_repos r
            JOIN tsk_repo_endpoints e
                ON e.owner_id       = r.owner_id
                AND e.repo_id       = r.repo_id
            JOIN tsk_projects p
                ON p.project_id     = r.project_id
                AND p.is_active     = 'Y'
        ) LOOP
            APEX_UTIL.SET_PREFERENCE('CLIENT_ID',   c.client_id);
            APEX_UTIL.SET_PREFERENCE('PROJECT_ID',  c.project_id);
            --
            tsk_p500.sync_commits();
            --
            COMMIT;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_commits
    AS
        rec                 tsk_task_commits%ROWTYPE;
        in_action           CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.commit_id       := core.get_grid_data('COMMIT_ID');
        rec.task_id         := core.get_grid_data('TASK_ID');
        --
        tsk_tapi.task_commits (rec,
            in_action       => in_action,
            in_commit_id    => core.get_grid_data('OLD_COMMIT_ID'),
            in_task_id      => core.get_grid_data('OLD_TASK_ID')
        );

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_COMMIT_ID',     rec.commit_id);
        core.set_grid_data('OLD_TASK_ID',       rec.task_id);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_repos
    AS
        rec                     tsk_repos%ROWTYPE;
        in_action               CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.repo_id             := core.get_grid_data('REPO_ID');
        rec.owner_id            := core.get_grid_data('OWNER_ID');
        rec.client_id           := core.get_grid_data('CLIENT_ID');
        rec.project_id          := core.get_grid_data('PROJECT_ID');
        rec.branch_id           := core.get_grid_data('BRANCH_ID');
        rec.api_type            := core.get_grid_data('API_TYPE');
        rec.api_token           := core.get_grid_data('API_TOKEN');
        rec.last_synced_at      := core.get_date(core.get_grid_data('LAST_SYNCED_AT'));
        --
        tsk_tapi.repos (rec,
            in_action               => in_action,
            in_repo_id              => NVL(core.get_grid_data('OLD_REPO_ID'), rec.repo_id),
            in_owner_id             => NVL(core.get_grid_data('OLD_OWNER_ID'), rec.owner_id)
        );
        --
        IF in_action = 'D' THEN
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_REPO_ID',           rec.repo_id);
        core.set_grid_data('OLD_OWNER_ID',          rec.owner_id);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_repo_endpoints
    AS
        rec                     tsk_repo_endpoints%ROWTYPE;
        in_action               CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.repo_id             := core.get_grid_data('REPO_ID');
        rec.owner_id            := core.get_grid_data('OWNER_ID');
        rec.endpoint_id         := core.get_grid_data('ENDPOINT_ID');
        rec.endpoint_url        := core.get_grid_data('ENDPOINT_URL');
        rec.endpoint_body       := core.get_grid_data('ENDPOINT_BODY');
        rec.endpoint_method     := core.get_grid_data('ENDPOINT_METHOD');
        --
        tsk_tapi.repo_endpoints (rec,
            in_action               => in_action,
            in_repo_id              => NVL(core.get_grid_data('OLD_REPO_ID'), rec.repo_id),
            in_owner_id             => NVL(core.get_grid_data('OLD_OWNER_ID'), rec.owner_id)
        );
        --
        IF in_action = 'D' THEN
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_REPO_ID',           rec.repo_id);
        core.set_grid_data('OLD_OWNER_ID',          rec.owner_id);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

