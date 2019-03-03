/****** Script for SelectTopNRows command from SSMS  ******/

with AvgStockItemPrice
as
(
	select 
		tmp.StockItemID,
		tmp.TotalSum / tmp.TotalQuantity as AvgStockItemPrice
	from (
		select 
			ol.StockItemID,
			SUM(ol.UnitPrice * ol.Quantity) as TotalSum,
			SUM(ol.Quantity) as TotalQuantity

		from WideWorldImporters.Sales.OrderLines as ol

		group by ol.StockItemID
		) as tmp
)

select
	si.StockItemID,
	si.StockItemName,
	FORMAT (o.OrderDate, 'yy-MM') as Month,
	SUM(ol.UnitPrice * ol.Quantity) as TotalSum,
	avgSI.AvgStockItemPrice,
	si.UnitPrice as StockItemUnitPrice

from WideWorldImporters.Warehouse.StockItems as si

join (
	select * 
	from AvgStockItemPrice
	) as avgSI
	on si.StockItemID = avgSI.StockItemID

join WideWorldImporters.Sales.OrderLines as ol
	on si.StockItemID = ol.StockItemID

join WideWorldImporters.Sales.Orders as o
	on ol.OrderID = o.OrderID

group by 
	si.StockItemID,
	si.StockItemName,
	si.UnitPrice,
	FORMAT (o.OrderDate, 'yy-MM'),
	avgSI.AvgStockItemPrice

order by si.StockItemID, Month
