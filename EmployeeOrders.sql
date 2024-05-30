create database HumanResource;

create table Employees(employee_id Integer,name varchar(20),position varchar(20)
PRIMARY KEY (employee_id));


create table Departments(department_id Integer, department_name varchar(20)
PRIMARY KEY(department_id) );


create table  EmployeeDepartments(employee_department_id Integer,employee_id Integer,department_id Integer,
 start_date DATE ,end_date Date 
 PRIMARY KEY (employee_department_id),
 FOREIGN KEY (employee_id) References Employees(employee_id),
 foreign key (department_id) References Departments(department_id));

 create table Salaries(salary_id Integer,employee_id Integer,amount Integer,start_date varchar(20),end_date varchar(20)
 PRIMARY KEY ( salary_id),
 FOREIGN KEY (employee_id) References Employees(employee_id)
 );

 select * from Employees;
 select * from EmployeeDepartments;
 select * from Departments;
 select * from Salaries;



 ------------------------------------------Inserting the values to Employee;
  Insert into Employees(employee_id,name,position) Values(1,'Alice Brown','Manager');
 Insert into Employees(employee_id,name,position) Values(2,'Bob Smitch','Developer');
 Insert into Employees(employee_id,name,position) Values(3,'Charlie Day','Analyst');

 -------------------------------------------Inserting the values to the Departmenst;
 Insert into Departments(department_id,department_name) Values (1,'HR');
 Insert into Departments(department_id,department_name) Values (2,'IT');
 Insert into Departments(department_id,department_name) Values (3,'Finance');

  Insert into Departments(department_id,department_name) Values (4,'Finance');

----------------------------------------------------------------------------------Inserting into the EmployeeDepartments


Insert into EmployeeDepartments(employee_department_id,employee_id,department_id,start_date,end_date) 
   Values (2,2,2,'2023-03-01',NULL);

Insert into EmployeeDepartments(employee_department_id,employee_id,department_id,start_date,end_date) 
   Values (3,3,3,'2022-06-01',NULL);

   Insert into EmployeeDepartments(employee_department_id,employee_id,department_id,start_date,end_date) 
   Values (4,3,1,'2023-01-01','2023-12-31');

update EmployeeDepartments set end_date='2024-01-01' where department_id=3;

-----------------------------------------------------------------------;

Insert into Salaries(salary_id,employee_id,amount,start_date,end_date)
Values(1,1,70000,2022-01-01,NULL);

Insert into Salaries(salary_id,employee_id,amount,start_date,end_date)
Values(2,2,90000,2023-03-01,NULL);

Insert into Salaries(salary_id,employee_id,amount,start_date,end_date)
Values(3,3,80000,2022-06-01,2024-01-01);

update Salaries set start_date='2020-01-01' where start_date='2020';
update Salaries set start_date='2023-03-01' where start_date='2019';
update Salaries set start_date='2022-06-01' where start_date='2015';
  
 
 ----------------------------------------okay now do querys 

 select e.employee_id,ed.department_id,d.department_name from Employees as e 
 join EmployeeDepartments as ed on e.employee_id=ed.employee_id
 join Departments as d on ed.department_id=d.department_id;

 select e.employee_id,ed.department_id,d.department_name,sum(amount) from Employees as e 
 join EmployeeDepartments as ed on e.employee_id=ed.employee_id
 join Departments as d on ed.department_id=d.department_id
 join Salaries as s on e.employee_id=s.employee_id 
 group by e.employee_id,ed.department_id,d.department_name;

 ------------------------------------------------  Selecting the employees who worked on more than 1 department 

  select e.employee_id from Employees as e 
 join EmployeeDepartments as ed on e.employee_id=ed.employee_id
 join Departments as d on ed.department_id=d.department_id
 group by e.employee_id
 having count(ed.department_id)>1;