-- 1. The following query can be used 

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
    COUNT(OperationName) AS OperationCount,ActionName,ClientIP
INTO
    OperationTally
FROM
    Operations
GROUP BY ActionName,ClientIP,HoppingWindow(minute,5,2)

SELECT 
    EventTime,OperationName,ActionName,Status,ClassType,ClientIP,ObjectName
INTO
    DatabaseOperations
FROM
    Operations
