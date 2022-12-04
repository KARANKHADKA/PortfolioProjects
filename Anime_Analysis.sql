use Anime_Analysis;

-- Top 10 Anime based on ratings --
SELECT
    *
FROM
    anime
ORDER BY score desc;

-- Anime 10 tv shows in decending order of members --

SELECT Top 20
    Name, Score, Genres, Episodes, Ranked, members
FROM
    anime
WHERE
    type = 'tv'
ORDER BY members DESC;

-- Anime tv shows with highest number of episodes and score above 7--
SELECT top 20
    Name, Score, Genres, Episodes, Ranked, members
FROM
    anime
WHERE
    type = 'tv' and score > 7
ORDER BY episodes DESC;

-- Anime watching vs dropped vs completed--
SELECT 
    name, type, episodes, members, watching, dropped, completed,
    (watching / members) * 100 AS WatchingPercetage,
    (dropped / members) * 100 AS DroppedPercetage,
    (completed / members) * 100 AS CompletedPercentage
FROM
    anime
ORDER BY members DESC;

-- Anime watching vs dropped vs completed(only tv shows)--
SELECT 
    name, episodes, members, watching, dropped, completed,
    (watching / members) * 100 AS WatchingPercetage,
    (dropped / members) * 100 AS DroppedPercetage,
    (completed / members) * 100 AS CompletedPercentage
FROM
    anime
WHERE
    type = 'tv'
ORDER BY 9 DESC;

--Information about my favourite animes--
SELECT 
    name, type, episodes, members, watching, dropped, completed,
    (watching / members) * 100 AS WatchingPercetage,
    (dropped / members) * 100 AS DroppedPercetage,
    (completed / members) * 100 AS CompletedPercentage
FROM
    anime
WHERE
	type = 'tv' and (name like 'dragon ball%' or name like 'naruto%' or name like 'death note%'
	or name like 'one punch%' or name like 'bleach%')
ORDER BY 10 DESC;
