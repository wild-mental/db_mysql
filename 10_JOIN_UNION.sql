/*
	조인(JOIN)
    2개 이상의 테이블을 결합, 여러 테이블에 나누어 삽입된 연관된 데이터를 결합해주는 기능
    같은 내용의 컬럼이 존재해야만 사용할 수 있음.
    
    SELECT 테이블1.컬럼1, 테이블1.컬럼2 ... 테이블2.컬럼1, 테이블2.컬럼2...
    FROM 테이블1 JOIN 구문 테이블2
    ON 테이블1.공통컬럼 = 테이블2.공통컬럼;

	WHERE 구문을 이용해 ON 절로 합쳐진 결과 컬럼에 대한 필터링이 가능합니다.
*/

-- 예제 데이터를 삽입하기 위한 테이블 2개 생성(외래키는 걸지 않겠습니다.)
CREATE TABLE shop_client (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL,
    address VARCHAR(10) NOT NULL
);

CREATE TABLE purchase (
	id INT PRIMARY KEY AUTO_INCREMENT,
    shop_client_id INT,
    purchase_at DATETIME DEFAULT now(),
    total_price INT
);

-- 예제 데이터 삽입
INSERT INTO shop_client VALUES
	(null, '김회원', '서울'),
    (null, '박회원', '경기'),
    (null, '최회원', '제주'),
    (null, '박성현', '경기'),
    (null, '이성민', '서울'),
    (null, '강영호', '충북');

INSERT INTO purchase VALUES
	(null, 1, '2023-05-12', 50000),
    (null, 3, '2023-05-12', 20000),
    (null, 4, '2023-05-12', 10000),
    (null, 1, '2023-05-13', 40000),
    (null, 1, '2023-05-14', 30000),
    (null, 3, '2023-05-14', 30000),
    (null, 5, '2023-05-14', 50000),
    (null, 5, '2023-05-15', 60000),
    (null, 1, '2023-05-15', 15000);

-- 학생 실습용 테이블
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(10) NOT NULL,
    location VARCHAR(10) NOT NULL
);

