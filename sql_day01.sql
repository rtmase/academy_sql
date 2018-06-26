 -- sql day 01
 -- 1. SCOTT 계정 활성화 : sys 계정으로 접속하여 스크립트 실행
 @C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
 -- 2. 접속 유저 확인 명령
 SHOW user
 -- 3. HR 계정 활성화 : sys 계정으로 접속하여 다른 사용자 확장 후 HR 계정의 잠김, 비밀번호 만료 상태 해제 // HR/HR
--------------------------------------------------------------------------------------------
 -- SCOTT 계정의 데이터 구조
 -- (1) emp 테이블 내용 조회
 SELECT *
   FROM emp;
/*
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
*/
 -- (2) dept 테이블 내용 조회
 SELECT *
   FROM dept;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON 
*/
-- (3) salgrade 테이블 내용 조회
 SELECT *
   FROM salgrade;
/*
GRADE, LOSAL, HISAL
1	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
*/
-- 01. DQL
-- (1) SELECT 구문
-- emp 테이블에서 사번, 이름, 직무를 조회
 SELECT e.EMPNO,
        e.ENAME,
        e.JOB
   FROM emp e; -- alias
/*
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
*/
-- emp 테이블에서 직무만 조회
 SELECT e.JOB
   FROM emp e;
/*
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT
SALESMAN
CLERK
ANALYST
CLERK
*/
 -- (2) DISTINCT 문
 -- emp 테이블에서 job 컬럼의 중복을 배제하여 조회
 SELECT DISTINCT e.JOB 
   FROM emp e;
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
*/
 -- SQL SELECT 구문의 작동 원리 : 테이블의 한 행을 기본 단위로 실행함.
 --                              테이블 행의 개수만큼 반복 실행.
 SELECT 'Hello, SQL~'  -- why? SELECT 절에 있는 문자열을 테이블의 행의 개수 만큼 반복 실행//반드시 컬럼의 이름을 줘야한다고 생각 할 필욘 없음
   FROM emp e;
 -- emp 테이블에서 job, dept 에 대해 중복을 제거하여 조회
 SELECT DISTINCT e.JOB,
                e.DEPTNO
   from emp e;
 -- (3) ORDER BY 절 : 정렬
 -- emp 테이블에서 job 을 중복배제하여 조회하고, 오름차순 정렬
 SELECT DISTINCT e.JOB
   FROM emp e
  ORDER BY e.JOB ASC; -- ASC 생략 가능
/*
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
*/
 -- emp 테이블에서 job 을 중복배제하여 조회하고, 내림차순 정렬
 SELECT DISTINCT e.JOB
   FROM emp e
  ORDER BY e.JOB DESC;
/*
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
*/
 -- emp 테이블에서 comm 을 가장 많이 받는 순서대로 출력
 -- 사번, 이름, 직무, 입사일, 커미션 순으로 조회
 SELECT e.EMPNO,e.ename,e.job,e.HIREDATE,e.comm
   FROM emp e
  ORDER BY e.comm DESC;
 -- emp 테이블에서 comm 이 적은 순서대로, 직무별 오름차순, 이름별 오름차순으로 정렬
 -- 사번, 이름, 직무, 입사일, 커미션 순으로 조회
 SELECT e.EMPNO,
        e.ename,
        e.job,
        e.hiredate,
        e.comm
   FROM emp e
  ORDER BY e.comm,e.ename,e.job;
 -- emp 테이블에서 comm이 적은 순서대로 직무별 오름차순, 이름별 내림차순으로 정렬
 -- 사번, 이름, 직무, 입사일, 커미션을 조회
 SELECT e.empno,
        e.ename,
        e.job,
        e.hiredate,
        e.comm
   FROM emp e
  ORDER BY e.comm, e.job, e.ename DESC;
 -- (4) Alias : 별칭
 -- emp 테이블에서 empno-> Employee No. , ename-> Employee Name , job-> Job Name
 SELECT e.empno as "Employee No", 
        e.ename as "Employee Name", 
        e.job as "Job Name"
   FROM emp e;
 -- 위와 동일 한데 as 키워드 생략하여 조회
 SELECT e.empno 사번, 
        e.ename "사원 이름", 
        e.job "직무"
   FROM emp e;
 -- 테이블에 붙이는 별칭을 주지 않았을 때
 SELECT empno
   FROM emp;
 SELECT emp.empno -- FROM 절에서 설정된 테이블별칭은 SELECT 절에서 사용됨.
   FROM emp; -- 소문자 e 가 emp 테이블의 별칭이며 테이블 별칭은 FROM 절에 사용함

 SELECT e.empno
   FROM emp e;
 SELECT d.deptno
   FROM dept d;
 -- 영문별칭 사용시 특수기호 _ 사용하는 경우
 SELECT e.empno Employee_No,
        e.ename "Employee Name"
   FROM emp e;     
 -- 별칭과 정렬의 조합 : SELECT 절에 별칭을 준 경우 ORDER BY 절에서 사용가능
 -- emp 테이블에서 사번, 이름, 직무, 입사일, 커미션을 조회할 때 각 컬럼에 대해서 한글별칭을 주어 조회 
 -- 정렬은 커미션, 직무, 이름을 오름차순
 SELECT e.EMPNO 사번,
        e.ename 이름,
        e.job 직무,
        e.hiredate 입사일,
        e.comm 커미션
   FROM emp e
  ORDER BY 커미션,직무,이름;
 -- DISTINCT, 별칭, 정렬의 조합
 -- job 을 중복을 제거해서 직무라는 별칭으로 조회하고 내림차순으로 정렬
 SELECT DISTINCT e.job 직무
   FROM emp e
  ORDER BY 직무 DESC;
