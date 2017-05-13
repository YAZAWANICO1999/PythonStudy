-- 建立department表

CREATE TABLE department
(
	dept_name varchar(255) NOT NULL,
    building varchar(10),
    budget int(6),
    primary key(dept_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 建立students表

CREATE TABLE students
(
	ID int(255) NOT NULL,
    name varchar(20),
    sex char(1),
    age int(3),
    emotion_state varchar(20),
    dept_name varchar(255),
	foreign key(dept_name) references department(dept_name)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    primary key(ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 建立exam表

CREATE TABLE exam
(
	student_ID int(255) NOT NULL,
    exam_name varchar(20) NOT NULL,
    grade int(5),
    foreign key(student_ID) references students(ID)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    primary key(student_ID, exam_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
 select * from students;









