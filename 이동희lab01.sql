-- 실습
-- (1) emp 테이블에서 사번, 이름, 업무, 급여 컬럼을 조회하고 급여가 많은 순서대로 정렬
SELECT e.empno,
       e.ENAME,
       e.JOB,
       e.SAL
  FROM emp e
 ORDER BY e.sal DESC;
-- (2) emp 테이블에서 사번, 이름, 입사일 컬럼을 조회하고 입사일이 빠른 순서대로 정렬
SELECT e.empno,
       e.ename,
       e.HIREDATE
  FROM emp e
 ORDER BY e.hiredate;
 -- (3) emp 테이블에서 수당이 적은 순서대로 사번, 이름, 수당 컬럼을 조회
SELECT e.EMPNO,e.ename,e.job,e.comm
  FROM emp e
 ORDER BY e.comm ASC;
-- (4) emp 테이블에서 수당이 큰 순서대로 사번, 이름, 수당 컬럼을 조회
SELECT e.EMPNO,e.ename,e.job,e.comm
  FROM emp e
 ORDER BY e.comm DESC;
-- (5) emp 테이블에서 empno -> 사번, ename -> 이름, sal -> 급여, hiredate -> 입사일로 변경하여 출력
SELECT e.empno as "사번",
       e.ename as "이름",
       e.sal as "급여",
       e.hiredate as "입사일"
  FROM emp e;
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
-- (23) BETWEEN 을 사용하여 급여가 2500에서 3000 사이인 사원의 모든 정보를 조회
SELECT *
  FROM emp e
 WHERE e.sal BETWEEN 2500 and 3000;
-- (24) 커미션이 NULL 인 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.comm is null;
-- (25) 커미션 NULL 이 아닌 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.comm is not null;
-- (26) 
SELECT e.empno as 사번,
       e.ename || '의 월급은' || e.sal || '입니다' 월급여
  FROM emp e
 WHERE e.empno < 7567;




