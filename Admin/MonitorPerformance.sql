SELECT 
    sqltext.TEXT,
    req.session_id,
    req.status,
    req.command,
    req.cpu_time,
    req.total_elapsed_time
FROM 
    sys.dm_exec_requests req
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext
WHERE
    req.total_elapsed_time > 300000 -- longer than 5 minutes
ORDER BY 
    req.total_elapsed_time DESC;
