CREATE USER 'admin2' IDENTIFIED BY '1234';
CREATE USER 'app_service_acc2' IDENTIFIED BY '1234';

-- Privilege 를 부여
GRANT ALL PRIVILEGES ON *.* to 'admin2';
SELECT * FROM mysql.user WHERE User = 'admin2';
GRANT SELECT ON *.* to 'app_service_acc2';
SELECT * FROM mysql.user WHERE User = 'app_service_acc2';

-- 권한의 집합을 다루는 단위 : Role
CREATE USER 'admin_acc'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'developer_acc'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'readonly_acc'@'localhost' IDENTIFIED BY '1234';
SELECT * FROM mysql.user;

CREATE ROLE admin;
CREATE ROLE developer;
CREATE ROLE readonly;

GRANT ALL PRIVILEGES ON *.* TO 'admin';
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'developer';
GRANT SELECT ON *.* TO 'readonly';
