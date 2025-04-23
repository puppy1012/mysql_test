-- group by 활용
use mytestdb;
select job,sum(sal) from emp
group by job;

select sum(sal),max(sal),min(sal),avg(sal),count(sal)
from emp;

-- 일반함수와 그룹함수의 차이
use mytestdb;
select ename,length(ename) from emp
where length(ename)>=5;

select sum(sal),max(sal),min(sal),avg(sal),count(sal)
from emp;

select ename,sal from emp
where sal>avg(sal);

-- 그룹화에 대한 연습
select deptno,max(sal) from emp
group by deptno
order by deptno desc;

-- 직업별 인원수와 평균sal을 출려가기 단, president는 제외하고 작업하기
-- 									인원수가 3명이상인 결과만 출력
select job '직 업',count(job) '인원수',avg(sal) '평 균'from emp
where job != 'president' 
group by job
having count(job)>=3
order by count(job) desc;

select empno,mgr,count(mgr) from emp
where mgr is not null
group by empno
having count(mgr)>1;

SELECT mgr,group_concat(distinct job) as '직 업',count(empno) AS '관리 인원수'
FROM emp
WHERE mgr IS NOT NULL
GROUP BY mgr
HAVING COUNT(empno) > 1
order by count(empno) desc;

select deptno,max(sal),min(sal) 
from emp
where job !='president'
group by deptno
having max(sal)>=3000
order by deptno desc;

