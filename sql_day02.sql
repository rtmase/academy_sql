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
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  