/* 상호연관 서브쿼리(상관서브쿼리)
- 메인쿼리의 값을 서브쿼리가 사용하고, 서브쿼리의 결과값을 메인쿼리에서 사용
- 메인쿼리와 서브쿼리가 서로 조인된 형태로 동작
*************/
-- SELECT 절에 사용된 상관 서브 쿼리
SELECT * FROM ORDERS;
SELECT O.ORDERID, O.CUSTID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUST_NAME,
       O.BOOKID,
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOK_NAME
  FROM ORDERS O
;
----출판사별 평균 도서 가격보다 비싼 도서 목록을 구하시오
SELECT * FROM BOOK ORDER BY PUBLISHER, PRICE;
SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = '굿스포츠';
---
SELECT *
  FROM BOOK B
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = B.PUBLISHER)
;
--- 조인문(JOIN문)
---- 출판사별 평균 도서 가격
SELECT PUBLISHER, AVG(PRICE) AS AVG_PRICE
  FROM BOOK
 GROUP BY PUBLISHER
;
-- BOOK + 출판사별 평균도서 
SELECT *
  FROM BOOK B,
       (SELECT PUBLISHER, AVG(PRICE) AS AVG_PRICE
        FROM BOOK
        GROUP BY PUBLISHER) A
 WHERE B.PUBLISHER = A.PUBLISHER --조인조건
   AND B.PRICE > A.AVG_PRICE --검색(선택)조건
;
--==========================
-- EXISTS : 존재여부 확인시 사용(있으면 TRUE)
-- NOT EXISTS : 없으면 TRUE
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS)
;
-- ====> EXISTS 적용 : 데이터가 있으면 선택
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
SELECT *
  FROM CUSTOMER C
 WHERE EXISTS (SELECT CUSTID FROM ORDERS --컬럼에는 뭐가 오든 상관없다
               WHERE CUSTID = C.CUSTID)
;               
-- ====> NOT EXISTS 적용 : 데이터가 없으면 선택             
SELECT *
  FROM CUSTOMER C
 WHERE NOT EXISTS (SELECT CUSTID FROM ORDERS
               WHERE CUSTID = C.CUSTID)
; 

