create table employees(emp_id Integer,emp_name varchar(20), salary varchar(20), dept_id Integer
 PRIMARY KEY(emp_id));

create table departments(dept_id Integer,dept_name Integer
 PRIMARY KEY(dept_id));

select * from employees ;
select * from departments;

Alter table employees Alter column salary Integer;

Insert into employees(emp_id,emp_name,salary,dept_id)Values(1,'john',20,1);
Insert into employees(emp_id,emp_name,salary,dept_id)Values(2,'san',30,1);
Insert into employees(emp_id,emp_name,salary,dept_id)Values(3,'khan',20,2);
Insert into employees(emp_id,emp_name,salary,dept_id)Values(4,'tam',30,3);
Insert into employees(emp_id,emp_name,salary,dept_id)Values(5,'lam',30,4);
Insert into employees(emp_id,emp_name,salary,dept_id)Values(6,'Gaary',20,4);

select * from employees;
select SUM(salary) from employees group by dept_id;

----the highest salary of the department ;