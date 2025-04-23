-- 함수
-- if함수
use mytestdb;
select empno,ename,sal,if(sal>2000,'경력','신입') as info
from emp;
-- comm이 null이면 1000을 출력하고 nulll이 아니면 comm값을 그대로 출력하기
-- 연봉은 comm이 null인 경우 comm대신 1000이 더해지도록 하고 null이 아니면 그대로 계산
select empno,ename,sal,if(comm is null,1000,comm) as comm from emp;
select empno,ename,sal,ifnull(comm,1000) as comm from emp;
select empno,ename,sal,ifnull(comm,1000) as comm,ifnull(sal*12+comm,sal*12 +1000) as sal from emp;

-- 관리자별 인원수
-- 관리자가 null이면 '관리자 없음'으로 출력
select ifnull(mgr,'관리자 없음') as '관리자 번호',count(empno)
from emp
group by mgr
order by count(empno) desc;

-- 문자열관련함수
select upper('test'),lower('TEST');

select instr('java programming','a');

select lpad('test',10,'*'),rpad('test',10,'*');
select length('      test         '),ltrim('      test         '),
rtrim('      test         '),trim('      test         '),length(trim('      test         '));

-- 수학
select round(195.589),round(195.589,2),round(185.589,-1),round(195.589,0);
select ceiling(195.589),ceiling(195.589),ceiling(185.589),ceiling(195.589);
select floor(195.589),floor(195.589),floor(185.589),floor(195.589);

select sysdate(),curdate(),curtime(),now(),localtime(),localtimestamp();

select date_format(now(),'%Y'),date_format(now(),'%y'),date_format(now(),'%m'),date_format(now(),'%d');
select date_format(now(),'%Y년 %m월 %d일');