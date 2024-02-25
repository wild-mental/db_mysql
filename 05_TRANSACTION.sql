# 은행 송금에서의 트랜젝션 처리

CREATE TABLE bank_account (
    account_number int PRIMARY KEY AUTO_INCREMENT,
    account_owner VARCHAR(10) NOT NULL,
    balance INT(20) DEFAULT 0 NOT NULL
);
SHOW CREATE TABLE bank_account;
SELECT * FROM bank_account;

-- 2사람의 계좌에 대한 송금 처리 (판매자, 구매자) 상황에서 둘 중 한사람에 대한 처리 (출금 only, 입금 only)
-- All or Nothing 처리가 보장 되어야 한다.

INSERT INTO bank_account VALUES
	(null, '김셀러', 0),
	(null, '이구매', 500000);

-- CASE 1 : 성공 케이스 - COMMIT 으로 종료    
START TRANSACTION;
UPDATE bank_account SET balance = (balance - 100000) WHERE account_owner = '이구매';
UPDATE bank_account SET balance = (balance + 100000) WHERE account_owner = '김셀러';
SELECT * FROM bank_account;
COMMIT;

-- CASE 2 : 실패 케이스 - ROLLBACK 으로 종료
START TRANSACTION;
UPDATE bank_account SET balance = (balance - 100000) WHERE account_owner = '이구매';
-- 김셀러가, 첫구매자만 10만원 혜택 : 상품 가액 (150000)에 맞지 않으면 송금을 아예 취소해버리는 세팅
-- UPDATE bank_account SET balance = (balance + 100000) WHERE account_owner = '김셀러';
SELECT * FROM bank_account;
ROLLBACK;
SELECT * FROM bank_account;

-- 트랜젝션 처리에서 트랜잭션의 시작과, 실행취소 또는 영구반영 동작을 조건, 처리 순서에 따라서 적절히 편성하면 
-- 데이터 일관성을 확보할 수 있다. => 합계 금액 정합성 보장

-- CASE 3 : 일부 반영 필요한 경우 - 구간별 반영 필요한 경우 SAVEPOINT 사용
INSERT INTO bank_account VALUES
	(null, '나중개', 0);
START TRANSACTION;
UPDATE bank_account SET balance = (balance - 5000) WHERE account_owner = '이구매';
UPDATE bank_account SET balance = (balance + 5000) WHERE account_owner = '나중개';
SAVEPOINT commission_paid;
UPDATE bank_account SET balance = (balance - 100000) WHERE account_owner = '이구매';
-- 김셀러가, 첫구매자만 10만원 혜택 : 상품 가액 (150000)에 맞지 않으면 송금을 아예 취소해버리는 세팅
-- UPDATE bank_account SET balance = (balance + 100000) WHERE account_owner = '김셀러';
-- ROLLBACK;
ROLLBACK TO commission_paid;
COMMIT;
SELECT * FROM bank_account;
-- 수수료 지불 완료 후 거래는 취소
