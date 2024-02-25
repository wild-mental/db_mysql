-- DDL : Data Definition Language
-- 데이터 스키마를 다루는 구문을 DDL 이라 함

-- 테이블 생성 (물리 모델링의 산출물 / 명세서보다 더 명확함)
CREATE TABLE app_user(
  	u_number INT PRIMARY KEY,
  	u_id VARCHAR(20) UNIQUE NOT NULL,  -- VARCHAR 를 사용하면 해당 길이 미만 TEXT 데이터가 입력될 시 저장 공간이 절약된다.
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(80)
);
SHOW CREATE TABLE app_user;
/*
CREATE TABLE `app_user` (
  `u_number` int NOT NULL,
  `u_id` varchar(20) NOT NULL,
  `u_name` varchar(30) NOT NULL,
  `email` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`u_number`),  -- KEY 에 대해서 별도 행으로 표시하는 방식이 : 물리적 저장 구조를 반영해 준다.
  UNIQUE KEY `u_id` (`u_id`)  -- UNIQUE KEY 도 unique 검사를 위한 index 생성이 이루어짐 : 물리적 저장 데이터가 추가됨
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
*/
ALTER TABLE app_user ADD COLUMN (u_address varchar(30));
SHOW CREATE TABLE app_user;
/* 
CREATE TABLE `app_user` (
  `u_number` int NOT NULL,
  `u_id` varchar(20) NOT NULL,
  `u_name` varchar(30) NOT NULL,
  `email` varchar(80) DEFAULT NULL,
  `u_address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`u_number`),
  UNIQUE KEY `u_id` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
*/
ALTER TABLE app_user DROP COLUMN email;
/*
CREATE TABLE `app_user` (
  `u_number` int NOT NULL,
  `u_id` varchar(20) NOT NULL,
  `u_name` varchar(30) NOT NULL,
  `u_address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`u_number`),
  UNIQUE KEY `u_id` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
*/
ALTER TABLE app_user ADD COLUMN email varchar(30);
ALTER TABLE app_user RENAME COLUMN email TO u_email;

-- 도메인 Domain : 논리 데이터 모델링 결과물 - 값의 범위에 대한 정의
ALTER TABLE app_user ADD CONSTRAINT udx_uaddress UNIQUE (u_address);
ALTER TABLE app_user DROP CONSTRAINT udx_uaddress;

RENAME TABLE app_user TO member;
SHOW CREATE TABLE member;
SHOW CREATE TABLE app_user;  -- 여전히 나온다.
select * from member;
select * from app_user;

INSERT INTO app_user VALUES (1, 'abc3456', '마바사', '우리집', 'abc@ab.com');
INSERT INTO app_user VALUES (2, 'def3456', '마바사', '너희집', 'abc@ab.com');

TRUNCATE TABLE app_user;
DROP TABLE app_user;  -- 스키마까지 완전히 날린다.