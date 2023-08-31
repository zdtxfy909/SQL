/* 함수(FUNCTION)
CREATE OR REPLACE FUNCTION FUNCTION1 (
  PARAM1 IN VARCHAR2 --파라미터(옵션)
) RETURN VARCHAR2  --리턴 데이터 타입 선언(필수)
AS 
BEGIN
  RETURN NULL; --리턴값(필수)
END;
------------------
-- 리턴 데이터 타입 선언 필요
RETURN 데이터유형

-- 프로그램 마지막(중간)에 값을 리턴하는 RETURN문이 필요(필수)
RETURN 리턴값;
********************/
-- BOOKID로 책제목 확인 함수(파라미터값:BOOKID, RETURN값:BOOKNAME)
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
    IN_ID IN NUMBER
) RETURN VARCHAR2 --리턴데이터 타입
AS
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
BEGIN
    SELECT BOOKNAME 
    INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME;
END;
---------------------
--동작여부 확인
SELECT GET_BOOKNAME(5) FROM DUAL;
--함수의 사용(SELECT, WHERE 절에서 사용)
----WHERE 절에서 함수 사용
SELECT O.*
     , GET_BOOKNAME(O.BOOKID) AS BOOKNAME
FROM ORDERS O
WHERE GET_BOOKNAME(O.BOOKID) LIKE '%축구%'
; 
----SELECT 절에서 사용
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID)
FROM BOOK;
--=======================
--(실습) 고객ID 값을 받아서 고객명을 돌려주는 함수 작성(CUSTOMER 테이블 사용)
-- 함수명 : GET_CUSTNAME
-- GET_CUSTNAME 함수 사용해서 고객명 검색 여부 확인해보기
-------------------
-- ORDERS 테이블 데이터 조회
---- GET_BOOKNAME, GET_CUSTNAME 함수사용 주문(판매)정보와 책제목, 고객명 조회
-------------------
create or replace FUNCTION GET_CUSTNAME (
   IN_ID IN NUMBER
) RETURN VARCHAR2
AS
    V_CUSTNAME CUSTOMER.NAME%TYPE;
BEGIN
    SELECT NAME
    INTO V_CUSTNAME
    FROM CUSTOMER
    WHERE CUSTID = IN_ID;

    RETURN V_CUSTNAME;
END;
-----
SELECT GET_CUSTNAME(1) FROM DUAL;
-----
SELECT O.*
    , GET_CUSTNAME(CUSTID) AS CUSTNAME
    , GET_BOOKNAME(BOOKID) AS BOOKNAME
FROM ORDERS O
;
--------------
-- 서브쿼리로 작성
SELECT O.*
    , (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) AS BOOKNAME
    , (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) AS CUSTNAME
FROM ORDERS O
;
--------------
-- JOIN
SELECT O.*
    , B.BOOKNAME
    , C.NAME
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
  AND O.CUSTID = C.CUSTID
;


