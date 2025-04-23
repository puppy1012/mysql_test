use mytestdb;
select * from emp;
select ename, mgr,if(mgr is null,'상위자','담당')as 관리자 from emp;


select * from mytestdb.salgrade;
desc locations;
desc salgrade;

select losal,city
from salgrade, locations;

-- 간편조인
select empno,ename,emp.deptno,dname from emp,dept
where emp.deptno=dept.deptno;

-- alias로 변경
select empno,ename,e.deptno,dname
from emp e, dept d
where e.deptno= d.deptno and e.sal>=2000;

insert into emp(empno,deptno) values('1717',100);
select * from emp;
select * from dept;
select * from locations;

SELECT e.empno, e.ename, e.deptno, d.dname, l.city
FROM emp e
JOIN dept d ON e.deptno = d.deptno -- emp 테이블과 dept 테이블을 deptno 컬럼을 기준으로 조인한다. 즉, 각 직원이 속한 부서 정보를 결합한다.
JOIN locations l ON d.loc_code = l.loc_code; -- JOIN locations l ON d.loc_code = l.loc_code:dept 테이블과 locations 테이블을 **loc_code**를 기준으로 조인합니다. 각 부서가 위치한 지역 정보를 가져옵니다.

select empno,ename,e.deptno,dname,d.loc_code,l.city
from emp e,dept d, locations l
where e.deptno=d.deptno and d.loc_code =l.loc_code;

select e.empno,e.ename,e.sal from emp e, dept d, locations l
where e.deptno=d.deptno and d.loc_code=l.loc_code and l.city='seoul';

select e.empno,e.ename,d.dname,l.city from emp e, dept d, locations l
where e.deptno=d.deptno and d.loc_code=l.loc_code and l.city='DALLAS';

-- 1번
select e.empno,e.ename,e.sal,d.dname,d.loc_code from emp e, dept d, locations l
where e.deptno=d.deptno and job='salesman';

-- 2번
select e.ename,d.dname,e.sal,l.city from emp e, dept d, locations l
where e.deptno=d.deptno and d.loc_code=l.loc_code;
-- 3번
select e.ename,e.sal,e.job,e.hiredate,e.comm from emp e, dept d, locations l
where e.deptno=d.deptno and d.loc_code=l.loc_code and l.city='dallas' and e.sal>=1500;

-- 4번
select d.dname,count(e.empno) from emp e, dept d
where e.deptno=d.deptno
group by d.dname;

-- 5번
select l.city,count(e.empno) from emp e, dept d, locations l
where e.deptno=d.deptno and d.loc_code=l.loc_code
group by l.city;

-- 간편조인
select empno,ename,emp.deptno,dname
from emp,dept
where emp.deptno=dept.deptno;

-- 표준조인
select empno,ename,e.deptno,dname
from emp e
	inner join dept d
	on e.deptno= d.deptno;
    
-- 부서별 인원수 inner join
select d.dname,count(e.empno)
from emp e
join dept d on e.deptno =d.deptno
group by d.dname;

SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'mytestdb'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
-- 도시별 인원수를 inner join으로 작업
select l.city,count(e.empno)
from emp e
join dept d on e.deptno=d.deptno
join locations l on d.loc_code=l.loc_code
group by l.city;

select l.city,count(e.empno)
from emp e
join dept d 
join locations l 
on d.loc_code=l.loc_code and e.deptno=d.deptno
where l.city !='seoul'
group by l.city
having count(e.empno)>3;

-- left outer join :emp의 일치하는 deptno가 없다고 해도 모두 emp데이터 출력하기
select empno,ename,e.deptno,dname
from emp e
left outer join dept d
on e.deptno=d.deptno;	

select empno,ename,emp.deptno,dname
from emp,dept
where emp.deptno=dept.deptno;

select * from emp;
select * from dept;
use mytestdb;
-- 부서별 인원수로 출력하기(부서가 없는 경우 신입사원으로 출력하세요) 고로 신입사원과 같은 null값도 포함해야한다
-- null을 포함하기위해서는 현재 left outer를 사용중이니까 from 기준이 emp 이므로 e.empno를 사용하자
select ifnull(d.dname,'신입사원') 부서명,count(e.empno) 인원수
from emp e
left outer join dept d
on e.deptno=d.deptno
group by d.dname;

select ifnull(d.dname,'신입사원') 부서명,count(*) as 인원수
from emp e
right outer join dept d
on e.deptno=d.deptno
group by d.dname;

select ifnull(d.dname,'신입사원')as 부서명,count(*) as 인원수
from emp e
left join dept d on e.deptno=d.deptno
group by d.dname

union

select d.dname as 부서명, 0 as 인원수
from dept d
where d.deptno not in (SELECT deptno FROM emp WHERE deptno IS NOT NULL);

-- 셀프 조인
-- 사원번호, 사원명, 관리자번호, 관리자명 출력

select e.empno,e.ename,e.mgr,m.ename
from emp e, emp m
where e.mgr=m.empno;

-- [미션] self조인과 outer 조인을 같이 사용해서 작업
-- 관리자별로 관리하는 직원의 수를 조회하기
-- 단,관리자가 없는 경우 "관리자없음"으로 표시
select 
	ifnull(m.ename,'관리자없음') 관리자이름,
    count(*) 직원수
from emp e
left join emp m on e.mgr=m.empno
group by m.ename;


select 
	e.mgr,
    e.first_name,
	ifnull(m.ename,'관리자없음') 관리자이름
from emp e
left join emp m on e.mgr=m.empno
where e.first_name like'_t%'
group by m.ename;
