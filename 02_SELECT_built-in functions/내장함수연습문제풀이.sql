--1. ABS(숫자) : 절대값
SELECT ABS(-15) FROM DUAL; -- 15
--2. CEIL(숫자) : 올림 
SELECT CEIL(15.7) FROM DUAL; -- 16
--3. COS : 코사인값을 반환
SELECT COS(3.14159) FROM DUAL;
--4. FLOOR(숫자) : 소수점 아래 버림
SELECT FLOOR(15.7) FROM DUAL;
--5. LOG(m,n) : 밑을 m으로 한 n의 로그값을 반환
SELECT LOG(10,100) FROM DUAL; --2
--6. MOD(숫자, 나누는수) : 나머지값을 반환
SELECT MOD(11,4) FROM DUAL; --3
--7. POWER(숫자, n) : 숫자의 n제곱 값 계산
SELECT POWER(3,2) FROM DUAL; 
--8. ROUND(숫자) : 반올림 - 소수점 이하 반올림
SELECT ROUND(15.7) FROM DUAL; --16
SELECT ROUND(15.7845, 2) FROM DUAL; --15.78
--9. SIGN(숫자) : 부호값 반환(양수: 1, 영: 0, 음수: -1)
SELECT SIGN(-15) FROM DUAL; -- -1
--10. TRUNC(숫자) : 정수만 남기고, 소수부 버림
SELECT TRUNC(15.7) FROM DUAL;
SELECT TRUNC(15.78964, 4) FROM DUAL; --15.7896
--11. CHR : 함수인자에 대응하는 문자를 반환
SELECT CHR(67) FROM DUAL; --C
--12. CONCAT(문자열1, 문자열2) : 문자열 연결 - 문자열1 || 문자열2
SELECT CONCAT('HAPPY ', 'Birthday') FROM DUAL;
--13. LOWER : 소문자로 변경
SELECT LOWER('Birthday') FROM DUAL;
--14. LPAD(대상문자열, 전체글자수, 삽입될문자) : 왼쪽에 삽입 (남는 부분의 처리)
SELECT LPAD('Page 1', 15, '*') FROM DUAL;
--15. LTRIM('문자열', '옵션') : 왼쪽에 있는 공백 제거
SELECT LTRIM('aeaePage 1', 'ae') FROM DUAL; --Page 1
--16. REPLACE(대상문자열, 찾을문자, 변경문자) : 문자열에서 찾은문자를 변경
SELECT REPLACE('JACK','J','BL') FROM DUAL; --BLACK
--17. RPAD(대상문자열, 전체글자수, 삽입될문자) : 오른쪽에 삽입
SELECT RPAD('PAGE1', 15, '*|') FROM DUAL; --PAGE1*|*|*|*|*|
--18. SUBSTR(대상, 시작위치, 길이) : 문자열의 일부 추출
--   (시작위치는 1부터 시작, 오른쪽에서 시작하는 경우 마이너스(-)값 사용)
SELECT SUBSTR('ABCDEFG', 3, 4) FROM DUAL; --CDEF
--19. TRIM(옵션 FROM '문자열') : 양쪽 공백 제거
SELECT TRIM(LEADING 0 FROM '00AA00') FROM DUAL; --AA00/LEADING 앞부분의 0을 제거해라
/*
LEADING 왼쪽에서 제거
TRAILING 오른쪽에서 제거
BOTH 양쪽에서 제거
*/
--20. UPPER : 대문자로 변경
SELECT UPPER('Birthday') FROM DUAL;
--21. ASCII : 주어진 문자의 첫문자의 아스키값에 상응하는 10진수값을 반환
SELECT ASCII('A') FROM DUAL; --65
SELECT ASCII('가') FROM DUAL; --15380608
SELECT ASCII('ABC') FROM DUAL; --65
--22. INSTR(대상, 찾는문자, 시작위치, nth) : nth 찾은값의 순서값(3 : 3번째 찾은 값)
SELECT INSTR('CORPORATE FLOOR', 'OR', 3, 2) FROM DUAL; --14
--23. LENGTH : 문자열의 길이(문자단위)
--    LENGTHB : 문자열의 길이(BYTE 단위)
SELECT LENGTH('Birthday') FROM DUAL;
SELECT LENGTHB('Birthday') FROM DUAL; --8
SELECT LENGTHB('생일') FROM DUAL; --6
--24. ADD_MONTHS(날짜, 개월수) : 개월수 만큼 월이 증가 또는 감소
SELECT ADD_MONTHS(TO_DATE('14/05/21', 'YY-MM-DD'), 4) FROM DUAL; --2014/09/21
SELECT ADD_MONTHS(TO_DATE('14/05/21', 'DD-MM-YY'), 4) FROM DUAL; --2021/09/14
--25. LAST_DAY(날짜) : 날짜가 속한 달의 마지막 날짜 구하기
SELECT LAST_DAY(SYSDATE) FROM DUAL; --2023/08/31
SELECT LAST_DAY(SYSDATE + 30) FROM DUAL; --2023/09/30
--26. NEXT_DAY(날짜, 요일) : 요일 날짜 구하기, 날짜 다음에 오는 첫번째 요일날짜(일) 구하기
SELECT NEXT_DAY(SYSDATE, '화') FROM DUAL;
--27. ROUND(SYSDATE, '옵션') : 날짜타입 반올림
SELECT SYSDATE FROM DUAL; --2023/08/09
SELECT ROUND(SYSDATE) FROM DUAL; --2023/08/10
SELECT ROUND(SYSDATE, 'MONTH') FROM DUAL; --2023/08/01
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL; --2024/01/01
--28. TO_CHAR : 문자타입으로 전환(날짜 -> 문자, 숫자 -> 문자)
SELECT TO_CHAR(SYSDATE) FROM DUAL; --2023/08/09(날짜 -> 문자)
SELECT TO_CHAR(123) FROM DUAL; --123
--29. TO_DATE : 날짜타입으로 전환(문자 -> 날짜)
SELECT TO_DATE('12 01 2014', 'DD MM YYYY') FROM DUAL; --2014/01/12(문자 -> 날짜)
--30. TO_NUMBER : 숫자타입으로 전환(문자 -> 숫자)
SELECT TO_NUMBER('12.3') FROM DUAL; --12.3(문자 -> 숫자)
--31. DECODE(x, y, a, b) : x = y이면 a를 출력, x =/= y일 경우 b를 출력
SELECT DECODE(1,1,'aa','bb') FROM DUAL; --aa
SELECT DECODE(1,2,'aa','bb') FROM DUAL; --bb
--32. NULLIF(a, b) : a와 b의 값이 같으면 null을 리턴, 그렇지 않으면 첫번째 인자를 리턴
SELECT NULLIF(123, 123) FROM DUAL; --NULL을 리턴
SELECT NULLIF(123, 400) FROM DUAL; --123 / 두개의 값이 같지 않으면 첫번째 인자를 리턴
--33. NVL(값, 지정값) : 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래값을 그대로 출력
SELECT NVL(NULL, 123) FROM DUAL; --123
SELECT NVL(1234, 123) FROM DUAL; --1234
