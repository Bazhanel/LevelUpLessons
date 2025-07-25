-- Порахувати кіль-ть замовлень по кожному клієнту
CREATE TABLE #CustomerOrderCount (
    CustomerName NVARCHAR(100),
    OrderCount INT
);

DECLARE @CustomerID INT,
        @CustomerName NVARCHAR(100),
        @OrderCount INT;

DECLARE CustomerCursor CURSOR FOR
SELECT CustomerID, Name FROM Customers;

OPEN CustomerCursor;

FETCH NEXT FROM CustomerCursor INTO @CustomerID, @CustomerName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @OrderCount = COUNT(*) 
    FROM Orders 
    WHERE customer_id = @CustomerID;

    INSERT INTO #CustomerOrderCount (CustomerName, OrderCount)
    VALUES (@CustomerName, @OrderCount);

    FETCH NEXT FROM CustomerCursor INTO @CustomerID, @CustomerName;
END

CLOSE CustomerCursor;
DEALLOCATE CustomerCursor;

SELECT * FROM #CustomerOrderCount;