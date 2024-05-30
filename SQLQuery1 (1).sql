select h.hacker_id,c.challenge_id,s.submissions_id,d.difficulty_level,d.score from hackers as h
join submissions as s on h.hacker_id=s.hacker_id
join challenges as c on s.challenge_id=c.challenge_id
join difficulti as d on c.difficulty_level=d.difficulty_level and s.score=d.score
group by h.hacker_id,c.challenge_id,s.submissions_id,d.difficulty_level,d.score;

----group by h.hacker_id,h.name;
---having count(*)>1;


select * from hackers as h
join submissions as s on h.hacker_id=s.hacker_id
join challenges as c on s.challenge_id=c.challenge_id;

select * from submissions;

update submissions set challenge_id=4810 where submissions_id=2721 and hacker_id=8439;

select * from challenges;