/*
직무
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST*/

 -- (5) WHERE 조건절
 -- emp 테이블에서 empno 이 7900인 사원의 사번, 이름, 직무, 입사일, 급여, 부서번호 조회
 SELECT e.empno,
        e.ename,
        e.job,
        e.hiredate,
        e.sal,
        e.deptno
   FROM emp e
  WHERE e.empno = 7900;
/*
EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
7900	JAMES	CLERK	81/12/03	950	30
*/
 -- emp 테이블에서 empno 이 7900이거나 deptno 가 20인 사원의 사번, 이름, 직무, 입사일, 급여, 부서번호 조회
 SELECT e.empno,
        e.ename,
        e.job,
        e.hiredate,
        e.sal,
        e.deptno
   FROM emp e
  WHERE e.empno = 7900 or e.deptno = 20;
 -- emp 테이블에서 empno 이 7900이고 deptno 가 20인 사원의 사번, 이름, 직무, 입사일, 급여, 부서번호 조회
 SELECT e.empno,
        e.ename,
        e.job,
        e.hiredate,
        e.sal,
        e.deptno
   FROM emp e
  WHERE e.empno = 7900 and e.deptno = 20;
 -- 인출된 모든 행 : 0

 -- job이 'CLERK' 이면서 deptno 가 10인 직원의 사번, 이름, 직무, 부서번호를 조회
 SELECT e.empno,
        e.ename,
        e.job,
        e.deptno
   FROM emp e
  WHERE e.job = 'CLERK' and e.deptno = 10; -- 문자값 비교시 '' 사용 대소문자 구분

 SELECT e.empno,
        e.ename,
        e.job,
        e.deptno
   FROM emp e
  WHERE e.job = 'clerk' and e.deptno = 10; -- 문자값 비교시 '' 사용 대소문자 구분(소문자시 인출되지 않음)
 -- 소문자 clerk 로 저장된 직무는 존재하지 않으므로 조건에 맞는 행이 없음 
 -- 인출된 모든 행 : 0 결과가 발생함

 -- (6) 연산자 1. 산술연산자
 -- 사번, 이름, 급여를 조회하고, 급여의 3.3%에 해당하는 원천징수 세금을 계산하여 조회
 SELECT e.empno 사번,
        e.ename 이름,
        e.sal 급여,
        e.sal * 0.033 원천징수세금
   FROM emp e;
 -- 실수령액에 해당하는 96.7%의 급여도 계산
 SELECT e.empno 사번,
        e.ename 이름,
        e.sal 급여,
        e.sal * 0.033 원천징수세금,
        e.sal * 0.967 실수령액
   FROM emp e;
 -- 동일결과를 내는 다른 계산
 SELECT e.empno 사번,
        e.ename 이름,
        e.sal 급여,
        e.sal * 0.033 원천징수세금,
        e.sal - (e.sal * 0.033) 실수령액
   FROM emp e;
 -- (6) 2. 비교연산자
 -- 비교연산자는 SELECT 절에 사용할 수 없음 WHERE, HAVING 절에만 사용
 -- 급여가 2000이 넘는 사원의 사번, 이름, 급여를 조회
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal >2000;
 -- 급여가 1000이상인 직원의 사번, 이름, 급여를 조회
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal >= 1000;
 -- 급여가 1000이상이며 2000미만인 직원 사번, 이름, 급여를 조회
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal >= 1000 and e.sal <2000;
 -- comm 값이 0보다 큰 직원의 사번, 이름, 급여를 조회
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.comm > 0;
 -- 위의 실행 결과에서 comm 이 null 인 사람들의 행은 처음부터 비교대상에 들지 않음에 주의해야 한다.
 -- null 값은 비교연산자로 비교할 수 없는 값이다.
  
 -- 영업사원 직무를 가진 사람들의 급여와 수당을 함께 받으므로 영업사원의 실제 수령금을 계산
  SELECT e.empno,
         e.ename,
         e.JOB,
         e.sal + e.comm "급여 + 수당"
    FROM emp e;
