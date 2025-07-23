DECLARE @Salaries TABLE (ID INT IDENTITY(1,1), AMOUNT DECIMAL(10,2));
DECLARE @TaxRate TABLE (
		AMOUNTFROM DECIMAL(10, 2),
		AMOUNTTO DECIMAL(10, 2),
		RATE INT);

INSERT INTO @Salaries (AMOUNT)
VALUES (4000), (10000), (17000), (100), (12000), (100);

INSERT INTO @TaxRate(AMOUNTFROM, AMOUNTTO, RATE)
VALUES (0, 4999.99, 10), (5000, 15000, 15), (15000.01, 9999999, 20);

DECLARE @result NVARCHAR(MAX);
--Працівник #<номер>: Зарплата = <сума>, Податок = <сума>, Статус = <текст>
SELECT 
     N'Працівник #:' + CAST(T.ID AS NVARCHAR) +
	 N'Зарплата = ' + CAST (T.AMOUNT AS NVARCHAR) +
	 N', Податок = ' + CAST(T.AMOUNT * T.RATE / 100 AS NVARCHAR) +
	 N', Статус = ' + CASE 
						   WHEN RATE = 10 THEN N'Низький податок'
						   WHEN RATE = 15 THEN N'Середній податок'
						   ELSE N'Високий податок'
					   END
  FROM (
		SELECT ID,
			   AMOUNT,
			   (SELECT RATE FROM @TaxRate WHERE AMOUNT BETWEEN AMOUNTFROM AND AMOUNTTO) AS RATE
			   /*(SELECT AMOUNT * RATE / 100 FROM @TaxRate WHERE AMOUNT BETWEEN AMOUNTFROM AND AMOUNTTO) AS RATEAMOUNT,
			   (SELECT CASE 
						   WHEN RATE = 10 THEN N'Низький податок'
						   WHEN RATE = 15 THEN N'Середній податок'
						   ELSE N'Високий податок'
					   END
					  FROM @TaxRate WHERE AMOUNT BETWEEN AMOUNTFROM AND AMOUNTTO) AS RATETEXT*/
		  FROM @Salaries
      ) AS T;