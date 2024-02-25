CREATE TABLE department (
    department_id INT(4) AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

INSERT INTO department (department_id, department_name) VALUES (1, 'Engineering');
INSERT INTO department (department_id, department_name) VALUES (2, 'Sales');
INSERT INTO department (department_id, department_name) VALUES (3, 'Marketing');
INSERT INTO department (department_id, department_name) VALUES (4, 'Human Resources');

SELECT *
FROM employee e
LEFT JOIN department d ON e.department_id = d.department_id
UNION
SELECT *
FROM employee e
RIGHT JOIN department d ON e.department_id = d.department_id;
