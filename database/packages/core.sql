CREATE OR REPLACE PACKAGE BODY core AS

    FUNCTION get_owner (
        in_app_id               NUMBER
    )
    RETURN VARCHAR2
    AS
        out_owner               apex_applications.owner%TYPE;
    BEGIN
        SELECT a.owner INTO out_owner
        FROM apex_applications a
        WHERE a.application_id = in_app_id;
        --
        RETURN out_owner;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION get_owner
    RETURN VARCHAR2
    AS
        out_owner               apex_applications.owner%TYPE;
    BEGIN
        RETURN COALESCE(core.get_owner(core.get_app_id()), APEX_UTIL.GET_DEFAULT_SCHEMA, USER);
    END;



    FUNCTION get_app_id
    RETURN NUMBER
    AS
    BEGIN
        RETURN APEX_APPLICATION.G_FLOW_ID;
    END;



    FUNCTION get_user_id
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN COALESCE (
            APEX_APPLICATION.G_USER,
            SYS_CONTEXT('USERENV', 'PROXY_USER'),
            SYS_CONTEXT('USERENV', 'SESSION_USER'),
            USER
        );
    END;



    FUNCTION get_user_lang
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN REPLACE(UPPER(SUBSTR(OWA_UTIL.GET_CGI_ENV('HTTP_ACCEPT_LANGUAGE'), 1, 2)), 'CS', 'CZ');
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'EN';
    END;



    FUNCTION is_developer (
        in_user                 VARCHAR2        := NULL
    )
    RETURN BOOLEAN
    AS
        is_valid                CHAR;
    BEGIN
        WITH u AS (
            SELECT core.get_user_id() AS user_id    FROM DUAL UNION ALL
            SELECT in_user                          FROM DUAL
        )
        SELECT 'Y' INTO is_valid
        FROM apex_workspace_developers d
        JOIN apex_applications a
            ON a.workspace                  = d.workspace_name
        JOIN u
            ON UPPER(u.user_id)             IN (UPPER(d.user_name), UPPER(d.email))
        WHERE a.application_id              = core.get_app_id()
            AND d.is_application_developer  = 'Yes'
            AND d.account_locked            = 'No'
            AND ROWNUM                      = 1;
        --
        RETURN TRUE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END;



    FUNCTION is_developer_y (
        in_user                 VARCHAR2        := NULL
    )
    RETURN CHAR
    AS
    BEGIN
        RETURN CASE WHEN core.is_developer(in_user) THEN 'Y' END;
    END;



    FUNCTION is_debug_on
    RETURN BOOLEAN
    AS
    BEGIN
        RETURN APEX_APPLICATION.G_DEBUG;
    END;



    PROCEDURE set_debug (
        in_status               BOOLEAN                     := TRUE
    )
    AS
    BEGIN
        APEX_APPLICATION.G_DEBUG := in_status;
        DBMS_OUTPUT.PUT_LINE('DEBUG: ' || CASE WHEN core.is_debug_on() THEN 'ON' ELSE 'OFF' END);
    END;



    PROCEDURE create_session (
        in_user_id              VARCHAR2,
        in_app_id               NUMBER,
        in_page_id              NUMBER      := NULL,
        in_session_id           NUMBER      := NULL,
        in_items                VARCHAR2    := NULL
    ) AS
        PRAGMA AUTONOMOUS_TRANSACTION;
        --
        v_workspace_id          apex_applications.workspace%TYPE;
        v_user_name             apex_workspace_sessions.user_name%TYPE;
    BEGIN
        -- create session from SQL Developer (not from APEX)
        SELECT MAX(s.user_name) INTO v_user_name
        FROM apex_workspace_sessions s
        WHERE s.apex_session_id = COALESCE(in_session_id, core.get_session_id());
        --
        IF ((v_user_name = core.get_user_id() AND in_app_id = core.get_app_id()) OR in_session_id != core.get_session_id()) THEN
            -- use existing session if possible
            IF (in_session_id > 0 OR in_session_id IS NULL) THEN
                BEGIN
                    APEX_SESSION.ATTACH (
                        p_app_id        => core.get_app_id(),
                        p_page_id       => NVL(in_page_id, 0),
                        p_session_id    => COALESCE(in_session_id, core.get_session_id())
                    );
                EXCEPTION
                WHEN OTHERS THEN
                    core.raise_error('ATTACH_SESSION_FAILED', in_app_id, v_user_name, COALESCE(in_session_id, core.get_session_id()));
                END;
            END IF;
        ELSE
            -- find and setup workspace
            BEGIN
                SELECT a.workspace INTO v_workspace_id
                FROM apex_applications a
                WHERE a.application_id = in_app_id;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                core.raise_error('INVALID_APP', in_app_id);
            END;
            --
            APEX_UTIL.SET_WORKSPACE (
                p_workspace => v_workspace_id
            );
            APEX_UTIL.SET_SECURITY_GROUP_ID (
                p_security_group_id => APEX_UTIL.FIND_SECURITY_GROUP_ID(p_workspace => v_workspace_id)
            );
        END IF;

        -- set username
        APEX_UTIL.SET_USERNAME (
            p_userid    => APEX_UTIL.GET_USER_ID(v_user_name),
            p_username  => v_user_name
        );

        -- create new APEX session
        IF (core.get_session_id() IS NULL OR in_session_id = 0) THEN
            BEGIN
                APEX_SESSION.CREATE_SESSION (
                    p_app_id    => in_app_id,
                    p_page_id   => NVL(in_page_id, 0),
                    p_username  => in_user_id
                );
            EXCEPTION
            WHEN OTHERS THEN
                core.raise_error('CREATE_SESSION_FAILED', in_app_id, in_user_id);
            END;
        END IF;
        --
        DBMS_OUTPUT.PUT_LINE('--');
        DBMS_OUTPUT.PUT_LINE('SESSION: ' || core.get_app_id() || ' | ' || core.get_page_id() || ' | ' || core.get_session_id() || ' | ' || core.get_user_id());
        DBMS_OUTPUT.PUT_LINE('--');

        -- print app and page items
        FOR c IN (
            SELECT
                i.item_name,
                core.get_item(i.item_name) AS item_value
            FROM apex_application_items i
            WHERE i.application_id      = in_app_id
            UNION ALL
            SELECT
                i.item_name,
                core.get_item(i.item_name) AS item_value
            FROM apex_application_page_items i
            WHERE i.application_id      = in_app_id
                AND i.page_id           = in_page_id
            ORDER BY 1
        ) LOOP
            IF c.item_value IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('  ' || RPAD(c.item_name, 30) || ' = ' || c.item_value);
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('--');
        --
        COMMIT;
    EXCEPTION
    WHEN core.app_exception THEN
        ROLLBACK;
        RAISE;
    WHEN APEX_APPLICATION.E_STOP_APEX_ENGINE THEN
        COMMIT;
    WHEN OTHERS THEN
        ROLLBACK;
        core.raise_error();
    END;



    PROCEDURE exit_session
    AS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        DBMS_SESSION.CLEAR_IDENTIFIER();
        --DBMS_SESSION.CLEAR_ALL_CONTEXT(namespace);
        --DBMS_SESSION.RESET_PACKAGE;  -- avoid ORA-04068 exception
        --
        DBMS_APPLICATION_INFO.SET_MODULE (
            module_name     => NULL,
            action_name     => NULL
        );
        --
        COMMIT;
    EXCEPTION
    WHEN core.app_exception THEN
        ROLLBACK;
        RAISE;
    WHEN OTHERS THEN
        ROLLBACK;
        core.raise_error();
    END;



    PROCEDURE set_action (
        in_action_name          VARCHAR2,
        in_module_name          VARCHAR2        := NULL
    ) AS
    BEGIN
        IF in_module_name IS NOT NULL THEN
            DBMS_APPLICATION_INFO.SET_MODULE(in_module_name, in_action_name);   -- USERENV.MODULE, USERENV.ACTION
        END IF;
        --
        IF in_action_name IS NOT NULL THEN
            DBMS_APPLICATION_INFO.SET_ACTION(in_action_name);                   -- USERENV.ACTION
        END IF;
    END;



    FUNCTION get_session_id
    RETURN NUMBER
    AS
    BEGIN
        RETURN SYS_CONTEXT('APEX$SESSION', 'APP_SESSION');  -- APEX_APPLICATION.G_INSTANCE
    END;



    FUNCTION get_client_id (
        in_user_id              VARCHAR2        := NULL
    )
    RETURN VARCHAR2 AS          -- mimic APEX client_id
    BEGIN
        RETURN
            COALESCE(in_user_id, core.get_user_id()) || ':' ||
            COALESCE(core.get_session_id(), SYS_CONTEXT('USERENV', 'SESSIONID')
        );
    END;



    FUNCTION get_env_name
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN SYS_CONTEXT('USERENV', 'SERVER_HOST') || '/' || SYS_CONTEXT('USERENV', 'INSTANCE_NAME');
    END;



    FUNCTION get_page_id
    RETURN NUMBER
    AS
    BEGIN
        RETURN APEX_APPLICATION.G_FLOW_STEP_ID;
    END;



    FUNCTION get_page_group (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL
    )
    RETURN apex_application_pages.page_group%TYPE
    AS
        out_name                apex_application_pages.page_group%TYPE;
    BEGIN
        SELECT p.page_group INTO out_name
        FROM apex_application_pages p
        WHERE p.application_id      = COALESCE(in_app_id, core.get_app_id())
            AND p.page_id           = COALESCE(in_page_id, core.get_page_id());
        --
        RETURN out_name;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION get_page_name (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL,
        in_name                 VARCHAR2    := NULL
    )
    RETURN VARCHAR2
    AS
        out_name                apex_application_pages.page_name%TYPE       := in_name;
        out_search              apex_application_pages.page_name%TYPE;
    BEGIN
        IF out_name IS NULL THEN
            SELECT p.page_name INTO out_name
            FROM apex_application_pages p
            WHERE p.application_id      = COALESCE(in_app_id, core.get_app_id())
                AND p.page_id           = COALESCE(in_page_id, core.get_page_id());
        END IF;

        -- transform icons
        FOR i IN 1 .. NVL(REGEXP_COUNT(out_name, '(#fa-)'), 0) + 1 LOOP
            out_search  := REGEXP_SUBSTR(out_name, '(#fa-[[:alnum:]+_-]+\s*)+');
            out_name    := REPLACE (
                out_name,
                out_search,
                ' &' || 'nbsp; <span class="fa' || REPLACE(REPLACE(out_search, '#fa-', '+'), '+', ' fa-') || '"></span> &' || 'nbsp; '
            );
        END LOOP;
        --
        RETURN REGEXP_REPLACE(out_name, '((^\s*&' || 'nbsp;\s*)|(\s*&' || 'nbsp;\s*$))', '');  -- trim hard spaces
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION get_page_title (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL,
        in_title                VARCHAR2    := NULL
    )
    RETURN VARCHAR2
    AS
        out_title               apex_application_pages.page_title%TYPE      := in_title;
    BEGIN
        IF out_title IS NULL THEN
            SELECT p.page_title INTO out_title
            FROM apex_application_pages p
            WHERE p.application_id      = COALESCE(in_app_id, core.get_app_id())
                AND p.page_id           = COALESCE(in_page_id, core.get_page_id());
        END IF;
        --
        RETURN out_title;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION get_page_url (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL,
        in_names                VARCHAR2    := NULL,
        in_values               VARCHAR2    := NULL,
        in_overload             VARCHAR2    := NULL,    -- JSON object to overload passed items/values
        in_session_id           NUMBER      := NULL,
        in_reset                CHAR        := 'Y'      -- reset page items
    )
    RETURN VARCHAR2
    AS
        out_names               VARCHAR2(32767) := in_names;
        out_values              VARCHAR2(32767) := in_values;
    BEGIN
        -- autofill missing values
        IF in_names IS NOT NULL AND in_values IS NULL THEN
            FOR c IN (
                SELECT item_name
                FROM (
                    SELECT DISTINCT REGEXP_SUBSTR(in_names, '[^,]+', 1, LEVEL) AS item_name, LEVEL AS order#
                    FROM DUAL
                    CONNECT BY LEVEL <= REGEXP_COUNT(in_names, ',') + 1
                )
                ORDER BY order# DESC
            ) LOOP
                out_values := core.get_item(c.item_name) || ',' || out_values;
            END LOOP;
        END IF;

        -- generate url
        RETURN APEX_PAGE.GET_URL (
            p_application       => in_app_id,
            p_session           => COALESCE(in_session_id, core.get_session_id()),
            p_page              => COALESCE(in_page_id, core.get_page_id()),
            p_clear_cache       => CASE WHEN in_reset = 'Y' THEN COALESCE(in_page_id, core.get_page_id()) END,
            p_items             => out_names,
            p_values            => NULLIF(out_values, 'NULL')
            /*
            p_request            IN VARCHAR2 DEFAULT NULL,
            p_debug              IN VARCHAR2 DEFAULT NULL,
            p_printer_friendly   IN VARCHAR2 DEFAULT NULL,
            p_trace              IN VARCHAR2 DEFAULT NULL,
            p_triggering_element IN VARCHAR2 DEFAULT 'this',
            p_plain_url          IN BOOLEAN DEFAULT FALSE
            */
        );
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION get_request_url (
        in_arguments_only       BOOLEAN                     := FALSE
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN RTRIM(CASE WHEN NOT in_arguments_only
            THEN UTL_URL.UNESCAPE (
                OWA_UTIL.GET_CGI_ENV('SCRIPT_NAME') ||
                OWA_UTIL.GET_CGI_ENV('PATH_INFO')   || '?'
            ) END ||
            UTL_URL.UNESCAPE(OWA_UTIL.GET_CGI_ENV('QUERY_STRING')), '?');
    EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
    END;



    FUNCTION get_request
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN APEX_APPLICATION.G_REQUEST;
    END;



    FUNCTION get_icon (
        in_name                 VARCHAR2,
        in_title                VARCHAR2    := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN '<span class="fa ' || in_name || '" title="' || in_title || '"></span>';
    END;



    FUNCTION get_item_name (
        in_name                 apex_application_page_items.item_name%TYPE,
        in_page_id              apex_application_page_items.page_id%TYPE            := NULL,
        in_app_id               apex_application_page_items.application_id%TYPE     := NULL
    )
    RETURN VARCHAR2
    AS
        v_item_name             apex_application_page_items.item_name%TYPE;
        v_page_id               apex_application_page_items.page_id%TYPE;
        v_app_id                apex_application_page_items.application_id%TYPE;
        is_valid                CHAR;
    BEGIN
        v_app_id        := NVL(in_app_id, core.get_app_id());
        v_page_id       := NVL(in_page_id, core.get_page_id());
        v_item_name     := REPLACE(in_name, c_page_item_wild, c_page_item_prefix || v_page_id || '_');

        -- check if item exists
        BEGIN
            SELECT 'Y' INTO is_valid
            FROM apex_application_page_items p
            WHERE p.application_id      = v_app_id
                AND p.page_id           IN (0, v_page_id)
                AND p.item_name         = v_item_name;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            BEGIN
                SELECT 'Y' INTO is_valid
                FROM apex_application_items g
                WHERE g.application_id      = v_app_id
                    AND g.item_name         = in_name;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN NULL;
            END;
        END;
        --
        RETURN v_item_name;
    END;



    FUNCTION get_item (
        in_name                 VARCHAR2
    )
    RETURN VARCHAR2
    AS
        v_item_name             apex_application_page_items.item_name%TYPE;
    BEGIN
        v_item_name := core.get_item_name(in_name);

        -- check item existence to avoid hidden errors
        IF v_item_name IS NOT NULL THEN
            RETURN APEX_UTIL.GET_SESSION_STATE(v_item_name);
        END IF;
        --
        RETURN NULL;
    END;



    FUNCTION get_number_item (
        in_name                 VARCHAR2
    )
    RETURN NUMBER
    AS
    BEGIN
        RETURN TO_NUMBER(core.get_item(in_name));
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error('INVALID_NUMBER', in_name, core.get_item(in_name));
    END;



    FUNCTION get_date_item (
        in_name                 VARCHAR2,
        in_format               VARCHAR2        := NULL
    )
    RETURN DATE
    AS
    BEGIN
        RETURN core.get_date(core.get_item(in_name), in_format);
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error('INVALID_DATE', in_name, core.get_item(in_name), in_format);
    END;



    FUNCTION get_date (
        in_value                VARCHAR2,
        in_format               VARCHAR2        := NULL
    )
    RETURN DATE
    AS
        l_value                 VARCHAR2(30)    := SUBSTR(REPLACE(in_value, 'T', ' '), 1, 30);
    BEGIN
        IF in_format IS NOT NULL THEN
            BEGIN
                RETURN TO_DATE(l_value, in_format);
            EXCEPTION
            WHEN OTHERS THEN
                core.raise_error('INVALID_DATE', in_value, in_format);
            END;
        END IF;

        -- try different formats
        BEGIN
            RETURN TO_DATE(l_value, c_format_date_time);                        -- YYYY-MM-DD HH24:MI:SS
        EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                RETURN TO_DATE(l_value, c_format_date_short);                   -- YYYY-MM-DD HH24:MI
            EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    RETURN TO_DATE(SUBSTR(l_value, 1, 10), c_format_date);      -- YYYY-MM-DD
                EXCEPTION
                WHEN OTHERS THEN
                    BEGIN
                        RETURN TO_DATE(SUBSTR(REPLACE(l_value, '.', '/'), 1, 10), 'DD/MM/YYYY');
--
-- @TODO: V('APP_NLS_DATE_FORMAT')
--
                    EXCEPTION
                    WHEN OTHERS THEN
                        core.raise_error('INVALID_DATE', in_value, in_format);
                    END;
                END;
            END;
        END;
    END;



    FUNCTION get_date (
        in_date                 DATE            := NULL,
        in_format               VARCHAR2        := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN TO_CHAR(COALESCE(in_date, SYSDATE), NVL(in_format, c_format_date));
    END;



    FUNCTION get_date_time (
        in_date                 DATE            := NULL,
        in_format               VARCHAR2        := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN TO_CHAR(COALESCE(in_date, SYSDATE), NVL(in_format, c_format_date_time));
    END;



    FUNCTION get_time_bucket (
        in_date                 DATE,
        in_interval             NUMBER
    )
    RETURN NUMBER
    RESULT_CACHE
    AS
        PRAGMA UDF;
    BEGIN
        RETURN FLOOR((in_date - TRUNC(in_date)) * 1440 / in_interval) + 1;
    END;



    FUNCTION get_duration (
        in_interval             INTERVAL DAY TO SECOND
    )
    RETURN VARCHAR2 AS
    BEGIN
        RETURN REGEXP_SUBSTR(in_interval, '(\d{2}:\d{2}:\d{2}\.\d{3})');
    END;



    FUNCTION get_duration (
        in_interval             NUMBER
    )
    RETURN VARCHAR2 AS
    BEGIN
        RETURN TO_CHAR(TRUNC(SYSDATE) + in_interval, 'HH24:MI:SS');
    END;



    FUNCTION get_duration (
        in_start                TIMESTAMP,
        in_end                  TIMESTAMP       := NULL
    )
    RETURN VARCHAR2
    AS
        v_end                   CONSTANT TIMESTAMP := SYSTIMESTAMP;  -- to prevent timezone shift, APEX_UTIL.GET_SESSION_TIME_ZONE
    BEGIN
        RETURN SUBSTR(TO_CHAR(COALESCE(in_end, v_end) - in_start), 12, 12);     -- keep 00:00:00.000
    END;



    PROCEDURE set_item (
        in_name                 VARCHAR2,
        in_value                VARCHAR2        := NULL
    )
    AS
        v_item_name             apex_application_page_items.item_name%TYPE;
    BEGIN
        v_item_name := core.get_item_name(in_name);
        --
        IF v_item_name IS NOT NULL THEN
            BEGIN
                APEX_UTIL.SET_SESSION_STATE (
                    p_name      => v_item_name,
                    p_value     => in_value,
                    p_commit    => FALSE
                );
            EXCEPTION
            WHEN OTHERS THEN
                core.raise_error('ITEM_MISSING', v_item_name, in_name);
            END;
        END IF;
    END;



    PROCEDURE set_date_item (
        in_name                 VARCHAR2,
        in_value                DATE
    )
    AS
    BEGIN
        core.set_item (
            in_name             => in_name,
            in_value            => TO_CHAR(in_value, c_format_date_time)
        );
    END;



    PROCEDURE clear_items
    AS
        req VARCHAR2(32767) := core.get_request_url();
    BEGIN
        -- delete page items one by one, except items passed in url (query string)
        FOR c IN (
            SELECT i.item_name
            FROM apex_application_page_items i
            WHERE i.application_id  = core.get_app_id()
                AND i.page_id       = core.get_page_id()
                AND (
                    NOT REGEXP_LIKE(req, '[:,]' || i.item_name || '[,:]')       -- for legacy
                    AND NOT REGEXP_LIKE(req, LOWER(i.item_name) || '[=&]')      -- for friendly url
                )
        ) LOOP
            core.set_item (
                in_name     => c.item_name,
                in_value    => NULL
            );
        END LOOP;
    END;



    FUNCTION get_page_items (
        in_page_id              NUMBER      := NULL,
        in_filter               VARCHAR2    := '%'
    )
    RETURN VARCHAR2
    AS
        out_payload             VARCHAR2(32767);
    BEGIN
        SELECT JSON_OBJECTAGG(t.item_name VALUE APEX_UTIL.GET_SESSION_STATE(t.item_name) ABSENT ON NULL)
        INTO out_payload
        FROM apex_application_page_items t
        WHERE t.application_id  = core.get_app_id()
            AND t.page_id       = COALESCE(in_page_id, core.get_page_id())
            AND t.item_name     LIKE in_filter;
        --
        RETURN out_payload;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    FUNCTION get_global_items (
        in_filter               VARCHAR2    := '%'
    )
    RETURN VARCHAR2
    AS
        out_payload             VARCHAR2(32767);
    BEGIN
        SELECT JSON_OBJECTAGG(t.item_name VALUE APEX_UTIL.GET_SESSION_STATE(t.item_name) ABSENT ON NULL)
        INTO out_payload
        FROM apex_application_items t
        WHERE t.application_id  = core.get_app_id()
            AND t.item_name     LIKE in_filter;
        --
        RETURN out_payload;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;



    PROCEDURE apply_items (
        in_items                VARCHAR2
    )
    AS
        json_keys               JSON_KEY_LIST;
    BEGIN
        IF in_items IS NULL THEN
            RETURN;
        END IF;
        --
        json_keys := JSON_OBJECT_T(in_items).get_keys();
        --
        FOR i IN 1 .. json_keys.COUNT LOOP
            BEGIN
                core.set_item(json_keys(i), JSON_VALUE(in_items, '$.' || json_keys(i)));
            EXCEPTION
            WHEN OTHERS THEN
                NULL;
            END;
        END LOOP;
    END;



    FUNCTION get_json_list (
        in_arg1                 VARCHAR2    := NULL,
        in_arg2                 VARCHAR2    := NULL,
        in_arg3                 VARCHAR2    := NULL,
        in_arg4                 VARCHAR2    := NULL,
        in_arg5                 VARCHAR2    := NULL,
        in_arg6                 VARCHAR2    := NULL,
        in_arg7                 VARCHAR2    := NULL,
        in_arg8                 VARCHAR2    := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN NULLIF(REGEXP_REPLACE(
            REGEXP_REPLACE(
                NULLIF(JSON_ARRAY(in_arg1, in_arg2, in_arg3, in_arg4, in_arg5, in_arg6, in_arg7, in_arg8 NULL ON NULL), '[]'),
                '"(\d+)([.,]\d+)?"', '\1\2'  -- convert to numbers if possible
            ),
            '(,null)+\]$', ']'),  -- strip NULLs from the right side
            '[null]');
    END;



    FUNCTION get_json_object (
        in_name01   VARCHAR2 := NULL,           in_value01  VARCHAR2 := NULL,
        in_name02   VARCHAR2 := NULL,           in_value02  VARCHAR2 := NULL,
        in_name03   VARCHAR2 := NULL,           in_value03  VARCHAR2 := NULL,
        in_name04   VARCHAR2 := NULL,           in_value04  VARCHAR2 := NULL,
        in_name05   VARCHAR2 := NULL,           in_value05  VARCHAR2 := NULL,
        in_name06   VARCHAR2 := NULL,           in_value06  VARCHAR2 := NULL,
        in_name07   VARCHAR2 := NULL,           in_value07  VARCHAR2 := NULL,
        in_name08   VARCHAR2 := NULL,           in_value08  VARCHAR2 := NULL,
        in_name09   VARCHAR2 := NULL,           in_value09  VARCHAR2 := NULL,
        in_name10   VARCHAR2 := NULL,           in_value10  VARCHAR2 := NULL,
        in_name11   VARCHAR2 := NULL,           in_value11  VARCHAR2 := NULL,
        in_name12   VARCHAR2 := NULL,           in_value12  VARCHAR2 := NULL,
        in_name13   VARCHAR2 := NULL,           in_value13  VARCHAR2 := NULL,
        in_name14   VARCHAR2 := NULL,           in_value14  VARCHAR2 := NULL,
        in_name15   VARCHAR2 := NULL,           in_value15  VARCHAR2 := NULL,
        in_name16   VARCHAR2 := NULL,           in_value16  VARCHAR2 := NULL,
        in_name17   VARCHAR2 := NULL,           in_value17  VARCHAR2 := NULL,
        in_name18   VARCHAR2 := NULL,           in_value18  VARCHAR2 := NULL,
        in_name19   VARCHAR2 := NULL,           in_value19  VARCHAR2 := NULL,
        in_name20   VARCHAR2 := NULL,           in_value20  VARCHAR2 := NULL
    )
    RETURN VARCHAR2
    AS
        v_obj                   JSON_OBJECT_T;
    BEGIN
        -- construct a key-value pairs
        v_obj := JSON_OBJECT_T(JSON_OBJECT (
            CASE WHEN (in_name01 IS NULL OR in_value01 IS NULL) THEN '__' ELSE in_name01 END VALUE in_value01,
            CASE WHEN (in_name02 IS NULL OR in_value02 IS NULL) THEN '__' ELSE in_name02 END VALUE in_value02,
            CASE WHEN (in_name03 IS NULL OR in_value03 IS NULL) THEN '__' ELSE in_name03 END VALUE in_value03,
            CASE WHEN (in_name04 IS NULL OR in_value04 IS NULL) THEN '__' ELSE in_name04 END VALUE in_value04,
            CASE WHEN (in_name05 IS NULL OR in_value05 IS NULL) THEN '__' ELSE in_name05 END VALUE in_value05,
            CASE WHEN (in_name06 IS NULL OR in_value06 IS NULL) THEN '__' ELSE in_name06 END VALUE in_value06,
            CASE WHEN (in_name07 IS NULL OR in_value07 IS NULL) THEN '__' ELSE in_name07 END VALUE in_value07,
            CASE WHEN (in_name08 IS NULL OR in_value08 IS NULL) THEN '__' ELSE in_name08 END VALUE in_value08,
            CASE WHEN (in_name09 IS NULL OR in_value09 IS NULL) THEN '__' ELSE in_name09 END VALUE in_value09,
            CASE WHEN (in_name10 IS NULL OR in_value10 IS NULL) THEN '__' ELSE in_name10 END VALUE in_value10,
            CASE WHEN (in_name11 IS NULL OR in_value11 IS NULL) THEN '__' ELSE in_name11 END VALUE in_value11,
            CASE WHEN (in_name12 IS NULL OR in_value12 IS NULL) THEN '__' ELSE in_name12 END VALUE in_value12,
            CASE WHEN (in_name13 IS NULL OR in_value13 IS NULL) THEN '__' ELSE in_name13 END VALUE in_value13,
            CASE WHEN (in_name14 IS NULL OR in_value14 IS NULL) THEN '__' ELSE in_name14 END VALUE in_value14,
            CASE WHEN (in_name15 IS NULL OR in_value15 IS NULL) THEN '__' ELSE in_name15 END VALUE in_value15,
            CASE WHEN (in_name16 IS NULL OR in_value16 IS NULL) THEN '__' ELSE in_name16 END VALUE in_value16,
            CASE WHEN (in_name17 IS NULL OR in_value17 IS NULL) THEN '__' ELSE in_name17 END VALUE in_value17,
            CASE WHEN (in_name18 IS NULL OR in_value18 IS NULL) THEN '__' ELSE in_name18 END VALUE in_value18,
            CASE WHEN (in_name19 IS NULL OR in_value19 IS NULL) THEN '__' ELSE in_name19 END VALUE in_value19,
            CASE WHEN (in_name20 IS NULL OR in_value20 IS NULL) THEN '__' ELSE in_name20 END VALUE in_value20
        ));
        v_obj.REMOVE('__');     -- remove empty pairs
        --
        RETURN NULLIF(v_obj.STRINGIFY, '{}');
    END;



    PROCEDURE create_job (
        in_job_name             VARCHAR2,
        in_statement            VARCHAR2,
        in_user_id              VARCHAR2        := NULL,
        in_app_id               NUMBER          := NULL,
        in_session_id           NUMBER          := NULL,
        in_priority             PLS_INTEGER     := NULL,
        in_start_date           DATE            := NULL,
        in_enabled              BOOLEAN         := TRUE,
        in_autodrop             BOOLEAN         := TRUE,
        in_comments             VARCHAR2        := NULL
    ) AS
        v_job_name              user_scheduler_jobs.job_name%TYPE;
        v_action                VARCHAR2(32767);
    BEGIN
        v_job_name := '"' || in_job_name || '"';
        --
        v_action :=
            --
            -- @TODO: use APEX_STRING.FORMAT
            --
            'BEGIN' || CHR(10) ||
            --
            CASE WHEN in_user_id IS NOT NULL THEN
                '    core.create_session ('                                                 || CHR(10) ||
                '        in_user_id      => ''' || in_user_id || ''','                      || CHR(10) ||
                '        in_app_id       => ' || NVL(in_app_id, core.get_app_id()) || ','   || CHR(10) ||
                '        in_session_id   => ' || NVL(in_session_id, 0)                      || CHR(10) ||
                '    );'                                                                    || CHR(10)
            END ||
            --
            '    ' || RTRIM(in_statement, ';') || ';'                                       || CHR(10) ||
            'EXCEPTION'                                                                     || CHR(10) ||
            'WHEN OTHERS THEN'                                                              || CHR(10) ||
            '    core.raise_error();'                                                       || CHR(10) ||
            'END;';
        --
        DBMS_SCHEDULER.CREATE_JOB (
            job_name        => v_job_name,
            job_type        => 'PLSQL_BLOCK',
            job_action      => v_action,
            start_date      => in_start_date,
            enabled         => FALSE,
            auto_drop       => in_autodrop,
            comments        => in_comments
        );
        --
        IF in_priority IS NOT NULL THEN
            DBMS_SCHEDULER.SET_ATTRIBUTE(v_job_name, 'JOB_PRIORITY', in_priority);
        END IF;
        --
        IF in_enabled THEN
            DBMS_SCHEDULER.ENABLE(v_job_name);
        END IF;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE raise_error (
        in_action_name          VARCHAR2    := NULL,
        --
        in_arg1                 VARCHAR2    := NULL,
        in_arg2                 VARCHAR2    := NULL,
        in_arg3                 VARCHAR2    := NULL,
        in_arg4                 VARCHAR2    := NULL,
        in_arg5                 VARCHAR2    := NULL,
        in_arg6                 VARCHAR2    := NULL,
        in_arg7                 VARCHAR2    := NULL,
        in_arg8                 VARCHAR2    := NULL,
        --
        in_payload              VARCHAR2    := NULL,
        in_rollback             BOOLEAN     := FALSE
    )
    AS
    BEGIN
        IF in_rollback THEN
            ROLLBACK;
        END IF;
        --
        RAISE_APPLICATION_ERROR (
            core.app_exception_code,
            COALESCE(in_action_name, core.get_caller_name(), 'UNEXPECTED_ERROR'),
            TRUE
        );
    END;



    PROCEDURE refresh_mviews (
        in_name_like            VARCHAR2 := NULL
    )
    AS
    BEGIN
        FOR c IN (
            SELECT m.mview_name
            FROM user_mviews m
            WHERE (m.mview_name LIKE in_name_like OR in_name_like IS NULL)
            ORDER BY 1
        ) LOOP
            DBMS_MVIEW.REFRESH(c.mview_name, 'C', parallelism => 1);
        END LOOP;
    EXCEPTION
    WHEN OTHERS THEN
        core.raise_error();
    END;



    FUNCTION get_caller_name (
        in_offset               PLS_INTEGER     := NULL
    )
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(NVL(in_offset, 2)));
    EXCEPTION
    WHEN BAD_DEPTH THEN
        RETURN NULL;
    END;



    FUNCTION get_caller_line (
        in_offset               PLS_INTEGER     := NULL
    )
    RETURN NUMBER
    AS
    BEGIN
        RETURN UTL_CALL_STACK.UNIT_LINE(NVL(in_offset, 2));
    EXCEPTION
    WHEN BAD_DEPTH THEN
        RETURN NULL;
    END;



    FUNCTION get_hash (
        in_payload      VARCHAR2
    )
    RETURN VARCHAR2
    RESULT_CACHE
    AS
        out_ VARCHAR2(40);
    BEGIN
        -- quick hash alg, shame we need a context switch, compensate with result cache
        SELECT STANDARD_HASH(in_payload) INTO out_
        FROM DUAL;
        --
        RETURN out_;
    END;



    FUNCTION get_call_stack (
        in_offset               PLS_INTEGER     := NULL,
        in_skip_others          BOOLEAN         := FALSE,
        in_line_numbers         BOOLEAN         := TRUE,
        in_splitter             VARCHAR2        := CHR(10)
    )
    RETURN VARCHAR2
    AS
        out_stack       VARCHAR2(32767);
        out_module      VARCHAR2(2000);
    BEGIN
        -- better version of DBMS_UTILITY.FORMAT_CALL_STACK
        FOR i IN REVERSE NVL(in_offset, 2) .. UTL_CALL_STACK.DYNAMIC_DEPTH LOOP  -- 2 = ignore this function, 3 = ignore caller
            CONTINUE WHEN in_skip_others AND NVL(UTL_CALL_STACK.OWNER(i), '-') NOT IN (core.get_owner());
            --
            out_module  := UTL_CALL_STACK.CONCATENATE_SUBPROGRAM(UTL_CALL_STACK.SUBPROGRAM(i));
            out_stack   := out_stack || out_module || CASE WHEN in_line_numbers THEN ' [' || TO_CHAR(UTL_CALL_STACK.UNIT_LINE(i)) || ']' END || in_splitter;
        END LOOP;
        --
        RETURN out_stack;
    EXCEPTION
    WHEN BAD_DEPTH THEN
        RETURN NULL;
    END;



    FUNCTION get_error_stack
    RETURN VARCHAR2
    AS
        out_stack       VARCHAR2(32767);
    BEGIN
        -- switch NLS to get error message in english
        BEGIN
            DBMS_SESSION.SET_NLS('NLS_LANGUAGE', '''ENGLISH''');
        EXCEPTION
        WHEN OTHERS THEN    -- cant set NLS in triggers
            NULL;
        END;

        -- better version of DBMS_UTILITY.FORMAT_ERROR_STACK, FORMAT_ERROR_BACKTRACE
        FOR i IN REVERSE 1 .. UTL_CALL_STACK.ERROR_DEPTH LOOP
            BEGIN
                out_stack := out_stack ||
                    UTL_CALL_STACK.BACKTRACE_UNIT(i) || ' [' || UTL_CALL_STACK.BACKTRACE_LINE(i) || '] ' ||
                    'ORA-' || LPAD(UTL_CALL_STACK.ERROR_NUMBER(i), 5, '0') || ' ' ||
                    UTL_CALL_STACK.ERROR_MSG(i) || CHR(10);
            EXCEPTION
            WHEN BAD_DEPTH THEN
                NULL;
            END;
        END LOOP;
        --
        RETURN out_stack;
    END;



    FUNCTION get_shorter_stack (
        in_stack                VARCHAR2
    )
    RETURN VARCHAR2
    AS
        out_stack               VARCHAR2(32767);
    BEGIN
        out_stack := REPLACE(in_stack, 'WWV_FLOW', '%');
        out_stack := REGEXP_REPLACE(out_stack, 'APEX_\d{6}', '%');
        --
        out_stack := REGEXP_REPLACE(out_stack, '\s.*SQL.*\.EXEC.*\]',   '.');
        out_stack := REGEXP_REPLACE(out_stack, '\s%.*EXEC.*\]',         '.');
        out_stack := REGEXP_REPLACE(out_stack, '\s%_PROCESS.*\]',       '.');
        out_stack := REGEXP_REPLACE(out_stack, '\s%_ERROR.*\]',         '.');
        out_stack := REGEXP_REPLACE(out_stack, '\s%_SECURITY.*\]',      '.');
        out_stack := REGEXP_REPLACE(out_stack, '\sHTMLDB*\]',           '.');
        out_stack := REGEXP_REPLACE(out_stack, '\s\d+\s\[\]',           '.');
        --
        out_stack := REGEXP_REPLACE(out_stack, '\sORA-\d+.*%\.%.*EXEC.*, line \d+',             '.');
        out_stack := REGEXP_REPLACE(out_stack, '\sORA-\d+.*%\.%.*PROCESS_NATIVE.*, line \d+',   '.');
        out_stack := REGEXP_REPLACE(out_stack, '\sORA-\d+.*DBMS_(SYS_)?SQL.*, line \d+',        '.');
        --
        RETURN out_stack;
    END;



    PROCEDURE send_mail (
        in_to                   VARCHAR2,
        in_subject              VARCHAR2,
        in_body                 CLOB,
        in_cc                   VARCHAR2        := NULL,
        in_bcc                  VARCHAR2        := NULL,
        in_from                 VARCHAR2        := NULL,
        in_attach_name          VARCHAR2        := NULL,
        in_attach_mime          VARCHAR2        := NULL,
        in_attach_data          CLOB            := NULL,
        in_compress             BOOLEAN         := FALSE
    ) AS
        smtp_from               VARCHAR2(256);
        smtp_username           VARCHAR2(256);
        smtp_password           VARCHAR2(256);
        smtp_host               VARCHAR2(256);
        smtp_port               NUMBER(4);
        smtp_timeout            NUMBER(2);
        --
        boundary                CONSTANT VARCHAR2(128)      := '-----5b9d8059445a8eb8c025f159131f02d94969a12c16363d4dec42e893b374cb85-----';
        --
        reply                   UTL_SMTP.REPLY;
        conn                    UTL_SMTP.CONNECTION;
        --
        blob_content            BLOB;
        blob_gzipped            BLOB;
        blob_amount             BINARY_INTEGER              := 6000;
        blob_offset             PLS_INTEGER                 := 1;
        buffer                  VARCHAR2(32767);
        buffer_raw              RAW(6000);                  -- must match blob_amount^
        --
        FUNCTION quote_encoding (
            in_text VARCHAR2
        )
        RETURN VARCHAR2 AS
        BEGIN
            RETURN '=?UTF-8?Q?' || REPLACE(
                UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(
                    UTL_RAW.CAST_TO_RAW(in_text))), '=' || UTL_TCP.CRLF, '') || '?=';
        END;
        --
        FUNCTION quote_address (
            in_address      VARCHAR2,
            in_strip_name   BOOLEAN := FALSE
        )
        RETURN VARCHAR2 AS
            in_found PLS_INTEGER;
        BEGIN
            IF in_strip_name THEN
                RETURN REGEXP_REPLACE(in_address, '.*\s?<(\S+)>$', '\1');
            ELSE
                in_found := REGEXP_INSTR(in_address, '\s?<\S+@\S+\.\S{2,6}>$');
                IF in_found > 1 THEN
                    RETURN quote_encoding(RTRIM(SUBSTR(in_address, 1, in_found))) || SUBSTR(in_address, in_found);
                ELSE
                    RETURN in_address;
                END IF;
            END IF;
        END;
        --
        PROCEDURE split_addresses (
            in_out_conn     IN OUT NOCOPY   UTL_SMTP.CONNECTION,
            in_to           IN              VARCHAR2
        )
        AS
        BEGIN
            FOR i IN (
                SELECT LTRIM(RTRIM(REGEXP_SUBSTR(in_to, '[^;,]+', 1, LEVEL))) AS address
                FROM DUAL
                CONNECT BY REGEXP_SUBSTR(in_to, '[^;,]+', 1, LEVEL) IS NOT NULL)
            LOOP
                UTL_SMTP.RCPT(in_out_conn, quote_address(i.address, TRUE));
            END LOOP;
        END;
    BEGIN
        IF (c_smtp_host IS NULL OR c_smtp_port IS NULL OR c_smtp_from IS NULL) THEN
            core.raise_error('SMTP_SETUP_MISSING');
        END IF;

        -- connect to SMTP server
        BEGIN
            reply := UTL_SMTP.OPEN_CONNECTION(c_smtp_host, NVL(c_smtp_port, 25), conn, NVL(c_smtp_timeout, 10));
        EXCEPTION
        WHEN OTHERS THEN
            core.raise_error('CONNECTION_FAILED');
            RETURN;
        END;
        --
        UTL_SMTP.HELO(conn, c_smtp_host);
        IF c_smtp_username IS NOT NULL THEN
            UTL_SMTP.COMMAND(conn, 'AUTH LOGIN');
            UTL_SMTP.COMMAND(conn, UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(c_smtp_username)));
            IF c_smtp_password IS NOT NULL THEN
                UTL_SMTP.COMMAND(conn, UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(c_smtp_password)));
            END IF;
        END IF;

        -- prepare headers
        UTL_SMTP.MAIL(conn, quote_address(c_smtp_from, TRUE));
        --
        -- apex_applications.email_from
        --

        -- handle multiple recipients
        split_addresses(conn, in_to);
        --
        IF in_cc IS NOT NULL THEN
            split_addresses(conn, in_cc);
        END IF;
        --
        IF in_bcc IS NOT NULL THEN
            split_addresses(conn, in_bcc);
        END IF;

        -- continue with headers
        UTL_SMTP.OPEN_DATA(conn);
        --
        UTL_SMTP.WRITE_DATA(conn, 'Date: '      || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || UTL_TCP.CRLF);
        UTL_SMTP.WRITE_DATA(conn, 'From: '      || quote_address(c_smtp_from) || UTL_TCP.CRLF);
        UTL_SMTP.WRITE_DATA(conn, 'To: '        || quote_address(in_to) || UTL_TCP.CRLF);
        UTL_SMTP.WRITE_DATA(conn, 'Subject: '   || quote_encoding(in_subject) || UTL_TCP.CRLF);
        UTL_SMTP.WRITE_DATA(conn, 'Reply-To: '  || quote_address(c_smtp_from) || UTL_TCP.CRLF);
        UTL_SMTP.WRITE_DATA(conn, 'MIME-Version: 1.0' || UTL_TCP.CRLF);
        UTL_SMTP.WRITE_DATA(conn, 'Content-Type: multipart/mixed; boundary="' || boundary || '"' || UTL_TCP.CRLF || UTL_TCP.CRLF);

        -- prepare body content
        IF in_body IS NOT NULL THEN
            UTL_SMTP.WRITE_DATA(conn, '--' || boundary || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Type: ' || 'text/html' || '; charset="utf-8"' || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Transfer-Encoding: base64' || UTL_TCP.CRLF || UTL_TCP.CRLF);
            --
            FOR i IN 0 .. TRUNC((DBMS_LOB.GETLENGTH(in_body) - 1) / 12000) LOOP
                UTL_SMTP.WRITE_RAW_DATA(conn, UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(DBMS_LOB.SUBSTR(in_body, 12000, i * 12000 + 1))));
            END LOOP;
            --
            UTL_SMTP.WRITE_DATA(conn, UTL_TCP.CRLF || UTL_TCP.CRLF);
        END IF;

        -- prepare attachment
        IF in_attach_name IS NOT NULL AND in_compress THEN
            -- compress attachment
            UTL_SMTP.WRITE_DATA(conn, '--' || boundary || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Transfer-Encoding: base64' || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Type: ' || 'application/octet-stream' || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Disposition: attachment; filename="' || in_attach_name || '.gz"' || UTL_TCP.CRLF || UTL_TCP.CRLF);
            --
            blob_content := core.clob_to_blob(in_attach_data);
            DBMS_LOB.CREATETEMPORARY(blob_gzipped, TRUE, DBMS_LOB.CALL);
            DBMS_LOB.OPEN(blob_gzipped, DBMS_LOB.LOB_READWRITE);
            --
            UTL_COMPRESS.LZ_COMPRESS(blob_content, blob_gzipped, quality => 8);
            --
            WHILE blob_offset <= DBMS_LOB.GETLENGTH(blob_gzipped) LOOP
                DBMS_LOB.READ(blob_gzipped, blob_amount, blob_offset, buffer_raw);
                UTL_SMTP.WRITE_RAW_DATA(conn, UTL_ENCODE.BASE64_ENCODE(buffer_raw));
                blob_offset := blob_offset + blob_amount;
            END LOOP;
            DBMS_LOB.FREETEMPORARY(blob_gzipped);
            --
            UTL_SMTP.WRITE_DATA(conn, UTL_TCP.CRLF || UTL_TCP.CRLF);
        ELSIF in_attach_name IS NOT NULL THEN
            -- regular attachment
            UTL_SMTP.WRITE_DATA(conn, '--' || boundary || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Transfer-Encoding: base64' || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Type: ' || in_attach_mime || '; name="' || in_attach_name || '"' || UTL_TCP.CRLF);
            UTL_SMTP.WRITE_DATA(conn, 'Content-Disposition: attachment; filename="' || in_attach_name || '"' || UTL_TCP.CRLF || UTL_TCP.CRLF);
            --
            FOR i IN 0 .. TRUNC((DBMS_LOB.GETLENGTH(in_attach_data) - 1) / 12000) LOOP
                UTL_SMTP.WRITE_RAW_DATA(conn, UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(DBMS_LOB.SUBSTR(in_attach_data, 12000, i * 12000 + 1))));
            END LOOP;
            --
            UTL_SMTP.WRITE_DATA(conn, UTL_TCP.CRLF || UTL_TCP.CRLF);
        END IF;

        -- close
        UTL_SMTP.WRITE_DATA(conn, '--' || boundary || '--' || UTL_TCP.CRLF);
        UTL_SMTP.CLOSE_DATA(conn);
        UTL_SMTP.QUIT(conn);
    EXCEPTION
    WHEN UTL_SMTP.TRANSIENT_ERROR OR UTL_SMTP.PERMANENT_ERROR THEN
        BEGIN
            UTL_SMTP.QUIT(conn);
        EXCEPTION
        WHEN UTL_SMTP.TRANSIENT_ERROR OR UTL_SMTP.PERMANENT_ERROR THEN
            NULL;
        END;
    WHEN OTHERS THEN
        core.raise_error('SEND_MAIL_FAILED');
    END;



    FUNCTION send_request (
        in_url              VARCHAR2,
        in_method           VARCHAR2    := NULL,
        in_content_type     VARCHAR2    := NULL,
        in_payload          VARCHAR2    := NULL
    )
    RETURN VARCHAR2
    AS
        http_req        UTL_HTTP.REQ;
        http_resp       UTL_HTTP.RESP;
        --
        out_content     VARCHAR2(32767);    -- could be CLOB
        v_buffer        VARCHAR2(32767);
    BEGIN
        IF c_app_proxy IS NOT NULL THEN
            UTL_HTTP.SET_PROXY(c_app_proxy);
        END IF;
        --
        IF c_app_wallet IS NOT NULL THEN
            UTL_HTTP.SET_WALLET(c_app_wallet);
        END IF;

        -- send headers
        BEGIN
            http_req := UTL_HTTP.BEGIN_REQUEST(in_url, NVL(UPPER(in_method), 'GET'), 'HTTP/1.1');
            --APEX_WEB_SERVICE.MAKE_REST_REQUEST
        EXCEPTION
        WHEN OTHERS THEN
            --
            -- parse callstack
            --
            core.raise_error (
                CASE SQLCODE
                    WHEN -24247 THEN 'MISSING_ACL_ISSUE'    -- ORA-24247: network access denied by access control list (ACL)
                    WHEN -29024 THEN 'CERTIFICATE_ISSUE'    -- ORA-29024: Certificate validation failure
                    ELSE 'CONNECTION_ERROR'
                    END,
                APEX_STRING_UTIL.GET_DOMAIN(in_url)
            );
        END;
        --
        UTL_HTTP.SET_BODY_CHARSET(http_req, 'UTF-8');

        -- extra headers for SOAP request
        UTL_HTTP.SET_HEADER(http_req, 'Accept',             '*/*');
        UTL_HTTP.SET_HEADER(http_req, 'Accept-Encoding',    'gzip, deflate');
        UTL_HTTP.SET_HEADER(http_req, 'Cache-Control',      'no-cache');
        UTL_HTTP.SET_HEADER(http_req, 'Content-Type',       NVL(in_content_type, 'application/x-www-form-urlencoded'));
        UTL_HTTP.SET_HEADER(http_req, 'Content-Length',     LENGTH(in_payload));
        UTL_HTTP.SET_HEADER(http_req, 'Connection',         'keep-alive');
        UTL_HTTP.SET_HEADER(http_req, 'User-Agent',         'Godzilla');

        -- send payload
        IF in_payload IS NOT NULL THEN
            UTL_HTTP.WRITE_TEXT(http_req, in_payload);
        END IF;

        -- get response
        http_resp := UTL_HTTP.GET_RESPONSE(http_req);
        DBMS_OUTPUT.PUT_LINE(http_resp.status_code);
        --
        IF http_resp.status_code >= 300 THEN
            core.raise_error('WRONG_RESPONSE_CODE', http_resp.status_code);
        END IF;

        -- get response
        --DBMS_LOB.CREATETEMPORARY(out_content, TRUE);
        BEGIN
            v_buffer := NULL;
            LOOP
                UTL_HTTP.READ_TEXT(http_resp, v_buffer, 32767);
                --IF v_buffer IS NOT NULL AND LENGTH(v_buffer) > 0 THEN
                    --DBMS_LOB.WRITEAPPEND(out_content, LENGTH(v_buffer), v_buffer);
                    out_content := v_buffer; EXIT;
                --END IF;
            END LOOP;
        EXCEPTION
        WHEN UTL_HTTP.END_OF_BODY THEN
            UTL_HTTP.END_RESPONSE(http_resp);
        END;

        -- quit
        UTL_HTTP.END_RESPONSE(http_resp);
        --
        RETURN out_content;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        BEGIN
            UTL_HTTP.END_RESPONSE(http_resp);
            --
            RETURN out_content;
        EXCEPTION
        WHEN OTHERS THEN
            NULL;
        END;
        --
        core.raise_error();
    END;



    FUNCTION clob_to_blob (
        in_clob CLOB
    )
    RETURN BLOB
    AS
        out_blob        BLOB;
        --
        v_file_size     INTEGER     := DBMS_LOB.LOBMAXSIZE;
        v_dest_offset   INTEGER     := 1;
        v_src_offset    INTEGER     := 1;
        v_blob_csid     NUMBER      := DBMS_LOB.DEFAULT_CSID;
        v_lang_context  NUMBER      := DBMS_LOB.DEFAULT_LANG_CTX;
        v_warning       INTEGER;
        v_length        NUMBER;
    BEGIN
        DBMS_LOB.CREATETEMPORARY(out_blob, TRUE);
        DBMS_LOB.CONVERTTOBLOB(out_blob, in_clob, v_file_size, v_dest_offset, v_src_offset, v_blob_csid, v_lang_context, v_warning);
        RETURN out_blob;
    END;



    FUNCTION get_long_string (
        in_table_name           VARCHAR2,
        in_column_name          VARCHAR2,
        in_where_col1_name      VARCHAR2,
        in_where_val1           VARCHAR2,
        in_where_col2_name      VARCHAR2    := NULL,
        in_where_val2           VARCHAR2    := NULL,
        in_owner                VARCHAR2    := NULL
    )
    RETURN VARCHAR2 AS
        l_query                 VARCHAR2(4000);
        l_cursor                INTEGER         := DBMS_SQL.OPEN_CURSOR;
        l_buflen                PLS_INTEGER     := 4000;
        l_result                PLS_INTEGER;
        --
        out_value               VARCHAR2(4000);
        out_value_len           PLS_INTEGER;
    BEGIN
        l_query :=
            'SELECT ' || in_column_name ||
            ' FROM '  || in_table_name ||
            ' WHERE ' || in_where_col1_name || ' = :val1';
        --
        IF in_where_col2_name IS NOT NULL THEN
            l_query := l_query || ' AND ' || in_where_col2_name || ' = :val2';
        END IF;
        --
        IF in_owner IS NOT NULL THEN
            l_query := l_query || ' AND owner = :owner';
        END IF;
        --
        DBMS_SQL.PARSE(l_cursor, l_query, DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_VARIABLE(l_cursor, ':val1', in_where_val1);
        --
        IF in_where_col2_name IS NOT NULL THEN
            DBMS_SQL.BIND_VARIABLE(l_cursor, ':val2', in_where_val2);
        END IF;
        --
        IF in_owner IS NOT NULL THEN
            DBMS_SQL.BIND_VARIABLE(l_cursor, ':owner', in_owner);
        END IF;
        --
        DBMS_SQL.DEFINE_COLUMN_LONG(l_cursor, 1);
        --
        l_result := DBMS_SQL.EXECUTE(l_cursor);
        IF DBMS_SQL.FETCH_ROWS(l_cursor) > 0 THEN
            DBMS_SQL.COLUMN_VALUE_LONG(l_cursor, 1, l_buflen, 0, out_value, out_value_len);
        END IF;
        DBMS_SQL.CLOSE_CURSOR(l_cursor);
        --
        RETURN out_value;
    END;

END;
/

