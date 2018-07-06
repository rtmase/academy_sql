--1. employees 테이블에서 job_id 를 중복 배제하여 조회 하고
--   job_title 같이 출력
--19건
 SELECT DISTINCT e.JOB_ID,
                 j.job_title
   FROM employees e JOIN jobs j ON (e.job_id = j.job_id);

--2. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터,
--   급여x커미션팩터(null 처리) 조회
--   커미션 컬럼에 대해 null 값이면 0으로 처리하도록 함
--107건
 SELECT e.EMPLOYEE_ID,
        e.LAST_NAME,
        e.SALARY,
        e.COMMISSION_PCT,
        nvl(e.salary * e.commission_pct,0)
   FROM employees e;
 
--3. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터(null 값 처리) 조회
--   단, 2007년 이 후 입사자에 대하여 조회, 고용년도 순 오름차순 정렬
--30건
 SELECT e.employee_id,
        e.last_name,
        e.salary,
        nvl(e.commission_pct,0)
   FROM employees e
  WHERE TO_CHAR(e.hire_date,'YY') >= '07'
  ORDER BY e.hire_date DESC;
--4. Finance 부서에 소속된 직원의 목록 조회
--조인으로 해결
 SELECT e.employee_id,
        e.last_name,
        e.department_id
   FROM employees e JOIN departments d ON (e.department_id = d.department_id)
  WHERE e.department_id = 100; 

--서브쿼리로 해결
 SELECT d.DEPARTMENT_ID
   FROM departments d
  WHERE d.department_id = 100; 
  
 SELECT e.EMPLOYEE_ID,
        e.LAST_NAME,
        e.DEPARTMENT_ID
   FROM employees e
  WHERE e.department_id = (SELECT d.DEPARTMENT_ID
                             FROM departments d
                            WHERE d.department_id = 100); 
--6건
 
--5. Steven King 의 직속 부하직원의 모든 정보를 조회
--14건
-- 조인 이용
 SELECT e2.employee_id,
        e2.last_name,
        e2.department_id
   FROM employees e1 JOIN employees e2 ON (e1.employee_id = e2.MANAGER_ID)
  WHERE e2.manager_id = 100; 

-- 서브쿼리 이용
 SELECT DISTINCT e.MANAGER_ID
   FROM employees e
  WHERE e.manager_id = 100; 
 SELECT e.*
   FROM employees e
  WHERE e.manager_id = (SELECT DISTINCT e.MANAGER_ID
                      FROM employees e
                     WHERE e.manager_id = 100); 
--6. Steven King의 직속 부하직원 중에서 Commission_pct 값이 null이 아닌 직원 목록
 SELECT e2.employee_id,
        e2.last_name,
        e2.department_id
   FROM employees e1 JOIN employees e2 ON (e1.employee_id = e2.MANAGER_ID)
  WHERE e2.manager_id = 100
    AND e2.COMMISSION_PCT IS NOT NULL; 
--5건

--7. 각 job 별 최대급여를 구하여 출력 job_id, job_title, job별 최대급여 조회
--19건
 SELECT e.job_id,
        MAX(e.SALARY),
        j.JOB_TITLE,
        j.MAX_SALARY
   FROM employees e JOIN jobs j ON (e.job_id = j.job_id) 
   GROUP BY e.job_id, 
            j.JOB_TITLE, 
            j.MAX_SALARY;

 
--8. 각 Job 별 최대급여를 받는 사람의 정보를 출력,
--  급여가 높은 순서로 출력
----서브쿼리 이용
 SELECT e.JOB_ID,
        MAX(e.SALARY)
   FROM employees e
  GROUP BY e.JOB_id;
 SELECT a.max_sal,
        e.EMPLOYEE_ID
   FROM employees e,(SELECT e.JOB_ID,
                           MAX(e.SALARY) as max_sal
                           FROM employees e
                           GROUP BY e.JOB_id) a;
----join 이용


--20건

--9. 7번 출력시 job_id 대신 Job_name, manager_id 대신 Manager의 last_name, department_id 대신 department_name 으로 출력
--20건



