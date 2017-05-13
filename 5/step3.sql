-- 3-1.把peoples表中school不是GDUFS的人全部找出来？（包括school为NULL的人）写出MySQL语句。
select * from peoples where school != GDUFS or school is NULL;

-- 3-2.查找计算机系每次考试学生的平均成绩(最终显示学生姓名, 考试名称, 平均分)。
select exam.exam_name,avg(exam.grade) 
from students,exam
where exam.student_ID = students.ID and students.dept_name = 'computer'
group by exam.exam_name;

-- 3-3.查找女学霸（考试平均分达到80分或80分以上的女生的姓名, 分数）。
select students.name,avg(exam.grade)
from students,exam
where students.ID = exam.student_ID and students.sex = 'f'
group by students.name
having avg(exam.grade) >= 80;

-- 3-4.找出人数最少的院系以及其年度预算。
select department.dept_name,department.budget
from
(select d.dept_name from (select dept_name,count(ID) as n from students group by dept_name) d
where d.n = (select min(n) from (select dept_name,count(ID) from students group by dept_name) dd)) ddd
,department
where ddd.dept_name = department.dept_name;

-- 3-5.计算机系改名了，改成计算机科学系（comp. sci.），写出mysql语句。
update department set dept_name='computer.sci.'
where dept_name='computer';

-- 3-6.修改每个系的年度预算，给该系的每个学生发2000元奖金。（修改每个系的年度预算为 原预算+该系人数*2000）。
update department d,
(select dept_name,count(ID) as cou from students group by dept_name) tmp
set d.budget = d.budget + tmp.cou * 2000
where d.dept_name = tmp.dept_name;

-- 3-7.向department表中插入一条数据, dept_name属性的值为avg_budget, building为空, 年度预算为所有院系的年度预算平均值.
insert into department values ('avg_budget', NULL, NULL);
update department d,
(select avg(budget) as a from department where building is not NULL) tmp
set d.budget = tmp.a
where d.building is NULL;

-- 3-8'中考试成绩平均分低于70的学生.
delete from (
select ID,dept_name from students) as T2 
left join (
select distinct students_ID,grade from exam ) as T3
on T2.ID = T3.students_ID
where T2.dept_name ='computer' and avg(T3.grade) <70;

-- 3-9.找出所有正在谈恋爱,但是学习成绩不佳(考试平均分低于75)的学生,强制将其情感状态改为单身.
update students s,
(select student_ID, avg(grade) as a from exam group by student_ID) T1
set s.emotion_state='single'
where s.ID =T1.student_ID and T1.a < 75;

-- 3-10(选做). 对每个学生, 往exam表格中插入名为Avg_Exam的考试, 考试分数为之前学生参加过考试的平均分.
delimiter $$　　　　
drop procedure if exists wk;
create procedure wk()
begin
declare i int;
set i = 1;　　　　　 
while i < 20 do
insert into department values ('Avg_Exam', i, NULL);
update exam d,
(select avg(grade) as a from exam group by student_ID) tmp
set d.budget = tmp.a
where d.students_ID = tmp.ID and d.name = 'Avd_Exam';
set i = i +1; 
end while; 
end $$　　　　　




























