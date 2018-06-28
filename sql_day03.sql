 -- sql_day03
 
 -- (3) 단일행 함수
 -- 6) CASE
 -- job별로 경조사비를 일정 비율로 지급하고 있다.
 -- 각 직원들의 경조사비 지원금을 구하자
 /*
    CLERK : 5%
    SALESMAN : 4%
    MANAGER : 3.7%
    ANALYST : 3%
    PRESIDENT : 1.5%
 */
 -- 1. Simple CASE 구문으로 구해보자 : DECODE 와 거의 유사, 동일비교만 가능
 --                                  괄호가 없고, 콤마대신 키워드 WHEN, THEN, ELSE 등을 사용
 SELECT e.empno,
        e.ename,
        e.job,
        CASE e.job WHEN 'CLERK'    THEN e.sal * 0.05
                   WHEN 'SALESMAN' THEN e.sal * 0.04
                   WHEN 'MANAGER'  THEN e.sal * 0.037
                   WHEN 'ANALYST'  THEN e.sal * 0.03
                   WHEN 'PRESIDENT' THEN e.sal * 0.015
         END as "경조사 지원금"
  FROM emp e;
 
 -- 2. Searched CASE 구문으로 구해보자 : 
 SELECT e.empno,
        e.ename,
        e.job,
        CASE WHEN e.job = 'CLERK'   THEN e.sal * 0.05
             WHEN e.job = 'SALESMAN'    THEN e.sal * 0.04
             WHEN e.job = 'MANAGER' THEN e.sal * 0.037
             WHEN e.job = 'ANALYST' THEN e.sal * 0.03
             WHEN e.job = 'PRESIDENT'   THEN e.sal * 0.015
             ELSE 10
         END as "경조사 지원금"
   FROM emp e;
 -- CASE 결과에 숫자 통화 패턴 씌우기 : $ 기호, 숫자 세자리 끊어 읽기, 소수점 이하 2자리
 SELECT e.empno,
        e.ename,
        nvl(e.job,'미지정') as job,
        TO_CHAR(CASE WHEN e.job = 'CLERK'   THEN e.sal * 0.05
             WHEN e.job = 'SALESMAN'    THEN e.sal * 0.04
             WHEN e.job = 'MANAGER' THEN e.sal * 0.037
             WHEN e.job = 'ANALYST' THEN e.sal * 0.03
             WHEN e.job = 'PRESIDENT'   THEN e.sal * 0.015
             ELSE 10
         END,'$9,999.99') as "경조사 지원금"
   FROM emp e;
 
 /* SALGRADE 테이블의 내용 : 이 회사의 급여 등급 기준 값
GRADE, LOSAL, HISAL 
1 	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
 */
 -- 제공되는 급여 등급을 바탕으로 각 사원들의 급여 등급을 구해보자 (CASE 사용)
 SELECT e.empno,
        e.ename,
        e.sal,
        CASE WHEN e.sal >= 700    and e.sal <= 1200 THEN 1
             WHEN e.sal >= 1201   and e.sal <= 1400 THEN 2
             WHEN e.sal >= 1401   and e.sal <= 2000 THEN 3
             WHEN e.sal >= 2001   and e.sal <= 3000 THEN 4
             WHEN e.sal >= 3001   and e.sal <= 9999 THEN 5
             ELSE 0
         END as "급여 등급"
   FROM emp e
  ORDER BY "급여 등급" DESC;
 -- WHEN 안의 구문을 BETWEEN 으로 변경하여 작성  
 SELECT e.empno,
        e.ename,
        e.sal,
        CASE WHEN e.sal BETWEEN 700     AND 1200 THEN 1
             WHEN e.sal BETWEEN 1201    AND 1400 THEN 2
             WHEN e.sal BETWEEN 1401    AND 2000 THEN 3
             WHEN e.sal BETWEEN 2001    AND 3000 THEN 4
             WHEN e.sal BETWEEN 3001    AND 9999 THEN 5
             ELSE 0
         END as "급여 등급"
   FROM emp e
  ORDER BY "급여 등급" DESC;  
 
 -- 2. 그룹함수 (복수행 함수)
 -- 1) COUNT(*) : 특정 테이블의 행의 개수 (데이터의 개수)를 세어주는 함수
 --               NULL 을 처리하는 유일한 그룹함수
 
 -- COUNT(expr) : expr 으로 등장한 값을 NULL 을 제외하고 세어주는 함수
 -- dept, salgrade 테이블의 전체 데이터 개수 조회
 SELECT COUNT(*) as "부서 개수"
   FROM dept;
 -- 4(행의 갯수)
 SELECT *
   FROM dept;
 /*
10	ACCOUNTING	NEW YORK    ===>
20	RESEARCH	DALLAS      ===>    COUNT(*) ==> 4
30	SALES	    CHICAGO     ===>
40	OPERATIONS	BOSTON      ===>
 */
 SELECT COUNT(*) as "급여 등급 개수"
   FROM salgrade;
 -- 5
 -- emp 테이블에서 job 컬럼의 데이터 개수를 카운트
 SELECT COUNT(e.job)
   FROM emp e;
 /*
 7369	SMITH	CLERK       ==>
7499	ALLEN	SALESMAN    ==>
7521	WARD	SALESMAN    ==>
7566	JONES	MANAGER     ==>
7654	MARTIN	SALESMAN    ==>
7698	BLAKE	MANAGER     ==>
7782	CLARK	MANAGER     ==>
7839	KING	PRESIDENT   ==>     COUNT(e.job) ==> 15
7844	TURNER	SALESMAN    ==>
7900	JAMES	CLERK       ==>
7902	FORD	ANALYST     ==>
7934	MILLER	CLERK       ==>
9999	J	    CLERK       ==>
8888	J_JUNE	CLERK       ==>
7777	J%JUNES	CLERK       ==>
6666	JJ	    (null)      ==> 개수를 세는 기준 컬럼인 job이 null이 이 한행은 처리 안함
 */
 -- 회사에 MANAGER 가 배정된 직원이 몇명인가
 SELECT COUNT(e.MGR) as "상사가 있는 직원 수"
   FROM emp e;
 -- MANAGER 직을 맡고 있는 직원이 몇명인가
 -- 1. MGR 컬럼을 중복제거해서 조회
 SELECT DISTINCT e.mgr
   FROM emp e;
 -- 2. 그 때의 결과를 카운트
 SELECT COUNT(DISTINCT e.mgr) as "매니저 수"
   FROM emp e;
 -- 부서가 배정된 직원이 몇명이나 있는가
 SELECT COUNT(e.deptno) as "부서 배정 인원"
   FROM emp e;
 -- COUNT(*) 가 아닌 COUNT(expr) 를 사용한 경우에는
 SELECT e.deptno
   FROM emp e
  WHERE e.deptno IS NOT NULL;
 -- 을 수행한 결과를 카운트 한 것으로 생각할 수 있다. 
   
 SELECT COUNT(*) as "전체 인원",
        COUNT(e.deptno) as "부서 배정 인원",
        COUNT(*) - COUNT(e.deptno) as "부서 미배정 인원"
   FROM emp e;
 
 -- 2) SUM() : NULL 항목 제외, 합산 가능한 행을 모두 더한 결과를 출력
 -- SALESMAN 들의 수당 총합
 SELECT SUM(e.comm)
   FROM emp e
  WHERE e.job = 'SALESMAN';
 -- 수당 총합 결과에 숫자 출력 패턴, 별칭
 SELECT TO_CHAR(SUM(e.comm), '$9,999') as "수당 총합"
   FROM emp e
  WHERE e.job = 'SALESMAN';
 
 -- 3) AVG() : NULL 항목 제외, 연산 가능한 항목의 산술 평균을 출력
 -- 수당 평균
 SELECT TO_CHAR(AVG(e.comm),'$9,999') as "수당 평균"
   FROM emp e
  WHERE e.job = 'SALESMAN';
 
 -- 4) MAX(expr) : expr에 등장하는 값 중 최댓값을 구함
 --                expr 이 문자인 경우 알파벳 순 뒷쪽에 위치한 글자를 최댓값으로 계산
 -- 이름이 가장 나중인 직원
 SELECT MAX(e.ename)
   FROM emp e;
 -- WARD
 
 -- 3. GROUP BY 절 
 -- 1) emp 테이블에서 각 부서별 급여의 총합 조회
 -- 총합을 구하기 위해서 SUM() 을 사용
 -- 그룹화 기준을 부서번호(DEPTNO) 를 사용
 -- 그룹화 기준으로 잡은 부서번호가 GROUP BY 절에 등장해야 함
 
 -- a) 먼저 emp 테이블에서 급여 총합을 구하는 구문을 작성
 SELECT sum(e.sal)
   FROM emp e;
 -- b) 부서번호를 기준으로 그룹화를 진행
 --    SUM()은 그룹함수이므로 GROUP BY 절을 조합하면 그룹화 가능
 --    그룹화를 하려면 기준 컬럼을 GROUP BY 절에 명시
 SELECT e.deptno,
        SUM(e.sal) "급여 총합"
   FROM emp e
  GROUP BY e.deptno;
 
 -- GROUP BY 절에 등장하지 않은 컬럼이 SELECT 에 등잦ㅇ하면 오류, 실행 불가
 SELECT e.deptno,
        e.job,
        SUM(e.sal) "급여 총합"
   FROM emp e
  GROUP BY e.deptno;
 -- ORA-00979: not a GROUP BY expression
 
 -- 부서별 급여의 총합, 평균, 최대급여, 최소급여
 SELECT e.deptno "부서 번호",
        SUM(e.sal) "급여 총합",
        TO_CHAR(AVG(e.sal),'9999.00') "급여 평균",
        MAX(e.sal) "최대 급여",
        MIN(e.sal) "최소 급여"
   FROM emp e
  GROUP BY e.deptno
  ORDER BY e.deptno;
 
 -- ########
 -- GROUP BY 절에 등장하는 그룹화 기준 컬럼은 반드시 SELECT 절에 똑같이 등장해야 한다. (중요!!)
 -- 하지만, 위의 쿼리가 실행되는 이유는 SELECT 절에 나열된 컬럼 중에서 그룹함수가 사용되지 않은 컬럼이 없기 때문
 -- 즉, 모두다 그룹함수가 사용된 컬럼들이기 때문에
 -- ########
 
 -- 부서별, 직무별 급여의 총합, 평균, 최대, 최소를 구해보자
 SELECT e.deptno "부서 번호",
        e.job "직무",
        SUM(e.sal) "급여 총합",
        AVG(e.sal) "급여 평균",
        MAX(e.sal) "최대 급여",
        MIN(e.sal) "최소 급여"
   FROM emp e
  GROUP BY e.deptno,e.job
  ORDER BY e.deptno,e.job;
 
 -- 오류코드 ORA-00979: not a GROUP BY expression
 SELECT e.deptno "부서 번호",
        e.job "직무",           -- SELECT 에는 등장
        SUM(e.sal) "급여 총합",
        AVG(e.sal) "급여 평균",
        MAX(e.sal) "최대 급여",
        MIN(e.sal) "최소 급여"
   FROM emp e
  GROUP BY e.deptno             -- GROUP BY 에는 누락된 컬럼 JOB
  ORDER BY e.deptno,e.job;
 -- 그룹함수가 적용되지 않았고, GROUP BY 절에도 등장하는 않은 JOB 컬럼이 
 -- SELECT 절에 있기 때문에 오류 발생
 
 -- 오류코드 ORA-00937: not a single-group group function
 SELECT e.deptno "부서 번호",
        e.job "직무",           -- SELECT 에는 등장
        SUM(e.sal) "급여 총합",
        AVG(e.sal) "급여 평균",
        MAX(e.sal) "최대 급여",
        MIN(e.sal) "최소 급여"
   FROM emp e;
 -- GROUP BY e.deptno             -- GROUP BY 누락
 -- 그룹함수가 적용되지 않은 컬럼들이 SELECT 에 등장하면 그룹화기준으로 가정되어야 함
 -- 그룹화 기준으로 사용되는 GROUP BY 절 자체가 누락
  
 -- job 별의 급여의 총합, 평균, 최대, 최소를 구해보자
 SELECT DISTINCT e.job,
        SUM(e.sal),
        AVG(e.sal),
        MAX(e.sal),
        MIN(e.sal)
   FROM emp e
  GROUP BY e.job,e.sal; 
 
 
 
 
 
 
 -- 16)
 SELECT e.empno 사원번호,
        e.ename 이름,
        e.sal 급여 ,
        TO_CHAR(CASE e.job WHEN 'CLERK'    THEN 300
                   WHEN 'SALESMAN' THEN 450
                   WHEN 'MANAGER'  THEN 600
                   WHEN 'ANALYST'  THEN 800
                   WHEN 'PRESIDENT' THEN 1000
         END,'$9,999') as "자기 계발비"
  FROM emp e;
 -- 17)
 SELECT e.empno 사원번호,
        e.ename 이름,
        e.sal 급여 ,
        TO_CHAR(CASE WHEN e.job = 'CLERK'    THEN 300
             WHEN e.job = 'SALESMAN' THEN 450
             WHEN e.job = 'MANAGER'  THEN 600
             WHEN e.job = 'ANALYST'  THEN 800
             WHEN e.job = 'PRESIDENT' THEN 1000
         END,'$9,999') as "자기 계발비"
  FROM emp e;
 -- 18)
 SELECT COUNT(*)
   FROM emp;
 -- 16
 -- 19)
 SELECT COUNT(DISTINCT e.job)
   FROM emp e;
 -- 5
 -- 20)
 SELECT COUNT(e.comm)
   FROM emp e;
 -- 4
 -- 21)
 SELECT SUM(e.sal)
   FROM emp e;
 -- 28925
 -- 22)
 SELECT AVG(e.sal)
   FROM emp e;
 --1807.8125
 -- 23)
 SELECT SUM(e.sal),
        AVG(e.sal),
        MAX(e.sal),
        MIN(e.sal)
   FROM emp e;
 -- 28925	1807.8125	5000	300
 -- 24)
 SELECT TO_CHAR(STDDEV(e.sal),'9999.99') as dev, 
        TO_CHAR(VARIANCE(e.sal),'9999999999.99') as var
   FROM emp e;     
 --  1269.96	    1612809.90  
 -- 25)
 SELECT TO_CHAR(STDDEV(e.sal),'9999.99') as dev, 
        TO_CHAR(VARIANCE(e.sal),'9999999999.99') as var
   FROM emp e
  WHERE e.job = 'SALESMAN';
 --   177.95	      31666.67