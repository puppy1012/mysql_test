









use hr;
/*
1. 매니저가 직원보다 늦게 입사한 경우의 직원과 매니저의 이름, 각자의 입사일을 출
력하세요.입사일은 "YYYY년 MM월 DD일" 형태로 나타내고, 직원 이름 기준 오름차
순으로 정렬(37개row)
*/
select
	e.first_name as 직원이름,
    m.first_name as 매니저이름,
    concat(year(e.hire_date),'/',month(e.hire_date),'/',day(e.hire_date)) as 직원입사일,
    concat(year(m.hire_date),'/',month(m.hire_date),'/',day(m.hire_date)) as 매니저입사일,
    if(m.hire_date > e.hire_date,'매니저가 늦음','직원이 늦음')as 입사비교
    from employees e
join employees m on e.manager_id = m.employee_id
where m.hire_date>e.hire_date;

/*
2. 같은 부서에 소속된 직원 간의 페어를 출력하되, 두 직원의 급여 차이가 7000 이상
인 페어만 나타내세요.
결과는 급여 차이가 큰 순으로 정렬하고 급여 차이를 표시하며, 동일한 조합의 중복
은 제외하고 입사일은 "YYYY/MM" 형태로 출력하세요(27row)
*/
select
	e1.first_name as 직원1,
    e2.first_name as 직원2,
    abs(e1.salary-e2.salary)as 급여차이,
    date_format(e1.hire_date,'%Y/%m') as 직원1입사일,
    date_format(e2.hire_date,'%Y/%m') as 직원2입사일,
    if(e1.salary>e2.salary,"직원1높음","직원2높음") as 급여비교
    from employees e1
join employees e2 on e1.department_id = e2.department_id -- 부서별로 비교
where abs(e1.salary-e2.salary)>=7000 and e1.employee_id<e2.employee_id -- 중복제거
order by abs(e1.salary-e2.salary) desc;

/*
3. 직책(job_title)별로 가장 최근 입사자의 입사일과 입사자 이름을 표시하세요.
가장 최근 입사일이 2007년 이후인 직책만 표시하고, 날짜는 "YYYY-MM-DD" 형식
으로 나타내세요.

*/
select
	j.job_title as 직책,
    max(e.first_name) as 최신입사자명,
    max(e.hire_date) as 최신입사일,
    if(max(year(e.hire_date))>=2007,"최근입사자","최근입사자아님") as 입사구분
    from employees e
join jobs j on e.job_id=j.job_id
group by j.job_title
having max(year(e.hire_date))>=2007;

/*
4. 각 부서의 위치(city)와 해당 부서 직원들의 평균 급여를 구하세요. 단, 부서의 위치
가 없으면 "미정"으로 표시하고, 평균 급여는 소수점 둘째자리까지 나타내며, 평균
급여가 7000 이상인 부서만 출력,평균급여 기준 내림차순 정렬
*/

select
	d.department_name as 부서명,
    ifnull(max(l.city),"미정") as 도시명,
    truncate(avg(e.salary),2) as 평균급여
    from employees e
join departments d on e.department_id=d.department_id
join locations l on d.location_id=l.location_id
group by d.department_name
having truncate(avg(e.salary),2)>=7000
order by truncate(avg(e.salary),2) desc;

/*
5. 2000년부터 2010년 사이에 입사한 직원 중, 급여가 8000 이상인 경우 "우수", 그렇
지 않으면 "일반"으로 구분하여,직원 이름, 직책, 급여, 입사일(YYYY/MM/DD)을 출
력하세요.( 결과는 급여 기준 내림차순으로 정렬)(107 row)
*/
select
	e.first_name as 직원이름,
    j.job_title as 직책,
    e.salary as 급여,
    e.hire_date as 입사일,
    if(2000<=year(e.hire_date)<=2010 and e.salary>8000,"우수","일반")as 급여등급
    from employees e
join jobs j on e.job_id=j.job_id
order by e.salary desc;