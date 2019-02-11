/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (10) [OrderID]
      ,[CustomerID]
      ,Customers.FullName as CustomerName
	  ,[SalespersonPersonID]
	  ,Salesperson.FullName as SalespersonName
      ,[OrderDate]
  FROM [WideWorldImporters].[Sales].[Orders]
  INNER JOIN Application.People as Customers
	ON Customers.PersonID = Orders.CustomerID
  INNER JOIN Application.People as Salesperson
	ON Salesperson.PersonID = Orders.SalespersonPersonID
  ORDER BY OrderDate DESC