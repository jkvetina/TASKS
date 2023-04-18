CREATE TABLE tsk_clients (
    client_id                       VARCHAR2(32)    CONSTRAINT nn_tsk_clients_id NOT NULL,
    client_name                     VARCHAR2(64),
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT pk_tsk_clients
        PRIMARY KEY (client_id)
);
--
COMMENT ON TABLE tsk_clients IS '';
--
COMMENT ON COLUMN tsk_clients.client_id     IS '';
COMMENT ON COLUMN tsk_clients.client_name   IS '';
COMMENT ON COLUMN tsk_clients.is_active     IS '';

