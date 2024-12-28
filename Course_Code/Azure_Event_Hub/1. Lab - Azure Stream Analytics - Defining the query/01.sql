-- 1. Use the following command to create the table

CREATE TABLE VehicleTollBooth
(
	Make varchar(100),
	Model varchar(100),
	VehicleType int,
	State varchar(10),
	TollAmount int
)

--2. Use the following for the query

SELECT 
CarModel.Make,CarModel.Model,CarModel.VehicleType,State,TollAmount
INTO
[Vehicletollbooth]
FROM
[datahub]