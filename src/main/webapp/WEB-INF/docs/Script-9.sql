show databases;

create database `miniProj-db`;

use `miniProj-db`;



CREATE TABLE TB_MEMBER
(
	memberid varchar(100) NOT NULL PRIMARY KEY,
	memberpwd varchar(100) NOT NULL,
	membername varchar(100) NOT NULL,
	memberaddress varchar(100) NOT NULL,
	memberphonenumber varchar(100) NOT NULL,
	membergender varchar(100) NOT NULL
);

InSert INTO TB_MEMBER values ('msa1', 'aaa111', '박경덕', '신곡로11', '010-1111-1111', '남');
InSert INTO TB_MEMBER values ('msa2', 'bbb222', '경덕박', '신곡로22', '010-2222-2222', '여');
InSert INTO TB_MEMBER values ('msa3', 'ccc333', '덕경박', '신곡로33', '010-3333-3333', '남');
InSert INTO TB_MEMBER values ('msa4', 'ddd444', '박덕경', '신곡로44', '010-4444-4444', '여');

SELECT * From TB_MEMBER tm ;

CREATE TABLE TB_Hobby (
    HobbyId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    HobbyName VARCHAR(100) NOT NULL
);

INSERT INTO TB_Hobby values (1, '자전거타기');
INSERT INTO TB_Hobby values (2, '돌고래타기');
INSERT INTO TB_Hobby values (3, '낙타타기');
INSERT INTO TB_Hobby values (4, '호랑이타기');
SELECT * FROM  TB_Hobby th ;


CREATE TABLE TB_MemberHobby (
    MemberId varchar(100) NOT NULL,
    HobbyId INT NOT NULL,
    PRIMARY KEY (MemberId, HobbyId),
    FOREIGN KEY (MemberId) REFERENCES TB_MEMBER(memberid),
    FOREIGN KEY (HobbyId) REFERENCES TB_Hobby(HobbyId)
);

INSERT INTO TB_MemberHobby values ('msa1',1);
INSERT INTO TB_MemberHobby values ('msa1',2);
INSERT INTO TB_MemberHobby values ('msa1',3);
INSERT INTO TB_MemberHobby values ('msa2',1);
INSERT INTO TB_MemberHobby values ('msa4',4);

SELECT * FROM TB_MEMBERHObby;

CREATE TABLE TB_BOARD (
    bno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    btitle VARCHAR(255) NOT NULL,
    bcontent VARCHAR(1000) NOT NULL,
    bwriter VARCHAR(100) NOT NULL,
    bdate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bViewCount INT Default 0,
    FOREIGN key (bwriter) REFERENCES TB_MEMBER (memberid)
);

INSERT INTO TB_BOARD values (1,'게시글1', '내용1입니다', 'msa1', '2024-01-01 01:01:01', 0);
INSERT INTO TB_BOARD values (2,'게시글2', '내용2입니다', 'msa2', '2024-02-04 02:02:02', 0);
INSERT INTO TB_BOARD values (3,'게시글3', '내용3입니다', 'msa3', '2024-03-04 03:03:03', 0);
INSERT INTO TB_BOARD values (4,'게시글4', '내용4입니다', 'msa4', '2024-04-04 03:04:04', 0);

SELECT * FROM TB_BOARD;
commit;

COMMENT ON TABLE TB_MEMBER IS '회원정보';
COMMENT ON COLUMN TB_MEMBER.MEMBERID IS '회원아이디';

SELECT * FROM TB_MEMBER tm ;

INSERT INTO TB_MEMBER VALUES ('MSA1', 'MSA1', 'MSA1','Singok1','010-1111-1111','남',1);
INSERT INTO TB_MEMBER VALUES ('MSA2', 'MSA2', 'MSA2','Singok2','010-2222-2222','여',2);
INSERT INTO TB_MEMBER VALUES ('MSA3', 'MSA3', 'MSA3','Singok3','010-3333-3333','남',3);
INSERT INTO TB_MEMBER VALUES ('MSA4', 'MSA4', 'MSA4','Singok4','010-4444-4444','여',4);


DROP TABLE TB_MEMBER;

 CREATE USER 'bituser'@'localhost' IDENTIFIED BY '1004';
GRANT ALL PRIVILEGES ON *.* TO 'bituser'@'localhost';
 FLUSH PRIVILEGES;
 commit;