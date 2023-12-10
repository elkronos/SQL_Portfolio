CREATE OR REPLACE PROCEDURE apply_change_to_all_schemas(change_sql TEXT, dry_run BOOLEAN DEFAULT FALSE)
AS $$
DECLARE
    client RECORD;
    schema_name TEXT;
    exec_sql TEXT;
BEGIN
    FOR client IN SELECT client_id FROM master_schema.client_list
    LOOP
        FOR schema_prefix IN SELECT * FROM unnest(ARRAY['daily_db_', 'monthly_db_', 'yearly_db_'])
        LOOP
            schema_name := schema_prefix || client.client_id;

            -- Prepare the SQL to be executed
            exec_sql := format(change_sql, schema_name);

            IF dry_run THEN
                -- Log the SQL that would be executed in dry run mode
                INSERT INTO master_schema.operation_logs (client_id, schema_name, status) VALUES (client.client_id, schema_name, 'Dry run: ' || exec_sql);
            ELSE
                BEGIN
                    -- Start transaction
                    START TRANSACTION;

                    -- Apply the schema change
                    EXECUTE exec_sql;

                    -- Log success
                    INSERT INTO master_schema.operation_logs (client_id, schema_name, status) VALUES (client.client_id, schema_name, 'Change Applied Successfully');

                    -- Commit transaction
                    COMMIT;
                EXCEPTION WHEN OTHERS THEN
                    -- Error handling and logging
                    GET DIAGNOSTICS operation_status = PG_EXCEPTION_DETAIL;
                    INSERT INTO master_schema.operation_logs (client_id, schema_name, status) VALUES (client.client_id, schema_name, 'Error: ' || operation_status);

                    -- Rollback transaction in case of error
                    ROLLBACK;
                END;
            END IF;
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;