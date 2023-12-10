CREATE TABLE master_schema.operation_logs (
    log_id INT IDENTITY(1,1),
    client_id VARCHAR(256),
    schema_name VARCHAR(256),
    status VARCHAR(1024),
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);