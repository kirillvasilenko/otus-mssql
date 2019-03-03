select
	si.StockItemID,
	si.StockItemName,
	FORMAT (o.OrderDate, 'yy-MM') as Month,
	SUM(ol.UnitPrice * ol.Quantity) as TotalSum,
	MIN(o.OrderDate) as FirstSale,
	SUM(ol.Quantity) as TotalQuantity

from WideWorldImporters.Warehouse.StockItems as si

join WideWorldImporters.Sales.OrderLines as ol
	on si.StockItemID = ol.StockItemID

join WideWorldImporters.Sales.Orders as o
	on ol.OrderID = o.OrderID

group by 
	grouping sets(
		(si.StockItemID,
		 si.StockItemName,
		 FORMAT (o.OrderDate, 'yy-MM')),
		
		(si.StockItemID,
		 si.StockItemName)
	)
	
having
	SUM(ol.Quantity) > 50

order by si.StockItemID, Month
