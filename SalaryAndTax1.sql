/*
Завдання 1.
Існує список зарплат співробітників. Необхідно для кожного працівника:
1. Визначити ставку податку в залежності від розміру зарплати:
   - Якщо зарплата менше 5000 — ставка 10%
   - Якщо зарплата від 5000 до 15000 — ставка 15%
   - Якщо зарплата більше 15000 — ставка 20%
2. Обчислити суму податку.
3. Призначити статус податкового навантаження:
   - 10%  - “Низький податок”
   - 15%  - “Середній податок”
   - 20%  - “Високий податок”
4. Вивести інформацію у вигляді: Працівник #<номер>: Зарплата = <сума>, Податок = <сума>, Статус = <текст>. 
5. Список зарплат задається вручну в таблиці-змінній (@Salaries)
*/
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

SELECT @result = STRING_AGG(ResultLine, CHAR(13) + CHAR(10))
  FROM (
		SELECT N'Працівник №:' + CAST(ID AS NVARCHAR)  +
			   N'Зарплата = ' + CAST(AMOUNT AS NVARCHAR) +
			   N', Податок = ' + CAST(AMOUNT *
				 CASE 
					 WHEN AMOUNT < 5000 THEN 10
					 WHEN AMOUNT BETWEEN 5000 AND 15000 THEN 15
					 ELSE 20
				 END / 100 AS NVARCHAR
			   ) + 
			   N', Статус = ' +
			   CASE 
				   WHEN AMOUNT < 5000 THEN N'Низький дохід'
				   WHEN AMOUNT BETWEEN 5000 AND 15000 THEN N'Середній дохід'
				   ELSE N'Високий дохід'
			   END AS ResultLine
		  FROM @Salaries
        ) AS T;

PRINT @result;