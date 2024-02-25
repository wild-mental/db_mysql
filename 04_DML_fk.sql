CREATE TABLE product_order (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    user_id bigint NOT NULL,  -- 관계가 의미적으로는 드러나지만 스키마에 KEY 로 적용되지 않은 사례
    product_name varchar(10) NOT NULL, -- 일단 큰 값으로 텍스트 데이터 등 데이터 타입 정의, 이후 개발 완료 및 성능 튜닝이 필요한 경우 조정
    product_category varchar(10) NOT NULL,
    price int NOT NULL,
    amount int NOT NULL
);

INSERT INTO product_order VALUES(null, 6, '색소폰', '금관악기', 450000, 1);
INSERT INTO product_order VALUES(null, 7, '갤럭시 fit5', '스마트 워치', 100000, 30);
select * from product_order;
select * from registered_user;
INSERT INTO product_order VALUES(null, 99, '아이패드', '태블릿 피씨', 800000, 1);

-- FK 가 제대로 들어간 테이블 생성하기
CREATE TABLE product_order_fk (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    user_id bigint NOT NULL,  -- 관계가 의미적으로는 드러나지만 스키마에 KEY 로 적용되지 않은 사례
    product_name varchar(10) NOT NULL, -- 일단 큰 값으로 텍스트 데이터 등 데이터 타입 정의, 이후 개발 완료 및 성능 튜닝이 필요한 경우 조정
    product_category varchar(10) NOT NULL,
    price int NOT NULL,
    amount int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES registered_user(id)
);
INSERT INTO product_order_fk VALUES(null, 6, '색소폰', '금관악기', 450000, 1);
INSERT INTO product_order_fk VALUES(null, 7, '갤럭시 fit5', '스마트 워치', 100000, 30);
SELECT * from product_order_fk;
INSERT INTO product_order_fk VALUES(null, 99, '아이패드', '태블릿 피씨', 800000, 1);
/* Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails
 (`su_camp`.`product_order_fk`, CONSTRAINT `product_order_fk_ibfk_1` FOREIGN KEY (`user_id`) 
 REFERENCES `registered_user` (`id`)) */

-- FK 키를 중간에 생성해 주기
ALTER TABLE product_order
ADD CONSTRAINT fk_productorder_userid
FOREIGN KEY (user_id) REFERENCES registered_user(id);

SELECT id FROM registered_user;
DELETE FROM product_order WHERE user_id NOT IN (SELECT id FROM registered_user);

/* Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
(`su_camp`.`#sql-396_8`, CONSTRAINT `fk_productorder_userid` FOREIGN KEY (`user_id`) 
REFERENCES `registered_user` (`id`)) */ 

SHOW CREATE TABLE product_order;
/*
CREATE TABLE `product_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `product_name` varchar(10) NOT NULL,
  `product_category` varchar(10) NOT NULL,
  `price` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productorder_userid` (`user_id`),
  CONSTRAINT `fk_productorder_userid` FOREIGN KEY (`user_id`) REFERENCES `registered_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
*/