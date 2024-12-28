-- 1. The following query can be used as a reference

WITH Operations AS
(
SELECT
    Records.ArrayValue.originalEventTimestamp AS EventTime,
    Records.ArrayValue.operationName AS OperationName,
    Records.ArrayValue.properties.action_name AS ActionName,
    Records.ArrayValue.properties.succeeded AS Status,
    Records.ArrayValue.properties.class_type_description AS ClassType,
    Records.ArrayValue.properties.client_ip AS ClientIP,
    Records.ArrayValue.properties.object_name AS ObjectName
FROM
    [securityhub] sh
CROSS APPLY GetArrayElements(sh.records) AS Records
) 

SELECT 
    o.EventTime,o.OperationName,o.ActionName,o.Status,o.ClassType,o.ClientIP,o.ObjectName,r.Tier
INTO
    DatabaseOperations
FROM 
    Operations o
    JOIN [reference] r
    ON o.ActionName=r.ActionName