--10. 전체 직원의 급여 평균을 구하여 출력
 SELECT AVG(e.SALARY)
   FROM employees e;

--11. 전체 직원의 급여 평균보다 높은 급여를 받는 사람의 목록 출력. 급여 오름차순 정렬
--51건
 SELECT e.EMPLOYEE_ID,
        e.FIRST_NAME,
        e.LAST_NAME,
        e.SALARY
   FROM employees e
  WHERE (SELECT AVG(e.SALARY)
           FROM employees e) < e.salary
  ORDER BY e.salary ASC;
--12. 각 부서별 평균 급여를 구하여 출력
--12건
 SELECT e.DEPARTMENT_ID,
        AVG(e.salary)
   FROM employees e
  GROUP BY e.DEPARTMENT_ID ;

--13. 12번의 결과에 department_name 같이 출력
--12건
  SELECT e.DEPARTMENT_ID,
         d.DEPARTMENT_NAME,
        AVG(e.salary)
   FROM employees e JOIN DEPARTMENTS d ON (e.DEPARTMENT_ID = d.department_id)
  GROUP BY e.DEPARTMENT_ID,
           d.DEPARTMENT_NAME ;

--14. employees 테이블이 각 job_id 별 인원수와 job_title을 같이 출력하고 job_id 오름차순 정렬
 SELECT e.job_id,
        j.job_title,
        COUNT(e.job_id)
   FROM EMPLOYEES e JOIN JOBS j ON (e.job_id = j.job_id)
  GROUP BY e.job_id,
           j.job_title; 

--15. employees 테이블의 job_id별 최저급여,
--   최대급여를 job_title과 함께 출력 job_id 알파벳순 오름차순 정렬
 SELECT e.job_id,
        MIN(e.salary),
        MAX(e.salary),
        j.job_title
   FROM employees e JOIN JOBS j ON (e.job_id = j.job_id)
  GROUP BY e.job_id,
           j.JOB_TITLE
  ORDER BY e.job_id;

 
--16. Employees 테이블에서 인원수가 가장 많은 job_id를 구하고
--   해당 job_id 의 job_title 과 그 때 직원의 인원수를 같이 출력
 SELECT COUNT(e.job_id),
        e.job_id
   FROM EMPLOYEES e 
  GROUP BY e.job_id;
 
 
  
 SELECT e.job_id,
        MAX(cnt)
   FROM employees e,
        (SELECT MAX(COUNT(e.job_id)) as cnt 
         FROM EMPLOYEES e 
        GROUP BY e.job_id);
             


--17.사번,last_name, 급여, 직책이름(job_title), 부서명(department_name), 부서매니저이름
--  부서 위치 도시(city), 나라(country_name), 지역(region_name) 을 출력
----------- 부서가 배정되지 않은 인원 고려 ------


--18.부서 아이디, 부서명, 부서에 속한 인원숫자를 출력



--19.인원이 가장 많은 상위 다섯 부서아이디, 부서명, 인원수 목록 출력


 
--20. 부서별, 직책별 평균 급여를 구하여라.
--   부서이름, 직책이름, 평균급여 소수점 둘째자리에서 반올림으로 구하여라.



--21.각 부서의 정보를 부서매니저 이름과 함께 출력(부서는 모두 출력되어야 함)


 
--22. 부서가 가장 많은 도시이름을 출력



--23. 부서가 없는 도시 목록 출력
--조인사용

--집합연산 사용

--서브쿼리 사용

  
--24.평균 급여가 가장 높은 부서명을 출력



--25. Finance 부서의 평균 급여보다 높은 급여를 받는 직원의 목록 출력


-- 26. 각 부서별 인원수를 출력하되, 인원이 없는 부서는 0으로 나와야 하며
--     부서는 정식 명칭으로 출력하고 인원이 많은 순서로 정렬.



--27. 지역별 등록된 나라의 갯수 출력(지역이름, 등록된 나라의 갯수)



 
--28. 가장 많은 나라가 등록된 지역명 출력
