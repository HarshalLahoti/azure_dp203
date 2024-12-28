-- 1. Use the following query to first get the required data

SELECT
    Records.ArrayValue.originalEventTimestamp AS EventTime,
    Records.ArrayValue.operationName AS OperationName,
    Records.ArrayValue.properties.action_name AS ActionName,
    Records.ArrayValue.properties.succeeded AS Status,
    Records.ArrayValue.properties.class_type_description AS ClassType,
    Records.ArrayValue.properties.client_ip AS ClientIP,
    Records.ArrayValue.properties.object_name AS ObjectName
INTO
    [DatabaseOperations]
FROM
    [securityhub] sh
CROSS APPLY GetArrayElements(sh.records) AS Records

-- 2. We can then use the Tumbling window

WITH Operations AS
(
SELECT
    Records.ArrayValue.operationName AS OperationName,
    Records.ArrayValue.properties.action_name AS ActionName,    
    Records.ArrayValue.properties.client_ip AS ClientIP
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
GROUP BY ActionName,ClientIP,TumblingWindow(minute,2)