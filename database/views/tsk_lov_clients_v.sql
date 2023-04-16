CREATE OR REPLACE FORCE VIEW tsk_lov_clients_v AS
SELECT
    t.client_id,
    t.client_name
FROM tsk_clients t
WHERE t.is_active       = 'Y'
ORDER BY t.client_name, t.client_id;
--
COMMENT ON TABLE tsk_lov_clients_v IS '';

