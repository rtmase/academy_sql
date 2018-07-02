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