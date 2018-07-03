 ----------
 -- PL/SQL 
 ----------
 -- IN, OUT 모드 변수를 사용하는 프로시저
 -- 문제) 한달 급여를 입력(IN 모드 변수) 하면 일년 급여를 계산해주는 프로시저를 작성
 -- 1) SP 이름 : sp_calc_year_sal
 -- 2) 변수 : IN => v_sal
 --        : OUT => v_sal_year
 -- 3) PROCEDURE 작성
 CREATE OR REPLACE PROCEDURE sp_calc_year_sal
 ( v_sal    IN NUMBER,
   v_sal_year OUT NUMBER)
 IS
 BEGIN
    v_sal_year := v_sal * 12;
 END sp_calc_year_sal;
 /
 
 -- 4) 컴파일 : SQL*PLUS CLi 라면 위 코드를 복사 붙여넣기
 --            Oracle SQL Developer 라면 Ctrl + Enter
 -- Procedure SP_CALC_YEAR_SAL이(가) 컴파일되었습니다.
 -- 5) OUT 모드 변수가 있는 프로시저이므로 BIND 변수가 필요
 -- VAR : 변수를 선언하는 SQL*PLUS 명령어
 -- DESC : SQL*PLUS 명령어
 VAR v_sal_year_bind NUMBER;
 -- 6) 프로시저 실행 : EXEC[UTE] : SQL*PLUS
 EXEC sp_calc_year_sal(1200000, :V_SAL_YEAR_BIND);
 -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
 -- 7) 실행 결과가 담긴 BIND 변수를 SQL*PLUS 에서 출력
 PRINT v_sal_year_bind;
 /*
 V_SAL_YEAR_BIND
 ---------------
        14400000
 */
 
 -- 실습 4번 hint
 /*
 SELECT 'myid' 의 가장 마지막 시간을 OUT 에 넣으면 됨
 MAX 라는 그룹함수 사용
 SELECT 시 TOCHAR화 해서 패턴화 시켜
 v_log_result VARCHAR2(300)
 */
 
 -- 실습 6번 과제 no 같이 
 -- 여러 형태의 변수를 사용하는 sp_variables 작성
 /*
    IN 모드 변수 : v_deptno, v_loc
    지역 변수    : v_hiredate, v_empno, v_msg
    상수        : v_max
 */
  -- 1) 프로시저 작성
  CREATE OR REPLACE PROCEDURE sp_variables
  ( v_deptno        IN NUMBER,
    v_loc           IN VARCHAR2)
  IS
   -- IS ~ BEGIN 사이는 지역변수 선언/초기화 하는 위치
   v_hiredate       VARCHAR2(30);
   v_empno          NUMBER := 1999;
   v_msg            VARCHAR2(500) DEFAULT 'Hello, PS/SQL';
   -- CONSTANT 는 상수를 만드는 설정
   v_max CONSTANT NUMBER := 5000;
  BEGIN
   -- 위에서 정의된 값들을 출력
   DBMS_OUTPUT.PUT_LINE('v_hiredate:' || v_hiredate);
   v_hiredate := TO_CHAR(sysdate,'YYYY-MM-DD HH24:MI:SS DY');
   DBMS_OUTPUT.PUT_LINE('v_hiredate:' || v_hiredate);
   DBMS_OUTPUT.PUT_LINE('v_deptno:' || v_deptno);
   DBMS_OUTPUT.PUT_LINE('v_loc:' || v_loc);
   DBMS_OUTPUT.PUT_LINE('v_empno:' || v_empno);
   v_msg := '내일 지구가 멸망하더라도 오늘 사과나무를 심겠다. by.스피노자';
   DBMS_OUTPUT.PUT_LINE('v_msg:' || v_msg);
   -- 상수인 v_max 에 할당시도
   -- v_max := 10000;
   DBMS_OUTPUT.PUT_LINE('v_max:' || v_max);
  END sp_variables;
  /
  -- 2) 컴파일 / 디버깅
  -- 3) VAR : BIND 변수가 필요하면 선언
  -- 4) EXEC : 실행
  SET SERVEROUTPUT ON;
  EXEC SP_VARIABLES('10','하와이');
  EXEC SP_VARIABLES('20','스페인');
  EXEC SP_VARIABLES('30','제주도');
  EXEC SP_VARIABLES('40','몰디브');
  -- 5) PRINT : BIND 변수에 값이 저장되었으면 출력
 /*
v_hiredate:
v_hiredate:2018-07-03 10:07:42 화
v_deptno:10
v_loc:하와이
v_empno:1999
v_msg:내일 지구가 멸망하더라도 오늘 사과나무를 심겠다. by.스피노자
v_max:5000


PL/SQL 프로시저가 성공적으로 완료되었습니다.
 */
 
 ----------------------------------------------------------
 -- PS/SQL 변수 : REFERNCES 변수의 사용
 -- 1) %TYPE 변수
 -- DEPT 테이블의 부서번호 입력(IN 모드)받아서 부서명을 출력(OUT 모드)하는 저장 프로시저 작성
 -- (1) SP 이름 : sp_get_dname
 -- (2) IN 변수 : v_deptno
 -- (3) OUT 변수 : v_dname
 
 -- 1. 프로시저 작성
 CREATE OR REPLACE PROCEDURE sp_get_dname
 ( v_deptno     IN  DEPT.DEPTNO%TYPE,
   v_dname      OUT dept.dname%TYPE )
 IS
 BEGIN
    SELECT d.dname
      INTO v_dname
      FROM dept d
     WHERE d.deptno = v_deptno;
 END sp_get_dname;
 /
 -- 2. 컴파일 / 디버깅
 
 -- 3. VAR : BIND 변수가 필요하면 선언
 VAR v_dname_bind VARCHAR2(30);
 -- 4. EXEC : 프로시저 실행
 EXEC sp_get_dname(10, :v_dname_bind);
 EXEC sp_get_dname(20, :v_dname_bind);
 
 EXEC sp_get_dname(50, :v_dname_bind);
 -- ORA-01403: no data found

 -- 5. PRINT : BIND 변수가 있으면 출력
 PRINT v_dname_bind;
 
 -- 2) %ROWTYPE 변수
 -- 특정 테이블의 한 행(row)를 컬럼의 순서대로 타입, 크기를 그대로 매핑한 변수
 -- DEPT 테이블의 부서번호 입력(IN 모드)받아서 부서 전체 정보를 화면 출력 하는 저장 프로시저 작성
 -- (1) sp_get_dinfo
 -- (2) IN 변수 : v_deptno
 --     지역 변수 : v_dinfo
 -- 1. 프로시저 작성
  CREATE OR REPLACE PROCEDURE sp_get_dinfo
 ( v_deptno     IN  DEPT.DEPTNO%TYPE )
 IS
 -- v_dinfo 변수는 dept 테이블의 한 행의 정보를 한번에 담는 변수
  v_dinfo       dept%ROWTYPE;
 BEGIN
    -- IN 모드로 입력된 v_deptno 에 해당한느 부서정보
    -- 1행을 조회하여 dept 테이블의 ROWTYPE 변수인 v_dinfo 에 저장
    SELECT d.deptno,
           d.DNAME,
           d.loc
      INTO v_dinfo -- INTO 절에 명시되는 변수에는 1행만 저장 가능
      FROM dept d
     WHERE d.deptno = v_deptno;
     
     -- 조회된 결과를 화면출력
      DBMS_OUTPUT.PUT_LINE('부서번호:' || v_dinfo.deptno);
      DBMS_OUTPUT.PUT_LINE('부서이름:' || v_dinfo.dname);
      DBMS_OUTPUT.PUT_LINE('부서위치:' || v_dinfo.loc);
 END sp_get_dinfo;
 /
 

 -- 2. 컴파일 / 디버깅
 -- 3. VAR : BIND 변수 필요시 선언
 -- 4. EXEC : SP 실행
 EXEC sp_get_dinfo(10);
 EXEC sp_get_dinfo(20);
 -- 5. PRINT : BIND 변수가 있을 때
 
 ---------------------------------------------------------------------
 -- 수업 중 실습
 -- 문제) 한 사람의 사번을 입력받으면 그 사람의 소속 부서명, 부서 위치를 함께 화면 출력
 SELECT e.ename,
        d.dname,
        d.loc
   INTO ?     
   FROM emp e,
        dept d
  WHERE e.deptno = d.deptno
    AND e.empno = 7654;
    
 -- (1) SP 이름 : sp_get_emp_info
 -- (2) IN 변수 : v_empno
 -- (3) %TYPE, %ROWTYPE 변수 활용
 CREATE OR REPLACE PROCEDURE sp_get_emp_info
 ( v_empno      IN EMP.EMPNO%TYPE)
 IS
  v_ename       VARCHAR2(30);
  v_dname       VARCHAR2(30);
  v_loc         VARCHAR2(30);
 BEGIN
    SELECT e.ename,
           d.dname,
           d.loc
      INTO v_ename,
           v_dname,
           v_loc
      FROM emp e,
           dept d
     WHERE e.deptno = d.deptno
       AND e.empno = v.empno;
       
      DBMS_OUTPUT.PUT_LINE('이름:' || v_ename);
      DBMS_OUTPUT.PUT_LINE('부서이름:' || v_dname);
      DBMS_OUTPUT.PUT_LINE('부서위치:' || v_loc);
 END sp_get_emp_info;
 /
 
 EXEC sp_get_emp_info(7499);
 -- (1) SP 이름 : sp_get_emp_info_ins
 -- (2) IN 변수 : v_empno
 -- (3) %TYPE, %ROWTYPE 변수 활용
 -- 1. 프로시저 작성
 CREATE OR REPLACE PROCEDURE sp_get_emp_info_ins
 ( v_empno      IN emp.empno%TYPE)
 IS
 -- emp 테이블의 한 행을 받을 ROWTYPE
 v_emp emp%ROWTYPE;
 -- dept 테이블의 한 행을 받을 ROWTYPE
 v_dept dept%ROWTYPE;
 BEGIN
  -- SP 의 좋은 점은 여러개의 쿼리를 순차적으로 실행 가능
  -- 변수를 활용할 수 있기 때문에
    -- 1.IN 변수로 들어오는 한 직원의 정보를 조회
    SELECT e.*
      INTO v_emp
      FROM emp e
     WHERE e.empno = v_empno;
    -- 2. 1의 결과에서 직원의 부서를 번호를 얻을 수 있으므로 부서 정보 조회
    SELECT d.*
      INTO v_dept
      FROM dept d
     WHERE d.deptno = v_emp.deptno;
    -- 3. v_emp,v_dept 에서 필요한 필드만 화면 출력
  DBMS_OUTPUT.PUT_LINE('직원 이름 : ' || v_emp.ename);
  DBMS_OUTPUT.PUT_LINE('소속 부서 : ' || v_dept.dname);
  DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_dept.loc);
 END sp_get_emp_info_ins;
 /
 -- 2. 컴파일 / 디버깅
 -- 3. 실행 EXEC
 EXEC sp_get_emp_info_ins(7654);
 
 ---------------------------------------------------------
 -- PL/SQL 변수 : RECODE TYPE 변수의 사용
 ---------------------------------------------------------
 -- RECODE TYPE : 한 개 혹은 그 이상 테이블에서 원하는 컬럼만 추출하여 구성
 -- 문제) 사번을 입력 받아서 그 직원의 사번, 이름, 매니저 이름, 부서이름, 부서위치, 급여등급 함께 출력
 -- (1) SP 이름 : sp_get_emp_info_detail
 -- (2) IN 변수 : v_empno
 -- (3) RECORD 변수 : v_emp_record
 -- 1. 프로시저 작성
 CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
 ( v_empno      IN  emp.empno%TYPE)
 IS
  -- 1. RECODE 타입 선언
  TYPE emp_record_type IS RECORD 
  ( r_empno     emp.empno%TYPE,
    r_ename     emp.ename%TYPE,
    r_mgrname   emp.ename%TYPE,
    r_dname     dept.dname%TYPE,
    r_loc       dept.loc%TYPE,
    r_salgrade  SALGRADE.GRADE%TYPE);
  -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record  emp_record_type;
 BEGIN
  -- 3. 1에서 선언한 record 타입은 조인의 결과를 받을 수 있음
  SELECT e.empno,
         e.ename,
         e1.ename,
         d.DNAME,
         d.LOC,
         s.GRADE
    INTO v_emp_record
    FROM emp e, 
         emp e1,
         dept d, 
         salgrade s
   WHERE e.mgr = e1.empno 
     AND e.deptno = d.deptno
     AND e.sal BETWEEN s.losal AND s.hisal
     AND e.empno = v_empno;     
     -- 4. v_emp_record 에 들어온 값들 화면 출력
     DBMS_OUTPUT.put_line('사 번 : ' || v_emp_record.r_empno);
     DBMS_OUTPUT.put_line('이 름 : ' || v_emp_record.r_ename);
     DBMS_OUTPUT.put_line('매니저 : ' || v_emp_record.r_mgrname);
     DBMS_OUTPUT.put_line('부서명 : ' || v_emp_record.r_dname);
     DBMS_OUTPUT.put_line('부서 위치 : ' || v_emp_record.r_loc);
     DBMS_OUTPUT.put_line('급여 등급 : ' || v_emp_record.r_salgrade);
 END sp_get_emp_info_detail;
 /
 
 -- 2. 컴파일 / 디버깅
 -- Procedure SP_GET_EMP_INFO_DETAIL이(가) 컴파일되었습니다.
 -- 3. 실행
 EXEC sp_get_emp_info_detail(7654);
 /*
사 번 : 7654
이 름 : MARTIN
매니저 : BLAKE
부서명 : SALES
부서 위치 : CHICAGO
급여 등급 : 2


PL/SQL 프로시저가 성공적으로 완료되었습니다.
 */
 EXEC sp_get_emp_info_detail(7839);
 -- mgr 이 없어서 에러
 EXEC sp_get_emp_info_detail(7902);
 
 ----------------------------------------------------------------
 -- 포로시저는 다른 프로시저에서 호출 가능
 -- ANONYMOUS PROCEDURE 를 사용하여 지금 정의한 
 -- sp_get_emp_info_detail 실행
 DECLARE
    v_empno     emp.empno%TYPE;
 BEGIN
    SELECT e.empno
      INTO v_empno
      FROM emp e
     WHERE e.empno = 7902 ;
     
     sp_get_emp_info_detail(v_empno);
 END;
 /
 /*
사 번 : 7902
이 름 : FORD
매니저 : JONES
부서명 : RESEARCH
부서 위치 : DALLAS
급여 등급 : 4


PL/SQL 프로시저가 성공적으로 완료되었습니다. 
 */