/*
7369	SMITH	CLERK	
7499	ALLEN	SALESMAN	1900
7521	WARD	SALESMAN	1750
7566	JONES	MANAGER	
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER	
7782	CLARK	MANAGER	
7839	KING	PRESIDENT	
7844	TURNER	SALESMAN	1500
7900	JAMES	CLERK	
7902	FORD	ANALYST	
7934	MILLER	CLERK	
--> 숫자 값과(NULL) 값의 산술 연산결과는 결국 NULL 임을 주의하자.
*/

 -- (6) 연산자 : 3. 논리연산자
 -- NOT 연산자
 -- 급여가 2000보다 적지 않은 직원의 사번, 이름, 급여를 조회
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE NOT e.sal < 2000;
 -- 동일 결과를 내는 다른 쿼리 NOT 사용하지 않음
  SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal >= 2000;
 -- (6) 연산자 : 4. SQL 연산자
 -- IN 연산자 : 비교하고자 하는 기준 값이 제시된 항목 목록에 존재하면 참으로 판단
 -- 급여가 800, 3000, 5000 중에 하나인 직원의 사번, 이름, 급여를 조회
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal = 800 or e.sal = 3000 or e.sal = 5000;
 -- IN 연산자를 사용하여 해결
  SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal IN(800,3000,5000);
  
 -- LIKE 연산자 : 유사 값을 검색하는데 사용
 -- LIKE 연산자는 유사 값 검색을 위해 함께 사용하는 패턴 인식문자가 있다.
 -- % : 0 자릿수 이상의 모든 문자 패턴이 올 수 있음
 -- _ : 1 자리의 모든 문자 패턴이 올 수 있음
 -- 이름이 J로 시작하는 직원의 사번, 이름 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE 'J%';
 -- 이름이 M으로 시작하는 직원의 사번, 이름 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE 'M%';
 -- 이름에 M이 들어가는 직원의 사번, 이름 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE '%M%';
 -- 이름의 두번째 자리에 M이 들어가는 직원의 사번, 이름 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE '_M%'; --유사 패턴 인식 문자를 _를 사용하여 한글자로 제한
 -- 이름의 세번째 자리에 M이 들어가는 직원의 사번, 이름 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE '__M%'; -- 유사 패턴 인식 문자 _를 두번 사용하여 앞자리를 2자리로 제한
  
 -- 이름의 둘째자리부터 LA가 들어가는 이름을 가진 직원의 사번, 이름 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE '_LA%';
 -- 이름이 J_ 로 시작하는 직원의 사번, 이름 조회
 -- : 조회 값에 패턴인식 문자가 들어있는 데이터의 경우 어떻게 조회할 것인가?
  SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE 'J\_%' ESCAPE '\';
 -- 조회하려는 값에 들어있는 패턴인식 문자를 무효화 하려면 ESCAPE 절과 조합한다.
 
 -- 이름이 J% 로 시작하는 직원의 사번, 이름 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE 'J\%%' ESCAPE '\';