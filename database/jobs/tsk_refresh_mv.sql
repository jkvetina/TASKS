DECLARE
    in_job_name             CONSTANT VARCHAR2(30)   := 'TSK_REFRESH_MV';
    in_run_immediatelly     CONSTANT BOOLEAN        := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- JOB ' || UPPER(in_job_name));
    DBMS_OUTPUT.PUT_LINE('--');
    --
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(in_job_name, TRUE);
    EXCEPTION
    WHEN OTHERS THEN
        NULL;
    END;
    --
    DBMS_SCHEDULER.CREATE_JOB (
        job_name            => in_job_name,
        job_type            => 'STORED_PROCEDURE',
        job_action          => 'core.refresh_mviews',
        number_of_arguments => 1,
        start_date          => SYSDATE,
        repeat_interval     => 'FREQ=DAILY;BYHOUR=0;BYMINUTE=0;BYSECOND=5;',
        enabled             => FALSE,
        auto_drop           => FALSE,
        comments            => 'Refresh MViews'
    );
    --
    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(in_job_name, argument_position => 1, argument_value => TSK%);
    --
    DBMS_SCHEDULER.SET_ATTRIBUTE(in_job_name, 'JOB_PRIORITY', 3);
    DBMS_SCHEDULER.ENABLE(in_job_name);
    COMMIT;
    --
    IF in_run_immediatelly THEN
        DBMS_SCHEDULER.RUN_JOB(in_job_name);
        COMMIT;
    END IF;
END;
/

