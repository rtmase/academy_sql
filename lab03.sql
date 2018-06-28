-- 16)
 SELECT e.empno 사원번호,
        e.ename 이름,
        e.sal 급여 ,
        TO_CHAR(CASE e.job WHEN 'CLERK'    THEN 300
                   WHEN 'SALESMAN' THEN 450
                   WHEN 'MANAGER'  THEN 600
                   WHEN 'ANALYST'  THEN 800
                   WHEN 'PRESIDENT' THEN 1000
         END,'$9,999') as "자기 계발비"
  FROM emp e;
 -- 17)
 SELECT e.empno 사원번호,
        e.ename 이름,
        e.sal 급여 ,
        TO_CHAR(CASE WHEN e.job = 'CLERK'    THEN 300
             WHEN e.job = 'SALESMAN' THEN 450
             WHEN e.job = 'MANAGER'  THEN 600
             WHEN e.job = 'ANALYST'  THEN 800
             WHEN e.job = 'PRESIDENT' THEN 1000
         END,'$9,999') as "자기 계발비"
  FROM emp e;
 -- 18)
 SELECT COUNT(*)
   FROM emp;
 -- 16
 -- 19)
 SELECT COUNT(DISTINCT e.job)
   FROM emp e;
 -- 5
 -- 20)
 SELECT COUNT(e.comm)
   FROM emp e;
 -- 4
 -- 21)
 SELECT SUM(e.sal)
   FROM emp e;
 -- 28925
 -- 22)
 SELECT AVG(e.sal)
   FROM emp e;
 --1807.8125
 -- 23)
 SELECT SUM(e.sal),
        AVG(e.sal),
        MAX(e.sal),
        MIN(e.sal)
   FROM emp e;
 -- 28925	1807.8125	5000	300
 -- 24)
 SELECT TO_CHAR(STDDEV(e.sal),'9999.99') as dev, 
        TO_CHAR(VARIANCE(e.sal),'9999999999.99') as var
   FROM emp e;     
 --  1269.96	    1612809.90  
 -- 25)
 SELECT TO_CHAR(STDDEV(e.sal),'9999.99') as dev, 
        TO_CHAR(VARIANCE(e.sal),'9999999999.99') as var
   FROM emp e
  WHERE e.job = 'SALESMAN';
 --   177.95	      31666.67
 -- 26)
 SELECT DECODE(e.job, 
               'CLERK', 300,
               'SALESMAN', 450,
               'MANAGER', 600,
               'ANALYST', 800,
               'PRESIDENT', 1000) 자기계발비
   FROM emp e;
  SELECT e.deptno,
         SUM(DECODE(e.job, 
               'CLERK', 300,
               'SALESMAN', 450,
               'MANAGER', 600,
               'ANALYST', 800,
               'PRESIDENT', 1000)) "자기계발비 총합"
   FROM emp e 
  GROUP BY e.deptno; 
  /*
30	    2700
null	900
20	    1700
10	    1900
  */
  -- 27)
  SELECT e.deptno,
         e.job,
         SUM(DECODE(e.job, 
               'CLERK', 300,
               'SALESMAN', 450,
               'MANAGER', 600,
               'ANALYST', 800,
               'PRESIDENT', 1000)) "자기계발비 총합"
    FROM emp e
   GROUP BY e.deptno,e.job
   ORDER BY e.deptno,e.job DESC;
  /*
10  	PRESIDENT	1000
10  	MANAGER 	600
10  	CLERK	    300
20  	MANAGER 	600
20  	CLERK   	300
20  	ANALYST	    800
30  	SALESMAN	1800
30  	MANAGER 	600
30  	CLERK   	300
null    null        null		
null	CLERK   	900  
  */
 -- 1)
 SELECT *
   FROM emp e NATURAL JOIN dept d;
 /*
20	7369	SMITH	CLERK	7902	80/12/17	800		RESEARCH	DALLAS
30	7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	SALES	CHICAGO
30	7521	WARD	SALESMAN	7698	81/02/22	1250	500	SALES	CHICAGO
20	7566	JONES	MANAGER	7839	81/04/02	2975		RESEARCH	DALLAS
30	7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	SALES	CHICAGO
30	7698	BLAKE	MANAGER	7839	81/05/01	2850		SALES	CHICAGO
10	7782	CLARK	MANAGER	7839	81/06/09	2450		ACCOUNTING	NEW YORK
10	7839	KING	PRESIDENT		81/11/17	5000		ACCOUNTING	NEW YORK
30	7844	TURNER	SALESMAN	7698	81/09/08	1500	0	SALES	CHICAGO
30	7900	JAMES	CLERK	7698	81/12/03	950		SALES	CHICAGO
20	7902	FORD	ANALYST	7566	81/12/03	3000		RESEARCH	DALLAS
10	7934	MILLER	CLERK	7782	82/01/23	1300		ACCOUNTING	NEW YORK
 */
 -- 2)
 SELECT *
    FROM emp e JOIN dept d USING(deptno);
 /*
20	7369	SMITH	CLERK	7902	80/12/17	800		RESEARCH	DALLAS
30	7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	SALES	CHICAGO
30	7521	WARD	SALESMAN	7698	81/02/22	1250	500	SALES	CHICAGO
20	7566	JONES	MANAGER	7839	81/04/02	2975		RESEARCH	DALLAS
30	7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	SALES	CHICAGO
30	7698	BLAKE	MANAGER	7839	81/05/01	2850		SALES	CHICAGO
10	7782	CLARK	MANAGER	7839	81/06/09	2450		ACCOUNTING	NEW YORK
10	7839	KING	PRESIDENT		81/11/17	5000		ACCOUNTING	NEW YORK
30	7844	TURNER	SALESMAN	7698	81/09/08	1500	0	SALES	CHICAGO
30	7900	JAMES	CLERK	7698	81/12/03	950		SALES	CHICAGO
20	7902	FORD	ANALYST	7566	81/12/03	3000		RESEARCH	DALLAS
10	7934	MILLER	CLERK	7782	82/01/23	1300		ACCOUNTING	NEW YORK
 */