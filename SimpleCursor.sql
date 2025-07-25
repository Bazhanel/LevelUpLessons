
-- 1. Объявляем курсор
DECLARE contragent_сursor CURSOR FOR
SELECT id, name FROM Contragent where id = 0;

-- 2. Переменные для хранения текущей строки
DECLARE @Id INT, @Name NVARCHAR(256);

-- 3. Открываем курсор
OPEN contragent_сursor;

-- 4. Получаем первую строку
FETCH NEXT FROM contragent_сursor INTO @Id, @Name;

-- 5. Цикл по строкам
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Здесь можно выполнять действия с переменными @Id, @Name
    PRINT CONCAT(N'Сотрудник: #', @Id, ' — ', @Name);

    -- Получаем следующую строку
    FETCH NEXT FROM contragent_сursor INTO @Id, @Name;
END

-- 6. Закрываем и удаляем курсор
CLOSE contragent_сursor;
DEALLOCATE contragent_сursor;