-- 디비자자-Phase2-1.sql
-- 디비자자 DDL


CREATE TABLE USERS
(
id VARCHAR(20) NOT NULL,
password VARCHAR(20) NOT NULL,
birthday DATE NOT NULL,
name VARCHAR(10) NOT NULL,
profile_photo VARCHAR(100),
PRIMARY KEY (id)
);

CREATE TABLE Diary
(
diary_key NUMBER NOT NULL,
diary_content VARCHAR(1000),
DIARY_date DATE NOT NULL,
id VARCHAR(20) NOT NULL,--
date_Key number not null,--
PRIMARY KEY(diary_key)
);

CREATE TABLE ATTACHED_FILE
(
file_name VARCHAR(100) NOT NULL,
file_size NUMBER NOT NULL,
extension VARCHAR(6) NOT NULL,
diary_key NUMBER NOT NULL,
PRIMARY KEY(file_name)
);

Create table  day_record
(
date_Key number not null,
record_date Date not null,
schedule  varchar(30),
schedule_content varchar(200),
color number default 1 not null,
group_id varchar(20) not null,
question_key Number not null,
primary key(date_Key)
);

Create table Calendar
(
group_id varchar(20) not null,
createdAt Date,
password varchar(4),
primary key(group_id)
);

Create table Question
(
question_key Number not null,
question_content varchar(100) not null,
primary key(question_key)
);

CREATE TABLE VOTE
(
vote_key NUMBER NOT NULL,
vote_name VARCHAR(20) NOT NULL,
deadline DATE,
date_Key number not null,
group_id varchar(20) not null,
PRIMARY KEY (vote_key)
);

CREATE TABLE ITEM
(
item_key NUMBER NOT NULL,
item_name VARCHAR(30) NOT NULL,
vote_key NUMBER NOT NULL,
PRIMARY KEY(item_key)
);

Create table participate
(
group_id varchar(20) not null,
participant varchar(20) not null,
primary key(group_id, participant)
);

Create table Answer
(
id VARCHAR(20) NOT NULL,
question_key number not null,
user_answer varchar(500),
primary key(id, question_key)
);

CREATE TABLE PICK
(
user_id VARCHAR(20) NOT NULL,
item_key NUMBER NOT NULL,
PRIMARY KEY(user_id, item_key)
);


ALTER TABLE PARTICIPATE ADD CONSTRAINT FK1 FOREIGN KEY (PARTICIPANT) references USERS(ID) ON DELETE CASCADE;
ALTER TABLE PARTICIPATE ADD CONSTRAINT FK2 FOREIGN KEY (GROUP_ID) references CALENDAR(GROUP_ID) ON DELETE CASCADE;
AlTER table answer add constraint FK3 foreign key (id) references users(id)on delete cascade;
AlTER table answer add constraint FK4 foreign key (question_key) references question(question_key)on delete cascade;
ALTER TABLE PICK ADD CONSTRAINT FK5 FOREIGN KEY (USER_ID) references USERS(ID) ON DELETE CASCADE;
ALTER TABLE PICK ADD CONSTRAINT FK6 FOREIGN KEY (ITEM_KEY) references ITEM(ITEM_KEY) ON DELETE CASCADE;


ALTER TABLE DAY_RECORD ADD CONSTRAINT FK7 FOREIGN KEY (GROUP_ID) references CALENDAR(GROUP_ID) ON DELETE CASCADE;
ALTER TABLE DAY_RECORD ADD CONSTRAINT FK8 FOREIGN KEY (QUESTION_KEY) references QUESTION(QUESTION_KEY) ON DELETE CASCADE;
ALTER TABLE DIARY ADD CONSTRAINT FK9 FOREIGN KEY (ID) references USERS(ID) ON DELETE CASCADE;
ALTER TABLE DIARY ADD CONSTRAINT FK10 FOREIGN KEY (DATE_KEY) references DAY_RECORD(DATE_KEY) ON DELETE CASCADE;
ALTER TABLE VOTE ADD CONSTRAINT FK11 FOREIGN KEY (DATE_KEY) references DAY_RECORD(DATE_KEY) ON DELETE CASCADE;
ALTER TABLE ATTACHED_FILE ADD CONSTRAINT FK12 FOREIGN KEY (DIARY_KEY) references DIARY(DIARY_KEY) ON DELETE CASCADE;
