CREATE OR REPLACE PROCEDURE create_client_schemas()
AS $$
DECLARE
    client RECORD;
    schema_prefix TEXT;
    schema_name TEXT;
    schema_exists BOOLEAN;
BEGIN
    FOR client IN SELECT client_id FROM master_schema.client_list
    LOOP
        FOR schema_prefix IN SELECT * FROM unnest(ARRAY['daily_db_', 'monthly_db_', 'yearly_db_'])
        LOOP
            schema_name := schema_prefix || client.client_id;
            
            -- Check if schema already exists
            SELECT EXISTS(SELECT 1 FROM information_schema.schemata WHERE schema_name = schema_name) INTO schema_exists;

            IF NOT schema_exists THEN
                BEGIN
                    -- Start transaction
                    START TRANSACTION;

                    -- Safely create schema using format
                    EXECUTE format('CREATE SCHEMA %I', schema_name);

                    -- Safely create tables within the schema using format
                    EXECUTE format('CREATE TABLE %I.sales (date DATE, amount DECIMAL(12,2), industry VARCHAR(255), other_demographics VARCHAR(255))', schema_name);
                    EXECUTE format('CREATE TABLE %I.revenue (date DATE, amount DECIMAL(12,2), industry VARCHAR(255), other_demographics VARCHAR(255))', schema_name);
                    EXECUTE format('CREATE TABLE %I.demographics (date DATE, industry VARCHAR(255), other_demographics VARCHAR(255))', schema_name);

                    -- Log success
                    INSERT INTO master_schema.operation_logs (client_id, schema_name, status) VALUES (client.client_id, schema_name, 'Success');

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