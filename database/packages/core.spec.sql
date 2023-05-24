CREATE OR REPLACE PACKAGE core AS

    /**
     * This package is part of the CORE project under MIT licence.
     * https://github.com/jkvetina/core23
     *
     * Copyright (c) Jan Kvetina, 2023
     *
     *                                                      (R)
     *                      ---                  ---
     *                    #@@@@@@              &@@@@@@
     *                    @@@@@@@@     .@      @@@@@@@@
     *          -----      @@@@@@    @@@@@@,   @@@@@@@      -----
     *       &@@@@@@@@@@@    @@@   &@@@@@@@@@.  @@@@   .@@@@@@@@@@@#
     *           @@@@@@@@@@@   @  @@@@@@@@@@@@@  @   @@@@@@@@@@@
     *             \@@@@@@@@@@   @@@@@@@@@@@@@@@   @@@@@@@@@@
     *               @@@@@@@@@   @@@@@@@@@@@@@@@  &@@@@@@@@
     *                 @@@@@@@(  @@@@@@@@@@@@@@@  @@@@@@@@
     *                  @@@@@@(  @@@@@@@@@@@@@@,  @@@@@@@
     *                  .@@@@@,   @@@@@@@@@@@@@   @@@@@@
     *                   @@@@@@  *@@@@@@@@@@@@@   @@@@@@
     *                   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.
     *                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     *                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@
     *                     .@@@@@@@@@@@@@@@@@@@@@@@@@
     *                       .@@@@@@@@@@@@@@@@@@@@@
     *                            jankvetina.cz
     *                               -------
     *
     */

    -- code for app exception
    app_exception_code          CONSTANT PLS_INTEGER            := -20990;
    app_exception               EXCEPTION;
    --
    PRAGMA EXCEPTION_INIT(app_exception, app_exception_code);   -- as a side effect this will disable listing constants in tree on the left

    -- possible exception when parsing call stack
    BAD_DEPTH EXCEPTION;
    PRAGMA EXCEPTION_INIT(BAD_DEPTH, -64610);

    -- some constants
    c_page_item_wild        CONSTANT VARCHAR2(2)    := '$';
    c_page_item_prefix      CONSTANT VARCHAR2(2)    := 'P';
    c_format_date           CONSTANT VARCHAR2(32)   := 'YYYY-MM-DD';
    c_format_date_time      CONSTANT VARCHAR2(32)   := 'YYYY-MM-DD HH24:MI:SS';
    c_format_date_short     CONSTANT VARCHAR2(32)   := 'YYYY-MM-DD HH24:MI';
    c_app_proxy             CONSTANT VARCHAR2(128)  := '';
    c_app_wallet            CONSTANT VARCHAR2(128)  := '';
    c_smtp_from             CONSTANT VARCHAR2(128)  := '';
    c_smtp_host             CONSTANT VARCHAR2(128)  := '';
    c_smtp_port             CONSTANT NUMBER(8)      := NULL;
    c_smtp_timeout          CONSTANT NUMBER(8)      := NULL;
    c_smtp_username         CONSTANT VARCHAR2(128)  := '';
    c_smtp_password         CONSTANT VARCHAR2(128)  := '';

    -- for bulk set_item(s)
    TYPE type_page_items IS RECORD (
        column_name     VARCHAR2(30),
        item_name       VARCHAR2(64),
        item_value      VARCHAR2(2000)
    );
    --
    TYPE t_page_items IS TABLE OF type_page_items;





    FUNCTION get_owner (
        in_app_id               NUMBER
    )
    RETURN VARCHAR2;



    FUNCTION get_owner
    RETURN VARCHAR2;



    FUNCTION get_app_id
    RETURN NUMBER;



    FUNCTION get_user_id
    RETURN VARCHAR2;



    FUNCTION get_user_lang
    RETURN VARCHAR2;



    FUNCTION is_developer (
        in_user                 VARCHAR2        := NULL
    )
    RETURN BOOLEAN;



    FUNCTION is_developer_y (
        in_user                 VARCHAR2        := NULL
    )
    RETURN CHAR;



    FUNCTION is_debug_on
    RETURN BOOLEAN;



    PROCEDURE set_debug (
        in_status               BOOLEAN                     := TRUE
    );



    PROCEDURE create_session (
        in_user_id              VARCHAR2,
        in_app_id               NUMBER,
        in_page_id              NUMBER      := NULL,
        in_session_id           NUMBER      := NULL,
        in_items                VARCHAR2    := NULL
    );



    PROCEDURE exit_session;



    PROCEDURE set_action (
        in_action_name          VARCHAR2,
        in_module_name          VARCHAR2        := NULL
    );



    FUNCTION get_session_id
    RETURN NUMBER;



    FUNCTION get_client_id (
        in_user_id              VARCHAR2        := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_env_name
    RETURN VARCHAR2;



    FUNCTION get_page_id
    RETURN NUMBER;



    FUNCTION get_page_group (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL
    )
    RETURN apex_application_pages.page_group%TYPE;



    FUNCTION get_page_name (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL,
        in_name                 VARCHAR2    := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_page_title (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL,
        in_title                VARCHAR2    := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_page_url (
        in_page_id              NUMBER      := NULL,
        in_app_id               NUMBER      := NULL,
        in_names                VARCHAR2    := NULL,
        in_values               VARCHAR2    := NULL,
        in_overload             VARCHAR2    := NULL,    -- JSON object to overload passed items/values
        in_session_id           NUMBER      := NULL,
        in_reset                CHAR        := 'Y',     -- reset page items
        in_plain                CHAR        := 'Y'      -- remove JS
    )
    RETURN VARCHAR2;



    FUNCTION get_request_url (
        in_arguments_only       BOOLEAN                     := FALSE
    )
    RETURN VARCHAR2;



    FUNCTION get_request
    RETURN VARCHAR2;



    FUNCTION get_icon (
        in_name                 VARCHAR2,
        in_title                VARCHAR2    := NULL,
        in_style                VARCHAR2    := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_grid_action
    RETURN VARCHAR2;



    FUNCTION get_grid_data (
        in_column_name          VARCHAR2
    )
    RETURN VARCHAR2;



    PROCEDURE set_grid_data (
        in_column_name          VARCHAR2,
        in_value                VARCHAR2
    );



    FUNCTION get_item_name (
        in_name                 apex_application_page_items.item_name%TYPE,
        in_page_id              apex_application_page_items.page_id%TYPE            := NULL,
        in_app_id               apex_application_page_items.application_id%TYPE     := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_item (
        in_name                 VARCHAR2
    )
    RETURN VARCHAR2;



    FUNCTION get_number_item (
        in_name                 VARCHAR2
    )
    RETURN NUMBER;



    FUNCTION get_date_item (
        in_name                 VARCHAR2,
        in_format               VARCHAR2        := NULL
    )
    RETURN DATE;



    FUNCTION get_date (
        in_value                VARCHAR2,
        in_format               VARCHAR2        := NULL
    )
    RETURN DATE;



    FUNCTION get_date (
        in_date                 DATE            := NULL,
        in_format               VARCHAR2        := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_date_time (
        in_date                 DATE            := NULL,
        in_format               VARCHAR2        := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_time_bucket (
        in_date                 DATE,
        in_interval             NUMBER
    )
    RETURN NUMBER
    RESULT_CACHE;



    FUNCTION get_duration (
        in_interval             INTERVAL DAY TO SECOND
    )
    RETURN VARCHAR2;



    FUNCTION get_duration (
        in_interval             NUMBER
    )
    RETURN VARCHAR2;



    FUNCTION get_duration (
        in_start                TIMESTAMP,
        in_end                  TIMESTAMP       := NULL
    )
    RETURN VARCHAR2;



    PROCEDURE set_item (
        in_name                 VARCHAR2,
        in_value                VARCHAR2        := NULL
    );



    PROCEDURE set_date_item (
        in_name                 VARCHAR2,
        in_value                DATE
    );



    PROCEDURE set_page_items (
        in_query            VARCHAR2,
        in_page_id          NUMBER          := NULL
    );



    FUNCTION set_page_items (
        in_query            VARCHAR2,
        in_page_id          NUMBER          := NULL
    )
    RETURN t_page_items PIPELINED;



    PROCEDURE set_page_items (
        in_cursor           SYS_REFCURSOR,
        in_page_id          NUMBER          := NULL
    );



    FUNCTION set_page_items (
        in_cursor           SYS_REFCURSOR,
        in_page_id          NUMBER          := NULL
    )
    RETURN t_page_items PIPELINED;



    FUNCTION get_values (
        io_cursor           IN OUT  PLS_INTEGER,
        in_page_id                  NUMBER          := NULL
    )
    RETURN t_page_items;



    FUNCTION get_cursor_number (
        io_cursor           IN OUT SYS_REFCURSOR
    )
    RETURN PLS_INTEGER;



    PROCEDURE close_cursor (
        io_cursor           IN OUT PLS_INTEGER
    );



    PROCEDURE clear_items;



    FUNCTION get_page_items (
        in_page_id              NUMBER      := NULL,
        in_filter               VARCHAR2    := '%'
    )
    RETURN VARCHAR2;



    FUNCTION get_global_items (
        in_filter               VARCHAR2    := '%'
    )
    RETURN VARCHAR2;



    PROCEDURE apply_items (
        in_items                VARCHAR2
    );



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
    RETURN VARCHAR2;



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
    RETURN VARCHAR2;



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
    );



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
        in_rollback             BOOLEAN     := FALSE,
        in_traceback            BOOLEAN     := FALSE
    );



    PROCEDURE refresh_mviews (
        in_name_like            VARCHAR2 := NULL
    );



    FUNCTION get_caller_name (
        in_offset               PLS_INTEGER     := NULL
    )
    RETURN VARCHAR2;



    FUNCTION get_caller_line (
        in_offset               PLS_INTEGER     := NULL
    )
    RETURN NUMBER;



    FUNCTION get_hash (
        in_payload      VARCHAR2
    )
    RETURN VARCHAR2
    RESULT_CACHE;



    FUNCTION get_call_stack (
        in_offset               PLS_INTEGER     := NULL,
        in_skip_others          BOOLEAN         := FALSE,
        in_line_numbers         BOOLEAN         := TRUE,
        in_splitter             VARCHAR2        := CHR(10)
    )
    RETURN VARCHAR2;



    FUNCTION get_error_stack
    RETURN VARCHAR2;



    FUNCTION get_shorter_stack (
        in_stack                VARCHAR2
    )
    RETURN VARCHAR2;



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
    );



    FUNCTION send_request (
        in_url              VARCHAR2,
        in_method           VARCHAR2    := NULL,
        in_content_type     VARCHAR2    := NULL,
        in_payload          VARCHAR2    := NULL
    )
    RETURN VARCHAR2;



    FUNCTION clob_to_blob (
        in_clob CLOB
    )
    RETURN BLOB;



    FUNCTION get_long_string (
        in_table_name           VARCHAR2,
        in_column_name          VARCHAR2,
        in_where_col1_name      VARCHAR2,
        in_where_val1           VARCHAR2,
        in_where_col2_name      VARCHAR2    := NULL,
        in_where_val2           VARCHAR2    := NULL,
        in_owner                VARCHAR2    := NULL
    )
    RETURN VARCHAR2;



    PROCEDURE download_file (
        in_file_name                        VARCHAR2,
        in_file_mime                        VARCHAR2,
        in_file_payload     IN OUT NOCOPY   BLOB
    );

END;
/

