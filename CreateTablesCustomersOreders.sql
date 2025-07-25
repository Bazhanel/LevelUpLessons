DROP TABLE Customers; 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    Country NVARCHAR(50),
    CreatedAt DATE
);

INSERT INTO Customers (CustomerID, Name, Email, Country, CreatedAt)
VALUES
(1, 'Ivan Petrov', 'ivan@mail.com', 'Ukraine', '2023-11-10'),
(2, 'Anna Ivanova', NULL, 'Poland', '2024-01-15'),
(3, 'John Smith', 'john@gmail.com', 'USA', '2025-02-20');


DROP TABLE Orders; 
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2023-01-05', 120.00),
(2, 1, '2023-02-10', 80.00),
(3, 2, '2023-01-15', 150.00),
(4, 1, '2023-03-01', 60.00),
(5, 3, '2023-01-25', 200.00),
(6, 2, '2023-04-10', 130.00),
(7, 3, '2023-02-28', 100.00),
(8, 3, '2023-03-15', 50.00),
(9, 1, '2023-04-01', 75.00),
(10, 2, '2023-03-20', 90.00);