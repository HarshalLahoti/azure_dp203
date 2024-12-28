-- 1. Use the following command to create the table

CREATE TABLE FlowTuples
(
	Recordedtime datetimeoffset,
	Rulename varchar(1000),
	SourceIPAddress varchar(30),
	DestinationIPAddress varchar(30),
	SourcePort varchar(10),
	Decision varchar(2)
)

-- 2. The following is the entire SQL query to process the data

WITH
Stage1 AS
(
SELECT
  Records.ArrayValue.time AS Recordedtime,
  Records.ArrayValue.properties.flows AS flows
FROM 
insights i
CROSS APPLY GetArrayElements(i.records) AS Records
),
Stage2 AS
(
SELECT 
 Recordedtime,GetArrayElement(flows,0) AS flows
FROM 
Stage1
),
Stage3 AS
(
SELECT
  s2.Recordedtime,
  s2.flows.[rule] AS Rulename,
  flows
FROM Stage2 s2
CROSS APPLY GetArrayElements(s2.flows.flows) AS flows
),
Stage4 AS
(
SELECT  
 s3.Recordedtime,
 s3.Rulename,
 flowTuples
FROM Stage3 s3
CROSS APPLY GetArrayElements(s3.flows.ArrayValue.flowTuples) AS flowtuples
)

SELECT 
    Recordedtime,
    Rulename,
    UDF.GetItems(flowTuples.ArrayValue,2) AS SourceIPAddress,
 	UDF.GetItems(flowTuples.ArrayValue,1) AS DestinationIPAddress,
	UDF.GetItems(flowTuples.ArrayValue,3) AS SourcePort,
	UDF.GetItems(flowTuples.ArrayValue,7) AS Action
INTO
    FlowTuples
FROM 
Stage4