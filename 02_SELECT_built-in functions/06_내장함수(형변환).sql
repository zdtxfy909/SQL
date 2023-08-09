﻿/************************************************
형변환 내장함수
TO_CHAR : 문자타입으로 전환(날짜 -> 문자, 숫자 -> 문자)
TO_NUMBER : 숫자타입으로 전환(문자 -> 숫자)
TO_DATE : 날짜타입으로 전환(문자 -> 날짜)

      <- TO_NUMBER(문자)  -> TO_DATE(문자)
숫자형   ----    문자형   ----     날짜형
      -> TO_CHAR(숫자)   <- TO_CHAR(날짜)
************************************************
--날짜 -> 문자
TO_CHAR(날짜데이터, '출력형식')
<출력형식>
년도(YYYY, YY), 월(MM), 일(DD)
시간 : HH, HH12(12 시간제), HH24(24 시간제)
분(MI), 초(SS)
오전, 오후: AM, PM
년월일시분초 작성예) YYYY-MM-DD HH24:MI:SS
************************************************/
--TO_CHAR : 문자타입으로 전환(날짜 -> 문자, 숫자 -> 문자)
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; --날짜형, 날짜를 문자로
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; --수요일
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DY') FROM DUAL; --수
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD(DY)') FROM DUAL; --(수)

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; --24시간제. 기본
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL; --12시간제
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS') FROM DUAL; --오전/오후 붙여서
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH:MI:SS') FROM DUAL; --오전/오후 붙여서
--==============================
/* TO_CHAR(숫자, '출력형식') : 숫자 -> 문자타입
<형식지정>
0(영) : 자리수를 나타내며, 자리수가 맞지 않는 경우 0을 표시
9(구) : 자리수를 나타내며, 자리수가 맞지 않는 경우 표시하지 않음
L : 지역 통화 문자 표시
.(점) : 소수점
,(콤마) : 1000단위 구분 표시 문자
**************************************/
SELECT 123000, '123000', TO_CHAR(123000) FROM DUAL; --숫자, 문자, 숫자를 문자로
SELECT 123000 + 9, '123000' + 9 FROM DUAL; --123009, 123009(자동형변환)
SELECT '123000' + 9 FROM DUAL; --자동형변환(문자 ---> 숫자) 후 덧셈연산
SELECT '123ABC' + 9 FROM DUAL; --ORA-01722: invalid number

--묵시적(자동)형변환, 명시적 형변환
SELECT 123000 + 9, TO_NUMBER('123000') + 9 FROM DUAL; --숫자, 문자를 숫자로
-------------
--형식문자를 지정
SELECT TO_CHAR(123456, 'L999,999,999') FROM DUAL; --￦123,456
SELECT TO_CHAR(123456, 'L000,000,000') FROM DUAL; --￦000,123,456

--                   ￦0                       ￦000,000,000    
SELECT TO_CHAR(0, 'L999,999,999'), TO_CHAR(0, 'L000,000,000') FROM DUAL; 

SELECT TO_CHAR(1230.4, 'L999,999,999'), TO_CHAR(1230.4, 'L000,000,000') FROM DUAL;
--                       ￦1,230                          ￦000,001,230
SELECT TO_CHAR(1230.5, 'L999,999,999'), TO_CHAR(1230.5, 'L000,000,000') FROM DUAL;
--                       ￦1,231                          ￦000,001,231
SELECT TO_CHAR(1230.5555, 'L999,999,999.99'), TO_CHAR(1230.5555, 'L000,000,000.00') FROM DUAL;
--                         ￦1,230.56                            ￦000,001,230.56
SELECT TO_CHAR(1230, 'L999,999,999.99'), TO_CHAR(1230, 'L000,000,000.00') FROM DUAL;
------------------
--TO_DATE(문자열, 형식문자) ---> 날짜타입
SELECT '2023-08-09', SYSDATE FROM DUAL; -- 문자열, 날짜형
SELECT '2023-08-09' + 1 FROM DUAL; --ORA-01722: invalid number
SELECT SYSDATE + 1 FROM DUAL;

SELECT TO_DATE('2023-08-09') + 1 FROM DUAL; 
--날짜타입 형변환하면 날짜 연산 가능하지만 명시적으로 연월일을 써줘야 오류가 안남.
SELECT TO_DATE('2023-08-09', 'YYYY-MM-DD') + 1 FROM DUAL; 
--(주의) 날짜타입으로 형변환시에는 형식지정문자를 반드시 사용하기를 권장
SELECT TO_DATE('20230809', 'YYYY-MM-DD') + 1 FROM DUAL; 

SELECT ORDERID, ORDERDATE 
      ,TO_CHAR(ORDERDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM ORDERS;
----------
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
      ,TO_CHAR(TRUNC(SYSDATE),'YYYY-MM-DD HH24:MI:SS') --시분초 날라감
      ,TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

