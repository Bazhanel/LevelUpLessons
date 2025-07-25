-- Змінні
DECLARE @Salary INT;
DECLARE @TaxRate FLOAT;
DECLARE @TaxAmount FLOAT;
DECLARE @Status NVARCHAR(20);
DECLARE @EmployeeID INT;

-- Таблиця зарплат
DECLARE @Salaries TABLE (
    EmployeeID INT IDENTITY(1,1),
    Salary INT
);

-- Дані
INSERT INTO @Salaries (Salary)
VALUES (4500), (12000), (7000), (22000), (1500);

-- Курсор
DECLARE salary_cursor CURSOR FOR
SELECT EmployeeID, Salary FROM @Salaries;

-- Відкриття курсора
OPEN salary_cursor;

-- Читання першого запису
FETCH NEXT FROM salary_cursor INTO @EmployeeID, @Salary;

-- Обробка всіх записів
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Визначення ставки податку
    SET @TaxRate = 
        CASE 
            WHEN @Salary < 5000 THEN 0.10
            WHEN @Salary BETWEEN 5000 AND 15000 THEN 0.15
            ELSE 0.20
        END;

    -- Розрахунок податку
    SET @TaxAmount = @Salary * @TaxRate;

    -- Визначення статусу
    SET @Status = 
        CASE 
            WHEN @TaxRate = 0.10 THEN 'Низький податок'
            WHEN @TaxRate = 0.15 THEN 'Середній податок'
            ELSE 'Високий податок'
        END;

    -- Виведення
    PRINT 'Працівник #' + CAST(@EmployeeID AS NVARCHAR)
        + ': Зарплата = ' + CAST(@Salary AS NVARCHAR)
        + ', Податок = ' + CAST(@TaxAmount AS NVARCHAR)
        + ', Статус = ' + @Status;

    -- Наступний запис
    FETCH NEXT FROM salary_cursor INTO @EmployeeID, @Salary;
END

-- Закриття курсора
CLOSE salary_cursor;
DEALLOCATE salary_cursor;
