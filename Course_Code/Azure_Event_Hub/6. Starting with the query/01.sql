-- 1. The following initial query can be used to get the data

SELECT
  Records.ArrayValue.time AS Recordedtime,
  Records.ArrayValue.properties.flows AS flows
FROM 
insights i
CROSS APPLY GetArrayElements(i.records) AS Records