 -- SQL day 02
 
 -- IS NULL, IS NOT NULL 연산자
 -- IS NULL : 비교하려는 컬럼의 값이 NULL 이면 TRUE , NULL 이 아니면 FALSE
 -- IS NOT NULL : 비교하려는 컬럼의 값이 NULL 이 아니면 TRUE, NULL 이면 FALSE
 -- NULL 값의 컬럼은 비교연산자와 연산이 불가능 하므로
 -- NULL 값 비교 연산자가 따로 존재함
 -- col = null      => NULL 값에 대해서는 = 비교 연산자가 사용 불가능
 -- col1 != null    => NULL 값에 대해서는 !=, <> 비교 연산자 사용 불가능
 
 --어떤 직원의 MGR 이 지정되지 않은 직원 정보 조회
 SELECT e.empno,
        e.ename,
        e.mgr
   FROM emp e
  WHERE e.mgr is null;
 /*
7839	KING	
9999	J	
8888	J_JUNE	
7777	J%JUNES	
 */
  SELECT e.empno,
        e.ename,
        e.mgr
   FROM emp e
  WHERE e.mgr is not null;
 /*
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
 */
 -- BETWEEN A AND B : 범위 비교 연산자 (범위 포함)
 -- a <= sal <= b : 이러한 범위 연산과 동일
 -- 급여가 500~ 1200 사이인 직원 정보 조회
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal BETWEEN 500 and 1200;
/*
7369	SMITH	800
7900	JAMES	950
9999	J	500
*/
 -- BETWEEN 500 AND 1200 과 같은 결과를 내는 비교 연산자
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal >=500 and e.sal <= 1200; 
 
 -- IN 연산자 : col IN ( 값 )
  
 -- EXISTS 연산자 : 조회한 결과가 1행 이상 있다. (TRUE)
 --                어떤 SELECT 구문을 실행 했을 때 조회 결과가 1행 이상 있으면 
 --                이 연산자의 결과가 TRUE
 --                조회 결과 : 인출된 모든 행 : 0 인 경우 FALSE
 --                따라서 서브쿼리와 함께 사용됨
 -- EXISTS ( 조회 결과가 있다/없다(SELECT FROM 구문이 들어가야함) ) => TURE/FALSE
 -- 급여가 10000이 넘는 사람이 있는가?
 -- (1) 급여가 10000이 넘는 사람을 찾는 구문을 작성
 SELECT e.name
   FROM emp e
  WHERE e.sal > 10000;
 /*
    위의 쿼리 실행 결과가 1행이라도 존재하면 화면에 급여가 10000이 넘는 직원이 존재함 이라고 출력
 */
 SELECT '급여가 10000이 넘는 직원이 존재함' as "시스템 메시지"
   FROM dual
  WHERE EXISTS ( SELECT e.ename
                   FROM emp e
                  WHERE e.sal > 3000);
 /*
    위의 쿼리 실행 결과가 1행이라도 존재하지 않으면 화면에 급여가 10000이 넘는 직원이 존재하지 않음 이라고 출력
 */
 SELECT '급여가 10000이 넘는 직원이 존재하지 않음' as "시스템 메시지"
   FROM dual
  WHERE NOT EXISTS ( SELECT e.ename
                   FROM emp e
                  WHERE e.sal > 10000);
 
 -- (6) 연산자 : 결합연산자 ( || )
 -- oracle에만 존재, 문자열 결합(접합)
 -- 자바 등의 프로그래밍 언어에서는 OR 논리 연산자로 사용되므로 혼동에 주의
 -- 오늘의 날짜를 화면에 조회
 SELECT sysdate
   FROM dual; -- 1행만 출력을 보장하는 테이블
 
 -- 오늘의 날짜를 알려주는 문장을 만들려면
 SELECT '오늘의 날짜는 ' || sysdate || ' 입니다.|' as "오늘의 날짜"
   FROM dual;
 -- 직원의 사번을 알려주는 구문을 || 연산자를 사용하여 작성
 SELECT '안녕하세요. ' || e.ename || ' 씨, 당신의 사번은 ' || e.empno || ' 입니다.' as "사번 알림"
  FROM emp e;
 
 
 -- (6) 연산자 : 6. 집합연산자
 -- 첫번째 쿼리
 SELECT *
   FROM dept d;
 -- 두번째 쿼리
 SELECT *
   FROM dept d
  WHERE d.deptno = 10;
  
 -- 1) UNION ALL : 두 집합의 중복 데이터 허용
 SELECT *
   FROM dept d
  UNION ALL
 SELECT *
   FROM dept d
  WHERE d.deptno = 10;
 /*
 10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
10	ACCOUNTING	NEW YORK
 */
 -- 2) UNION : 두 집합의 중복 데이터 제거 (합집합)
 SELECT *
   FROM dept d
  UNION 
 SELECT *
   FROM dept d
  WHERE d.deptno = 10;
 -- 3) INTERSECT : 두 집합의 중복된 데이터만 남김 (교집합)
 SELECT *
   FROM dept d
  INTERSECT 
 SELECT *
   FROM dept d
  WHERE d.deptno = 10;
 -- 4) MINUS : 첫번째 쿼리 실행 결과에서 두번째 쿼리 실행결과를 뺌 (차집합)
 SELECT *
   FROM dept d
  MINUS 
 SELECT *
   FROM dept d
  WHERE d.deptno = 10;
 
 -- 주의 ! : 각 쿼리 조회 결과의 컬럼 갯수, 데이터 타입이 서로 일치해야 함
 -- 컬럼 갯수가 일치하지 않은 경우
 SELECT *           -- 첫번째 쿼리 조회 컬럼 개수는 3
   FROM dept d
  UNION ALL
 SELECT d.DEPTNO,   -- 두번째 쿼리 조회 컬럼 개수는 2
        d.dname
   FROM dept d
  WHERE d.deptno = 10;
 -- ORA-01789: query block has incorrect number of result columns
 
 -- 데이터 타입이 일치하지 않은 경우
  SELECT d.dname,   -- 문자형 데이터 
         d.deptno   -- 숫자형 데이터
   FROM dept d
  UNION ALL
 SELECT d.DEPTNO,   -- 숫자형 데이터
        d.dname     -- 문자형 데이터
   FROM dept d
  WHERE d.deptno = 10;
 -- ORA-01790: expression must have same datatype as corresponding expression
 
 -- 서로 다른 테이블에서 조회한 결과를 집합연산 가능
 -- 첫번째 쿼리 : emp 테이블에서 조회
 SELECT e.empno,    -- 숫자
        e.ename,    -- 문자
        e.job       -- 문자
   FROM emp e;
 -- 두번째 쿼리 : dept 테이블에서 조회
 SELEECT d.deptno,  -- 숫자
         d.dname,   -- 문자
         d.loc      -- 문자
  FROM dept d
  
  -- 서로 다른 테이블의 조회 내용을 UNION
 SELECT e.empno,    -- 숫자
        e.ename,    -- 문자
        e.job       -- 문자
   FROM emp e
  UNION
 SELECT d.deptno,  -- 숫자
        d.dname,   -- 문자
        d.loc      -- 문자
   FROM dept d;
 /*  19줄
 10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7777	J%JUNES	CLERK
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
8888	J_JUNE	CLERK
9999	J	CLERK
 */
 -- 서로 다른 테이블의 조회 내용을 MINUS
 SELECT e.empno,    -- 숫자
        e.ename,    -- 문자
        e.job       -- 문자
   FROM emp e
  MINUS
 SELECT d.deptno,  -- 숫자
        d.dname,   -- 문자
        d.loc      -- 문자
   FROM dept d;
 /*   15줄 (emp 에서 dept 뺄 게 없어서 emp 테이블만 인출됨)
 7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7777	J%JUNES	CLERK
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
8888	J_JUNE	CLERK
9999	J	CLERK
 */
 -- 서로 다른 테이블의 조회 내용을 INTERSECT
 SELECT e.empno,    -- 숫자
        e.ename,    -- 문자
        e.job       -- 문자
   FROM emp e
  INTERSECT
 SELECT d.deptno,  -- 숫자
        d.dname,   -- 문자
        d.loc      -- 문자
   FROM dept d;
 -- 조회 결과 없음 : 인출된 모든 행 : 0
 -- no rows selected 
 
 -- (6) 연산자 : 7. 연산자 우선순위
 -- 주어진 조건 3가지
 -- 1.MGR = 7698
 -- 2.JOB = 'CLERK'
 -- 3.SAL > 1300
 
 -- 1) 매니저가 7698 이며, 직무는 CLERK 이거나 급여나 1300 이 넘는 조건을 만족하는 직원의 정보를 조회
 SELECT e.empno,
        e.ename,
        e.job,
        e.sal,
        e.mgr
   FROM emp e
  WHERE e.mgr = 7698 and e.job = 'CLERK' or e.sal > 1300;
  /*
7499	ALLEN	SALESMAN	1600	7698
7566	JONES	MANAGER	    2975	7839
7698	BLAKE	MANAGER	    2850	7839
7782	CLARK	MANAGER	    2450	7839
7839	KING	PRESIDENT	5000	
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
7902	FORD	ANALYST	    3000	7566
  */
 -- 2) 매니저가 7698 인 직원중에, 직무가 CLERK 이거나 급여가 1300이 넘는 조건을 만족하는 직원 정보
 SELECT e.empno,
        e.ename,
        e.job,
        e.sal,
        e.mgr
   FROM emp e
  WHERE e.mgr = 7698 and (e.job = 'CLERK' or e.sal > 1300); 
  /*
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
  */
 -- 3) 직무가 CLERK 이거나 급여가 1300이 넘으면서 매니저가 7698인 직원의 정보 조회
 SELECT e.empno,
        e.ename,
        e.job,
        e.sal,
        e.mgr
   FROM emp e
  WHERE e.job = 'CLERK' or (e.sal > 1300 and e.mgr = 7698); 
 -- AND 연산자의 우선순위가 or 연산보다 높기 때문에 괄호를 사용하지 않아도 수행 결과는 같음
 /*
7369	SMITH	CLERK	    800	    7902
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
7934	MILLER	CLERK	    1300	7782
9999	J	    CLERK	    500	
8888	J_JUNE	CLERK	    400	
7777	J%JUNES	CLERK	    300	
 */
 
 -- 6. 함수
 -- (2) dual 테이블 : 1 행 1열로 구성된 시스템 테이블
 DESC dual;  --> 문자 데이터 1칸으로 구성된 dummy 컬럼을 가진 테이블 

 DESC emp;

 SELECT *   -- dummy 컬럼의 x 값이 하나 들어있음을 확인할 수 있다.
   FROM dual;
 
 -- dual 테이블을 사용하여 날짜 조회
 SELECT sysdate
   FROM dual;
 
 -- (3) 단일행 함수
 -- 1) 숫자함수 : 1. MOD(m,n) : m을 n으로 나눈 나머지를 계산 함수
 -- 행의 개수만큼 실행
 -- 1번 실행
 SELECT mod(10,3) as result
   FROM dual;
 
 -- 15번 실행
 SELECT mod(10,3) as result
   FROM emp;
 
 -- 4번 실행
 SELECT mod(10,3) as result
   FROM dept;
 -- 각 사원의 급여를 3으로 나눈 나머지를 조회
 SELECT e.empno,
        e.ename,
        mod(e.sal,3) as result
   FROM emp e;
 /*
7369	SMITH	2
7499	ALLEN	1
7521	WARD	2
7566	JONES	2
7654	MARTIN	2
7698	BLAKE	0
7782	CLARK	2
7839	KING	2
7844	TURNER	0
7900	JAMES	2
7902	FORD	0
7934	MILLER	1
9999	J	2
8888	J_JUNE	1
7777	J%JUNES	0
 */
 -- 단일행 함수는 테이블 1행당 1번씩 적용
 
 -- 2. ROUND(m,n) : 실수 m 을 소수점 n + 1 자리에서 반올림 한 결과를 계산
 SELECT round(1234.56,1)
   FROM dual;
 -- 1234.6
 SELECT round(1234.56,0)
   FROM dual;  
 -- 1235
 SELECT round(1234.46,0)
   FROM dual;
 -- 1234
 
 -- ROUND(m) : n 값을 생략하면 소수점 이하 첫째자리 반올림 바로 수행
 -- 즉, n 값을 0 으로 수행함
 SELECT round(1234.56)
  FROM dual;  
 -- 1235
 SELECT round(1234.46)
  FROM dual;  
 -- 1234
 
 -- 3. TRUNC(m,n) : 실수 m 을 n 에서 지정한 자리 이하로 수소점 버림
 SELECT TRUNC(1234.56,1)
   FROM dual;  
 -- 1234.5
 SELECT TRUNC(1234.56,0)
   FROM dual;   
 -- 1234
 
 -- 3. TRUNC(m) : n 을 생략하면 0으로 수행
 SELECT TRUNC(1234.56)
   FROM dual;   
 -- 1234
 
 -- 4. CEIL(n) : 입력된 실수 n 에서 가장 같거나 가장 큰 가까운 정수
 SELECT CEIL(1234.56) 
   FROM dual;
 -- 1235
 SELECT CEIL(1234) 
   FROM dual;
 -- 1234
 SELECT CEIL(1234.001) 
   FROM dual;
 -- 1235
 
 -- 5. FLOOR(n) : 입력된 실수 n 에서 같거나 가장 가까운 작은 정수
 SELECT RLOOR(1234.56)
   FROM dual;
 -- 1234
 SELECT RLOOR(1234)
   FROM dual;
 -- 1234
 SELECT RLOOR(1235.56)
   FROM dual;
 -- 1235
 
 -- 6. WIDTH_BUCKET(expr, min, max, buckets) : min, max 값 사이를 buckets 개수 만큼의 구간으로 나누
 -- expr이 출력하는 값이 어느 구간인지 위치를 숫자로 구해줌
 -- 급여 범위를 0 ~ 5000 으로 잡고, 5개의 구간으로 나누어서 각 직원의 급여가 어느 구간에 해당하는지 보고서를 출력
 SELECT e.empno,
        e.ename,
        e.sal,
        width_bucket(e.sal,0,5000,5) as "급여 구간"
   FROM emp e
  ORDER BY "급여 구간" DESC;
 
 -- 2) 문자함수
 -- 1. INITCAP(str) : str 의 첫 글자를 대문자화 (영문인 경우)
 SELECT INITCAP('the soap') 
   FROM dual; -- The Soap
 SELECT INITCAP('안녕하세요') 
   FROM dual; -- 안녕하세요

 -- 2. LOWER(str) : str 을 소문자화 (영문인 경우)
 SELECT LOWER('MR. SCOTT MCMILLAN') "소문자로 변경" 
   FROM dual;

 -- 3. UPPER(str) : str 을 대문자화 (영문인 경우)
 SELECT UPPER('lee') "성을 대문자로" 
   FROM dual;
 SELECT UPPER('sql is coooooooooooool~!!') "씐나!" 
   FROM dual;

 -- 4. LENGTH(str), LENGTHB(str) : str 의 글자길이를 계산
 SELECT LENGTH('hello, sql') as "글자 길이" 
   FROM dual;
 SELECT 'hello, sql의 글자 길이는 ' || LENGTH('hello, sql') || '입니다' as "글자 길이"
   FROM dual;
 -- oracle 에서 한글은 3byte로 계산
 SELECT LENGTHB('hello, sql') as "글자 byte" 
   FROM dual;
 SELECT LENGTHB('오라클凸') as "글자 byte" 
   FROM dual;

 -- 5. CONCAT(str1, str2) : str1, str2 문자열을 접합, || 연산자와 동일
 SELECT CONCAT('안녕하세요, ', 'SQL') 
   FROM dual;
 SELECT '안녕하세요, ' || 'SQL' 
   FROM dual;

 -- 6. SUBSTR(str, i, n) : str 에서 i번째 위치에서 n개의 글자를 추출
 --                        SQL 에서 문자열 인덱스를 나타내는 i는 1부터 시작에 주의함
 SELECT SUBSTR('sql is coooooooooooooooool', 3, 4) 
   FROM dual;
 --      SUBSTR(str, i) : i번째 위치에 문자열 끝까지 추출
 SELECT SUBSTR('sql is coooooooooooooooool', 3) 
   FROM dual;

 -- 7. INSTR(str1, str2) : 2번째 문자열이 1번째 문자열 어디에 위치하는가
 --                        등장하는 위치를 계산
 SELECT INSTR('sql is coooooooooooooooool', 'is') 
   FROM dual;
 SELECT INSTR('sql is coooooooooooooooool', 'ia') 
   FROM dual;
 -- 2번째 문장이 등장하지 않으면 0으로 계산

 -- 8. LPAD, RPAD(str, n, c) : 입력된 str 에 대해서, 전체 글자의 자릿수를 n으로 잡고
 --                            남는 공간에 왼쪽, 혹은 오른쪽으로 c 의 문자를 채워넣는다
 SELECT LPAD('sql is cool', 20, '!') 
   FROM dual;
 SELECT RPAD('sql is cool', 20, '!') 
   FROM dual;

 -- 9. LTRIM, RTRIM, TRIM : 입력된 문자열의 왼쪽, 오른쪽, 양쪽 공백 제거
 SELECT '>' || LTRIM('          sql is cool           ') || '<' 
   FROM dual;
 SELECT '>' || RTRIM('          sql is cool           ') || '<' 
   FROM dual;
 SELECT '>' || TRIM('          sql is cool           ') || '<' 
   FROM dual;

 -- 10. NVL(expr1, expr2), NVL2(expr1, expr2, expr3), NULLIF(expr1, expr2)
 -- NVL(expr1, expr2) : 첫번째 식의 값이 NULL이면 두번째 식으로 대체하여 출력
 -- mgr 가 배정안된 직원의 경우 '매니저 없음' 으로 변경하여 출력
 SELECT e.EMPNO
      , e.ENAME
      , NVL(e.MGR, '매니저 없음')
   FROM emp e                         --타입 불일치로 실행이 안됨;
   
 SELECT e.EMPNO
      , e.ENAME
      , NVL('' || e.MGR, '매니저 없음')
   FROM emp e;

 -- NVL2(expr1, expr2, expr3)
 --  : 첫번째 식의 값이 NOT NULL 이면 두번째 식의 값으로 대체하여 출력
 --                  NULL 이면 세번째 식의 값으로 대체하여 출력
 SELECT e.EMPNO
      , e.ENAME
      , NVL2(e.MGR, '매니저있음', '매니저없음')
   FROM emp e;

 -- NULLIF(expr1, expr2)
 --  : 첫번째 식, 두번째 식의 값이 동일하면 NULL을 출력
 --    식의 값이 다르면 첫번째 식의 값을 출력
 SELECT NULLIF('AAA', 'AAA') 
   FROM dual;
 SELECT NULLIF('AAA', 'BBB') 
   FROM dual;
 -- 조회된 결과 1행이 NULL 인 결과를 얻게 됨
 -- 1행이라도 NULL이 조회된 결과는 인출된 모든 행 : 0 과는 상태가 다름

 -- 3) 날짜 함수 : 날짜 출력 패턴 조합으로 다양하게 출력 가능
 SELECT sysdate
   FROM dual;
   
 -- TO_CHAR() : 숫자나 날짜를 문자형으로 변환
 SELECT TO_CHAR(sysdate, 'YYYY') FROM dual;
 SELECT TO_CHAR(sysdate, 'YY') FROM dual;
 SELECT TO_CHAR(sysdate, 'MM') FROM dual;
 SELECT TO_CHAR(sysdate, 'MONTH') FROM dual;
 SELECT TO_CHAR(sysdate, 'DD') FROM dual;
 SELECT TO_CHAR(sysdate, 'D') FROM dual;
 SELECT TO_CHAR(sysdate, 'DAY') FROM dual;
 SELECT TO_CHAR(sysdate, 'DY') FROM dual;
 
 -- 패턴을 조합
 SELECT TO_CHAR(sysdate, 'YYYY-MM-DD') FROM dual;
 SELECT TO_CHAR(sysdate, 'FMYYYY-MM-DD') FROM dual;
 SELECT TO_CHAR(sysdate, 'YY-MONTH-DD') FROM dual;
 SELECT TO_CHAR(sysdate, 'YY-MONTH-DD DAY') FROM dual;
 SELECT TO_CHAR(sysdate, 'YY-MONTH-DD DY') FROM dual;
 
 /* 시간 패턴 :
    HH : 시간을 두자리로 표기
    MI : 분을 두자리로 표기
    SS : 초를 두자리로 표기
    HH24 : 시간을 24시간 체계로 표기
    AM : 오전인지 오후인지 표기
*/
 SELECT TO_CHAR(sysdate, 'YY-MONTH-DD HH24:MI:SS') FROM dual;
 SELECT TO_CHAR(sysdate, 'YY-MONTH-DD AM HH:MI:SS') FROM dual;
 
 -- 날짜 값과 숫자의 연산 : +, - 연산 가능
 -- 10일 후
 SELECT sysdate + 10 FROM dual;
 -- 10일 전
 SELECT sysdate - 10 FROM dual;
 -- 10시간 후
 SELECT sysdate + (10/24) FROM dual;
 SELECT TO_CHAR(sysdate + (10/24),'YY-MM-DD HH24:MI:SS') FROM dual;
 
 -- 1. MONTHS_BETWEEN(day1,day2) : 두 날짜 사이의 달의 차이
 SELECT MONTHS_BETWEEN(SYSDATE,emp.hiredate) 
   FROM emp;
   
 -- 2. ADD_MONTHS(day1, n) : 날짜1에 숫자 만큼 더한 후의 날짜를 구함
 SELECT ADD_MONTHS(sysdate, 3) FROM dual;
 
 -- 3. NEXT_DAY, LAST_DAY : 다음 요일에 해당하는 날짜를 구함, 이 달의 마지막 날짜
 SELECT NEXT_DAY(sysdate, '일요일') FROM dual;   -- 요일을 문자로 입력했을 때
 SELECT NEXT_DAY(sysdate, 1) FROM dual;         -- 요일을 숫자로 입력해도 작동
 SELECT LAST_DAY(sysdate) FROM dual;
 
 -- 4. ROUND, TRUNC : 날짜 관련 반올림, 버림
 SELECT ROUND(sysdate) FROM dual;
 SELECT TO_CHAR(ROUND(sysdate),'YY-MM-DD HH24:MI:SS') FROM dual;
 SELECT TRUNC(sysdate) FROM dual;
 SELECT TO_CHAR(TRUNC(sysdate),'YY-MM-DD HH24:MI:SS') FROM dual;
 
 -- 4) 데이터 타입 변환 함수
 /*
  TO_CHAR()     : 숫자, 날짜 ==> 문자
  TO_DATE()     : 날짜 형식의 문자 ==> 날짜
  TO_NUMBER()   : 숫자로만 구성된 문자데이터 ==> 숫자
 */
 -- 1. TO_CHAR() : 숫자패턴
 -- 숫자패턴 = 9 ==> 한자리 숫자
 SELECT TO_CHAR(12345,'9999') FROM dual;
 SELECT TO_CHAR(12345,'99999') FROM dual; 
 SELECT e.empno,
        TO_CHAR(e.sal)
   FROM emp e;
 --문자 데이터는 <<정렬
 --숫자 데이터는 >>정렬
 
 -- 숫자를 문자로 표현
 SELECT TO_CHAR(12345,'999999999') data
   FROM dual; 
 -- 앞에 빈칸 0 으로 패딩
 SELECT TO_CHAR(12345,'099999999') data 
   FROM dual;  
 -- 소수점 이하 표현
 SELECT TO_CHAR(12345,'999999.99') data
   FROM dual; 
 -- 숫자패턴에서 3자리씩 끊어 읽기 + 소수점 이하 표현
 SELECT TO_CHAR(12345,'9,999,999.99') data 
   FROM dual; 
 
 -- 2. TO_DATE() : 날짜패턴에 맞는 문자 값을 날짜 데이터로 변경
 SELECT TO_DATE('2018-06-27', 'YYYY-MM-DD') today
   FROM dual;
 -- 18/06/27        날짜로 인식 
 SELECT '2018-06-27' today FROM dual; 
 -- 2018-06-27      날짜로 인식 하지 않음
 SELECT TO_DATE('2018-06-27', 'YYYY-MM-DD') + 10 today
   FROM dual;
 -- 18/07/07
 SELECT '2018-06-27' + 10 today FROM dual; 
 -- ORA-01722: invalid number ==> 문자 + 숫자 의 연산 불가능
 
 -- 3. TO_NUMBER() : 오라클이 자동 형변환을 제공하므로 자주 사용은 안됨
 SELECT '1000' + 10 result FROM dual;
 -- 1010            
 SELECT TO_NUMBER('1000') + 10 result FROM dual;
 -- 1010
   
 -- 5) DECODE(expr,search,result [,search, result]...[,default])
 -- 만약 default 가 설정이 안되었고, expr 과 일치하는 search 가 없는 경우 NULL을 return
 -- 값이 YES 일 때
 SELECT DECODE('YES',
        'YES', '입력값이 YES 입니다.',  -- search, result set1
        'NO', '입력값이 NO 입니다.'     -- search, result set2
        ) as result  
   FROM dual;
 -- 값이 NO 일 때
 SELECT DECODE('NO',
        'YES', '입력값이 YES 입니다.',  -- search, result set1
        'NO', '입력값이 NO 입니다.'     -- search, result set2
        ) as result  
   FROM dual;
 -- 값이 예 일 때
 SELECT DECODE('예',
        'YES', '입력값이 YES 입니다.',  -- search, result set1
        'NO', '입력값이 NO 입니다.'     -- search, result set2
        ) as result  
   FROM dual;
 -- expr 과 일치하는 search 가 없고, default 설정도 안되었을 때, 
 -- 결과가 인출된 모든 행 : 0 이 아닌 NULL 이라는 것을 확인
 SELECT DECODE('예',
        'YES', '입력값이 YES 입니다.',  -- search, result set1
        'NO', '입력값이 NO 입니다.',     -- search, result set2
        '입력값이 YES/NO 중 어느 것도 아닙니다') as result  
   FROM dual;
 
 -- emp 테이블의 hiredate 의 입사년도를 추출하여 몇년 근무했는지를 계산
 -- 장기근속 여부 판단
 -- 1) 입사년도 추출 : 날짜 패턴
 SELECT e.empno,
        e.ename,
        TO_CHAR(e.hiredate,'YYYY') hireyear
   FROM emp e; 
 -- 2) 몇년근무 판단 : 오늘 시스템 날짜와 연산
 SELECT e.empno,
        e.ename,
        TO_CHAR(sysdate,'YYYY') - TO_CHAR(e.hiredate,'YYYY') "근무햇수"
   FROM emp e;
 -- 3) 37년 이상 된 직원을 장기 근속으로 판단
 SELECT a.empno,
        a.ename,
        a.warkingyear,
        DECODE(a.warkingyear,
               37,'장기 근속자 입니다.',
               38,'장기 근속자 입니다',
               '장기근속자가 아닙니다.') as "장기 근속 여부"
   FROM (SELECT e.empno,
                e.ename,
                TO_CHAR(sysdate,'YYYY') - TO_CHAR(e.hiredate,'YYYY') warkingyear
           FROM emp e) a;
   
 -- job별로 경조사비를 일정 비율로 지급하고 있다.
 -- 각 직원들의 경조사비 지원금을 구하자
 /*
    CLERK : 5%
    SALESMAN : 4%
    MANAGER : 3.7%
    ANALYST : 3%
    PRESIDENT : 1.5%
 */
  SELECT e.empno,
         e.ename,
         e.job,
         TO_CHAR(DECODE(e.job,
                        'CLERK', e.sal * 0.05,
                        'SALESMAN', e.sal * 0.04,
                        'MANAGER', e.sal * 0.037,
                        'ANALYST', e.sal * 0.03,
                        'PRESIDENT', e.sal * 0.015),'$999.99') " 경조사비 지원금"
   FROM emp e;
   /*
7369	SMITH	CLERK	      $40.00
7499	ALLEN	SALESMAN	  $64.00
7521	WARD	SALESMAN	  $50.00
7566	JONES	MANAGER	     $110.08
7654	MARTIN	SALESMAN	  $50.00
7698	BLAKE	MANAGER	     $105.45
7782	CLARK	MANAGER	      $90.65
7839	KING	PRESIDENT	  $75.00
7844	TURNER	SALESMAN	  $60.00
7900	JAMES	CLERK	      $47.50
7902	FORD	ANALYST	      $90.00
7934	MILLER	CLERK	      $65.00
9999	J	CLERK	          $25.00
8888	J_JUNE	CLERK	      $20.00
7777	J%JUNES	CLERK	      $15.00   
   */
   
   
 -- 15)
  SELECT e.empno 사원번호,
         e.ename 이름,
         e.sal 급여 ,
         TO_CHAR(DECODE(e.job,
                'CLERK', 300,
                'SALESMAN', 450,
                'MANAGER', 600,
                'ANALYST', 800,
                'PRESIDENT', 1000),'$9,999') "자기 계발비"
   FROM emp e;      
  /*
7369	SMITH	800	       $300
7499	ALLEN	1600	   $450
7521	WARD	1250	   $450
7566	JONES	2975	   $600
7654	MARTIN	1250	   $450
7698	BLAKE	2850	   $600
7782	CLARK	2450	   $600
7839	KING	5000	 $1,000
7844	TURNER	1500	   $450
7900	JAMES	950	       $300
7902	FORD	3000	   $800
7934	MILLER	1300	   $300
9999	J	500	   $300
8888	J_JUNE	400	   $300
7777	J%JUNES	300	   $300
  */