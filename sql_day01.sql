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
