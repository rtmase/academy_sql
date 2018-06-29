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
 