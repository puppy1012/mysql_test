use hr;
select * from employees;
select ifnull(department_id,'No Department') as '부서번호',
		round(avg(salary),0) as '평균급여' from employees
group by department_id
having avg(salary)>6000;

select * from employees;
select department_id, avg(salary) from employees
group by department_id
having avg(salary)>=10000;

select * from employees;
-- 문제 3번
select department_id, avg(salary) from employees
where department_id is not null and department_id not in (40,50)
group by department_id
order by avg(salary) desc;

-- 문제 4번
select * from employees;
select first_name,last_name,salary,commission_pct,(salary+ifnull(commission_pct,0)) as '총액' from employees
where commission_pct is not null
order by (salary+coalesce(commission_pct,0)) desc;
-- 문제 4번
select first_name,last_name,salary,commission_pct,(salary+commission_pct) as '총액' from employees
where commission_pct is not null
order by (salary+commission_pct) desc;

SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'hr'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

select * from departments;
select * from employees;
select * from job_history;
select * from locations;
-- 부서별 인원수 출력
select d.department_name 부서명,count(e.employee_id) 인원수 from departments d , employees e
where d.department_id=e.department_id
group by d.department_name
order by count(e.employee_id) desc;

select ifnull(d.department_name,'신입사원') 부서명,count(e.employee_id) 인원수 
from departments d
left outer join employees e 
on d.department_id=e.department_id
group by d.department_name
order by count(e.employee_id) desc;

-- seattle 도시에 부서 근무 직원 출력
select e.employee_id 사번,e.first_name 이름,j.job_title 업무명,d.department_name 부서명
from employees e
join departments d on e.department_id=d.department_id
join jobs j on e.job_id=j.job_id
join locations l on d.location_id =l.location_id
where l.city='seattle'
order by e.employee_id asc;

use hr;

select 
	e.employee_id,
    e.first_name,
	ifnull(m.first_name,'관리자없음') 관리자이름
from employees e
-- 일반사원의 매니저번호를 매니저의 일반번호로 self join
left join employees m on e.manager_id=m.employee_id 
where e.first_name like'_t%'
group by e.employee_id; -- 매니저 사원번호 기준
use hr;
select * from employees;
select * from departments;
select * from jobs;
-- job_id

select 
	j.job_title 직책,
    -- null 미포함
	count(e.employee_id) 직원수
from jobs j
left join employees e on j.job_id= e.job_id
group by j.job_title;

select
	d.department_id 부서번호,
    d.department_name 부서이름,
    count(e.employee_id) 사원수,
    max(e.salary) 최고급여,
    min(e.salary) 최저급여,
    floor(avg(e.salary)) 평균급여,
    sum(e.salary+ifnull(e.commission_pct,0)) 급여총액
from departments d
left join employees e on d.department_id=e.department_id
group by d.department_id
having count(e.employee_id)>2
order by count(e.employee_id) desc;

select * from employees;
SELECT job_title
FROM jobs
WHERE job_title LIKE '%Representative%';

-- 추가미션 1번
select 
	j.job_title as JOB,
    sum(e.salary) as 급여
from jobs j
left join employees e on j.job_id=e.job_id
where  j.job_title not like '%representative%'
group by j.job_title
having sum(e.salary)>30000
order by sum(e.salary) asc;

-- 추가미션 2번
select 
	d.department_name as 부서명,
	count(e.employee_id) as 인원수
from employees e
left join departments d on e.department_id=d.department_id
where year(e.hire_date)<2005
group by d.department_name;

SELECT *
FROM departments;
SELECT *
FROM employees
WHERE first_name ='diana'; 

-- 추가미션 3번
select
	concat(e.first_name,' ',e.last_name,'의 연봉은 ',floor(e.salary),' 입니다.') as 결과
from employees e
left join departments d on e.department_id = d.department_id
where d.department_name like 'IT'
order by e.salary asc;

-- 추가미션 4번
select
	e.employee_id as EMPLOYEE_ID,
    e.first_name as FIRST_NAME,
    j.job_title as JOB_TITLE,
    d.department_name as DEPARTMENT_NAME
from employees e
join departments d on e.department_id=d.department_id
join locations l on d.location_id=l.location_id 
join jobs j on e.job_id=j.job_id
where l.city ='Seattle';

SELECT 
    table_name, column_name
FROM 
    information_schema.columns
WHERE 
    column_name = 'avg_salary'
    AND table_schema = 'hr';

-- 추가미션 5번
select
	d.department_name as 부서명,
    avg(e.salary) as 평균급여
from employees e
join departments d on e.department_id = d.department_id
where d.department_name not like 'IT'
group by d.department_name
having count(e.employee_id)>=3 and avg(e.salary)>=5000;

select * from jobs;

-- 추가미션 6번
select 
	j.job_title as '직 책',
    floor(avg(e.salary)) as 평균급여
from employees e
left join jobs j on e.job_id =j.job_id
-- in 연산자는 정확히 일치하는 값들만 비교
-- not like in은 불가능
where j.job_id not in ('IT_PROG', 'ST_CLERK')
group by j.job_title
having avg(e.salary)>=7000
order by avg(e.salary) desc;
	