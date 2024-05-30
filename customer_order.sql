
create table customers(customer_id Integer, customer_name varchar(20),
 Primary key(customer_id) );

 create table orders(order_id Integer,customer_id Integer , total_amount Integer
 PRIMARY KEY(order_id) foreign key(customer_id) references customers(customer_id));

select * from orders;
select * from customers;

Insert into orders(order_id,customer_id,total_amount) values (1,1,120);
Insert into orders(order_id,customer_id,total_amount) values (2,1,100);
Insert into orders(order_id,customer_id,total_amount) values (3,1,30);
Insert into orders(order_id,customer_id,total_amount) values (4,2,60);
Insert into orders(order_id,customer_id,total_amount) values (5,3,10);
Insert into orders(order_id,customer_id,total_amount) values (6,4,120);

update orders  set customer_id=3 where customer_id=4;

select customer_name from customers where customer_id IN(
select  customer_id from orders group by customer_id having count(order_id)>1);

select * from orders;
select * from customers;


Insert into customers(customer_id,customer_name)Values(1,'k');
Insert into customers(customer_id,customer_name)Values(2,'l');
Insert into customers(customer_id,customer_name)Values(3,'m');
Insert into customers(customer_id,customer_name)Values(4,'n');