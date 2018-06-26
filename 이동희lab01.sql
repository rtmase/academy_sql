-- 실습
-- (1) emp 테이블에서 사번, 이름, 업무, 급여 컬럼을 조회하고 급여가 많은 순서대로 정렬
SELECT e.empno,
       e.ENAME,
       e.JOB,
       e.SAL
  FROM emp e
 ORDER BY e.sal DESC;
 /*
 8888	J	CLERK	
9999	J_JUNE	CLERK	
7777	J%JONES	CLERK	
7839	KING	PRESIDENT	5000
7902	FORD	ANALYST	3000
7566	JONES	MANAGER	2975
7698	BLAKE	MANAGER	2850
7782	CLARK	MANAGER	2450
7499	ALLEN	SALESMAN	1600
7844	TURNER	SALESMAN	1500
7934	MILLER	CLERK	1300
7654	MARTIN	SALESMAN	1250
7521	WARD	SALESMAN	1250
7900	JAMES	CLERK	950
7369	SMITH	CLERK	800
 */
-- (2) emp 테이블에서 사번, 이름, 입사일 컬럼을 조회하고 입사일이 빠른 순서대로 정렬
SELECT e.empno,
       e.ename,
       e.HIREDATE
  FROM emp e
 ORDER BY e.hiredate;
 /*
 7369	SMITH	80/12/17
7499	ALLEN	81/02/20
7521	WARD	81/02/22
7566	JONES	81/04/02
7698	BLAKE	81/05/01
7782	CLARK	81/06/09
7844	TURNER	81/09/08
7654	MARTIN	81/09/28
7839	KING	81/11/17
7900	JAMES	81/12/03
7902	FORD	81/12/03
7934	MILLER	82/01/23
9999	J_JUNE	18/06/26
8888	J	18/06/26
7777	J%JONES	18/06/26
 */
 -- (3) emp 테이블에서 수당이 적은 순서대로 사번, 이름, 수당 컬럼을 조회
SELECT e.EMPNO,e.ename,e.job,e.comm
  FROM emp e
 ORDER BY e.comm ASC;
 /*
 7844	TURNER	SALESMAN	0
7499	ALLEN	SALESMAN	300
8888	J	CLERK	400
7777	J%JONES	CLERK	500
9999	J_JUNE	CLERK	500
7521	WARD	SALESMAN	500
7654	MARTIN	SALESMAN	1400
7900	JAMES	CLERK	
7902	FORD	ANALYST	
7934	MILLER	CLERK	
7839	KING	PRESIDENT	
7782	CLARK	MANAGER	
7698	BLAKE	MANAGER	
7566	JONES	MANAGER	
7369	SMITH	CLERK	
 */
-- (4) emp 테이블에서 수당이 큰 순서대로 사번, 이름, 수당 컬럼을 조회
SELECT e.EMPNO,e.ename,e.job,e.comm
  FROM emp e
 ORDER BY e.comm DESC;
 /*
 7369	SMITH	CLERK	
7698	BLAKE	MANAGER	
7902	FORD	ANALYST	
7900	JAMES	CLERK	
7839	KING	PRESIDENT	
7566	JONES	MANAGER	
7934	MILLER	CLERK	
7782	CLARK	MANAGER	
7654	MARTIN	SALESMAN	1400
9999	J_JUNE	CLERK	500
7521	WARD	SALESMAN	500
7777	J%JONES	CLERK	500
8888	J	CLERK	400
7499	ALLEN	SALESMAN	300
7844	TURNER	SALESMAN	0
 */
-- (5) emp 테이블에서 empno -> 사번, ename -> 이름, sal -> 급여, hiredate -> 입사일로 변경하여 출력
SELECT e.empno as "사번",
       e.ename as "이름",
       e.sal as "급여",
       e.hiredate as "입사일"
  FROM emp e;
