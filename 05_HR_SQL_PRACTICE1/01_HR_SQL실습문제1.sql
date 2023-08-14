/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
--1) 사번(employee_id)이 100인 직원 정보 전체 보기
--2) 월급(salary)이 15000 이상인 직원의 모든 정보 보기
--3) 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
--4) 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
--5) 이름(first_name)이 john인 사원의 모든 정보 조회
--6) 이름(first_name)이 john인 사원은 몇 명인가?
--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
--8) 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
--9) 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
--10) 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
---------------------------------
--11) 직종별 최대 월급여 검색 (group by)
--12) 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
--13) 직종별 평균급여 이상인 직원 조회
*****************************/
SELECT * FROM EMPLOYEES;
--1) 사번(employee_id)이 100인 직원 정보 전체 보기
SELECT *
FROM employees
WHERE employee_id = 100
;
--2) 월급(salary)이 15000 이상인 직원의 모든 정보 보기
SELECT *
FROM employees
WHERE salary >= 15000
;
--3) 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 
----입사일(hire_date), 월급여 정보 보기
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE salary >= 15000
;
--4) 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 
----입사일, 월급여 정보 보기(급여가 많은 사람부터)
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE salary <= 10000
ORDER BY salary DESC
;
--5) 이름(first_name)이 john인 사원의 모든 정보 조회
SELECT *
FROM employees
WHERE lower(first_name) = 'john'
;
--6) 이름(first_name)이 john인 사원은 몇 명인가?
SELECT 'John' AS FIRST_NAME, COUNT(*) 
FROM employees
WHERE lower(first_name) = 'john'
;
--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
SELECT employee_id, 
       CONCAT(first_name, last_name) "first_name last_name", 
       salary
FROM employees
WHERE HIRE_DATE > TO_DATE('2007/12/31', 'YYYY/MM/DD')
;
--8) 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT employee_id, 
       CONCAT(first_name, last_name) "first_name last_name", 
       salary
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000
;
--9) 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
SELECT *
FROM EMPLOYEES
WHERE manager_id IS NULL
;
--10) 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
SELECT MAX(salary)
FROM EMPLOYEES
WHERE job_id = 'IT_PROG'
;
---------------------------------
--11) 직종별 최대 월급여 검색 (group by)
SELECT job_id, MAX(salary)
FROM EMPLOYEES
GROUP BY job_id
;
--12) 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
SELECT job_id, MAX(salary)
FROM EMPLOYEES
GROUP BY job_id
HAVING MAX(salary) >= 10000
;
--13) 직종별 평균급여 이상인 직원 조회
SELECT  J.*, E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E,
    (SELECT JOB_ID, AVG(SALARY) AS AVG_SALARY
       FROM EMPLOYEES GROUP BY JOB_ID) J --직종(직무)별 평균급여
WHERE e.job_id = J.job_id
  AND E.SALARY >= J.avg_salary
;


