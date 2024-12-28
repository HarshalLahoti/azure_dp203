SELECT 
hd.[SalesOrderID],hd.[OrderDate],hd.[CustomerID],hd.[SubTotal],hd.[TaxAmt],hd.[Freight],hd.[TotalDue],
dt.[OrderQty],dt.[ProductID],dt.[UnitPrice],dt.[UnitPriceDiscount],dt.[LineTotal]
FROM [SalesLT].[SalesOrderHeader] hd INNER JOIN [SalesLT].[SalesOrderDetail] dt
ON hd.[SalesOrderID]=dt.[SalesOrderID];

CREATE TABLE factSales
(
    SalesOrderID int NOT NULL,
    OrderDate datetime NOT NULL,
    CustomerID int NOT NULL,
    SubTotal money NOT NULL,
    TaxAmt money NOT NULL,
    Freight money NOT NULL,
    TotalDue money NOT NULL,
    OrderQty int,
    ProductID int NOT NULL,
    UnitPrice money NOT NULL,
    UnitPriceDiscount money NOT NULL,
    LineTotal decimal NOT NULL
)
WITH
(
    DISTRIBUTION=HASH(ProductID)
)
