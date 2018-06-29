 -- JOIN 계속...
 -- EQUI JOIN 구문 구조
 
 -- 1. 오라클 전용 조인 구조
 SELECT [별칭1.]컬럼명1,[별칭2.]컬럼명2 [,...]
   FROM 테이블 1 별칭1, 테이블2 별칭2 [,....]
  WHERE 별칭1.공통컬럼1 = 별칭2.공통컬럼1       -- 조인 조건을 WHERE 에 작성
   [AND 별칭1.공통컬럼2 = 별칭n.공통컬럼2]      -- FROM 에 나열된 테이블이 2개가 넘을 때
   [AND ... 추가 가능한 일반 조건들 등장];
 ----------------------------------------------------------------
 
 -- 2. NATURAL JOIN 을 사용하는 구조
 SELECT [별칭1.]컬럼명1,[별칭2.]컬럼명2 [,...]
   FROM 테이블1 별칭1 NATURAL JOIN 테이블2 별칭2
                    [NATURAL JOIN 테이블n 별칭n];
 ----------------------------------------------------------------
 
 -- 3. JOIN ~ USING 을 사용하는 구조 : 공통컬럼 이름이 동일해야 함
 SELECT [별칭1.]컬럼명1,[별칭2.]컬럼명2 [,...]
   FROM 테이블1 별칭1 JOIN 테이블2 별칭2 USING (공통컬럼);     -- 공통컬럼에 별칭 사용하지 않음
 ----------------------------------------------------------------
 
 -- 4. JOIN ~ ON 을 사용하는 구조 : 표준 SQL 구문
 SELECT [별칭1.]컬럼명1,[별칭2.]컬럼명2 [,...]
   FROM 테이블1 별칭1 JOIN 테이블2 별칭2 ON (별칭1.공통컬럼1 = 별칭2.공통컬럼1)
                    [JOIN 테이블n 별칭n ON (별칭1.공통컬럼n = 별칭n.공통컬럼n)];
 ----------------------------------------------------------------                    
 
 -- 4) NON-EQUI JOIN : WHERE 조건절에 join attribute 사용하는 대신
 --                    다른 비교 연산자를 사용하여 여러 테이블을 엮는 기법
 
 -- 문제) emp, salgrade 테이블을 사용하는 직원의 급여에 따른 등급을 함께 조회
 --      emp 테이블에는 salgrade 테이블과 연결할 수있는 동일한 값이 없음
 SELECT e.empno,
        e.ename,
        e.sal,
        s.grade
   FROM emp e, salgrade s 
  WHERE e.sal BETWEEN s.losal AND s.hisal;
 
 -- 5) OUTER JOIN : 조인 대상 테이블 중 공통 컬럼에 NULL 값인 데이터의 경우도 출력을 원할 때
 -- 연산자 : (+), LEFT OUTER JOIN, RIGTH OUTER JOIN
 -- 1. (+) : 오라클이 사용하는 전통적인 OUTER JOIN 연산자
 --          왼쪽,오른쪽 어느쪽에나 NULL 값을 출력하기 원하는 쪽에 붙여서 사용
 -- 2. (+) 연산자 사용시 JOIN 구문 구조
 SELECT .....
   FROM 테이블1 별칭1,테이블2 별칭2
  WHERE 별칭1.공통컬럼(+) = 별칭2.공통컬럼      -- RIGHT OUTER JOIN, 왼쪽 테이블의 NULL 데이터 출력
 [WHERE 별칭1.공통컬럼 = 별칭2.공통컬럼(+)];    -- LEFT OUTER JOIN, 오른쪽 테이블의 NULL 데이터 출력
 
 -- RIGHT OUTER JOIN ~ ON 구문 구조
 SELECT .....
   FROM 테이블1 별칭1 RIGHT OUTER JOIN 테이블2 별칭2 
     ON 별칭1.공통컬럼 = 별칭2.공통컬럼;
 
 -- LEFT OUTER JOIN ~ ON 구문 구조
 SELECT .....
   FROM 테이블1 별칭1 LEFT OUTER JOIN 테이블2 별칭2 
     ON 별칭1.공통컬럼 = 별칭2.공통컬럼;
 -----------------------------------------------------------------
 -- 문제) 직원 중에 부서가 배치되지 않은 사람이 있을 때
 -- 1. 일반 조인(EQUI-JOIN)을 걸면 조회가 되지 않는다.
 SELECT e.empno,
        e.ename,
        e.deptno,
        d.dname
   FROM emp e,
        dept d
  WHERE e.deptno = d.deptno; 
 -- 2. OUTER JOIN 이용
 SELECT e.empno,
        e.ename,
        e.deptno,
        d.dname
   FROM emp e,
        dept d
  WHERE e.deptno = d.deptno(+); 
 -- (+) 연산자는 오른쪽에 붙이고 이는 NULL 상태로 출력될 테이블을 결정
 -- 전체 데이터를 기준삼는 테이블이 왼쪽이기 때문에 LEFT OUTER JOIN 발생
 -----------------------------------------------------------------
 -- LEFT OUTER JOIN ~ ON 으로
 SELECT e.empno,
        e.ename,
        e.deptno,
        d.dname
   FROM emp e LEFT OUTER JOIN dept d -- 왼쪽데이터를 다 출력하고, 오른쪽에 부족한부분 추가해서 출력
     ON e.deptno = d.deptno; 
 
 -- 문제) 아직 아무도 배치되지 않은 부서가 있어도 부서를 다 조회하고 싶다
 -- 1.(+) 연산자로 해결
 SELECT e.empno,
        e.ename,
        e.deptno,
        '|',
        d.deptno,
        d.dname
   FROM emp e,
        dept d
  WHERE e.deptno(+) = d.deptno;
  
 -- 2. RIGHT OUTER JOIN ~ ON 으로 해결
 SELECT e.empno,
        e.ename,
        e.deptno,
        '|',
        d.deptno,
        d.dname
   FROM emp e RIGHT OUTER JOIN dept d
     ON e.deptno = d.deptno;
 
 -- 문제) 부서배치가 안된 직원도 보고 싶고 직원이 없는 부서도 모두 보고 싶을 때
 --      즉, 양쪽 모두에 존재하는 NULL 값을 모두 한번에 조회하려면 어떻게 해야 하는가?
 SELECT e.empno,
        e.ename,
        e.deptno,
        '|',
        d.deptno,
        d.dname
   FROM emp e RIGHT OUTER JOIN dept d
     ON e.deptno = d.deptno;

 -- ORA-01468: a predicate may reference only one outer-joined table
 -- (+) 연산자로는 양쪽 아우터 조인 불가능
 
 -- 2. FULL OUTER JOIN ~ ON 구문
 SELECT e.empno,
        e.ename,
        d.dname
   FROM emp e FULL OUTER JOIN dept d
     ON e.deptno = d.deptno;
 
 -- 6) SELF JOIN : 한 테이블 내에서 자기 자신의 컬럼 끼리 연결하여 새 행을 만드는 기법
 -- 문제) emp 테이블에서 mgr 에 해당하느 상사의 이름을 같이 조회하려면
 SELECT e1.empno       "직원 사번",
        e1.ename       "직원 이름",
        e1.mgr         "상사 사번",
        e2.ename       "상사 이름"
   FROM emp e1,
        emp e2
  WHERE e1.mgr = e2.empno;      
 -- 상사가 없는 직원도 조회하고 싶다
 -- a) e1 테이블이 기준 => LEFT OUTER JOIN
 -- b) (+) 기호를 오른쪽에 붙힌다.
 SELECT e1.empno       "직원 사번",
        e1.ename       "직원 이름",
        e1.mgr         "상사 사번",
        e2.ename       "상사 이름"
   FROM emp e1,
        emp e2
  WHERE e1.mgr = e2.empno(+);      
 ----------------------------------
 SELECT e1.empno       "직원 사번",
        e1.ename       "직원 이름",
        e1.mgr         "상사 사번",
        e2.ename       "상사 이름"
   FROM emp e1 LEFT OUTER JOIN emp e2
     ON e1.mgr = e2.empno;      
 
 -- 부하직원이 없는 직원
 SELECT e1.empno       "직원 사번",
        e1.ename       "직원 이름",
        e1.mgr         "상사 사번",
        e2.ename       "상사 이름"
   FROM emp e1 RIGHT OUTER JOIN emp e2
     ON e1.mgr = e2.empno;      
 
 -- 7. 조인과 서브쿼리
 -- (2) 서브쿼리 : SUB-QUERY
 --               SELECT, FROM, WHERE 절에 사용할 수 있다.
 
 -- 문제) BLAKE와 직무가 동일한 직원의 정보를 조회
 -- 1.BLAKE 의 직무를 조회
 SELECT e.job
   FROM emp e
  WHERE e.ename = 'BLAKE';
 
 -- 2. 1의 결과를 WHERE 조건 절에 사용하는 메인 쿼리 작성
 SELECT e.empno,
        e.ename,
        e.job
   FROM emp e
  WHERE e.job = (SELECT e.job
                   FROM emp e
                  WHERE e.ename = 'BLAKE'); 
 -- ==> 메인 쿼리의 WHERE 절에 () 안에 전달되는 값이 1의 결과인 'MANAGER' 라는 값이다.
 
 ----------------------------------------------------
 -- 수업중 실습 (서브 쿼리)
 -- 1. 이 회사의 평균 급여보다 급여가 큰 직원들의 목록을 조회
 SELECT AVG(e.sal)
   FROM emp e;
 
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal > (SELECT AVG(e.sal)
                   FROM emp e);
 ----------------------------------------------------
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal > (SELECT AVG(e.sal)
                   FROM emp e);
 
 -- 2. 급여가 평균 급여보다 크면서 사번이 7700 번보다 높은 직원 조회
 SELECT AVG(e.sal)
   FROM emp e;
 
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal > (SELECT AVG(e.sal)
                   FROM emp e) 
    AND e.empno > 7700;
 ----------------------------------------------------
 -- a) AND 조건으로 처리
 SELECT AVG(e.sal)
   FROM emp e;
 
 SELECT e.empno,
        e.ename,
        e.sal
   FROM emp e
  WHERE e.sal > (SELECT AVG(e.sal)
                   FROM emp e) 
    AND e.empno > 7700;
 -- b) sub-query 로 해결   
 SELECT a.*
   FROM (SELECT e.empno,
                e.ename,
                e.sal
           FROM emp e
          WHERE e.sal > (SELECT AVG(e.sal)
                           FROM emp e)) a
  WHERE a.empno > 7700;
 -- 이중 서브 쿼리
 
 -- 3. 각 직무별로 최대 급여를 받는 직원 목록을 조회
 SELECT e.job,
        MAX(e.sal)
   FROM emp e
  GROUP BY e.job; 
  
  SELECT e.empno,
         e.ename,
         e.job,
         e.sal
    FROM emp e,
         (SELECT e.job as job,
                 MAX(e.sal) as max_sal
                 FROM emp e
                 GROUP BY e.job ) jm
   WHERE e.job = jm.job AND e.sal = jm.max_sal;
 ----------------------------------------------------
 -- a) 직무별 최대 급여
 SELECT e.job,
        MAX(e.sal)
   FROM emp e
  GROUP BY e.job; 
 -- b) a를 사용할 메인 쿼리
 --    최대 급여가 자신의 급여와 같은지, 그 때의 직무가 나의 직무와 같은지 비교
 SELECT e.empno,
        e.ename,
        e.job,
        e.sal
   FROM emp e
  WHERE e.sal = (SELECT e.job,      -- ==> ORA-00913: too many values
                        MAX(e.sal)
                   FROM emp e
                  GROUP BY e.job ); 
 -- WHERE 절에서 비교는 e.sal 은 컬럼1행
 -- 그런데 서브쿼리에서 들어오는 값은 컬럼이 6행, 비교 자체가 불가능
 SELECT e.empno,
        e.ename,
        e.job,
        e.sal
   FROM emp e
  WHERE e.sal = (SELECT MAX(e.sal)
                   FROM emp e
                  GROUP BY e.job );
 -- ORA-01427: single-row subquery returns more than one row
 
 -- > IN 연산자를 사용하여 해결
 SELECT e.empno,
        e.ename,
        e.job,
        e.sal
   FROM emp e
  WHERE (e.job,e.sal) IN((SELECT e.job,
                                 MAX(e.sal)
                            FROM emp e
                           GROUP BY e.job ));
 
 -- 4. 각 월별 입사인원을 세로로 출력
 -- a) 입사일 데이터로 월을 추출
 SELECT TO_CHAR(e.hiredate, 'FMMM')
   FROM emp e;
 -- b) 입사 월별 인원 => 그룹화 기준 월
 --    인원을 구하는 함수는 COUNT(*)
 SELECT TO_CHAR(e.hiredate, 'FMMM'),
        COUNT(*)
   FROM emp e
  GROUP BY TO_CHAR(e.hiredate, 'FMMM');
 -- c) 입사 월 순으로 정렬
 SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) || '월'  "입사월",
        COUNT(*) "인원"
   FROM emp e
  GROUP BY TO_CHAR(e.hiredate, 'FMMM')
  ORDER BY "입사월";
 -- ==> '월'을 붙이면 다시 문자화 되어 정렬이 망가짐
 
 -- 서브쿼리로 정렬시도
 SELECT a."입사월"||'월' as "입사월",
        a."인원"
   FROM ( SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "입사월",
           COUNT(*) "인원"
            FROM emp e
           GROUP BY TO_CHAR(e.hiredate, 'FMMM')
           ORDER BY "입사월") a;
 
 
 
 
 
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 