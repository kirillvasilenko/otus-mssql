/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PersonID]
      ,[FullName]
	  ,People.PhoneNumber
	  ,StockItemName

  FROM [WideWorldImporters].[Application].[People]
  INNER JOIN Sales.Orders
	ON Orders.CustomerID = People.PersonID
  INNER JOIN Sales.OrderLines
	ON OrderLines.OrderID = Orders.OrderID
  INNER JOIN Warehouse.StockItems
	ON StockItems.StockItemID = OrderLines.StockItemID

WHERE StockItems.StockItemName = 'Chocolate frogs 250g'