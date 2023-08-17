/******************************************
제약조건 (Constraint) 
- 올바른 데이터만 입력하기 위해 사용(잘못된 데이터는 입력 차단-에러발생)
- 데이터의 정확성과 일관성을 보장하기 위해 각 칼럼에 정의하는 규칙
- 딕셔너리에 저장됨
- 테이블 생성시 무결성 제약조건을 정의하여 프로그래밍 과정을 단순화
- 데이터베이스 서버에 의해 무결성 제약조건이 관리되어 데이터 오류 발생 가능성을 줄여줌
- 일시적으로 활성화(ENABLE) 또는 비활성화(DISABLE) 할 수 있다.

<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
1. NOT NULL : Null값 포함할수 없음
2. UNIQUE : 중복되는 값 오면 안됨
    (중복되는 것 없어야 하므로, 서버프로세스가 기존 데이터를 찾아야 한다. 오래걸림 - 해결 : 인덱스)
3. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
4. PRIMARY KEY(기본키) : 고유 값 (NOT NULL + UNIQUE)
5. FOREIGN KEY(외래키-참조) : 해당 칼럼 값은 참조되는 테이블의 칼럼 값 중 하나와 일치하거나 Null을 가짐
    - 자식 테이블 : 다른 테이블의 값을 참조하는 테이블
    - 외래키(foreign key): 부모테이블의 값을 참조하는 자식테이블의 칼럼
    - 부모 테이블 : 다른 테이블에 의해 참조되는 테이블
    - 참조키(reference : 자식 테이블에서 참조하는 부모 테이블의 칼럼
************************************************/
SELECT * FROM DEPT;
-- 테이블 생성시 컬럼레벨에서 제약조건(외래키) 설정
CREATE TABLE EMP01 (
    EMPNO NUMBER(5) PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT (ID) --외래키 설정(컬럼레벨)
);
SELECT * FROM EMP01;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');
COMMIT;

INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40'); --오류:parent key not found

--=================
-- 테이블 레벨에서 제약조건 지정
CREATE TABLE EMP02 (
    EMPNO NUMBER(5),
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --기본키(PRIMARY KEY) 설정
    FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) --외래키(FOREIGN KEY) 설정
);
--===================
--제약조건명을 명시적으로 선언해서 사용
--형태  : CONSTRAIN 제약조건명 적용할 제약조건
CREATE TABLE EMP03 (
    EMPNO NUMBER(5),
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO),
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID)
);
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');
COMMIT;

INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40');

--============================================
/* 테이블에 제약조건 추가, 삭제
-- 제약조건 추가
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 적용할제약조건;
-- 제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
********************/
-- EMP01 테이블의 PRIMARY KEY 삭제 : SYS_C007032
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007032;

-- EMP01 테이블의 PRIMARY KEY 추가
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);

----------------------------
-- EMP02, EMP03 테이블 외래키(FOREIGN KEY) 이름 변경 처리
-- EMP02 : EMP02_EMPNO_FK, EMP03 : FK_EMP03_DEPTNO
-- RENAME 사용해서 바꾸기
ALTER TABLE EMP02 
RENAME CONSTRAINT EMP02_FK TO EMP02_EMPNO_FK;
ALTER TABLE EMP03
RENAME CONSTRAINT EMP03_DEPTNO_FK TO FK_EMP03_DEPTNO;
-- EMP02 테이블 DROP/ADD 사용해서 삭제 후 추가
alter table EMP02 drop constraint "EMP02_EMPNO_FK";
alter table EMP02 add constraint EMP02_EMPNO_FK 
    foreign key("DEPTNO") references DEPT(ID);
-- EMP03 테이블 DROP/ADD 사용해서 삭제 후 추가
alter table EMP03 drop constraint "FK_EMP03_DEPTNO";    
ALTER TABLE EMP03 ADD CONSTRAINT FK_EMP03_DEPTNO 
    FOREIGN KEY("DEPTNO") REFERENCES DEPT(ID);
    
--===========================
/* 제약조건 활성화 또는 비활성화
-- 제약조건 설정되어 있는 것을 적용 또는 적용해제
ALTER TABLE 테이블명 DISABLE CONSTRIANT 제약조건명;
ALTER TABLE 테이블명 ENABLE CONSTRIANT 제약조건명;
*****************/
alter table "MADANG"."EMP02" disable  constraint "EMP02_EMPNO_FK";
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_EMPNO_FK;
-- 외래키 DISABLE 상태인 경우 
INSERT INTO EMP02 VALUES (3333, '홍길동3', '직무3', '40');
COMMIT;
SELECT * FROM EMP02;
-- 제약조건 활성화(적용) 또는 추가시
---- 제약조건 활성화(또는 추가시) 제약조건 위반 데이터가 있으면 활성화(추가)가 안된다.
--ORA-02298: cannot validate (MADANG.EMP02_EMPNO_FK) - parent keys not found
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_EMPNO_FK;

--=====================
-- 데이터사전 테이블
SELECT * FROM USER_CONS_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;

SELECT A.OWNER, A.TABLE_NAME, A.COLUMN_NAME, A.CONSTRAINT_NAME
     , B.CONSTRAINT_TYPE
     , DECODE(B.CONSTRAINT_TYPE, 
              'P', 'PRIMARY KEY',
              'U', 'UNIQUE',
              'C', 'CHECK OR NOT NULL',
              'R', 'FOREIGN KEY',
              '기타등등'
       ) AS CONSTRAINT_TYPE_DESC
FROM USER_CONS_COLUMNS A,
     USER_CONSTRAINTS B
WHERE A.TABLE_NAME = B.TABLE_NAME --조인조건
  AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME --조인조건
--  AND A.TABLE_NAME LIKE 'EMP%'
ORDER BY A.TABLE_NAME
;
--==================
-- 기본키(PRIMARY KEY) 설정시 복합키 사용
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), --학년
    BAN NUMBER(2), --반(10반 이상 있을 때 2자리)
    BUN NUMBER(2), --번호
    NAME VARCHAR2(30),
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
SELECT * FROM HSCHOOL;
INSERT INTO HSCHOOL VALUES (1,1,1,'강감찬');
INSERT INTO HSCHOOL VALUES (1,1,1,'홍길동'); --ORA-00001: unique constraint (MADANG.HSCHOOL_HAK_BAN_BUN_PK) violated
INSERT INTO HSCHOOL VALUES (1,1,2,'홍길동');
INSERT INTO HSCHOOL VALUES (1,2,1,'홍길동');
INSERT INTO HSCHOOL VALUES (2,1,1,'홍길동');
COMMIT;
INSERT INTO HSCHOOL VALUES (1,2,2,'을지문덕');


    