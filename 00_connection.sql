show databases;
use my_first_db;
show tables;
use mysql;
show tables;

-- 연동된 프로젝트에서의 DB 접근
-- 로그인 계정이 아닌, user 계정 (로그인 없이 특정 리소스를 직접 호출 가능) => 데이터 베이스를 안전하게 불필요한 고수준의 DDL 권한 없이 접근하도록 함
-- DDL : Data Definition Language
-- DML : Data Modification Language
-- 프로그램 App 에서 DB 에 접속할 때 사용하는 계정은 user 계정으로, DML 에 대한 권한을 가지는 경우가 많다.

SELECT @@sql_mode;

-- ONLY_FULL_GROUP_BY
-- : 이 옵션이 활성화되면 GROUP BY 절에서 SELECT 목록에 있는 열 외에는 
--   GROUP BY 절에 명시되지 않은 열에 대한 집계 함수를 사용할 수 없습니다. 
--   이 옵션은 ANSI SQL 표준을 준수하여 GROUP BY 절의 엄격한 규칙을 적용합니다.

-- STRICT_TRANS_TABLES
-- : 이 옵션이 활성화되면, 데이터베이스 테이블에 데이터를 삽입 또는 수정할 때
--   엄격한 데이터 유형 검사를 수행합니다. 예를 들어, 잘못된 데이터 형식 또는
--   NULL 값을 포함한 경우에 오류를 반환합니다.

-- NO_ZERO_IN_DATE
-- : 이 옵션이 활성화되면 '0000-00-00'과 같은 "제로" 날짜가 유효하지 않은
--   날짜로 처리됩니다. 따라서 이 옵션을 사용하면 무효한 날짜에 대한 오류를 
--   방지할 수 있습니다.

-- NO_ZERO_DATE
-- : 이 옵션이 활성화되면 '0000-00-00'과 같은 "제로" 날짜를 데이터베이스에
--   삽입하거나 업데이트하는 것을 금지합니다. 이 옵션을 사용하면 무효한 날짜에
--   대한 오류를 방지할 수 있습니다.

-- ERROR_FOR_DIVISION_BY_ZERO
-- : 이 옵션이 활성화되면 0으로 나누기와 같은 나누기 오류가 발생할 때
--   오류를 반환합니다. 이 옵션을 사용하면 0으로 나누기 오류를 쉽게 식별하고
--   디버깅할 수 있습니다.

-- NO_ENGINE_SUBSTITUTION
-- : 이 옵션이 활성화되면 특정 스토리지 엔진이 사용할 수 없는 경우
--   오류를 발생시킵니다. 예를 들어, 특정 테이블에 InnoDB 엔진을 지정하지만
--   InnoDB 엔진을 사용할 수 없는 경우 오류가 발생합니다.