CREATE TABLE post (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_date DATETIME DEFAULT now(),
    content VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- 예제 데이터 삽입
INSERT INTO user VALUES
    (null, 'bob456', '경기'),
    (null, 'david_park', '경기'),
    (null, 'charlie789', '제주'),
    (null, 'frank_kang', '충북'),
    (null, 'emilylee', '서울'),
    (null, 'alice123', '서울');

INSERT INTO post VALUES
    (null, 6, '2023-05-12 10:00:00', '안녕하세요, 첫 번째 게시글입니다.'),
    (null, 4, '2023-05-12 11:30:00', '오늘의 일기를 공유합니다.'),
    (null, 5, '2023-05-12 12:45:00', '오늘도 열심히 일했습니다.'),
    (null, 6, '2023-05-13 09:20:00', '오늘의 일정을 공유합니다.'),
    (null, 6, '2023-05-14 14:00:00', '즐거운 주말 보내세요.'),
    (null, 3, '2023-05-14 15:30:00', '오늘의 감정을 공유합니다.'),
    (null, 1, '2023-05-14 16:45:00', '오늘의 소식을 전합니다.'),
    (null, 2, '2023-05-15 08:00:00', '좋은 아침입니다.'),
    (null, 6, '2023-05-15 09:30:00', '오늘의 일정을 업데이트합니다.');

SELECT * FROM shop_client;
SELECT * FROM purchase;
-- INNER JOIN 예제
SELECT shop_client.id, shop_client.name, shop_client.address,
		purchase.purchase_at, purchase.id, purchase.total_price
FROM shop_client INNER JOIN purchase
ON shop_client.id = purchase.shop_client_id;

-- FROM 절에서 테이블명을 지정할 때, FROM 테이블명 별칭1 JOIN 테이블명 별칭2
-- 형식을 사용하면 별칭을 테이블명 대신 쓸 수 있습니다.
-- INNER JOIN 테이블 별칭 사용 예제
SELECT c.id, c.name, c.address,
		p.purchase_at, p.id, p.total_price
FROM shop_client c INNER JOIN purchase p
ON c.id = p.shop_client_id;

-- LEFT (OUTER) JOIN, RIGHT (OUTER) JOIN 은,
-- JOIN 절 왼쪽이나 오른쪽 테이블 데이터를 남기고
-- 반대쪽방향 테이블은 교집합만 남깁니다.
-- LEFT OUTER JOIN 예제
SELECT p.id, c.name, c.address,
		p.purchase_at, p.id, p.total_price
FROM shop_client c LEFT JOIN purchase p
ON c.id = p.shop_client_id;

SELECT * FROM purchase;
-- RIGHT JOIN 확인을 위한 데이터 생성
INSERT INTO purchase VALUES
	(null, 8, '2023-05-16', 25000),
    (null, 9, '2023-05-16', 25000),
    (null, 8, '2023-05-17', 35000);
-- RIGHT OUTER JOIN 예제
SELECT p.id, c.name, c.address,
		p.purchase_at, p.id, p.total_price
FROM shop_client c RIGHT JOIN purchase p
ON c.id = p.shop_client_id;


-- MySQL 에서는 FULL OUTER JOIN 을 지원하지 않습니다.
-- 따라서 뒤에서 배울 UNION 이라는 구문을 응용해 처리합니다.

-- 조인할 컬럼명이 동일하다면, ON 대신 USING(공통컬럼명) 구문을 대신 써도 됩니다.
ALTER TABLE shop_client RENAME COLUMN id TO shop_client_id;
SELECT * FROM shop_client;
SELECT c.shop_client_id, c.name, c.address,
		p.id, p.purchase_at, p.shop_client_id, p.total_price
FROM shop_client c LEFT JOIN purchase p
USING (shop_client_id);

-- CROSS JOIN 은 조인 대상인 테이블1과 테이블2간의 모든 ROW 의 조합쌍을 출력합니다.
-- 이해하기 쉬운 예시
CREATE TABLE phone_volume(
	volume varchar(3),
    model_name varchar(10)
);
CREATE TABLE phone_color(
	color varchar(5)
);
INSERT INTO phone_volume VALUES
	(128, 'galaxy'),
    (256, 'galaxy'),
    (512, 'galaxy'),
    (128, 'iphone'),
    (256, 'iphone'),
    (512, 'iphone');
INSERT INTO phone_color VALUES
	('빨간색'),
    ('파란색'),
    ('노란색'),
    ('회색');

-- 여러분들이 직접 크로스조인 결과를 보면서 모든 조합쌍이 나왔는지 체크해주세요.
SELECT * FROM phone_volume CROSS JOIN phone_color;

-- SELF조인은 자기 테이블 내부 자료를 참조하는 컬럼이 있을때
-- 해당 자료를 온전하게 노출시키기 위해서 사용하는 경우가 대부분입니다.
-- 예시로는 사원 목록중 자기 자신과 직속상사를 나타내거나 게시판에서 원본글과 답변글을 나타내는 경우
-- 연관된 자료를 한 테이블 형식으로 조회하기 위해 사용합니다.
CREATE TABLE staff(
	staff_num INT AUTO_INCREMENT PRIMARY KEY,
    staff_name VARCHAR(20),
    staff_job VARCHAR(20),
    staff_salary INT,
    staff_supervisor INT
);

INSERT INTO staff VALUES
	(NULL, '설민경', '개발', 30000, NULL),
    (NULL, '윤동석', '총무', 25000, NULL),
    (NULL, '하영선', '인사', 18000, NULL),
    (NULL, '오진호', '개발', 5000, 1),
    (NULL, '류민지', '개발', 4500, 4),
    (NULL, '권기남', '총무', 4000, 2),
    (NULL, '조예지', '인사', 3200, 3),
    (NULL, '배성은', '개발', 3500, 5);
SELECT * FROM staff;
-- SELF JOIN을 이용해 직원이름과 상사이름이 같이 나오게 만들어보겠습니다.
-- SELF JOIN은 테이블 자기 자신을 자기가 참조하도록 만들기 때문에
-- JOIN시 테이블명은 좌, 우 같은 이름으로, AS를 이용해서 부여한 별칭은 다르게 해서
-- 좌측과 우측 테이블을 구분하면 됩니다. 이외에는 모두 같습니다.
SELECT
	r.staff_num, l.staff_name as 상급자이름, r.staff_name as 하급자이름
FROM
	staff as l INNER JOIN staff as r
ON
	l.staff_num = r.staff_supervisor;

-- NATURAL JOIN 예제
-- personal_info1 테이블 생성
CREATE TABLE personal_info1 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);
-- personal_info2 테이블 생성
CREATE TABLE personal_info2 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    city VARCHAR(50)
);
-- personal_info1 테이블 더미 데이터 삽입
INSERT INTO personal_info1 (name, age) VALUES
    ('John', 25),
    ('Alice', 30),
    ('Bob', 28),
    ('Eva', 35),
    ('David', 40),
    ('Sophia', 27),
    ('Michael', 33),
    ('Emma', 29),
    ('James', 45),
    ('Olivia', 22),
    ('William', 38),
    ('Mia', 31),
    ('Alexander', 36),
    ('Charlotte', 26),
    ('Daniel', 41);
