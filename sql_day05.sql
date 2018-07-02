 -- sql_day05
 ----------------------------------------
 -- ORACLE 의 특별한 컬럼
 -- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
 --            물리적으로 저장된 위치이므로 한 행당 반드시 유일할 수 밖에 없음.
 --            ORDER BY 절에 의해서 변경되지 않는 값
 -- ex) emp 테이블에서 'SMITH'인 사람의 정보를 조회
 SELECT e.empno,
        e.ename
   FROM emp e
  WHERE e.ename = 'SMITH';
  
 -- rowid 를 같이 조회
 SELECT e.rowid,
        e.empno,
        e.ename
   FROM emp e
  WHERE e.ename = 'SMITH';
 
 -- rowid 는 ORDER BY 에 의해 변경되지 않는다.
 SELECT e.rowid,
        e.empno,
        e.ename
   FROM emp e
  ORDER BY e.ename;
 -- ORDER BY 를 사용하지 않을시 rowid 를 기반으로 정렬되서 출력된다.
 
 -- 2. ROWNUM : 조회된 결과의 첫번째 행부터 1로 
 SELECT rownum,
        e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE 'J%';
/*
ROWNUM, EMPNO, ENAME
1	7566	JONES
2	7900	JAMES
3	9999	J
4	8888	J_JUNE
5	7777	J%JUNES
6	6666	JJ
*/
 SELECT rownum,
        e.empno,
        e.ename
   FROM emp e
  WHERE e.ename LIKE 'J%'
  ORDER BY e.ename;
/*
ROWNUM, EMPNO, ENAME
3	9999	J
5	7777	J%JUNES
2	7900	JAMES
6	6666	JJ
1	7566	JONES
4	8888	J_JUNE
*/
 -- 위의 두 결과를 비교하면, rownum 도 ORDER BY에 영향을 받지 않는 것 처럼 보일 수 있으나
 -- SUB_QUERY 로 사용할 때 영향을 받음.
 SELECT rownum,
        a.empno,
        a.ename,
        a.deli,
        a.numrow
   FROM ( SELECT e.empno,
                 e.ename,
                 '|' deli,
                 rownum numrow
            FROM emp e
           WHERE e.ename LIKE 'J%'
           ORDER BY e.ename) a;
