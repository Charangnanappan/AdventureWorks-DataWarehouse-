create database AdventureWorksDB
go
use AdventureWorksDB
go
 
 CREATE TABLE [dbo].[Dim_Customer](
	[CustomerKey] [int] NOT NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State-Province] [nvarchar](255) NULL,
	[Country-Region] [nvarchar](255) NULL,
	[Postal Code] [nvarchar](255) NULL,
 CONSTRAINT [PK_Dim_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Dim_Product](
	[ProductKey] [int] NOT NULL,
	[SKU] [nvarchar](255) NULL,
	[Product] [nvarchar](255) NULL,
	[Standard Cost] [money] NULL,
	[Color] [nvarchar](255) NULL,
	[List Price] [money] NULL,
	[Model] [nvarchar](255) NULL,
	[Subcategory] [nvarchar](255) NULL,
	[Category] [nvarchar](255) NULL,
 CONSTRAINT [PK_Dim_Product] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



CREATE TABLE [dbo].[Dim_Reseller](
	[ResellerKey] [int] NOT NULL,
	[Reseller ID] [nvarchar](255) NULL,
	[Business Type] [nvarchar](255) NULL,
	[Reseller] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State-Province] [nvarchar](255) NULL,
	[Country-Region] [nvarchar](255) NULL,
	[Postal Code] [nvarchar](255) NULL,
 CONSTRAINT [PK_Dim_Reseller] PRIMARY KEY CLUSTERED 
(
	[ResellerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Dim_SalesTerritory](
	[SalesTerritoryKey] [int] NOT NULL,
	[Region] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
 CONSTRAINT [PK_Dim_SalesTerritory] PRIMARY KEY CLUSTERED 
(
	[SalesTerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO




   ------------------------------------

   CREATE TABLE dbo.Dim_Date (
   [DateKey] INT NOT NULL PRIMARY KEY,
   [OrderDate] DATE NOT NULL,
   [Year] INT NOT NULL,
    [QuarterName] VARCHAR(6) NOT NULL,
    [MonthNum] TINYINT NOT NULL,
   [MonthName] VARCHAR(10) NOT NULL,
   [DayofMonth] TINYINT NOT NULL,
   [DayofWeek] TINYINT NOT NULL,   
   [DayName] VARCHAR(10) NOT NULL
   )



   -------------------------------
   CREATE TABLE [dbo].[Fact_Sales_Data](
	[ResellerKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[ProductKey] [int] NULL,
	[OrderDateKey] [int] NULL,
	[SalesTerritoryKey] [int] NULL,
	[Order Quantity] [float] NULL,
	[Unit Price] [money] NULL,
	[Extended Amount] [money] NULL,
	[Unit Price Discount Pct] [float] NULL,
	[Product Standard Cost] [money] NULL,
	[Total Product Cost] [money] NULL,
	[Sales Amount] [money] NULL

 FOREIGN KEY([CustomerKey]) REFERENCES [dbo].[Dim_Customer] ([CustomerKey]),
 FOREIGN KEY([OrderDateKey]) REFERENCES [dbo].[Dim_Date] ([DateKey]),
 FOREIGN KEY([ProductKey]) REFERENCES [dbo].[Dim_Product] ([ProductKey]),
 FOREIGN KEY([ResellerKey])REFERENCES [dbo].[Dim_Reseller] ([ResellerKey]),
 FOREIGN KEY([SalesTerritoryKey]) REFERENCES [dbo].[Dim_SalesTerritory] ([SalesTerritoryKey])

) ON [PRIMARY]
GO
--------------------------------------------------------------------

   

DECLARE @CDate DATE = '2017-01-01'
DECLARE @EDate DATE = '2020-12-31'

WHILE @CDate < @EDate
BEGIN
	   INSERT INTO [dbo].Dim_Date (
	      [DateKey]
	,[OrderDate]
	,[Year]
	,[QuarterName]
	,[MonthNum]
	,[MonthName]
	,[DayofMonth]
	,[DayofWeek]	
	,[DayName]
	      )
   SELECT DateKey = YEAR(@CDate) * 10000 + MONTH(@CDate) * 100 + DAY(@CDate),
      DATE = @CDate,
	  [Year] = YEAR(@CDate),
	   [QuarterName] = CASE 
         WHEN DATENAME(qq, @CDate) = 1
            THEN 'First'
         WHEN DATENAME(qq, @CDate) = 2
            THEN 'second'
         WHEN DATENAME(qq, @CDate) = 3
            THEN 'third'
         WHEN DATENAME(qq, @CDate) = 4
            THEN 'fourth'
         END,
		  [Month] = MONTH(@CDate),
		   [MonthName] = DATENAME(mm, @CDate),
		    Day = DAY(@CDate),
			 WEEKDAY = DATEPART(dw, @CDate),
			  WeekDayName = DATENAME(dw, @CDate)
     
      

   SET @CDate = DATEADD(DD, 1, @CDate)
END