-- personal_info2 테이블 더미 데이터 삽입
INSERT INTO personal_info2 (name, city) VALUES
    ('John', 'Seoul'),
    ('Alice', 'Busan'),
    ('Bob', 'Daegu'),
    ('Eva', 'Incheon'),
    ('David', 'Gwangju'),
    ('Sophia', 'Daejeon'),
    ('Michael', 'Ulsan'),
    ('Emma', 'Sejong'),
    ('James', 'Gyeonggi'),
    ('Olivia', 'Gangwon'),
    ('William', 'Chungcheong'),
    ('Mia', 'Jeolla'),
    ('Alexander', 'Gyeongsang'),
    ('Charlotte', 'Jeju'),
    ('Daniel', 'Foreign');
SELECT *
FROM personal_info1
NATURAL JOIN personal_info2;

-- 자연조인은 이름이 같은 "모든!!!!!!" 컬럼을 기준으로 동등 JOIN 을 수행
-- personal_info3 테이블 생성
CREATE TABLE personal_info3 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);
-- personal_info3 테이블 더미 데이터 삽입
INSERT INTO personal_info3 (name, age) VALUES
    ('Daniel', 41),
    ('John', 25),
    ('Alice', 30),
    ('Bob', 28),
    ('Eva', 35),
    ('David', 40),
    ('Sophia', 27),
    ('Michael', 33),
    ('Emma', 29),
    ('James', 45),
    ('Olivia', 22),
    ('William', 38),
    ('Mia', 31),
    ('Alexander', 36),
    ('Charlotte', 26);
-- 자연조인 수행
SELECT *
FROM personal_info2
NATURAL JOIN personal_info3;
-- 이처럼, 자연조인은 생각지 않은 일치 판단 기준 컬럼 발생으로 결과 왜곡이 가능하므로
-- 명시적 조건을 사용하는 조인을 사용하는 것이 좋다


-- ---------------------------------------
-- UNION
-- ---------------------------------------

-- UNION은 SELECT문 두 개를 위 아래로 배치해서 양쪽 결과를 붙여줍니다.
-- 수직적확장을 고려할때 주로 사용합니다.
-- 고양이 테이블 생성
CREATE TABLE CAT (
	animal_name VARCHAR(20),
    animal_age INT,
    animal_owner VARCHAR(20),
    animal_type VARCHAR(20)
);
-- 강아지 테이블 생성
CREATE TABLE DOG (
	animal_name VARCHAR(20),
    animal_age INT,
    animal_owner VARCHAR(20),
	animal_type VARCHAR(20)
);

-- 고양이 2마리, 강아지 2마리 넣기
INSERT INTO cat VALUES
	('룰루', 4, '룰맘', '고양이'),
    ('어완자', 5, '양정', '고양이');
INSERT INTO dog VALUES
	('턱순이', 7, '이영수', '강아지'),
    ('구슬이', 8, '이영수', '강아지');

-- UNION으로 결과 합치기
SELECT * FROM CAT
UNION
SELECT * FROM DOG;


-- MySQL은 FULL OUTER JOIN을 UNION을 이용해서 합니다.
-- LEFT 조인 구문 UNION RIGHT 조인구문
-- 순으로 작성하면 됩니다.

SELECT p.id, m.name, m.address,
		p.purchase_at, p.id, p.total_price
FROM shop_client m LEFT JOIN purchase p
ON m.id = p.id
UNION
SELECT p.id, m.name, m.address,
		p.purchase_at, p.id, p.total_price
FROM shop_client m RIGHT JOIN purchase p
ON m.id = p.id
WHERE m.id IS NULL;
