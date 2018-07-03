 -- 1)
 INSERT INTO customer (userid, name, birthyear, address )
 VALUES ('C001','김수현',1988,'경기');
 INSERT INTO customer (userid, name, birthyear, address )
 VALUES ('C002','이효리',1979,'제주');
 INSERT INTO customer (userid, name, birthyear, address )
 VALUES ('C003','원빈',1977,'강원');
 
 -- 2)
 UPDATE customer c
    SET c.name = '차태현',
        c.birthyear = 1976,
        c.address = '서울'
  WHERE c.userid = 'C001';  
 -- 3)
 UPDATE customer c
    SET c.address = '서울';
 -- 4)
 DELETE customer c
  WHERE c.userid = 'C003';
 -- 5)
 DELETE customer;
 
 -- 6)
 INSERT INTO customer (userid, name, birthyear, address )
 VALUES ('C001','김수현',1988,'경기');
 INSERT INTO customer (userid, name, birthyear, address )
 VALUES ('C002','이효리',1979,'제주');
 INSERT INTO customer (userid, name, birthyear, address )
 VALUES ('C003','원빈',1977,'강원');
    
 TRUNCATE TABLE customer;   
 
 -- 1)
 CREATE SEQUENCE seq_cust_userid
 MINVALUE 1
 MAXVALUE 99
 NOCYCLE;
 -- 2)
 SELECT s.MIN_VALUE,
        s.MAX_VALUE,
        s.CYCLE_FLAG,
        s.increment_by
   FROM user_sequences s
  WHERE s.SEQUENCE_NAME = 'SEQ_CUST_USERID'; 
 -- 1	99	N	1
 -- 3)
 INSERT INTO new_cust (userid, name, birthyear, address )
 VALUES ('C001','김수현',1988,'경기');
 INSERT INTO new_cust (userid, name, birthyear, address )
 VALUES ('C002','이효리',1979,'제주');
 INSERT INTO new_cust (userid, name, birthyear, address )
 VALUES ('C003','원빈',1977,'강원');
 
 CREATE INDEX idx_new_cust_userid
 ON new_cust(userid);
 -- Index IDX_NEW_CUST_USERID이(가) 생성되었습니다.
 -- 4)
 SELECT i.INDEX_NAME,
        i.INDEX_TYPE,
        i.table_name,
        i.table_owner,
        i.INCLUDE_COLUMN
   FROM user_indexes i;
/*
PK_SUB_TABLE4	NORMAL	SUB_TABLE	SCOTT	
IDX_NEW_MEMBER_ID	NORMAL	NEW_MEMBER	SCOTT	
IDX_NEW_CUST_USERID	NORMAL	NEW_CUST	SCOTT	
PK_MEMBER	NORMAL	MEMBER	SCOTT	
PK_EMP	NORMAL	EMP	SCOTT	
PK_DEPT	NORMAL	DEPT	SCOTT	
SYS_C007031	NORMAL	CUSTOMER	SCOTT	
*/
 SELECT c.COLUMN_NAME,
        c.COLUMN_LENGTH,
        c.INDEX_NAME,
        c.TABLE_NAME
   FROM user_ind_columns c;
