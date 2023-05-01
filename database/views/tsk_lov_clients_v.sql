CREATE OR REPLACE FORCE VIEW tsk_lov_clients_v AS
SELECT
    t.client_id,
    t.client_name,
    --
    ROW_NUMBER() OVER (ORDER BY t.client_name, t.client_id) AS client_r#
    --
FROM tsk_clients t
JOIN tsk_auth_available_clients_v a
    ON a.client_id      = t.client_id;
--
COMMENT ON TABLE tsk_lov_clients_v IS '';

