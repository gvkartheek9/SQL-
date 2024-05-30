create table Hackers(hacker_id Integer, name varchar(10));


---Inserting the values;


Insert into Hackers(hacker_id,name) Values(21283,'Angela');
Insert into Hackers(hacker_id,name) Values(62743,'Frank');
Insert into Hackers(hacker_id,name) Values(88255,'Patrik');
Insert into Hackers(hacker_id,name) Values(96196,'Lisa');

select * from Hackers;


create table challenges(challenge_id Integer,hacker_id Integer);

---Inserting the values to challenges table ;

Insert into challenges