CREATE OR REPLACE PROCEDURE grant_client_permissions()
AS $$
DECLARE
    client RECORD;
    schema_name TEXT;
    user_exists BOOLEAN;
BEGIN
    FOR client IN SELECT client_id FROM master_schema.client_list
    LOOP
        -- Check if user exists
        SELECT EXISTS(SELECT 1 FROM pg_user WHERE usename = 'user_' || client.client_id) INTO user_exists;

        IF user_exists THEN
            FOR schema_prefix IN SELECT * FROM unnest(ARRAY['daily_db_', 'monthly_db_', 'yearly_db_'])
            LOOP
                schema_name := schema_prefix || client.client_id;
                BEGIN
                    -- Start transaction
                    START TRANSACTION;

                    -- Grant USAGE permission on each schema to the respective client
                    EXECUTE format('GRANT USAGE ON SCHEMA %I TO %I', schema_name, 'user_' || client.client_id);

                    -- Grant SELECT permission on all tables in each schema
                    EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA %I TO %I', schema_name, 'user_' || client.client_id);

                    -- Commit transaction
                    COMMIT;
                EXCEPTION WHEN OTHERS THEN
                    -- Implement error handling if necessary
                    RAISE;

                    -- Rollback transaction in case of error
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;