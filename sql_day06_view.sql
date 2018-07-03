 --sql_day06_view
 
 -- VIEW : 논리적으로만 존재하는 가상 테이블
 -- 1.SCOTT 계정에 VIEW 생성 권한 설정
 CONN SYS as sysdba;
 GRANT CREATE VIEW TO SCOTT; -- sys에서 해야 함
 CONN SCOTT/TIGER;
 
 -- 2. emp, dept 복사
 DROP TABLE new_emp;
 DROP TABLE new_dept;
 
 CREATE TABLE new_emp
 AS
 SELECT *
   FROM emp
  WHERE 1 = 1; 
 CREATE TABLE new_dept
 as 
 SELECT *
   FROM dept
  WHERE 1 = 1; 
  
 -- 3. 복사 테이블에 누락된 PK 설정 ALTER
 -- new_dept 에 PK 설정
 ALTER TABLE new_dept ADD
 ( CONSTRAINT pk_new_dept PRIMARY KEY (deptno)
 );
 -- new,dept 에 PK 설정
 ALTER TABLE new_emp ADD
 ( CONSTRAINT pk_new_emp        PRIMARY KEY (empno),
   CONSTRAINT fk_new_deptno     FOREIGN KEY (deptno) REFERENCES new_dept(deptno),
   CONSTRAINT fk_new_emp_mgr    FOREIGN KEY (mgr)    REFERENCES new_emp(empno)
 );
 
 -- 4. 복사 테이블에서 view 생성
 --   : 상사이름, 부서명, 부서위치 까지 조회할 수 있는 뷰
 CREATE OR REPLACE VIEW v_emp_dept
 AS
 SELECT e1.empno,
        e1.ename,
        e2.ename mgr_name,
        e1.deptno,
        d.dname,
        d.loc
   FROM new_emp e1,
        new_emp e2,
        new_dept d
  WHERE e1.deptno = d.deptno(+)
    AND e1.mgr = e2.empno(+)
  WITH READ ONLY;
 -- 5. 
 DESC v_emp_dept;
 -- 6. 뷰 정보는 딕셔너리에 저장됨. 딕셔너리 확인
 -- user_views
 DESC user_views;
 
 SELECT u.VIEW_NAME,
        u.TEXT,
        u.READ_ONLY
   FROM user_views u;
   
 -- 7. 생성된 뷰에서 데이터 확인
 -- 1) 전체 데이터 조회
 SELECT v.*
   FROM v_emp_dept v;
 -- 2) SALES 이름 부서의 소속 직원 조회
 SELECT v.empno,
        v.ename,
        v.dname
   FROM v_emp_dept v
  WHERE v.dname = 'SALES'; 
   /*
7900	JAMES	SALES
7844	TURNER	SALES
7698	BLAKE	SALES
7654	MARTIN	SALES
7521	WARD	SALES
7499	ALLEN	SALES   
   */