/*
ROWNUM, EMPNO, ENAME
1	9999	J
2	7777	J%JUNES
3	7900	JAMES
4	6666	JJ
5	7566	JONES
6	8888	J_JUNE
*/
 
 --------------------------------------- 
 -- DML : 데이터 조작어
 ---------------------------------------
 -- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령
 -- 데이터를 넣을 테이블의 형태
 DROP TABLE member;
 CREATE TABLE member
 ( member_id    varchar2(3)     ,
   member_name  varchar2(15)    NOT NULL,
   phone        varchar2(4), -- NULL 허용시 제약조건 비우면 됨
   reg_date     DATE            DEFAULT sysdate,
   address      varchar2(30),
   birth_month  NUMBER(2),
   gender       varchar2(1),
   CONSTRAINT pk_member PRIMARY KEY (member_id),
   CONSTRAINT ck_member_gender CHECK (gender IN ('M','F')),
   CONSTRAINT ck_member_birth CHECK (birth_month > 0 AND birth_month <=12)
 ); 
 
 -- 테이블 구조 확인 
 DESC member;
 -- 1. INTO 구문에 컬럼 이름 생략시 데이터 추가
 -- 전체 데이터 추가
 INSERT INTO member
 VALUES ('M01','전현찬','5250',sysdate,'덕명동',11,'M');
 INSERT INTO member
 VALUES ('M02','조성철','9034',sysdate,'오정동',8,'M');
 INSERT INTO member
 VALUES ('M03','김승유','5219',sysdate,'오정동',1,'M');
 -- 몇몇 컬럼에 NULL 데이터 추가
 INSERT INTO member
 VALUES ('M04','박길수','4003',sysdate,NULL,NULL,'M');
 INSERT INTO member
 VALUES ('M05','강현',NULL,NULL,'홍도동',6,'M');
 INSERT INTO member
 VALUES ('M06','김소민',NULL,sysdate,'월평동',NULL,NULL);
 
 -- 입력데이터 조회
 SELECT m.*
   FROM member m;
 -- CHECK 옵션에 위배되는 데이터 추가 시도
 INSERT INTO member
 VALUES ('M07','강병우','2260',NULL,'사정동',2,'N'); -- gender 위반
 -- ORA-02290: check constraint (SCOTT.CK_MEMBER_GENDER) violated
 INSERT INTO member
 VALUES ('M08','정준호',NULL,sysdate,'나성동',0,NULL); -- birth_month 위반
 -- ORA-02290: check constraint (SCOTT.CK_MEMBER_BIRTH) violated
 -- 수정
 INSERT INTO member
 VALUES ('M07','강병우','2260',NULL,'사정동',2,'M'); 
 INSERT INTO member
 VALUES ('M08','정준호',NULL,sysdate,'나성동',1,NULL);
  
 -- 2. INTO 구문에 컬럼 이름 명시하여 데이터 추가
 -- : VALUES 절에 INTO 의 순서대로 값의 타입, 개수를 맞추어서 작성
 INSERT INTO member (member_id, member_name, gender )
 VALUES ('M09','윤홍식','M');
 -- reg_date 컬럼 : DEFALUT 설정이 작동하여 시스템 날짜가 자동입력
 -- phone, address 컬럼 : NULL 값으로 입력되는 것 확인
 
 -- INTO 절에 컬럼 나열시 테이블 정의 순서와 별개로 나열 가능
 INSERT INTO member (member_name, address, member_id )
 VALUES ('이주영','용전동','M10');
 -- PK 값이 중복되는 입력시도
 INSERT INTO member (member_name, member_id )
 VALUES ('남정규','M10');
 -- ORA-00001: unique constraint (SCOTT.PK_MEMBER) violated
 -- 수정 : 이름 컬럼에 주소가 들어가는 데이터
 --       이름, 주소 모두 문자 데이터이기 떄문에 타입이 맞아서 논리 오류 발생
 INSERT INTO member (member_name, member_id )
 VALUES ('목동','M11');
 
 -- 필수 입력 컬럼인 member_name 누락
 INSERT INTO member (member_name )
 VALUES ('M12');
 -- ORA-01400: cannot insert NULL into ("SCOTT"."MEMBER"."MEMBER_ID")
 -- 수정
 INSERT INTO member (member_id, member_name )
 VALUES ('M12','이동희');
 
 -- INTO 절에 나열된 컬럼(3 개)과 VALUES 절의 값(2 개)의 개수 불일치
 INSERT INTO member (member_id, member_name,gender )
 VALUES ('M13','유재성');
 -- QL 오류: ORA-00947: not enough values
 
 -- INTO 절에 나열된 컬럼과 VALUES 절의 데이터 타입이 불일치
 INSERT INTO member (member_id, member_name, birth_month )
 VALUES ('M13','유재성','M');
 -- ORA-01722: invalid number
 --수정
 INSERT INTO member (member_id, member_name, birth_month )
 VALUES ('M13','유재성',3);
 
 ---------------------------------------------------
 -- 다중 행 입력 : SUB-QUERY 를 사용하여 가능
 -- 구문구조
 INSERT INTO 테이블이름
 SELECT 문장; -- SUB-QUERY
 
 -- CREATE AS SELECT 는 데이터를 복사하여 테이블생성
 -- vs,
 -- INSERT INTO ~ SELECT 는 이미 만들어진 테이블에 데이터만 복사 추가
 
 -- member 테이블의 내용을 조회해서 nuw_member 로 insert
 INSERT INTO new_member
 SELECT m.*
   FROM member m
  WHERE m.phone IS NOT NULL;
 -- 5개 행 이(가) 삽입되었습니다.
 INSERT INTO new_member
 SELECT m.*
   FROM member m
  WHERE m.member_id > 'M09';
 -- 4개 행 이(가) 삽입되었습니다.
 -- new_member 테이블 데이터 삭제 X 버튼 클릭 후 -> 데이터 반영
 
 -- 성이 '김'인 멤버 데이터를 복사 입력
 INSERT INTO new_member
 SELECT m.*
   FROM member m
  WHERE member_name LIKE '김%';
  
 -- 짝수달에 태어난 멤버데이터를 복사 입력
 INSERT INTO new_member
 SELECT m.*
   FROM member m
  WHERE MOD(m.birth_month,2) = 0 ;
 
 -------------------------------------------------------
 -- 2) UPDATE : 테이블의 행을 수정
 --             WHERE 조건절의 조합에 따라 1행 혹은 다행 수정이 가능
 -- member 테이블에서 이름이 잘못들어간 'M11' 멤버 정보를 수정
 -- 데이터 수정전에 영구반영을 싱행
 commit; -- 커밋 완료.
 
 UPDATE member m
    SET m.MEMBER_NAME = '남정규'
  WHERE m.member_id = 'M11';
 
 -- 'M05' 회원의 전화번호 필드를 업데이트
 commit;
 UPDATE member m
    SET m.phone = '1743';
 -- WHERE m.member_id = 'M05';
 -- WHERE 조건절의 실수를 DML 작업 실수가 발생
 -- 데이터 상태 되돌리기
 rollback; -- 마지막 commit 상태로 되돌림
 UPDATE member m
    SET m.phone = '1743'
  WHERE m.member_id = 'M05';
 
 -- 2개 이상의 컬럼을 한번에 업데이트 SET 절에 나열
 UPDATE member m
    SET m.phone = '0000',
        m.reg_date = sysdate
  WHERE m.member_id = 'M05';
 commit;
 
 UPDATE member m
    SET m.phone = '4724',
        m.birth_month = 1,
        m.gender = 'F'
  WHERE m.address = '월평동';      
  -- WHERE m.member_id = 'M06';
 
 -- 위의 실행 결과는 의도대로 반영되는 것처럼 월평동에 사는 사람이 많다면
 -- 월평동의 모든 사람 정보가 수정될 것.
 -- 따라서 UPDATE 구문작성시 WHERE 조건은 주의를 기울여서 작성해야 함.
 
 /*
 DML : UPDATE, DELETE 작업시 주의 점
 
 딱 하나의 데이터를 수정/삭제 하려면
 WHERE 절의 비교 조건에 반드시 PK 로 설정한 컬럼의 값을 비교하도록 권장
 
 PK 는 전체 행에서 유일하고, NOT NULL 임이 보장되기 때문
 
 UPDATE, DELETE 는 구문에 물리적 오류가 없으면, WHERE 조건에 맞는 전체 행 대상으로 작업하는 것이
 기본이므로 항상 주의!!!
 */
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 