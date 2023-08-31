select id, name, kor, eng, math, total, avg
from student 
order by id
;
----------------
select * from student 
where id = '2023002'
order by id;

--update
update student 
   set kor = 95
     , eng = 85
     , math = 78
where id = '2023002'
;
----------------
--statement 방식 (문자열 붙이기 방식)
--아래 3개의 문장은 서로 다른 문장이다.
--해킹 가능성 있음
select id, name, kor, eng, math, total, avg
from student 
where id = '2023002'
;
select id, name, kor, eng, math, total, avg
from student 
where id = '2023003'
;
select id, name, kor, eng, math, total, avg
from student 
where id = '2023004'
;
----------------
--prepared 방식
--한번 분석하면 다시 분석하지 않고 값에 따라 다른 결과 출력
select id, name, kor, eng, math, total, avg
from student 
where id = :id
;
----------------
DELETE FROM STUDENT WHERE ID = :ID;

