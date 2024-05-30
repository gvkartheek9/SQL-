create database CustomerOrders;


create table customers(customerId Integer, name Varchar(20),email Varchar(30) PRIMARY KEY(customerId) );
create table orders(order_id INTEGER, customer_id integer,order_date Date, total_amount integer ,
PRIMARY KEY(order_id),
 Foreign Key(customer_id) References customers(customerId));

 select * from customers;
 select * from orders;

 ------inserting the values ;

 Insert into customers(customerId,name)Values(1,'John Smitch');
 Insert into customers(customerId,name)Values(2,'Jane Doe');
 Insert into customers(customerId,name)Values(3,'Alice Brown');

 ---------inserting the values to orders table 

 Insert into orders(order_id,customer_id,order_date,total_amount) Values(101,1,'2024-01-15',250);
 Insert into orders(order_id,customer_id,order_date,total_amount) Values(102,2,'2024-02-20',150);
 Insert into orders(order_id,customer_id,order_date,total_amount) Values(103,3,'2024-03-10',325);
 Insert into orders(order_id,customer_id,order_date,total_amount) Values(104,1,'2024-04-05',200);

 update orders set customer_id=3 where customer_id=1 and total_amount=200;


 select * from orders

 -------------------------------------------/
----to retrive all the cutomers along with the orders

select c.customerId,count(o.order_id) as orders from customers as c join orders as o on c.customerId=o.customer_id 
group by c.customerId
having count(o.order_id)>1;      ----the customers whos orders are >1;
---------------------------------------------------------------------------------------

select c.customerId,SUM(total_amount) as amount from customers as c join orders as o on c.customerId=o.customer_id 
group by c.customerId;


