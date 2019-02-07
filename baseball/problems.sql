-- -----------------------------------------------------------------------------

-- What was the total spent on salaries by each team, each year?

SELECT
  teamid,
  yearid,
  SUM(salary) AS total_salary
FROM Salaries
GROUP BY teamid, yearid
ORDER BY yearid DESC;

-- -----------------------------------------------------------------------------

-- What were the min, max, median, and average salaries for each team each year?

-- Note: The median is the 50th percentile by definition.

SELECT
  teamid,
  yearid,
  MIN(salary) AS min_salary,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary,
  ROUND(AVG(salary::NUMERIC), 0) AS avg_salary,
  MAX(salary) AS max_salary
FROM Salaries
GROUP BY teamid, yearid
ORDER BY yearid DESC;

-- -----------------------------------------------------------------------------

-- How many players have no salary information available?

SELECT
  COUNT(*)
FROM People
LEFT JOIN Salaries ON People.playerid = Salaries.playerid
WHERE Salaries.playerid IS NULL;

-- -----------------------------------------------------------------------------

-- What is the first and last year played for each player?

SELECT
  People.namefirst,
  People.namelast,
  MIN(Fielding.yearid) AS first_year,
  MAX(Fielding.yearid) AS last_year
FROM Fielding
INNER JOIN People ON People.playerid = Fielding.playerid
GROUP BY People.playerid;

-- OR --

SELECT
  namefirst AS first_name,
  namelast AS last_name,
  EXTRACT(YEAR FROM CAST(debut AS DATE)) AS first_year,
  EXTRACT(YEAR FROM CAST(finalgame AS DATE)) AS last_year
FROM People
GROUP BY playerid;

-- -----------------------------------------------------------------------------

-- What is the distribution of debut months?

SELECT
  EXTRACT(MONTH FROM DATE(debut)) AS debut_month,
  COUNT(*) AS num_players
FROM People
WHERE debut IS NOT NULL
GROUP BY debut_month
ORDER BY debut_month;

-- -----------------------------------------------------------------------------

-- Which players have had the longest careers?

SELECT
  playerid,
  debut,
  finalgame,
  ROUND((DATE(finalgame) - DATE(debut))/365., 2) AS career_years
FROM People
WHERE
  finalgame IS NOT NULL
  AND debut IS NOT NULL
ORDER BY career_years DESC

LIMIT 10;

-- -----------------------------------------------------------------------------

-- Who played in the most all star games?

SELECT
  playerid,
  COUNT(*) as total_games
FROM AllstarFull
GROUP BY playerid
ORDER BY total_games DESC

LIMIT 10;

-- -----------------------------------------------------------------------------

-- Which school has generated the most players?

-- Note: DISTINCT is necessary because many players played multiple years in college

SELECT
  schoolid,
  COUNT(DISTINCT(playerid)) as num_players
FROM CollegePlaying
GROUP BY schoolid
ORDER BY num_players DESC

LIMIT 10;

-- -----------------------------------------------------------------------------
