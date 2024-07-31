create database assignment;

--  QUESTION 1 
create table company(company_code varchar(20), founder varchar(20));
create table lead_manager(lead_manager_code varchar(20),company_code varchar(20));
create table senior_manager(senior_manager_code varchar(20),lead_manager_code varchar(20),company_code varchar(20));
create table manager(manager_code varchar(20),senior_manager_code varchar(20),lead_manager_code varchar(20),company_code varchar(20));
create table employee(employee_code varchar(20),manager_code varchar(20),senior_manager_code varchar(20),
lead_manager_code varchar(20),company_code varchar(20));
insert into company values("C1","Monika"),("C2","Samantha");
insert into lead_manager values("LM1","C1"),("LM2","C2");
insert into senior_manager values("SM1","LM1","C1"),("SM2","LM1","C1"),("SM3","LM2","C2");
insert into manager values("M1","SM1","LM1","C1"),("M2","SM3","LM2","C2"),("M3","SM3","LM2","C2");
insert into employee values("E1","M1","SM1","LM1","C1"),("E2","M1","SM1","LM1","C1"),("E3","M2","SM3","LM2","C2"),
("E4","M3","SM3","LM2","C2");

-- SOLUTION
select c.company_code, c.founder, count(distinct l.lead_manager_code) as lead_managers, 
count(distinct s.senior_manager_code)as senior_managers,
count(distinct m.manager_code) as managers, 
count(distinct e.employee_code)as employees
from company as c 
join lead_manager as l using(company_code) 
join senior_manager as s using(company_code)
join manager as m using(company_code) 
join employee as e using (company_code) 
group by c.company_code, c.founder
order by company_code asc;

-- QUESTION 2
create table students(ID int, Name varchar(50), Marks int);
create table grades(Grade int, Min_Marks int, Max_Marks int);
insert into students values( 1, "Julia",88),( 2, "Samantha",68),( 3, "Maria",99),( 4, "Scarlet",78),( 5, "Ashley",63),( 6, "Jane",81);
insert into grades values(1,0,9),(2,10,19),(3,20,29),(4,30,39),(5,40,49),(6,50,59),(7,60,69),(8,70,79),(9,80,89),(10,90,100);

-- SOLUTION 
select case
WHEN g.grade >= 8 THEN s.name
ELSE 'NULL'
END as Name, g.grade as Grade, s.marks as Marks from students s join grades g on s.marks<=g.max_marks 
and s.marks >=g.min_marks order by g.grade desc,
CASE
WHEN g.grade >= 8 THEN s.name
ELSE s.marks 
END asc;


-- QUESTION 3
create table hackers(hacker_id int, name varchar(50));
insert into hackers values(5580 ,"Rose"),(8439, "Angela"),(27205, "Frank"),( 52243, "Patrick"),
 (52348, "Lisa"), (57645, "Kimberly"),( 77726, "Bonnie"),( 83082, "Michael"),(86870, "Todd"),( 90411 ,"Joe");
create table difficulty(difficulty_level int, score int);
insert into difficulty values(1,20),(2,30),(3,40),(4,60),(5,80),(6,100),(7,120);
create table challenges(challenge_id int, hacker_id int, difficulty_level int);
insert into challenges values(4810,77726 ,4),(21089, 27205, 1),(36566, 5580, 7), (66730, 52243, 6), (71055, 52243, 2);
create table submissions(submission_id int ,challenge_id int, hacker_id int, score int);
insert into submissions values(68628, 77726, 36566 ,30), ( 65300 ,77726 ,21089, 10),  (40326, 52243 ,36566 ,77), ( 8941, 27205 ,4810 ,4),  
(83554, 77726, 66730 ,30 ), (43353, 52243, 66730, 0) , (55385, 52348, 71055, 20) ,( 39784 ,27205, 71055, 23), ( 94613, 86870, 71055, 30),  
(45788, 52348, 36566, 0 ),( 93058 ,86870, 36566 ,30 ),( 7344, 8439, 66730 ,92 ), (2721, 8439, 4810, 36) ,( 523, 5580 ,71055, 4),  
(49105 ,52348, 66730, 0 ),( 55877, 57645, 66730, 80),(38355, 27205 ,66730, 35), ( 3924, 8439, 36566, 80 ), (97397, 90411, 66730 ,100),  
(84162, 83082 ,4810, 40) ,( 97431, 90411, 71055 ,30);
select * from submissions;
select h.hacker_id , h.name  from hackers h join submissions s on h.hacker_id=s.hacker_id
join challenges c on s.challenge_id=c.challenge_id
join difficulty d on c.difficulty_level=d.difficulty_level where s.score=d.score group by h.hacker_id,h.name 
having count(s.score)=count(d.score) and sum(s.score)=sum(d.score) order by  h.hacker_id desc limit 1; 

select concat(hackers.hacker_id,' ', name) as Answer from hackers join submissions using(hacker_id) 
join challenges using(challenge_id) join difficulty using(difficulty_level) where submissions.score = difficulty.score 
group by answer having count(submissions.score) = count(difficulty.score)and sum(submissions.score) = sum(difficulty.score)
 order by answer desc limit 1;

-- QUESTION 4
create table student(id int, name varchar(50));
insert into student values (1,"Ashley"),(2,"Samantha"),(3,"Julia"),(4,"Scarlet");
create table friends(id int , friend_id int);
insert into friends values(1,2),(2,3),(3,4),(4,1);
create table packages(id int, salary float );
insert into packages values(1,15.20),(2,10.06),(3,11.55),(4,12.12);

-- SOLUTION 
select s.name from student s join friends f on s.id=f.id 
join packages ps on s.id=ps.id join packages pf on f.friend_id=pf.id
where pf.salary>ps.salary group by s.name, pf.salary order by pf.salary desc;

