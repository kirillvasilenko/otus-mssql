/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	FORMAT (o.OrderDate, 'yy-MM') as Month,
	SUM (ol.Quantity * ol.UnitPrice) as TotalSum
FROM [WideWorldImporters].[Sales].[Orders] as o

join Sales.OrderLines as ol
	on o.OrderID = ol.OrderID

group by
	FORMAT (o.OrderDate, 'yy-MM')

having
	SUM (ol.Quantity * ol.UnitPrice) > 10000