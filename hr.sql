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

use hr;
-- 1. 각 부서(department_name)별 평균 급여(avg_salary)를 구하여 출력하십시오. 단, 평균 급여가 8000 이상인 부서만 나타내고, 평균 급여 기준으로 내림차순 정렬하세요.
select
	d.department_name as 부서명,
    avg(e.salary) as 평균급여
from departments d
left join employees e on d.department_id=e.department_id
group by d.department_name
having avg(e.salary)>=8000
order by avg(e.salary) desc;

select * from employees;
select * from departments;
-- 2. 각 직원과 그 직원의 매니저 이름을 출력하십시오. 매니저가 없는 경우 "CEO"라고표시하세요.(결과 107row)
-- 자기 참조
select
	e.first_name as 직원,
    ifnull(m.first_name,'ceo') as 매니저
from employees e
left join employees m on e.manager_id=m.employee_id;

-- 3. 모든 직원의 이름과 그 직원의 매니저 이름을 표시하고, 매니저의 매니저 이름도 출력해보세요.
-- 단 단, 매니저나 매니저의 매니저가 없는 경우 각각 "직속상사없음", "최상위매니저"로 출력하기(결과 107 row)
select
	e.first_name as 직원,
    ifnull(m.first_name,'ceo') as 매니저,
    ifnull(f.first_name,'최상위매니저') as '매니저의 매니저'
from employees e
left join employees m on e.manager_id=m.employee_id
left join employees f on m.manager_id=f.employee_id;

-- 4. 각 도시(city)별로 2005년 이후에 입사한 직원 수를 구하되, 직원 수가 3명 이상인 도시만 출력하세요.
-- 입사일은 YYYY/MM/DD 형식으로 출력하고, 직원 수 기준으로 내림차순 정렬
-- city 연결 -e,d,lo
select * from job_history;
select
	l.city as 도시,
    count(e.employee_id) as 직원수
from employees e
left join departments d on e.department_id =d.department_id
left join locations l on d.location_id=l.location_id
where year(e.hire_date)>2005
group by l.city
having count(e.employee_id)>=3
order by count(e.employee_id) desc;

-- 5. 각 부서(department_name)와 직책(job_title) 별로 직원 수와 최초 입사일을 구하되,
-- 직원이 2명 이상이고, 최초 입사일이 2005년 이전인 그룹만 표시하세요.
-- 결과는 부서명 오름차순, 직책 내림차순으로 정렬하며, 날짜는 "YYYY-MM-DD" 형태로 출력(난이도상)

-- 출력리스트(d.department_name,j.jobs,count(e.employee_id),e.hiredate,if(year(e.hire_date)>=2025,단기운영부서,장기운영부서)
-- where year(e.hire_date)<2025
-- group by d.department_name,j.job_title

select
	d.department_name as 부서명,
    j.job_title as 직책,
    count(e.employee_id) as 직원수,
    min(e.hire_date) as 최초입사일,
    if(min(year(e.hire_date))>=2005,'단기운영부서','장기운영부서')as 부서운영기간
from employees e
left join
	departments d on e.department_id=d.department_id
-- left join 
-- 	job_history jh on e.job_id=jh.job_id
left join 
	jobs j on e.job_id=j.job_id
group by d.department_name , j.job_title
having count(e.employee_id) >=2 and min(year(e.hire_date))<2005
order by d.department_name asc , j.job_title desc;

/*
6. 매니저와 직원의 이름을 함께 출력하되,직원과 매니저의 입사일 차이가 5년 이상인
경우만 표시하세요.직원이름 오름차순 정렬하고, 입사일은 "YYYY/MM/DD" 형식
(year함수를 이용하면 년도 데이터만 추출할 수 있습니다.)
*/

select
	e.first_name as 직원이름,
    m.first_name as 매니저이름,
    concat(year(e.hire_date),'/',month(e.hire_date),'/',day(e.hire_date)) as 직원입사일,
    concat(year(m.hire_date),'/',month(m.hire_date),'/',day(m.hire_date)) as 매니저입사일,
    if(ABS(YEAR(m.hire_date) - YEAR(e.hire_date))>=5,'5년 이상 차이','5년 이하 차이') as 부서운영기간
from employees e
left join employees m on e.manager_id= m.employee_id
where ABS(YEAR(m.hire_date) - YEAR(e.hire_date))>=5
order by e.first_name asc;

select * from locations;
select * from departments;

-- 7번
select
    ifnull(l.city, '도시없음') as 도시,
    count(distinct d.department_id) as 부서수,
    count(e.employee_id) as 직원수
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
group by l.city
having COUNT(distinct d.department_id) >= COUNT(e.employee_id) / 2 and count(e.employee_id) > 1
order by count(distinct d.department_id) asc;
