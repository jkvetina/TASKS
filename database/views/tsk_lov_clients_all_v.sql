CREATE OR REPLACE FORCE VIEW tsk_lov_clients_all_v AS
SELECT
    t.client_id,
    t.client_name,
    t.is_active
FROM tsk_clients t
ORDER BY
    t.client_name,
    t.client_id;
--
COMMENT ON TABLE tsk_lov_clients_all_v IS '';

