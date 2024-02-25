CREATE TABLE registered_user (
	id bigint PRIMARY KEY AUTO_INCREMENT,
    name varchar(10) NOT NULL,  -- DEFAULT NULL
    birth_year int NOT NULL,
    address varchar(20) NOT NULL,
    height int, -- DEFAULT NULL 생략 가능 (NULLABLE 컬럼)
    registered_at date  -- 데이터 발생 일시 created_at 을 많이 사용
);
/*
SHOW CREATE TABLE registered_user;
CREATE TABLE `registered_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `birth_year` int NOT NULL,
  `address` varchar(20) NOT NULL,
  `height` int DEFAULT NULL,
  `registered_at` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci -- COLLATE 는 일관성 유지를 위해 향후 세부 조정 필요
*/

-- Insert 구문 : INSERT INTO <table_name> [(col1Name, col2Name, ...)] VALUES ();  -- 컬럼구성과 일치하는 구성의 값을 집어넣으면 컬럼 명칭 명시 불필요
INSERT INTO registered_user (`id`,`name`,`birth_year`,`address`,`height`,`registered_at`) VALUES
(1, '사용자1', 2000, '우리집', 180, now());
select * from registered_user;

-- 여러 행 동시 삽입 가능, colNames 작성 생략 가능
INSERT INTO registered_user VALUES
(2, '사용자2', 2001, '우리집', 180, now()),
(3, '사용자2', 2002, '우리집', 180, now());

INSERT INTO registered_user VALUES
(null, '사용자4', 2004, '우리집', null, null),
(null, '사용자5', 2005, '우리집', null, null);

-- UPDATE 구문 : UPDATE <table_name> SET <col_name> = <value> WHERE <condition>;
UPDATE registered_user SET height = 200 WHERE id = 4;
select * from registered_user;

-- DELETE 구문 : DELETE FROM registered_user WHERE <condition>;
DELETE FROM registered_user WHERE id = 3;
select * from registered_user;
DELETE FROM registered_user WHERE id > 3;
-- safe mode 적용시 조건이 없는 경우 또는 식별자가 아닌 조건을 적용한 경우에는 UPDATE 와 DELETE 금지
set SQL_SAFE_UPDATES = 0;
set SQL_SAFE_UPDATES = 1;
-- 환경 변수 종류에 따라 Daemon 재시작이 반드시 필요한 경우가 있음

INSERT INTO registered_user VALUES 
(null, '김자바', 1995, '서울', 175, '2024-02-23'),  -- date 타입의 리터럴 'YYYY-MM-DD'
(null, '이JS', 1996, '경기', 167, '2023-02-23'),
(null, '박Python', 1997, '대전', 185, '2022-02-23'),
(null, '최HTTP', 1998, '부산', 180, '2021-02-23'),
(null, '정CSS', 1999, '일산', 179, '2020-02-23');

DELETE FROM registered_user where address = '우리집';