--PL/SQL 프로시저(PROCEDURE) - 오라클
--SET SERVEROUTPUT ON; >> SYSTEM 유저에서 실행
SET SERVEROUTPUT ON; --서버쪽 출력화면을 볼 수 있게 설정

DECLARE --변수 선언
    V_EMPID NUMBER(10);
    V_NAME VARCHAR(30);
BEGIN --실행문 작성영역(시작)
    V_EMPID := 100; --치환문(대입문) 부호(콜른이퀄 :=) 사용
    V_NAME := '홍길동';
    
    --화면출력
    DBMS_OUTPUT.PUT_LINE('HELLO PROCEDURE');
    DBMS_OUTPUT.PUT_LINE(V_EMPID || ':' || V_NAME);
    
END; --실행문 작성영역(끝)
--------------------
-- BOOK 테이블 데이터를 화면 출력
DECLARE --변수 선언
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN --실행문 작성영역(시작)
    -- SELECT ~ INTO ~ FROM 형태로 DB 데이터를 선택하고 INTO절에 있는 변수에 저장
    -- 1개의 데이터만 처리가 가능하다
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK 
    WHERE BOOKID = 4;

    DBMS_OUTPUT.PUT_LINE(V_BOOKID || ', ' || V_BOOKNAME || ', ' || 
            V_PUBLISHER || ', ' || V_PRICE);
    
END; --실행문 작성영역(끝)
--======================
/* 저장 프로시저(stored procedure)
매개변수(파라미터, parameter) 유형
- IN : 입력을 받기만 하는 변수형태(기본값, 생략하면 IN)
- OUT : 출력만 하는 변수형태
        (값을 전달 받을 수 없고, 
         프로시저를 실행 후 변수에 저장된 값을 호출한 곳으로 전달한다.) 
- IN OUT : 입력도 받고, 값을 변수를 통해서 호출한 곳으로 전달(출력)한다.
*************************/
CREATE OR REPLACE PROCEDURE BOOK_DISP --프로시저 선언부
AS --변수선언부(AS 또는 IS ~ BEGIN문 사이)
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN --실행문 작성영역(시작)
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK 
    WHERE BOOKID = 4;

    DBMS_OUTPUT.PUT_LINE(V_BOOKID || ', ' || V_BOOKNAME || ', ' || 
            V_PUBLISHER || ', ' || V_PRICE);
    
END; --실행문 작성영역(끝)
    


