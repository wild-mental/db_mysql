-- WHERE 조건
SELECT * FROM registered_user;

-- 2022년 이전에 가입한 사람 또는 97년도 이전에 태어난 사람을 출력해 보자
select * from registered_user where registered_at < '2022-01-01' OR birth_year < 1997;

-- IN () 문법으로 주소가 일산, 경기 지역인 사람들만 출력
SELECT * FROM registered_user where address IN ('일산', '경기');
-- IN (sub query) 문법으로 구매 내역이 있는 유저만을 조회
SELECT * FROM product_order;
SELECT * FROM registered_user where id IN (SELECT user_id FROM product_order);

-- LIKE 검색 : 일치 검색이 아니라 문자열 포함으로 검색 가능
-- % 문자를 사용하면 0글자 이상 (wildcard 문자 '*' 와 같다)
SELECT * FROM registered_user WHERE name LIKE '%바%';
-- _ 문자를 사용하면 _하나당 1글자
SELECT * FROM registered_user WHERE name LIKE '__바';

-- BETWEEN 검색
SELECT * FROM registered_user WHERE height > 170 AND height < 180;
SELECT * FROM registered_user WHERE height BETWEEN 175 AND 180;  -- 앞 뒤 범위에 대해서 등호 처리를 수행

-- null 값에 대한 검색
INSERT INTO registered_user VALUES 
(null, '김자바', 1995, '서울', null, '2024-02-23'),
(null, '김자바', 1995, '서울', 200, null);
SELECT * FROM registered_user;
SELECT * FROM registered_user WHERE height = null;
SELECT * FROM registered_user WHERE registered_at is null;