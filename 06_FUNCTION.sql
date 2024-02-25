select * from registered_user;

INSERT INTO registered_user VALUES 
(null, 'Annie', 1995, 'New York', 180, '2024-02-23'),
(null, 'Kelly', 1998, 'London', 200, '2020-01-10'),
(null, 'Jason', 2000, 'Dubai', 185, '2023-02-23'),
(null, 'Cathy', 2010, 'Japan', 165, '2021-12-14');

SELECT 
	`name`,
	UPPER(`name`) AS CAPITAL_NAME,
    LOWER(`name`) AS LOWERCASE_NAME,
    LENGTH(`name`) AS STRING_LENGTH,
    SUBSTR(`name`, 2, 4) AS SUBSTRING, -- SUBSTR(문자열, 1로 시작하는 인덱스, 글자수)
    CONCAT(`name`, '회원이 등록되어 있습니다.') AS REGISTER_CHECK
FROM registered_user;
    
SELECT `name`, CHAR_LENGTH(`name`) FROM registered_user;
SELECT * FROM registered_user WHERE CHAR_LENGTH(`name`) = 5;

-- 함수 호출 없이도 글자 수를 필터링 할 수 있는 방법 
-- _, % 문자 사용 LIKE 검색
SELECT `name`, CHAR_LENGTH(`name`) FROM registered_user WHERE `name` LIKE "_____";
SELECT `name`, CHAR_LENGTH(`name`) FROM registered_user WHERE `name` LIKE "_____%";

-- 숫자함수 호출을 위해 컬럼 추가
ALTER TABLE registered_user ADD COLUMN weight DECIMAL(5, 2);
SHOW CREATE TABLE registered_user;
DESC registered_user;

SELECT * FROM registered_user;
UPDATE registered_user SET weight = 50 WHERE id IN (7, 13, 16);
UPDATE registered_user SET weight = 100.555 WHERE id IN (8, 12, 14, 15);
UPDATE registered_user SET weight = 75.555 WHERE id IN (6, 9, 10, 11);

SELECT
	`name`, height, weight,
    ROUND(weight, 0) AS 반올림_0번째_자리,
    TRUNCATE(weight, 1) AS 소수점_1자리_절사,
    MOD(height, 165) AS 키_165_MODULO,
    CEIL(weight) AS 몸무게_올림,
	FLOOR(weight) AS 몸무게_내림,
    SIGN(weight) AS 양음수_부호,
    SQRT(weight) AS 몸무게의제곱근
FROM registered_user;    
    
-- 날짜함수 DATE_ADD, LAST_DAT, TIMESTAMPDIFF, NOW()
SELECT NOW();
SELECT 
	`name`, registered_at,
    LAST_DAY(registered_at),
    DATE_ADD(registered_at, INTERVAL 60 DAY) AS _2개월_후,
    TIMESTAMPDIFF(DAY, registered_at, STR_TO_DATE('2024-02-23', '%Y-%m-%d')) AS 가입_경과일수
FROM registered_user;

-- 공식 문서, 라이브러리 등을 통해서 가용한 함수를 용도에 맞게 사용하는 것이 좋은 방법
-- 위 구문 예시를 통해서 기본 호출 구문 구조에 대해서 확인!!!