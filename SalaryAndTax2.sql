DECLARE @Salaries TABLE (ID INT IDENTITY(1,1), AMOUNT DECIMAL(10,2));
DECLARE @TaxRate TABLE (
		DATEFROM DATE,
		AMOUNTFROM DECIMAL(10, 2),
		AMOUNTTO DECIMAL(10, 2),
		RATE INT);

INSERT INTO @Salaries (AMOUNT)
VALUES (4000), (10000), (17000), (100), (12000), (100);

INSERT INTO @TaxRate(DATEFROM, AMOUNTFROM, AMOUNTTO, RATE)
VALUES ('2025-01-01', 0, 4999.99, 10), 
       ('2025-01-01', 5000, 15000, 15), 
	   ('2025-01-01', 15000.01, 9999999, 20),
	   ('2026-01-01', 0, 4999.99, 11), 
       ('2026-01-01', 5000, 15000, 16), 
	   ('2026-01-01', 15000.01, 9999999, 21),
	   ('2026-07-01', 0, 4999.99, 13), 
       ('2026-07-01', 5000, 15000, 19), 
	   ('2026-07-01', 15000.01, 9999999, 24);

DECLARE @result NVARCHAR(MAX);
DECLARE @calcDate DATE = '2027-07-22';
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
			   (SELECT TOP 1 RATE 
			      FROM @TaxRate 
				 WHERE AMOUNT BETWEEN AMOUNTFROM AND AMOUNTTO
				   AND DATEFROM <= @calcDate ORDER BY DATEFROM DESC
				) AS RATE
		  FROM @Salaries
      ) AS T;