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

 
 
 
 
 
 
 
 
 -- 실습 1)
 SELECT INITCAP(emp.ename)
   FROM emp;
   /*
Smith
Allen
Ward
Jones
Martin
Blake
Clark
King
Turner
James
Ford
Miller
J
J_June
J%Junes
   */
 -- 실습 2)
 SELECT LOWER(emp.ename)
   FROM emp;
  /*
smith
allen
ward
jones
martin
blake
clark
king
turner
james
ford
miller
j
j_june
j%junes
  */
  -- 3)
  SELECT UPPER(emp.ename)
    FROM emp;
  /*
SMITH
ALLEN
WARD
JONES
MARTIN
BLAKE
CLARK
KING
TURNER
JAMES
FORD
MILLER
J
J_JUNE
J%JUNES
  */
 -- 4)
 SELECT LENGTH('KOREA')
   FROM dual;
   
 SELECT LENGTHB('KOREA')
   FROM dual;
 -- 5)
 SELECT LENGTH('LEEDONGHEE')
   FROM dual;
   
 SELECT LENGTHB('LEEDONGHEE')
   FROM dual;
 -- 6)
 SELECT concat('SQL','배우기')
   FROM dual;
 -- SQL배우기
 -- 7)
 SELECT substr('SQL 배우기',5,2)
   FROM dual;
 -- 배우
 -- 8)
 SELECT lpad('SQL',7, '$')
   FROM dual;
 -- $$$$SQL
 -- 9)
 SELECT rpad('SQL',7,'$')
   FROM dual;
 -- SQL$$$$ 
 -- 10)
 SELECT ltrim('       SQL배우기    ')
   FROM dual;
 -- 11)
 SELECT rtrim('       SQL배우기    ')
   FROM dual;
 -- 12)
 SELECT trim('       SQL배우기    ')
   FROM dual;
 -- 13) 커미션이 NULL 인 경우 0으로 출력
 SELECT nvl(e.comm,0)
   FROM emp e;
  /*
0
300
500
0
1400
0
0
0
0
0
0
0
0
0
0
  */
 -- 14) 커미션이 NULL 이면 0, 아니면 급여 + 커미션 출력  
 SELECT nvl2(e.comm,0,e.sal + nvl(e.comm,0))
   FROM emp e;
  /*
800
0
0
2975
0
2850
2450
5000
0
950
3000
1300
500
400
300
  */