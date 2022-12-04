use football_database;


drop table if exists uefa_champions_league;
CREATE TABLE uefa_champions_league(
    YearOfCompetition YEAR PRIMARY KEY,
    Champions VARCHAR(50) NOT NULL,
    HighestScorer VARCHAR(50) NOT NULL,
    HighestNumberOfGoals INT NOT NULL,
    HighestAssists VARCHAR(50) NOT NULL,
    HighestNumberOfAssists INT NOT NULL
)
;
insert into uefa_champions_league values(
2010,
'Barcelona',
'Lionel Messi',
12,
'Mesut Ozil',
6
);

insert into uefa_champions_league values(2011,'Chelsea','Lionel Messi',14,'Kaka',5);
insert into uefa_champions_league values(2012,'Bayern Munich','Cristiano Ronaldo',12,'Zlatan Ibrahimović',7);
insert into uefa_champions_league values(2013,'Real Madrid','Cristiano Ronaldo',17,'Wayne Rooney',8);
insert into uefa_champions_league values(2014,'Barcelona','Neymar Jr',10,'Lionel Messi',7);
insert into uefa_champions_league values(2015,'Real Madrid','Cristiano Ronaldo',16,'Kingsley Coman',5);
insert into uefa_champions_league values(2016,'Real Madrid','Cristiano Ronaldo',12,'Neymar Jr',8);
insert into uefa_champions_league values(2017,'Real Madrid','Cristiano Ronaldo',15,'James Milner',9);
insert into uefa_champions_league values(2018,'Liverpool','Messi',12,'Leroy Sane',5);
insert into uefa_champions_league values(2019,'Bayern Munich','Robert Lewandowski',15,'Ángel Di María',6);

SELECT 
    *
FROM
    uefa_champions_league;
-- Highest Scorer Of The Decade--
SELECT 
    highestscorer AS Highest_Scorer_Of_The_Decade,
    highestnumberofgoals AS GOALS
FROM
    uefa_champions_league
WHERE
    highestnumberofgoals = (SELECT 
            MAX(highestnumberofgoals)
        FROM
            uefa_champions_league);
 
 -- Highest Assists Of The Decade -- 
SELECT 
    highestassists AS Highest_Assists_Of_The_Decade,
    highestnumberofassists AS ASSISTS
FROM
    uefa_champions_league
ORDER BY highestnumberofassists DESC
LIMIT 1;

SELECT 
    Champions, COUNT(champions) AS NumberOfTimesWon
FROM
    uefa_champions_league
GROUP BY champions
ORDER BY COUNT(champions) DESC;

-- table 1 queries done!
-- step 2: create and query table for la liga and try some more
-- CLubs with most wins in the decade(la liga)--

drop table if exists laliga_santander;
CREATE TABLE laliga_santander (
    YearOfCompetition YEAR PRIMARY KEY,
    Champions VARCHAR(50) NOT NULL,
    Runners_Up VARCHAR(50) NOT NULL,
    HighestScorer VARCHAR(50) NOT NULL,
    HighestNumberOfGoals INT NOT NULL
);
insert into laliga_santander values(2010,'Barcelona','Real Madrid','Cristiano Ronaldo',40);
insert into laliga_santander values(2011,'Real Madrid','Barcelona','Messi',50);
insert into laliga_santander values(2012,'Barcelona','Real Madrid','Cristiano Ronaldo',34);
insert into laliga_santander values(2013,'Athletico Madrid','Barcelona','Cristiano Ronaldo',31);
insert into laliga_santander values(2014,'Barcelona','Real Madrid','Cristiano Ronaldo',48);
insert into laliga_santander values(2015,'Barcelona','Real Madrid','Luis Suarez',40);
insert into laliga_santander values(2016,'Real Madrid','Barcelona','Lionel Messi',37);
insert into laliga_santander values(2017,'Barcelona','Athletico Madrid','Lionel Messi',34);
insert into laliga_santander values(2018,'Barcelona','Athletico Madrid','Lionel Messi',36);
insert into laliga_santander values(2019,'Real Madrid','Barcelona','Lionel Messi',25);

SELECT 
    *
FROM
    laliga_santander;

-- Team that has won the most number of times --
SELECT 
    Champions, COUNT(champions) Number_Of_Titles_Won
FROM
    laliga_santander
GROUP BY champions
ORDER BY COUNT(champions) DESC;

-- Top 3 scorers --
SELECT 
    highestscorer AS HighestGoalScorersOfTheDecade,
    highestnumberofgoals AS GOALS,
    YearOfCompetition
FROM
    laliga_santander
ORDER BY highestnumberofgoals DESC
LIMIT 3;


-- Now join the two tables --

select * from laliga_santander;
select * from uefa_champions_league;

SELECT 
    l.YearOfCompetition,
    l.champions AS ChampionsOfLaliga,
    l.highestscorer AS HighestGoalsScoredBY_LaLiga,
    u.champions AS ChampionsOfUCL,
    u.highestscorer AS HighestGoalsScoredBY_UCL
FROM
    laliga_santander l
        INNER JOIN
    uefa_champions_league u ON l.YearofCompetition = u.YearOfCompetition;

