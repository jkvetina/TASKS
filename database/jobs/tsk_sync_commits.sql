DECLARE
    in_job_name             CONSTANT VARCHAR2(30)   := 'TSK_SYNC_COMMITS';
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
        job_action          => 'tsk_p500.sync_commits_job',
        number_of_arguments => 0,
        start_date          => SYSDATE,
        repeat_interval     => 'FREQ=DAILY;BYHOUR=7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23;BYMINUTE=0,20,40;BYSECOND=0;',
        enabled             => FALSE,
        auto_drop           => FALSE,
        comments            => 'Refresh commits'
    );
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

