with AvgStockItemPrice
as
(
	select
		avg(si.UnitPrice) as AvgPrice
	from
		WideWorldImporters.Warehouse.StockItems as si
)

select
	si.StockItemID,
	si.StockItemName,
	FORMAT (i.InvoiceDate, 'yy-MM') as Month,
	SUM(il.UnitPrice * il.Quantity) as TotalSum,
	(select AvgPrice from AvgStockItemPrice) as AvgStockItemPrice

from WideWorldImporters.Warehouse.StockItems as si

join WideWorldImporters.Sales.InvoiceLines as il
	on si.StockItemID = il.StockItemID

join WideWorldImporters.Sales.Invoices as i
	on il.InvoiceID = i.InvoiceID

group by 
	si.StockItemID,
	si.StockItemName,
	FORMAT (i.InvoiceDate, 'yy-MM')

order by si.StockItemID, Month



