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
SELECT *
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
 SELECT e.empno,
        e.ename,
        (e.sal + e.comm)
   FROM emp e;
 
 
 
 
 
 
