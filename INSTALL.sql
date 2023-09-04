--
-- YOU HAVE TO INSTALL THE CORE PACKAGE FIRST
-- https://github.com/jkvetina/CORE23/tree/main/database
--
-- JOB .................... 2
-- MATERIALIZED VIEW ...... 2
-- PACKAGE ............... 20
-- PACKAGE BODY .......... 21
-- PROCEDURE .............. 1
-- SEQUENCE ............... 5
-- TABLE ................. 25
-- TRIGGER ................ 1
-- VIEW .................. 63

--
-- INIT
--
@@"./patches/10_init/01_init.sql"

--
-- SEQUENCES
--
@@"./database/sequences/tsk_board_id.sql"
@@"./database/sequences/tsk_checklist_id.sql"
@@"./database/sequences/tsk_comment_id.sql"
@@"./database/sequences/tsk_file_id.sql"
@@"./database/sequences/tsk_task_id.sql"

--
-- TABLES
--
@@"./database/tables/tsk_clients.sql"
@@"./database/tables/tsk_roles.sql"
@@"./database/tables/tsk_users.sql"
@@"./database/tables/tsk_navigation.sql"
@@"./database/tables/tsk_projects.sql"
@@"./database/tables/tsk_auth_procedures.sql"
@@"./database/tables/tsk_auth_tables.sql"
@@"./database/tables/tsk_repos.sql"
@@"./database/tables/tsk_statuses.sql"
@@"./database/tables/tsk_swimlanes.sql"
@@"./database/tables/tsk_auth_components.sql"
@@"./database/tables/tsk_auth_pages.sql"
@@"./database/tables/tsk_auth_users.sql"
@@"./database/tables/tsk_boards.sql"
@@"./database/tables/tsk_categories.sql"
@@"./database/tables/tsk_commits.sql"
@@"./database/tables/tsk_repo_endpoints.sql"
@@"./database/tables/tsk_auth_roles.sql"
@@"./database/tables/tsk_tasks.sql"
@@"./database/tables/tsk_user_fav_boards.sql"
@@"./database/tables/tsk_task_checklist.sql"
@@"./database/tables/tsk_task_comments.sql"
@@"./database/tables/tsk_task_commits.sql"
@@"./database/tables/tsk_task_files.sql"

