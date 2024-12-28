-- In the dedicated SQL pool, delete all of the tables to keep a clean slate
-- Create a new table

CREATE TABLE PoolActivityLog
(
   [Correlationid] varchar(200),
   [Operationname] varchar(300),
   [Status] varchar(100),
   [Eventcategory] varchar(100),
   [Level] varchar(100),
   [Time] datetime,
   [Subscription] varchar(200),
   [Eventinitiatedby] varchar(1000),
   [Resourcetype] varchar(300),
   [Resourcegroup] varchar(1000),
   [Resource] varchar(2000)
)
WITH
(
    DISTRIBUTION= HASH(Operationname)    
)