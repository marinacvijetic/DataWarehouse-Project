IF OBJECT_ID('FactSales', 'U') is not null
	DROP TABLE FactSales

IF OBJECT_ID ('DimDate','U') is not null
	DROP TABLE DimDate;

IF OBJECT_ID('DimCustomer', 'U') is not null
	DROP TABLE DimCustomer

IF OBJECT_ID('DimProduct', 'U') is not null
	DROP TABLE DimProduct
	
IF OBJECT_ID('DimSalesTeam', 'U') is not null
	DROP TABLE DimSalesTeam
	
IF OBJECT_ID('DimStoreLocation', 'U') is not null
	DROP TABLE DimStoreLocation
	
IF OBJECT_ID('DimRegion', 'U') is not null
	DROP TABLE DimRegion
	


CREATE TABLE DimCustomer
(
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerName VARCHAR(50)
)


CREATE TABLE DimProduct
(
	ProductID INT IDENTITY(1,1) PRIMARY KEY,
	ProductName VARCHAR(30)
)

CREATE TABLE DimSalesTeam 
(
	SalesTeamID INT IDENTITY(1,1) PRIMARY KEY,
	SalesTeam VARCHAR(50),
	Region VARCHAR(30)
)

CREATE TABLE DimStoreLocation
(
	StoreID INT IDENTITY(1,1) PRIMARY KEY,
	CityName VARCHAR(30),
	County VARCHAR(100), 
	_Type VARCHAR(30),
	Latitude NUMERIC(10,5),
	Longitude NUMERIC(10,5),
	AreaCode INT,
	_Population INT,
	HouseholdIncome NUMERIC(10,2),
	MedianIncome NUMERIC(10,2),
	LandArea NUMERIC(11,0),
	WaterArea NUMERIC(11,0),
	TimeZone VARCHAR(50)
)

CREATE TABLE DimRegion
(
	StateCode VARCHAR(5) PRIMARY KEY,
	StateName VARCHAR(30),
	Region VARCHAR(30)
)

CREATE TABLE DimDate
(
	DateID INT IDENTITY(1,1) PRIMARY KEY,
	FullOrderDate DATE not null,
	FullShipDate DATE not null,
	FullDeliveryDate DATE not null,
	OrderMonth VARCHAR(30),
	ShipMonth VARCHAR(30),
	DeliveryMonth VARCHAR(30),
	OrderYear INT

)


CREATE TABLE FactSales
(
	SaleID VARCHAR(20) PRIMARY KEY,
	ProductID INT,
	CustomerID INT,
	SalesTeamID INT,
	StoreID INT,
	StateCode VARCHAR(5),
	DateID INT,
	ProcuredDate DATE,
	SalesChannel VARCHAR(30),
	WarehouseCode VARCHAR(30),
	CurrencyCode VARCHAR(10),
	OrderQuantity INT,
	Discount NUMERIC(10,2),
	UnitPrice NUMERIC(10,2),
	UnitCost NUMERIC(10,2),
	FullPrice NUMERIC(10,2),
	PriceWithDiscount NUMERIC(10,2)
	CONSTRAINT FK_FACT_PRODUCT FOREIGN KEY (ProductID) REFERENCES DimProduct (ProductID),
	CONSTRAINT FK_FACT_CUSTOMER FOREIGN KEY (CustomerID) REFERENCES DimCustomer (CustomerID),
	CONSTRAINT FK_FACT_SALESTEAM FOREIGN KEY (SalesTeamID) REFERENCES DimSalesTeam (SalesTeamID),
	CONSTRAINT FK_FACT_STORELOCATION FOREIGN KEY (StoreID) REFERENCES DimStoreLocation (StoreID),
	CONSTRAINT FK_FACT_REGION FOREIGN KEY (StateCode) REFERENCES DimRegion (StateCode),
	CONSTRAINT FK_FACT_DATE FOREIGN KEY (DateID) REFERENCES DimDate (DateID)

)


select * from DimCustomer
select * from DimProduct
select round(avg(HouseholdIncome),2) from DimStoreLocation
select * from DimDate
select * from DimRegion
select * from FactSales