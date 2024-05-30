create table hackers(
   hacker_id Integer NOT NULL,
   name  varchar(50),
   PRIMARY KEY(hacker_id)
);


select * from hackers;

Insert into hackers(hacker_id,name) values(5077,'rose');

Insert into hackers(hacker_id,name) values(21283,'Angela');
Insert into hackers(hacker_id,name) values(62743,'Frank');
Insert into hackers(hacker_id,name) values(88255,'Patrick');
Insert into hackers(hacker_id,name) values(96196,'Lisa');

----------------;

create table challenges(
     hacker_id Integer,
	 challenge_id Integer ,
	 Primary Key(challenge_id),
	 FOREIGN KEY(hacker_id) References hackers(hacker_id) 
)

--Inserting into the challenges;

Insert into challenges(challenge_id,hacker_id) Values (74467,21283);
Insert into challenges(challenge_id,hacker_id) Values (33625,96196);
Insert into challenges(challenge_id,hacker_id) Values (26053,88255);
Insert into challenges(challenge_id,hacker_id) Values (42665,62743);
Insert into challenges(challenge_id,hacker_id) Values (12859,62743);
Insert into challenges(challenge_id,hacker_id) Values (70094,21283);
Insert into challenges(challenge_id,hacker_id) Values (34599,88255);
Insert into challenges(challenge_id,hacker_id) Values (54680,88255);
Insert into challenges(challenge_id,hacker_id) Values (61881,5077);



select * from hackers;
select * from challenges;

select h.hacker_id,h.name,count(challenge_id) as [no of challenges] from hackers as h
join challenges as c on h.hacker_id = c.hacker_id 
group by h.hacker_id,h.name;

----here I am getting the count;


select h.hacker_id,h.name,count(challenge_id) as [no of challenges] from hackers as h
join challenges as c on h.hacker_id = c.hacker_id 
group by h.hacker_id,h.name
order by [no of challenges] desc ;  --- I will be able to extract data based on no of challenges desc;


select h.hacker_id,h.name,count(challenge_id) as [no of challenges] from hackers as h
join challenges as c on h.hacker_id = c.hacker_id 
group by h.hacker_id,h.name
order by [no of challenges] desc,hacker_id ;  --- I will be able to extract data based on no of challenges desc 
                                              --- after that if two people are having same no of challenges then I will be 
											  ---- able to sort them using hacker id;

select h.hacker_id,h.name,count(challenge_id) as [no of challenges] from hackers as h
join challenges as c on h.hacker_id = c.hacker_id 
group by h.hacker_id,h.name
having count(c.challenge_id) = MAX(count(c.challenge_id))
order by [no of challenges] desc,hacker_id ;

select hacker_id,count(challenge_id) as [NO of challenges done by hackers] from challenges group by hacker_id ;

WITH HackerChallenges AS (
    SELECT h.hacker_id, h.name, COUNT(c.challenge_id) AS no_of_challenges
    FROM hackers AS h
    JOIN challenges AS c ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
),
TopChallenges AS (
    SELECT TOP 1 no_of_challenges
    FROM HackerChallenges
    ORDER BY no_of_challenges DESC
),
FilteredHackers AS (
    SELECT *
    FROM HackerChallenges
    WHERE no_of_challenges = (SELECT no_of_challenges FROM TopChallenges)
    UNION
    SELECT *
    FROM HackerChallenges
    WHERE no_of_challenges != (SELECT no_of_challenges FROM TopChallenges)
)
SELECT hacker_id, name, no_of_challenges
FROM FilteredHackers
ORDER BY no_of_challenges DESC, hacker_id;



WITH ChallengeCounts AS ( SELECT h.hacker_id, h.name, COUNT(c.challenge_id) AS no_of_challenges FROM hackers AS h JOIN challenges AS c ON h.hacker_id = c.hacker_id GROUP BY h.hacker_id, h.name ), RankedChallenges AS ( SELECT hacker_id, name, no_of_challenges, DENSE_RANK() OVER (ORDER BY no_of_challenges DESC) AS challenge_rank, ROW_NUMBER() OVER (PARTITION BY no_of_challenges ORDER BY hacker_id) AS row_num FROM ChallengeCounts ) SELECT hacker_id, name, no_of_challenges FROM RankedChallenges WHERE challenge_rank = 1 OR (challenge_rank > 1 AND row_num = 1) ORDER BY no_of_challenges DESC, hacker_id;

WITH
    ChallengeCounts AS (
        SELECT h.hacker_id, h.name, COUNT(c.challenge_id) AS no_of_challenges
        FROM hackers AS h
            JOIN challenges AS c ON h.hacker_id = c.hacker_id
        GROUP BY
            h.hacker_id,
            h.name
    ),
    RankedChallenges AS (
        SELECT
            hacker_id,
            name,
            no_of_challenges,
            DENSE_RANK() OVER (
                ORDER BY no_of_challenges DESC
            ) AS challenge_rank,
            ROW_NUMBER() OVER (
                PARTITION BY
                    no_of_challenges
                ORDER BY hacker_id
            ) AS row_num
        FROM ChallengeCounts
    )
SELECT
    hacker_id,
    name,
    no_of_challenges
FROM RankedChallenges
WHERE
    challenge_rank = 1
    OR (
        challenge_rank > 1
        AND row_num = 1
    )
ORDER BY no_of_challenges DESC, hacker_id;
