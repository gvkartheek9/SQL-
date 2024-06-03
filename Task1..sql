
create table orders(order_id Integer,customer_id Integer, order_date Date,product_id Integer,quantity Integer,
PRIMARY KEY(order_id),
foreign key(customer_id) references customers(customer_id),
foreign key(product_id) references products(product_id) );

create table customers(customer_id Integer,customer_name varchar(20)
PRIMARY KEY(customer_id));

select * from customers;

create table products(product_id Integer,price Integer
PRIMARY KEY(product_id));

select * from products;
select * from customers;
select * from orders;

insert into products(product_id,price) values(1,200);
insert into products(product_id,price) values(2,100);
insert into products(product_id,price) values(3,300);

insert into customers(customer_id,customer_name) values(1,'c1');
insert into customers(customer_id,customer_name) values(2,'c2');
insert into customers(customer_id,customer_name) values(3,'c3');
insert into customers(customer_id,customer_name) values(4,'c4');

insert into orders(order_id,customer_id,order_date,product_id,quantity) values(1,1,'2023-01-01',3,3);
insert into orders(order_id,customer_id,order_date,product_id,quantity) values(2,2,'2023-01-03',2,1);
insert into orders(order_id,customer_id,order_date,product_id,quantity) values(3,3,'2023-01-03',1,1);
insert into orders(order_id,customer_id,order_date,product_id,quantity) values(4,4,'2023-01-04',2,4);


------------Alterting the orders table
update orders set quantity=2 where order_id=4;
------------------updating the 4th order_id to see the working of dense_rank();

------------------we should add the product_name to the table 

alter table products add product_name varchar(50);
select* from products;

update products set product_name='product1' where product_id=1;

update products set product_name='product2' where product_id=2;
update products set product_name='product3' where product_id=3;


select *,(p.price*o.quantity) as total_spent from orders  as o
join products as p on o.product_id=p.product_id
join customers as c on o.customer_id=c.customer_id;

select TOP(3) *,(p.price*o.quantity) as total_spent
from orders  as o
join products as p on o.product_id=p.product_id
join customers as c on o.customer_id=c.customer_id
order by total_spent desc;


with m1 as(
select TOP(3) *,(p.price*o.quantity) as total_spent
from orders  as o
join products as p on o.product_id=p.product_id
join customers as c on o.customer_id=c.customer_id
order by total_spent desc);

select * from m1;

ROW_NUMBER() OVER ( ORDER BY total_spent DESC) AS rankNumber


------retrieving the customer_name,total_spent,rank;

select m1.* , 
ROW_NUMBER() over(order by total_spent desc) as rank
from(
select TOP(3) c.customer_name,(p.price*o.quantity) as total_spent
from orders  as o
join products as p on o.product_id=p.product_id
join customers as c on o.customer_id=c.customer_id
order by total_spent desc) as m1;


select m1.* , 
DENSE_RANK() over(order by total_spent desc) as rank
from(
select TOP(3) c.customer_name,(p.price*o.quantity) as total_spent
from orders  as o
join products as p on o.product_id=p.product_id
join customers as c on o.customer_id=c.customer_id
order by total_spent desc) as m1;
------------------------------------------------
-------If a customer  ordered two products will that be counting on total spent or not lets find by 
--------updating the  values in the table. 

insert into orders(order_id,customer_id,order_date,product_id,quantity) values(5,3,'2023-01-05',3,1);

select * from orders;

select m1.* , 
DENSE_RANK() over(order by total_spent desc) as rank
from(
select TOP(3) c.customer_name,(p.price*o.quantity) as total_spent
from orders  as o
join products as p on o.product_id=p.product_id
join customers as c on o.customer_id=c.customer_id
order by total_spent desc) as m1;

with cte1
as (
       select o.customer_id,p.product_id,o.quantity,p.price,sum(p.price*o.quantity) as amount,p.product_name from orders as o
	   join products as p on o.product_id=p.product_id 
	  group by o.customer_id,p.product_id,o.quantity,p.price,p.product_name;
  ),
 cte2 as (
  select customer_id,
   STUFF(
  (select ','+product_name 
     from cte1 as c1
	 where c2.customer_id=c1.customer_id
	 for XML PATH(''),TYPE).value('.','NVARCHAR(MAX)')
	 ,1,1,'') as products_names , SUM(amount)  as total_amount  
	 from cte1 as c2  group by customer_id
 )

 select TOP(3)  customer_id,products_names,total_amount,
 DENSE_RANK() over(order by total_amount desc) as rank
 from cte2;