/*
7369	SMITH	800	80/12/17
7499	ALLEN	1600	81/02/20
7521	WARD	1250	81/02/22
7566	JONES	2975	81/04/02
7654	MARTIN	1250	81/09/28
7698	BLAKE	2850	81/05/01
7782	CLARK	2450	81/06/09
7839	KING	5000	81/11/17
7844	TURNER	1500	81/09/08
7900	JAMES	950	81/12/03
7902	FORD	3000	81/12/03
7934	MILLER	1300	82/01/23
9999	J_JUNE		18/06/26
8888	J		18/06/26
7777	J%JONES		18/06/26
*/
-- (6) emp 테이블의 모든 정보 조회
SELECT e.empno,
       e.ename,
       e.job,
       e.mgr,
       e.hiredate,
       e.sal,
       e.comm,
       e.deptno
  FROM emp e;
-- (7) emp 테이블에서 직원이름이 ALLEN 인 사람의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.ename = 'ALLEN';
-- (8) emp 테이블에서 소속부서 번호가 20인 사람의 사번, 이름, 부서번호 조회
SELECT e.empno,
       e.ename,
       e.deptno
  FROM emp e
 WHERE e.deptno = 20;
-- (9) emp 테이블에서 소속부서가 20이며, 급여가 3000 미만인 사람의 사번, 이름, 급여, 부서번호 조회
SELECT e.empno,
       e.ename,
       e.sal,
       e.DEPTNO
  FROM emp e
 WHERE e.deptno = 20 and e.sal < 3000;
-- (10) emp 테이블에서 사원들의 사번, 이름, 급여와 커미션을 더한 값을 조회
 SELECT e.EMPNO,
        e.ename,
        e.sal+nvl(e.comm,0)
   FROM emp e;
-- (11) emp 테이블에서 사원들의 사번,이름,년급여를 조회
SELECT e.empno,
       e.ename,
       e.sal * 12
  FROM emp e;
-- (12) emp 테이블에서 이름 MARTIN, BLAKE인 사람의 사번, 이름, 직책, 급여 ,커미션을 조회
SELECT e.empno,
       e.ename,
       e.job,
       e.sal,
       e.comm
  FROM emp e
 WHERE e.ename = 'MARTIN' or e.ename = 'BLAKE';
-- (13) emp 테이블에서 이름이 MARTIN, BLAKE인 사람의 급여와 커미션을 합한 값을 계산하여 사번, 이름, 직책과 함께 조회
SELECT e.empno,
       e.ename,
       e.JOB,
       nvl(e.comm,0) + e.sal
  FROM emp e
 WHERE e.ename = 'MARTIN' or e.ename = 'BLAKE' ;
-- (14) emp 테이블에서 커미션이 0이 아닌 사원의 모든 정보 조회(3가지 방법)
SELECT *
  FROM emp e
 WHERE e.comm != 0 ;
 
SELECT *
  FROM emp e
 WHERE e.comm > 0;

SELECT *
  FROM emp e
 WHERE e.comm <> 0;
-- (15) emp 테이블에서 커미션이 null이 아닌 사원의 모든 정보 조회(3가지) 
SELECT *
  FROM emp e
 WHERE e.comm is not null;
 
SELECT *
  FROM emp e
 WHERE e.comm >= 0;
 
SELECT *
  FROM emp e
 WHERE e.comm = 0 or e.comm > 0;
-- (16) 부서번호가 20이고, 급여가 2500보다 큰 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.deptno = 20 and e.sal >= 2500;
-- (17) 직책이 MANAGER 이거나 부서번호가 10번인 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.job = 'MANAGER' or e.deptno = 10;
-- (18) 직책이 MANAGER, CLERK, SALESMAN 중 하나에 속하는 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.job = 'MANAGER' or e.job = 'CLERK' or e.job = 'SALESMAN';
-- (19) 이름이 A로 시작하는 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.ename LIKE 'A%';
-- (20) 이름에 A가 들어가는 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.ename LIKE '%A%';
-- (21) 이름이 S로 끝나는 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.ename LIKE '%S';
-- (22) 이름이 끝에서 두번째 글자가 E인 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.ename LIKE '%E_';




