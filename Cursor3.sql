-- Порахувати кіл-ть замовдень по кожному клієнту
DECLARE @qnt NVARCHAR(200);

SELECT 
    @qnt = CONCAT('Customer: ', c.Name, ' | Orders: ', COUNT(o.order_id))
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.customer_id
GROUP BY c.Name
HAVING COUNT(o.order_id) >= 0;

PRINT @qnt;

DECLARE @result NVARCHAR(MAX);

WITH CustomerOrders AS
(
    SELECT 
        c.Name,
        COUNT(o.order_ID) AS OrderCount
    FROM Customers c
    LEFT JOIN Orders o ON o.customer_id = c.CustomerID
    GROUP BY c.Name
)

SELECT @result = STRING_AGG('Customer ' + Name + ' has ' 
                            + CAST(OrderCount AS VARCHAR(10)) 
                            + ' orders.', CHAR(13))
FROM CustomerOrders;

PRINT @result;

----------------------------------------------------------------------------
DECLARE @result NVARCHAR(MAX);

select @result = STRING_AGG('Customer ' + Name + ' has ' 
                            + CAST(OrderCount AS VARCHAR(10)) 
                            + ' orders.', CHAR(13)) from (
    SELECT 
        c.Name,
        COUNT(o.order_ID) AS OrderCount
    FROM Customers c
    LEFT JOIN Orders o ON o.customer_id = c.CustomerID
    GROUP BY c.Name) as t;

PRINT @result;