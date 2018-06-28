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
 
 -- 부서 미배정이어서 NULL 인 데이터는 부서번호 대신 '미배정' 이라고 분류
 SELECT nvl(e.deptno||'','미배정') "부서 번호",        -- 타입변환해줘야함
        SUM(e.sal) "급여 총합",
        TO_CHAR(AVG(e.sal),'9999.00') "급여 평균",
        MAX(e.sal) "최대 급여",
        MIN(e.sal) "최소 급여"
   FROM emp e
  GROUP BY e.deptno
  ORDER BY e.deptno;
 
 -- DECODE 이용
 SELECT DECODE(nvl(e.deptno,0),
               e.deptno, e.deptno||'',
               0, '미배정') as "부서 번호",       
        SUM(e.sal) "급여 총합",
        TO_CHAR(AVG(e.sal),'9999.00') "급여 평균",
        MAX(e.sal) "최대 급여",
        MIN(e.sal) "최소 급여"
   FROM emp e
  GROUP BY e.deptno
  ORDER BY e.deptno;
 
 -- job 별의 급여의 총합, 평균, 최대, 최소를 구해보자
 SELECT nvl(e.job,'미배정'),
        SUM(e.sal),
        AVG(e.sal),
        MAX(e.sal),
        MIN(e.sal)
   FROM emp e
  GROUP BY e.job; 
 
 -- 4. HAVING 절의 사용
 -- GROUP BY 결과에 조건을 걸어서 결과를 제한 할 목적으로 사용되는 절
 -- 부서별 급여 평균이 2500인 부서
 -- a) 부서별 급여 평균을 구한다
 SELECT e.deptno "부서 번호",
        AVG(e.sal) "급여 평균"
   FROM emp e
  GROUP BY e.deptno;
 -- b) a 결과에서 2000이상인 부서만 남긴다.
 SELECT e.deptno "부서 번호",
        AVG(e.sal) "급여 평균"
   FROM emp e 
  GROUP BY e.deptno
 HAVING AVG(e.sal) >= 2000;
 
 -- HAVING 절을 사용하여 조건을 걸 때 주의 점 : 별칭을 사용할 수 없음
 SELECT e.deptno "부서 번호",
        AVG(e.sal) "급여 평균"
   FROM emp e 
  GROUP BY e.deptno
 HAVING AVG "급여 평균" >= 2000;
 -- 오류코드 : HAVING 의 조건에 별칭을 사용하였기 때문
 
 -- HAVING 절이 존재하는 경우 SELECT 의 구문의 실행 순서 정리
 /*
    1. FROM 절의 테이블 각 행을 대상으로
    2. WHERE 절의 조건에 맞는 행만 선택하고
    3. GROUP BY 절에 나온 컬럼, 식(함수 식등)으로 그룹화를 진행
    4. HAVING 절의 조건을 만족시키는 그룹행만 선택
    5. 4까지 선택된 그룹 정보를 가진 행에 대해서 SELECT 절에 명시된 컬럼, 식(함수 식등)만 출력
    6. ORDER BY 가 있다면 정렬 조건에 맞추어 최종 정렬하여 보여준다.
 
 */
  
 ------------------------------------------------------
 -- 수업중 실습
 -- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬
 -- : mgr 컬럼이 그룹화 기준 컬럼
 SELECT e.mgr,
        COUNT(e.mgr)
   FROM emp e
  GROUP BY e.mgr
  ORDER BY COUNT(e.mgr) DESC;
 ------------------------------------------------------
 --강사님 코드
 SELECT e.mgr        as "매니저 사번",
        COUNT(*) as "부하직원 수"
   FROM emp e
  WHERE e.mgr IS NOT NULL 
  GROUP BY e.mgr;
 -- 2. 부서별 인원을 구하고, 인원수 많은 순으로 정렬
 -- : deptno 컬럼이 그룹화 기준 컬럼
 SELECT e.deptno,
        COUNT(e.deptno)
   FROM emp e
  GROUP BY e.deptno
  ORDER BY COUNT(e.deptno) DESC;
 -------------------------------------------------------
 SELECT e.deptno        as "부서 번호",
        COUNT(*) as "인원"
   FROM emp e
  WHERE e.deptno IS NOT NULL 
  GROUP BY e.deptno
  ORDER BY "인원" DESC;
 -- 3. 직무별 급여 평균을 구하고, 급여평균 높은 순으로 정렬
 -- : job 이 그룹화 기준 컬럼
 SELECT e.job,
        AVG(e.sal)
   FROM emp e
  GROUP BY e.job
  ORDER BY AVG(e.sal) DESC;
 -------------------------------------------------------
 SELECT e.job       as "직무",
        AVG(e.sal)  as "급여 평균"
   FROM emp e
  GROUP BY e.job
  ORDER BY AVG(e.sal) DESC;
 -- 4. 직무별 급여 총합을 구하고, 총합 높은 순으로 정렬
 -- : job 이 그룹화 기준 컬럼
 SELECT e.job,
        SUM(e.sal)
   FROM emp e
  GROUP BY e.job
  ORDER BY SUM(e.sal) DESC;
 -------------------------------------------------------
 SELECT e.job,
        SUM(e.sal)
   FROM emp e
  GROUP BY e.job
  ORDER BY SUM(e.sal) DESC;
 -- 5. 급여의 앞단위가 1000미만,1000,2000,3000,5000 별로 인원수를 구하시오
 --    급여 단위 오름차순으로 정렬     
 -- a) 급여 단위를 어떻게 구할 것인가 TRUNC() 활용
 -- b) TRUNC를 활용해서 얻어낸 급여단위를 COUNT 하여 인원수 구함
 -- : TRUNC(e.sal,-3) 로 잘라낸 값이 그룹화 기준값으로 사용
 -- c) 급여 단위가 1000 미만인 경우 0으로 출력되는 것을 변경
 -- : 범위 연산이 필요해 보임 ==> CASE 활용
 
 
 -------------------------------------------------------
 -- a)
 SELECT e.empno,
        e.ename,
        TRUNC(e.sal,-3) as "급여 단위"
   FROM emp e;
 -- b)
 SELECT TRUNC(e.sal,-3) as "급여 단위",
        COUNT(TRUNC(e.sal,-3))
   FROM emp e
  GROUP BY TRUNC(e.sal,-3)
  ORDER BY TRUNC(e.sal,-3);
 -- c)
 SELECT CASE WHEN TRUNC(e.sal,-3) < 1000 THEN '1000 미만'
             ELSE TRUNC(e.sal,-3) || ''
         END as "급여 단위",
        COUNT(TRUNC(e.sal,-3)) as "인원"
   FROM emp e
  GROUP BY TRUNC(e.sal,-3)
  ORDER BY TRUNC(e.sal,-3);
 -- 다른 방식 풀이
 -- a) sal 컬럼에 왼쪽으로 패딩을 붙여서 0을 채움
 SELECT e.empno,
        e.ename,
        LPAD(e.sal,4,'0')
   FROM emp e;
 -- b) 맨 앞의 글자를 잘라낸다.
 SELECT e.empno,
        e.ename,
        SUBSTR(LPAD(e.sal,4,'0'),1,1)
   FROM emp e;
 -- c) 1000 단위로 처리 + COUNT + 그룹화
 SELECT CASE WHEN SUBSTR(LPAD(e.sal,4,'0'),1,1) = 0 THEN '1000 미만'
             ELSE TO_CHAR(SUBSTR(LPAD(e.sal,4,'0'),1,1) * 1000)
         END as "급여 단위",
        COUNT(*) as "인원"
   FROM emp e
  GROUP BY SUBSTR(LPAD(e.sal,4,'0'),1,1) 
  ORDER BY SUBSTR(LPAD(e.sal,4,'0'),1,1);
 -- 6. 직무별 급여 합의 단위(1000,2000,3000)를 구하고, 급여 합의 단위가 큰 순으로 정렬
 -- a) job 별로 급여의 합을 구함
 -- b) 급여의 합에서 단위를 구한다
 -- c) 정렬
 SELECT e.job,
        FLOOR(SUM(e.sal)/1000) * 1000 as sal_garde
   FROM emp e
  GROUP BY e.job
  ORDER BY sal_garde DESC;
 -------------------------------------------------------
 SELECT e.job,
        TRUNC(SUM(e.sal),-3) as "급여 단위"
   FROM emp e
  GROUP BY e.job
  ORDER BY "급여 단위" DESC;
 -- 7. 직무별 급여 평균이 2000이하인 경우를 구하고 평균이 높은 순으로 정렬
 -- : job 이 그룹화 기준 컬럼
 -- a) 직무별로 급여 평균을 구하자
 SELECT e.job,
        AVG(e.sal)
   FROM emp e
  GROUP BY e.job
 HAVING AVG(e.sal) <= 2000
  ORDER BY AVG(e.sal) DESC;
 ------------------------------------------------------- 
 SELECT e.job,
        AVG(e.sal) "급여 평균"
   FROM emp e
  GROUP BY e.job
 HAVING AVG(e.sal) <= 2000
  ORDER BY AVG(e.sal) DESC;
 -- 8. 년도별 입사 인원을 구하시오
 -- : hiredate 를 활용 ==> 년도만 추출하여 그룹화 기준으로 사용
 -- a) hiredate 에서 년도 추출 : TO_CHAR(hiredate, 'YY')
 -- b) 기준값으로 그룹화 작성
 SELECT TO_CHAR(e.hiredate,'YY') as "입사 년도",
        COUNT(TO_CHAR(e.hiredate,'YY'))
   FROM emp e
  GROUP BY TO_CHAR(e.hiredate,'YY');
 ------------------------------------------------------- 
 SELECT TO_CHAR(e.hiredate,'YYYY') as "입사 년도",
        COUNT(*) "인원"
   FROM emp e
  GROUP BY TO_CHAR(e.hiredate,'YYYY')
  ORDER BY "입사 년도";
 -- 9. 년도별 월별 입사 인원을 구하시오
 -- : hiredate 활용 ==> 년도 추출, 월 추출 두 가지를 그룹화 기준으로 사용
 -- a) hiredate 에서 년도 추출 : TO_CHAR(e.hiredate, 'YYYY')
 --                   월 추출 : TO_CHAR(e.hiredate, 'MM')
 -- b) 두가지 그룹화 기준 적용된 구문 작성
 
 
 -------------------------------------------------------
 SELECT TO_CHAR(e.hiredate, 'YYYY') "입사 년도",
        TO_CHAR(e.hiredate, 'MM') "입사 월",
        COUNT(*)
   FROM emp e
  GROUP BY TO_CHAR(e.hiredate, 'YYYY'),
           TO_CHAR(e.hiredate, 'MM')
  ORDER BY "입사 년도","입사 월";
 
 -------------------------------------------------------
 --     1월  2월  3   4   5   6   7   8   9   10  11  12
 -------------------------------------------------------
 --1980  0                                             1
 --1981  0                   1           1                 
 
 -------------------------------------------------------
 
 -- 년도별, 월별 입사 인원을 가로 표 형태로 형태
 -- a) 년도 추출, 월 추출
 -- b) hiredate 에서 추출한 값이 ex) 01 이 나오면 그 때의 숫자만 1월에서 카운트
 --     이 과정을 12월 까지 반복
 SELECT TO_CHAR(e.hiredate, 'YYYY') "입사 년도", -- 그룹화 기준 컬럼
        DECODE(TO_CHAR(e.hiredate, 'MM'),'01',1) "1월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'02',1) "2월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'03',1) "3월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'04',1) "4월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'05',1) "5월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'06',1) "6월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'07',1) "7월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'08',1) "8월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'09',1) "9월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'10',1) "10월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'11',1) "11월",
        DECODE(TO_CHAR(e.hiredate, 'MM'),'12',1) "12월"
   FROM emp e
  ORDER BY "입사 년도";
 -- c) 입사 년도 기준으로 COUNT 함수 결과를 그룹화
 SELECT TO_CHAR(e.hiredate, 'YYYY') "입사 년도", -- 그룹화 기준 컬럼
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'01',1)) "1월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'02',1)) "2월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'03',1)) "3월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'04',1)) "4월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'05',1)) "5월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'06',1)) "6월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'07',1)) "7월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'08',1)) "8월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'09',1)) "9월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'10',1)) "10월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'11',1)) "11월",
        COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'12',1)) "12월"
   FROM emp e
  GROUP BY  TO_CHAR(e.hiredate, 'YYYY')
  ORDER BY "입사 년도"; 
 -- 월별 총 입사 인원을 가로로 출력
  SELECT '인원' as "입사 월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'01',1)) "1월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'02',1)) "2월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'03',1)) "3월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'04',1)) "4월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'05',1)) "5월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'06',1)) "6월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'07',1)) "7월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'08',1)) "8월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'09',1)) "9월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'10',1)) "10월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'11',1)) "11월",
         COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'),'12',1)) "12월"
   FROM emp e;
  --GROUP BY  TO_CHAR(e.hiredate, 'MM')
  --ORDER BY "입사 월"; 
 
  -- 7. 조인과 서브쿼리
  -- (1) 조인 : JOIN
  -- 하나 이상의 테이블을 논맂거으로 묶어서 하나의 테이블 인 것처럼 다루는 기술
  -- FROM 절에 조인에 사용할 테이블 이름을 나열
  
  -- 문제) 직원의 부서 번호가 아닌 소속 부서 명을 알고 싶다. 
  -- FROM 절에 emp, dept 두 테이블을 나열 => 조인 발생 => 카티션 곱 => 두 테이블의 모든 조합
  SELECT e.ename,
         e.deptno,
         '|',
         d.deptno,
         d.dname
    FROM emp e,
         dept d;
  -- 16 * 4 = 64 : emp 테이블의 16건 * dept 테이블의 4건 = 64건
  -- b) 조건이 추가 되어야 직원의 소속부서만 정확하게 연결할 수 있음
  SELECT e.ename,
         d.dname
    FROM emp e,
         dept d
   WHERE e.deptno = d.deptno
   ORDER BY d.DEPTNO;
 -- 위 방식으로 잘 안씀
 
 SELECT e.ename,
         d.dname
    FROM emp e JOIN dept d ON(e.deptno = d.DEPTNO)
        -- 최근 다른 DBMS 들이 사용하고 있는 기법을 오라클에서 지원함
   ORDER BY d.DEPTNO;
 -- 조인 조건이 적절히 추가되어 12행의 의미 있는 데이터만 남김
 
 -- 문제) 위의 결과에서 ACCOUNTING 부서의 직원만 알고 싶다.
 --       조인 조건와 일반 조건이 같이 사용될 수 있다.
 SELECT e.ename,
        d.dname
   FROM emp e,
        dept d
  WHERE e.deptno = d.deptno 
    AND d.dname = 'ACCOUNTING';
 -- 2) 조인 : 카티션 곱
 --          조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것
 --          조인조건 누락시 발생
 --          9i 버전 이후 CROSS JOIN 키워드 지원
 SELECT e.ename,
        d.dname,
        s.GRADE
   FROM emp e CROSS JOIN dept d
              CROSS JOIN salgrade s;
  SELECT e.ename,
         d.dname,
         s.grade
    FROM emp e,
         dept d,
        salgrade s;
 -- emp 16 * dept 4 * salgrade 5 = 320 행 발생       
 
 -- 3) EQUI JOIN : 조인의 가장 기본 형태
 --                서로 다른 테이블의 공통 컬럼을 '=' 로 연결
 --                공통 컬럼(Join Attribute)라고 부름
 -- 1. 오라클 전통 적인 WHERE 에 조인 조건을 걸어주는 방법
  SELECT e.ename,
         d.dname
    FROM emp e,
         dept d
   WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
   ORDER BY d.DEPTNO;
 -- 2. NATURAL JOIN 키워드로 자동 조인
 SELECT e.ename,
        d.dname
    FROM emp e NATURAL JOIN dept d; -- 조인 공통 컬럼 명시가 필요 없음
 -- 3. JOIN ~ USING 키워드로 조인
 SELECT e.ename,
         d.dname
    FROM emp e JOIN dept d USING(deptno); -- USING 뒤에 공통 컬럼을 별칭 없이 명시
 -- 4. JOIN ~ ON 키워드로 조인
 SELECT e.ename,
         d.dname
    FROM emp e JOIN dept d ON(e.deptno = d.deptno); -- ON 뒤에 조인 조건구문을 명시
 
    
    
  -- (2) 서브쿼리
 
 
 
 
 
 
 
 