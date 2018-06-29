 -- 3)
 SELECT e1.empno,
        e1.ename,
        e1.mgr,
        e2.empno,
        e2.ename
  FROM emp e1, emp e2
 WHERE e1.mgr = e2.empno(+); 
 -- 4)
 SELECT e1.empno,
        e1.ename,
        e1.mgr,
        e2.ename
   FROM emp e1,
        emp e2
  WHERE e1.mgr(+) = e2.empno;   
 -- 5)
 SELECT e.job
   FROM emp e
  WHERE e.ename = 'BLAKE';
 
 SELECT e.ename,
        e.job
   FROM emp e
  WHERE e.job = (SELECT e.job
                   FROM emp e
                  WHERE e.ename = 'BLAKE');
 -- 6)
 SELECT e.empno,
        e.ename,
        e.mgr
   FROM emp e;
   
 SELECT e.empno as "사번",
        e.ename as "이름",
        a."상사 이름"
   FROM emp e,
        (SELECT e.empno,
                e.ename  as "상사 이름" 
                FROM emp e) a
  WHERE e.mgr = a.empno;
 -- 7)
 SELECT d.deptno,
        d.dname,
        d.loc
   FROM dept d;
 
 SELECT e.empno,
        e.ename,
        e.job,
        e.sal,
        a.dname,
        a.loc
   FROM emp e, 
        (SELECT d.deptno,
                d.dname,
                d.loc
           FROM dept d) a
  WHERE e.deptno = a.deptno; 
 -- 1)
 CREATE TABLE CUSTOMER
 (  userid      VARCHAR2(4)     PRIMARY KEY,
    name        VARCHAR2(30)    NOT NULL,
    birthyear   NUMBER(4),
    regdate     DATE            DEFAULT sysdate,
    address     VARCHAR2(30)
 );
 -- 2)
 DESC CUSTOMER;
 /*
 USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
 */
 -- 3)
 CREATE TABLE NEW_CUST
 AS
 SELECT *
   FROM customer
  WHERE 1 =2;
 -- 4)
 DESC new_cust;
 /*
 USERID             VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
 */
 -- 5) 
 CREATE TABLE salesman
 AS
 SELECT e.job
   FROM emp e
  WHERE e.job = 'SALESMAN';
 -- 6)
 DESC salesman;
 -- JOB    VARCHAR2(9) 
 
 -- 7)
 ALTER TABLE customer ADD
 (  phone       VARCHAR2(11),
    grade       VARCHAR2(30) CHECK( grade IN ('VIP','GOLD','SILVER'))
 );
 -- 8)
 ALTER TABLE customer DROP COLUMN grade;
 
 ALTER TABLE customer ADD 
 (grade       VARCHAR2(30)  CHECK( grade IN ('VIP','GOLD','SILVER'))
 );
 -- 9)
 ALTER TABLE customer MODIFY phone NUMBER(4);
 ALTER TABLE customer MODIFY phone VARCHAR2(30);