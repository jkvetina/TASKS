CREATE OR REPLACE TRIGGER tsk_navigation_mv__
AFTER INSERT OR UPDATE OR DELETE ON tsk_navigation
BEGIN
    core.create_job (
        in_job_name     => 'TSK_NAVIGATION_MV_REFRESH',
        in_statement    => 'BEGIN core.refresh_mviews(''TSK_NAVIGATION_MAP_MV''); END;'
    );
END;
/