/*
NICKNAME	30	BIN$+xaASt7STzGlZzjpN+0CKg==$0	BIN$2D/803v+SFiWqmyDawFrxg==$0
EMPNO	22	BIN$3EnuHX07QxuS651omAGwFQ==$0	BIN$hoJn8EyRSSSof6GesBwqZA==$0
NICKNAME	30	BIN$3SInxs/3Td+q+iFbJuIcJA==$0	BIN$RzCSVbQQQzSPEWs85wlmyw==$0
ID	10	BIN$4dc7G221TlqXA4PWdgmrlA==$0	BIN$2D/803v+SFiWqmyDawFrxg==$0
ID	10	BIN$4sOrmh73SKWCpTtb+j5euA==$0	BIN$fYMWh3m9Ru+nOREZNF50mw==$0
ID	10	BIN$6ht2uDUhQn2xrqmG3FMJug==$0	BIN$RzCSVbQQQzSPEWs85wlmyw==$0
MEMBER_ID	3	BIN$6zY8U39qS+KxbhR1CoTcaA==$0	BIN$67U9FjwlR/yEsHLv9x9tAQ==$0
MEMBER_ID	3	BIN$DIh7kSekTvy50mYPfRE5/g==$0	BIN$ZOvntKiKRXm3Q+hapV/HSw==$0
ID	10	BIN$EL3rH0RBQaC+OuXlFBhYLw==$0	BIN$EC5WlO2DTLiSRn2Heocq5g==$0
NICKNAME	30	BIN$PmzJCt2TSaWT3fW+9jiB0w==$0	BIN$EC5WlO2DTLiSRn2Heocq5g==$0
MEMBER_ID	3	BIN$RkUwGhdISaeFxnm9qY49xw==$0	BIN$ZkhDUEw1Sc6Rpq4kh6A+IQ==$0
SUB_CODE	22	BIN$beAeRbjnQKeqk2oLy1WXyw==$0	BIN$bdyGa7RyRU6wGOD+FCZk2Q==$0
ID	10	BIN$beAeRbjnQKeqk2oLy1WXyw==$0	BIN$bdyGa7RyRU6wGOD+FCZk2Q==$0
EMPNO	22	BIN$dk1hukJcQjCiBcSAtfuj0A==$0	BIN$7fDCehQDSZS3iYuSTV1c3g==$0
NICKNAME	30	BIN$j/CO4PM4Qtm1oqZelVni+Q==$0	BIN$fYMWh3m9Ru+nOREZNF50mw==$0
MEMBER_ID	3	BIN$o/neDkF2QR+PvDQxUGFR5Q==$0	BIN$5qsqUvd3SGyabMdhAixbJQ==$0
USERID	4	IDX_NEW_CUST_USERID	NEW_CUST
MEMBER_ID	3	IDX_NEW_MEMBER_ID	NEW_MEMBER
DEPTNO	22	PK_DEPT	DEPT
EMPNO	22	PK_EMP	EMP
MEMBER_ID	3	PK_MEMBER	MEMBER
SUB_CODE	22	PK_SUB_TABLE4	SUB_TABLE
ID	10	PK_SUB_TABLE4	SUB_TABLE
USERID	4	SYS_C007031	CUSTOMER
*/
 -- 5)
 SELECT i.INDEX_NAME,
        i.INDEX_TYPE,
        i.table_name,
        i.table_owner,
        i.INCLUDE_COLUMN
   FROM user_indexes i
  WHERE i.INDEX_NAME = 'IDX_NEW_CUST_USERID';
 -- IDX_NEW_CUST_USERID	NORMAL	NEW_CUST	SCOTT	
 -- 6)
 SELECT c.COLUMN_NAME,
        c.COLUMN_LENGTH,
        c.INDEX_NAME,
        c.TABLE_NAME
   FROM user_ind_columns c
  WHERE c.INDEX_NAME = 'IDX_NEW_CUST_USERID'; 
 -- USERID	4	IDX_NEW_CUST_USERID	NEW_CUST
 -- 7)
 DROP INDEX IDX_NEW_CUST_USERID;
 -- Index IDX_NEW_CUST_USERID이(가) 삭제되었습니다.
 -- 8)
 SELECT c.COLUMN_NAME,
        c.COLUMN_LENGTH,
        c.INDEX_NAME,
        c.TABLE_NAME
   FROM user_ind_columns c
  WHERE c.INDEX_NAME = 'IDX_NEW_CUST_USERID';  
 -- 인출된 모든 행 : 0
 
 -- 1)
 BEGIN
  DBMS_OUTPUT.PUT_LINE('PL/SQL World!');
 END;
 /
 /*
PL/SQL World!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
 */
 -- 2)
 DECLARE
  hello    VARCHAR2(10) := 'Hello';
  world    VARCHAR2(15) := 'PL/SQL World!';
 BEGIN
 DBMS_OUTPUT.PUT_LINE(hello || ' ' || world);
 END;
 /
 /*
Hello PL/SQL World!


PL/SQL 프로시저가 성공적으로 완료되었습니다. 
 */
 -- 3)