--
-- OBJECTS
--
@@"./patches/40_repeatable_objects/40_drop_objects.sql"
--
@@"./database/views/tsk_lov_board_types_v.sql"
@@"./database/procedures/recompile.sql"
@@"./database/packages/core.spec.sql"
@@"./database/packages/tsk_p100.spec.sql"
@@"./database/packages/tsk_p110.spec.sql"
@@"./database/packages/tsk_p200.spec.sql"
@@"./database/packages/tsk_p400.spec.sql"
@@"./database/packages/tsk_p500.spec.sql"
@@"./database/packages/tsk_p900.spec.sql"
@@"./database/packages/tsk_p952.spec.sql"
@@"./database/packages/tsk_p955.spec.sql"
@@"./database/packages/tsk_p962.spec.sql"
@@"./database/packages/tsk_p963.spec.sql"
@@"./database/packages/tsk_p965.spec.sql"
@@"./database/packages/tsk_p966.spec.sql"
@@"./database/packages/tsk_p980.spec.sql"
@@"./database/views/tsk_lov_role_groups_v.sql"
@@"./database/views/tsk_lov_users_all_v.sql"
@@"./database/packages/tsk_p105.spec.sql"
@@"./database/packages/tsk_p300.spec.sql"
@@"./database/packages/tsk_p960.spec.sql"
@@"./database/views/tsk_auth_components_list_v.sql"
@@"./database/views/tsk_lov_app_page_groups_v.sql"
@@"./database/views/tsk_lov_app_tables_v.sql"
@@"./database/views/tsk_lov_roles_v.sql"
@@"./database/views/tsk_lov_statuses_all_v.sql"
@@"./database/views/tsk_lov_swimlanes_all_v.sql"
@@"./database/views/tsk_p105_checklist_v.sql"
@@"./database/views/tsk_p105_comments_v.sql"
@@"./database/views/tsk_p105_files_v.sql"
@@"./database/views/tsk_p510_repositories_v.sql"
@@"./database/views/tsk_p950_users_v.sql"
@@"./database/views/tsk_p960_roles_columns_v.sql"
@@"./database/views/tsk_p963_regions_v.sql"
@@"./database/packages/tsk_p900.sql"
@@"./database/packages/tsk_p980.sql"
@@"./database/views/tsk_auth_available_clients_v.sql"
@@"./database/views/tsk_auth_components_v.sql"
@@"./database/views/tsk_auth_table_roles_v.sql"
@@"./database/views/tsk_lov_app_pages_v.sql"
@@"./database/views/tsk_lov_projects_all_v.sql"
@@"./database/views/tsk_navigation_auth_v.sql"
@@"./database/views/tsk_p110_tasks_v.sql"
@@"./database/views/tsk_p500_commits_v.sql"
@@"./database/views/tsk_p515_endpoints_v.sql"
@@"./database/views/tsk_p900_user_roles_v.sql"
@@"./database/views/tsk_p952_map_users_v.sql"
@@"./database/views/tsk_p960_roles_v.sql"
@@"./database/packages/tsk_app.spec.sql"
@@"./database/packages/tsk_auth.spec.sql"
@@"./database/packages/tsk_p955.sql"
@@"./database/packages/tsk_p965.sql"
@@"./database/views/tsk_auth_available_projects_v.sql"
@@"./database/views/tsk_lov_app_procedures_v.sql"
@@"./database/views/tsk_lov_clients_v.sql"
@@"./database/views/tsk_p955_map_roles_v.sql"
@@"./database/packages/tsk_tapi.spec.sql"
@@"./database/packages/tsk_p110.sql"
@@"./database/packages/tsk_p952.sql"
@@"./database/packages/tsk_p966.sql"
@@"./database/views/tsk_auth_grids_v.sql"
@@"./database/views/tsk_lov_categories_v.sql"
@@"./database/views/tsk_lov_statuses_v.sql"
@@"./database/views/tsk_lov_swimlanes_v.sql"
@@"./database/views/tsk_lov_users_v.sql"
@@"./database/views/tsk_p105_commits_v.sql"
@@"./database/views/tsk_p200_boards_v.sql"
@@"./database/views/tsk_p220_categories_v.sql"
@@"./database/views/tsk_p230_statuses_counts_v.sql"
@@"./database/views/tsk_p250_swimlanes_v.sql"
@@"./database/views/tsk_p300_projects_v.sql"
@@"./database/views/tsk_p962_map_pages_v.sql"
@@"./database/views/tsk_p965_map_tables_v.sql"
@@"./database/packages/tsk_app.sql"
@@"./database/packages/tsk_p300.sql"
@@"./database/packages/tsk_p400.sql"
@@"./database/packages/tsk_p500.sql"
@@"./database/packages/tsk_p960.sql"
@@"./database/views/tsk_auth_available_boards_v.sql"
@@"./database/views/tsk_lov_users_project_v.sql"
@@"./database/views/tsk_navigation_top_v.sql"
@@"./database/views/tsk_p230_statuses_v.sql"
@@"./database/views/tsk_p400_clients_v.sql"
@@"./database/views/tsk_p963_map_components_v.sql"
@@"./database/views/tsk_p968_grid_check_v.sql"
@@"./database/packages/tsk_p962.sql"
@@"./database/packages/tsk_tapi.sql"
@@"./database/views/tsk_auth_context_v.sql"
@@"./database/packages/tsk_auth.sql"
@@"./database/packages/tsk_p200.sql"
@@"./database/packages/tsk_p963.sql"
@@"./database/views/tsk_lov_projects_v.sql"
@@"./database/views/tsk_p100_tasks_grid_v.sql"
@@"./database/views/tsk_p966_map_procedures_v.sql"
@@"./database/views/tsk_lov_repos_v.sql"
@@"./database/views/tsk_p105_tags_v.sql"
@@"./database/packages/tsk_p100.sql"
@@"./database/views/tsk_lov_boards_v.sql"
@@"./database/views/tsk_lov_repo_owners_v.sql"
@@"./database/views/tsk_lov_task_autocomplete_v.sql"
@@"./database/views/tsk_p105_badges_v.sql"
@@"./database/packages/tsk_p105.sql"

--
-- TRIGGERS
--
@@"./database/triggers/tsk_navigation_mv__.sql"

--
-- MVIEWS
--
@@"./patches/50_mviews/50_recompile.sql"
--
@@"./database/mviews/tsk_navigation_map_mv.sql"
@@"./database/mviews/tsk_p963_regions_mv.sql"

--
-- INDEXES
--
@@"./patches/55_indexes/50_recompile.sql"

--
-- DATA
--
@@"./patches/60_data/tsk_roles.sql"
@@"./patches/60_data/tsk_auth_tables.sql"
@@"./patches/60_data/tsk_navigation.sql"
@@"./patches/60_data/tsk_auth_procedures.sql"
@@"./patches/60_data/tsk_repo_endpoints.sql"
@@"./patches/60_data/tsk_auth_pages.sql"
@@"./patches/60_data/tsk_auth_components.sql"
--
COMMIT;

--
-- JOBS
--
@@"./database/jobs/tsk_refresh_mv.sql"
@@"./database/jobs/tsk_sync_commits.sql"

--
-- FINALLY
--
@@"./patches/90_finally/98_checks.sql"
@@"./patches/90_finally/96_stats.sql"
@@"./patches/90_finally/94_indexes.sql"
@@"./patches/90_finally/90_recompile.sql"
@@"./patches/90_finally/92_refresh_mvw.sql"

--
-- APEX
--
@@"./database/apex/f710/f710.sql"

