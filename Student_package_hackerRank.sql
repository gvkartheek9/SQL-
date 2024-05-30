create table students(student_id Integer, name varchar(20) primary key (student_id));

create table friends(id Integer, friend_id Integer primary key(id));

create table packages(id Integer,salary Integer primary key(id)) ;

select * from students ;
select * from friends;
select * from packages;

-----Inserting into students 

Insert into students(student_id,name) values(1,'Ashley');
Insert into students(student_id,name) values(2,'Samantha');
Insert into students(student_id,name) values(3,'Julia');
Insert into students(student_id,name) values(4,'Scarlet');

--------inserting into the friends;

Insert into friends(id,friend_id) values(1,2);
Insert into friends(id,friend_id) values(2,3);
Insert into friends(id,friend_id) values(3,4);
Insert into friends(id,friend_id) values(4,1);

---------inserting into the salary table ;

Insert into packages(id, salary) values(1,15);
Insert into packages(id, salary) values(2,10);
Insert into packages(id, salary) values(3,11);
Insert into packages(id, salary) values(4,12);

select * from packages;
select * from students;
select * from friends;

;with student as(
select s.name,f.friend_id,p.salary  from students as s join friends as f on s.student_id=f.id
join packages as p on s.student_id=p.id ),
friends as
(
)
select student s inner joiin
;


with student as (
select s.student_id,s.name,p.salary  from students as s 
join packages as p on s.student_id=p.id),
friend as (
  select f.id as student_id, f.friend_id, p.salary as friend_sal from friends as f join packages as p on f.friend_id=p.id
 )
 select * from student as s join friend as f on s.student_id=f.student_id where s.salary<f.friend_sal;
 

