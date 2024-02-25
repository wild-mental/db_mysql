CREATE TABLE employee (
    id INT(6) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary INT(8),
    commission_pct DECIMAL(2, 2),
    manager_id INT(6),
    department_id INT(4)
);

-- 더미 레코드 삽입
INSERT INTO employee (id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES
(1, 'John', 'Doe', 'john@example.com', '123-4567', '2023-01-01', 'EMP001', 50000, 0.05, NULL, 1),
(2, 'Jane', 'Smith', 'jane@example.com', '987-6543', '2023-02-01', 'EMP002', 60000, 0.07, NULL, 1),
(3, 'Michael', 'Johnson', 'michael@example.com', '555-1234', '2023-03-01', 'EMP003', 55000, 0.03, NULL, 2),
(4, 'Emily', 'Brown', 'emily@example.com', '111-2222', '2023-04-01', 'EMP004', 62000, 0.06, NULL, 2),
(5, 'William', 'Jones', 'william@example.com', '999-8888', '2023-05-01', 'EMP005', 51000, 0.04, NULL, 3),
(6, 'Olivia', 'Garcia', 'olivia@example.com', '333-4444', '2023-06-01', 'EMP006', 59000, 0.05, NULL, 3),
(7, 'James', 'Martinez', 'james@example.com', '777-6666', '2023-07-01', 'EMP007', 54000, 0.03, NULL, 1),
(8, 'Emma', 'Lopez', 'emma@example.com', '222-3333', '2023-08-01', 'EMP008', 58000, 0.05, NULL, 2),
(9, 'Alexander', 'Hernandez', 'alexander@example.com', '444-5555', '2023-09-01', 'EMP009', 53000, 0.03, NULL, 3),
(10, 'Mia', 'Smith', 'mia@example.com', '666-9999', '2023-10-01', 'EMP010', 60000, 0.06, NULL, 1),
(11, 'David', 'Gonzalez', 'david@example.com', '888-1111', '2023-11-01', 'EMP011', 57000, 0.04, NULL, 2),
(12, 'Sophia', 'Rodriguez', 'sophia@example.com', '101-2020', '2023-12-01', 'EMP012', 54000, 0.03, NULL, 3),
(13, 'Michael', 'Smith', 'michael2@example.com', '333-7777', '2024-01-01', 'EMP013', 61000, 0.05, NULL, 1),
(14, 'Emily', 'Martinez', 'emily2@example.com', '555-9999', '2024-02-01', 'EMP014', 59000, 0.07, NULL, 2),
(15, 'Ethan', 'Garcia', 'ethan@example.com', '777-3333', '2024-03-01', 'EMP015', 55000, 0.03, NULL, 3),
(16, 'Sophia', 'Brown', 'sophia2@example.com', '999-2222', '2024-04-01', 'EMP016', 62000, 0.06, NULL, 1),
(17, 'Alexander', 'Rodriguez', 'alexander2@example.com', '222-8888', '2024-05-01', 'EMP017', 59000, 0.04, NULL, 2),
(18, 'Olivia', 'Martinez', 'olivia2@example.com', '444-6666', '2024-06-01', 'EMP018', 61000, 0.03, NULL, 3),
(19, 'William', 'Johnson', 'william2@example.com', '666-4444', '2024-07-01', 'EMP019', 56000, 0.05, NULL, 1),
(20, 'James', 'Hernandez', 'james2@example.com', '888-5555', '2024-08-01', 'EMP020', 59000, 0.07, NULL, 2);

SELECT
    department_id,
    COUNT(id) AS employee_count,
    AVG(salary) AS average_salary
FROM
    employee
GROUP BY
    department_id;