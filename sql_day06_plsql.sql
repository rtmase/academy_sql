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
   WHERE e.mgr = e1.empno(+) -- mgr 배정 안된 직원
     AND e.deptno = d.deptno(+) -- dept 배정 안된 직원
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
 EXEC sp_get_emp_info_detail(6666);
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
 ----------------------------------------------------
 -- PL/SQL 변수 : 아규먼트 변수 IN OUT 모드의 사용
 ----------------------------------------------------
 -- IN : SP로 값이 전달될 때 사용, 입력용
 --      프로시저를 사용하는 쪽(SQL*PLUS)에서 프로시저로 전달
 ----------------------------------------------------
 -- OUT : SP에서 수행 결과 값이 저장되는 용도, 
 --       출력용 프로시저는 리턴(반환)이 없기 떄문에 SP를 호출한 쪽에 돌려주는 방벙으로 사용
 ----------------------------------------------------
 -- IN OUT : 하나의 매개 변수에 입력, 출력을 함께 사용
 ----------------------------------------------------
 -- 문제) 기본 숫자값을 입력 받아서 숫자 포맷화 '$9,999.00'
 --      출력하는 프로시저를 작성 IN OUT 모드 변수를 활용
 -- (1) SP 이름 : sp_chng_number_format
 -- (2) IN OUT 변수 : v_number;
 -- (3) BIND 변수 : v_number_bind;
 -- 1. 프로시저 작성
 CREATE OR REPLACE PROCEDURE sp_chng_number_format
 ( v_number IN OUT VARCHAR2 )
 IS
 BEGIN
 -- 1. 입력된 초기 상태의 값 출력
 DBMS_OUTPUT.PUT_LINE('초기 입력 값' || v_number);
 
 -- 2. 숫자 패턴화 변경
 v_number := TO_CHAR(TO_NUMBER(v_number),'$9,999.99');
 
 -- 3. 화면 출력으로 변경된 패턴 확인
 DBMS_OUTPUT.PUT_LINE('패턴 적용 값' || v_number);
 
 END sp_chng_number_format;
 /
 -- 2. 컴파일 / 디버깅
 -- Procedure SP_CHNG_NUMBER_FORMAT이(가) 컴파일되었습니다.
 -- 3. VAR : BIND 변수 선언
 -- IN OUT 으로 사용될 변수
 VAR v_number_bind  VARCHAR2(20);
 -- 4. EXEC : 실행
 -- 4.1 BIND 변수에 1000을 먼저 저장
 EXEC :v_number_bind := 1000;
 -- 4.2 1000이 저장된 BIND 변수를 프로시저에 전달
 EXEC sp_chng_number_format(:v_number_bind);
 /*
 초기 입력 값1000
패턴 적용 값 $1,000.00
 */
 -- 5. PRINT : BIND 변수 출력
 PRINT v_number_bind;
 /*
 V_NUMBER_BIND
--------------------------------------------------------------------------------
 $1,000.00
 */
  
 -- 실습 8번 할때 sp : sp_chng_date_format // IN OUT v_date로 해서 작성
 
 -------------------------------------------------------------------------------
 -- 위의 문제를 다른 방법으로 풀이 : SELECT ~ INTO 절을 사용
 CREATE OR REPLACE PROCEDURE sp_chng_number_format
 ( in_number IN NUMBER,
   out_number OUT VARCHAR2)
 IS
 BEGIN 
 -- in_number 로 입력된 값을 INTO 절을 사용하여 out_number 변수로 입력
  SELECT TO_CHAR(in_number,'$9,999.99')
    INTO out_number
    FROM dual;
 END sp_chng_number_format;
 /
 
 VAR v_out_number_bind VARCHAR2(20);
 
 EXEC sp_chng_number_format(1000,:v_out_number_bind);
 
 PRINT v_out_number_bind;
 
 -------------------------------------------------------------------------------
 -- 매개 변수 전달법 : SP 에서는 위치, 변수명에 의한 전달 방식이 있다.
 -------------------------------------------------------------------------------
 -- 1. 위치에 의한 전달 법
 EXEC sp_chng_number_format(1000,:v_out_number_bind);
 -- 2. 변수명에 의한 전달
 EXEC sp_chng_number_format(in_number =>1000, out_number =>:v_out_number_bind);
 EXEC sp_chng_number_format(out_number =>:v_out_number_bind, in_number =>1000);                           
 
 
 
 -------------------------------------------------------------------------------
 -- PL/SQL 제어문
 -------------------------------------------------------------------------------
 -- 1. IF 제어문
 -- IF ~ THEN ~ [ELSIF ~ THEN] ~ ELSE ~ END IF;
 
 -- job 별로 경조사비를 급여대비 일정 비율로 지급하고 있다.
 -- 각 직원들의 경조사비 지원금을 구하는 프로시저 작성
 /*
    CLERK       :5%
    SALESMAN    :4%
    MANAGE      :3.7%
    ANALYST     :3%
    PRESIDENT   :1.5%
 */
 -- (1) SP 이름 : sp_get_tribute_fee
 -- (2) IN 변수 : v_empno (사번)
 -- (3) OUT 변수 : v_tribute_fee (급여타입)
 -- 1. 프로시저 작성
 CREATE OR REPLACE PROCEDURE sp_get_tribute_fee
 ( v_empno          IN emp.empno%TYPE,
   v_tribute_fee    OUT emp.sal%TYPE)
 IS
  -- 1. 사번인 직원의 직무를 저장할 지역변수 선언
  v_job    emp.job%TYPE;
  -- 2. 사번인 직원의 급여를 저장할 지역변수 선언
  v_sal    emp.sal%TYPE;
 BEGIN
  -- 3. 입력된 사번 직원의 직무,급여를 조회하여 v_job, v_sal 에 저장

  SELECT e.job,
         e.sal
    INTO v_job,
         v_sal
    FROM emp e
   WHERE e.empno = v_empno; 
  -- 4. 일정 비율로 v_tribute_fee 계산  
  IF v_job = 'CLERK' THEN v_tribute_fee := v_sal * 0.05;
  ELSIF v_job = 'SALESMAN' THEN v_tribute_fee := v_sal * 0.04;
  ELSIF v_job = 'MANAGER' THEN v_tribute_fee := v_sal * 0.03;
  ELSIF v_job = 'ANALYST' THEN v_tribute_Fee := v_sal * 0.037;
  ELSIF v_job = 'PRESIDENT' THEN v_tribute_Fee := v_sal * 0.015;
  END IF;
 END sp_get_tribute_fee;
 /
 -- 2. 컴파일 / 디버깅 
 -- Procedure SP_GET_TRIBUTE_FEE이(가) 컴파일되었습니다.
 -- 3. VAR v_tribute_fee_bind
 VAR v_tribute_fee_bind NUMBER;
 
 EXEC sp_get_tribute_fee(v_tribute_fee => :v_tribute_fee_bind, v_empno => 7566)
 
 PRINT v_tribute_fee_bind;
 /*
V_TRIBUTE_FEE_BIND
------------------
             89.25 
 */
 
 -- 2. LOOP 기본 반복문
 -- ANONYMOUS PROCEDURE 로 실행 예
 -- 문제) 1~ 10 까지의 합을 출력
 DECLARE
  -- 1.
  v_init NUMBER := 0;
  -- 2. 합산을 저장할 변수 선언 / 초기화
  v_sum  NUMBER := 0;
 BEGIN
  LOOP
    v_init := v_init + 1;
    v_sum := v_sum + v_init;
    DBMS_OUTPUT.put_line('v_sum :' || v_sum);
    -- 반복문 종료 조건
    EXIT WHEN v_init = 10;
  END LOOP;
  -- 합산 변수 출력
  DBMS_OUTPUT.put_line('1~ 10 합산 결과 :' || v_sum);
 END;
 /
 -- 2. LOOP : FOR LOOP 카운터 변수를 사용하는 반복문
 -- 지정된 횟수만큼 실행 반복문
 -- 문제) 1~ 20 사이의 3의 배수를 출력 : ANONYMOUS PROCEDURE
 DECLARE
    -- 1. FOR LOOP 에서 사용할 카운터 변수 선언 / 초기화
    cnt     NUMBER := 0;
 BEGIN
    -- 2. LOOP 작성
    FOR cnt IN 1 .. 20 LOOP
        -- 3. 3의 배수 판단
        IF(MOD(cnt,3)=0) 
        THEN DBMS_OUTPUT.PUT_LINE(cnt);
        END IF;
    END LOOP;
 END;
 /
 -- 2. LOOP : WHILE LOOP 조건에 따라 수행되는 반복문
 -- 문제) 1~ 20 사이의 수 중에서 2의 배수를 화면 출력 : ANONYMOUS PROCEDURE
 DECLARE
    -- 반복 조건으로 사용할 횟수 변수 선언
    cnt     NUMBER := 0;
 BEGIN
    -- WHILE 반복문 작성
    WHILE cnt < 20 LOOP
        cnt := cnt + 2;
        DBMS_OUTPUT.put_line(cnt);
        
    END LOOP;
 END;
 /
 ----------------------------------------------------------------------
 -- PL/SQL : Stored Function (저장 함수)
 ----------------------------------------------------------------------
 -- 대부분 SP랑 유사
 -- IS 블록 전에 RETURN 구문이 존재
 -- RETURN 구문에는 문장 종료 기호 (;) 없음
 -- 실행은 기존 사용하는 함수와 동일하게 SELECT, WHERE 절에 사용함.
 -- 문제) 부서번호를 입력받아서 해당 부서의 급여 평균을 구하는 함수 작성
 -- (1) FN 이름 : fn_avg_sal_by_dept
 -- (2) IN 변수 : v_deptno 부서번호타입
 -- (3) 지역변수 : v_avg_sal 급여타입   계산된 평균 급여를 저장
 -- 1. 함수작성
 CREATE OR REPLACE FUNCTION fn_avg_sal_by_dept
    ( v_deptno     IN  emp.DEPTNO%TYPE)
 RETURN NUMBER   
 IS
    -- 부서별 급여 평균을 저장할 지역변수 선언
    v_avg_sal     emp.sal%TYPE;
 BEGIN
    -- 부서 별 급여 평균을 AVG() 함수를 사용하여 구하고 저장
    SELECT AVG(e.sal)
      INTO v_avg_sal
      FROM emp e
     WHERE e.deptno = v_deptno;
     
    -- 계산 결과를 반올림하여 리턴
    RETURN ROUND(v_avg_sal);
 END fn_avg_sal_by_dept;
 /
 -- 2. 컴파일/ 디버깅
 -- Function FN_AVG_SAL_BY_DEPT이(가) 컴파일되었습니다.
 -- 3. 이 함수를 사용하는 쿼리를 작성하여 실행해 본다.
 -- 10번 부서의 급여 평균을 알고 싶다.
 SELECT fn_avg_sal_by_dept(10) as 부서급여평균
   FROM dual;
 SELECT AVG(sal)
   FROM emp 
  WHERE deptno = 10; 
  
 -- 30번 부서의 급여 평균보다 높은 급여 평균을 받는 부서는?
 SELECT e.DEPTNO,
        AVG(e.sal)
   FROM emp e
  GROUP BY e.deptno
  HAVING AVG(e.sal) > fn_avg_sal_by_dept(30);
 
 
 -- SP/ FN 에서 예외처리
 -- 예외처리 : 오라클에서 프로시저 실행 중 발생할 수 있는 
 --           이미 잘 알려진 상황에 대한 사전 정의 예외목록을 제공
 
 
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
     -- 5. NO_DATA_FOUND 예외처리
     EXCEPTION 
          WHEN NO_DATA_FOUND     
          THEN DBMS_OUTPUT.PUT_LINE('해당 직원의 매니저 혹은 부서가 배정되지 않았습니다.');
          
 END sp_get_emp_info_detail;
 /
  EXEC sp_get_emp_info_detail(7839);
  EXEC sp_get_emp_info_detail(6666); 
  -- 해당 직원의 매니저 혹은 부서가 배정되지 않았습니다.
  
  -- 2. DUP_VAL_ON_INDEX
  -- 문제) member 테이블에 member_id, member_name 을 입력받아서 신규로
  -- 1행을 추가하는 sp_insert_member 작성
  -- 1. 프로시저 작성
  CREATE OR REPLACE PROCEDURE sp_insert_member
  ( v_member_id     IN MEMBER.MEMBER_ID%TYPE,
    v_member_name   IN member.member_name%TYPE)
  IS
  BEGIN
    -- 입력된 IN 모드 변수 값을 INSERT 시도
    INSERT INTO member( member_id, member_name)
    VALUES (v_member_id, v_member_name);
    COMMIT;
    DBMS_OUTPUT.put_line(v_member_id||' 신규 추가 진행' );
    -- 입력시도에는 항상 DUP_VAL_ON_INDEX 예외 위험 존재
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN -- 이미 존재하는 키의 값이면 신규 추가가 아니라 수정으로 진행
             UPDATE member m
                SET m.member_name = v_member_name
              WHERE m.member_id = v_member_id;  
             -- 처리 내용을 화면 출력
             DBMS_OUTPUT.put_line(v_member_id||'가 이미 존재 하므로 멤버 정보 수정 진행' );
             /*
             when no_data_found
             then .....
             */
  END sp_insert_member;
  /
  
  EXEC sp_insert_member('M13','유재성');
  EXEC sp_insert_member('M14','채한나');