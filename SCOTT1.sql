create table emp01 
as
select * from emp;

select * from emp01;

select empno,ename,job 
from emp01
where empno = 7902;

desc emp01;

INSERT INTO EMP01 (EMPNO,ENAME,JOB,DEPTNO)
VALUES (NULL,NULL,'SALESMAN',30);

DROP TABLE EMP01;

CREATE TABLE EMP02(
    EMPNO NUMBER(4) NOT NULL,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2));

INSERT INTO EMP02(EMPNO,ENAME,JOB,DEPTNO)
VALUES (NULL,NULL,'SALEMAN',20);

INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (7355,'ALLEN','SALEMAN',20);

SELECT  * FROM EMP02;

CREATE TABLE EMP03 (
    EMPNO NUMBER(4) UNIQUE,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2));
    
INSERT INTO EMP03(EMPNO,ENAME,JOB,DEPTNO)
VALUES (7355,'ALLEN','SALESMAN',20);

INSERT INTO EMP03 (EMPNO,ENAME,JOB,DEPTNO)
VALUES (7355,'JONES','MANAGER',20);

INSERT INTO EMP03 (EMPNO,ENAME,JOB,DEPTNO)
VALUES (NULL,'JONES','MANAGER',20);

INSERT INTO EMP03 (EMPNO,ENAME,JOB,DEPTNO)
VALUES (NULL,'JONES','SALESMAN',10);

SELECT * FROM EMP03;

DROP TABLE EMP04;

CREATE TABLE EMP04(
    EMPNO NUMBER(4) CONSTRAINT EMP04_EMPNO_UK UNIQUE,
    ENAME VARCHAR2(10) CONSTRAINT EMP04_ENAME_NN NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2));
    
SELECT TABLE_NAME, CONSTRAINT_NAME 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'EMP04';

INSERT INTO EMP04 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (7499,'ALLEN','MANAGER',30);

INSERT INTO EMP04 (EMPNO, ENAME, JOB, DEPTNO) 
VALUES (7499, 'JONES','MANAGER', 20);

CREATE  TABLE EMP05 AS
SELECT * FROM EMP04
WHERE 1=2;

SELECT * FROM EMP05;

ALTER TABLE EMP05 ADD CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY(EMPNO);


INSERT INTO EMP05 
VALUES(7499,'ALLEN','SALESMAN',30);

SELECT * FROM EMP05;

INSERT INTO EMP05 
VALUES (7499,'JONES','MANAGER',20);
--오류 보고 -
--ORA-00001: 무결성 제약 조건(SCOTT.EMP05_EMPNO_PK)에 위배됩니다

INSERT INTO EMP05 
VALUES(NULL,'JONES','MANAGER',20);
--오류 보고 -
--ORA-01400: NULL을 ("SCOTT"."EMP05"."EMPNO") 안에 삽입할 수 없습니다

INSERT INTO EMP(EMPNO,ENAME,DEPTNO)
VALUES(8000, 'MIN', 50);
--오류 보고 -
--ORA-02291: 무결성 제약조건(SCOTT.FK_DEPTNO)이 위배되었습니다- 부모 키가 없습니다
SELECT * FROM DEPT;

SELECT TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME, R_CONSTRAINT_NAME 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME IN ('DEPT', 'EMP');

DROP TABLE EMP06;

CREATE TABLE EMP06(
    EMPNO NUMBER(4) CONSTRAINT EMP06_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP06_ENAME_NN NOT NULL,
    JOB VARCHAR(9),
    DEPTNO NUMBER(2) CONSTRAINT EMP06_DEPTNO_FK REFERENCES DEPT(DEPTNO));
    
INSERT INTO EMP06 
VALUES(7499,'ALLEN','SALESMAN',30);

SELECT * FROM EMP06;

INSERT INTO EMP06 VALUES(7566,'JONES','MANAGER',50);
--오류 보고 -
--ORA-02291: 무결성 제약조건(SCOTT.EMP06_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
--부모 키 = DEPTNO 50

INSERT INTO DEPT 
VALUES(50,'INSA','SEOUL');
-- 50 DEPTNO 생성

INSERT INTO EMP06 VALUES(7566,'JONES','MANAGER',50);
-- 성공

