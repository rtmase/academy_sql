-- (23) BETWEEN 을 사용하여 급여가 2500에서 3000 사이인 사원의 모든 정보를 조회
SELECT *
  FROM emp e
 WHERE e.sal BETWEEN 2500 and 3000;
 /*
 7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7902	FORD	ANALYST	7566	81/12/03	3000		20
 */
-- (24) 커미션이 NULL 인 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.comm is null;
 /*
 7369	SMITH	CLERK	7902	80/12/17	800		20
7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7839	KING	PRESIDENT		81/11/17	5000		10
7900	JAMES	CLERK	7698	81/12/03	950		30
7902	FORD	ANALYST	7566	81/12/03	3000		20
7934	MILLER	CLERK	7782	82/01/23	1300		10
9999	J	CLERK		18/06/27	500		
8888	J_JUNE	CLERK		18/06/07	400		
7777	J%JUNES	CLERK		18/06/27	300		
 */
-- (25) 커미션 NULL 이 아닌 사원의 모든 정보 조회
SELECT *
  FROM emp e
 WHERE e.comm is not null;
 /*
 7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30
 */
-- (26) 
SELECT e.empno as 사번,
       e.ename || '의 월급은' || e.sal || '입니다' 월급여
  FROM emp e;
  /*
  7369	SMITH의 월급은800입니다
7499	ALLEN의 월급은1600입니다
7521	WARD의 월급은1250입니다
7566	JONES의 월급은2975입니다
7654	MARTIN의 월급은1250입니다
7698	BLAKE의 월급은2850입니다
7782	CLARK의 월급은2450입니다
7839	KING의 월급은5000입니다
7844	TURNER의 월급은1500입니다
7900	JAMES의 월급은950입니다
7902	FORD의 월급은3000입니다
7934	MILLER의 월급은1300입니다
9999	J의 월급은500입니다
8888	J_JUNE의 월급은400입니다
7777	J%JUNES의 월급은300입니다
  */
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