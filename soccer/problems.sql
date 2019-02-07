-- -----------------------------------------------------------------------------

-- How many players have 'smith' anywhere in their name?

-- Note: SQLite's version of LIKE is case insensitive.

SELECT
  COUNT(*)
FROM Player
WHERE player_name LIKE '%smith%'

-- OR --

SELECT
  COUNT(*)
FROM Player
WHERE INSTR(LOWER(player_name), 'smith');

-- -----------------------------------------------------------------------------

-- How many players have Smith for their last name?

SELECT
  COUNT(*)
FROM Player
WHERE player_name LIKE '% Smith'

-- OR --

-- See https://stackoverflow.com/questions/11155886/split-firstname-and-lastname-in-sqlite

SELECT
  COUNT(*),
  SUBSTR(player_name, INSTR(player_name, ' ') + 1) AS last_name
FROM Player
WHERE last_name = 'Smith';

--- -----------------------------------------------------------------------------

-- Which team scored the most points when playing at home?

SELECT
  Team.team_long_name AS team_name,
  SUM(Match.home_team_goal) AS home_goals
FROM Team
INNER JOIN Match ON Match.home_team_api_id = Team.team_api_id
GROUP BY team_name
ORDER BY home_goals DESC

LIMIT 5;

-- -----------------------------------------------------------------------------

-- Did this team also score the most points when playing away?

SELECT
  Team.team_long_name AS team_name,
  SUM(Match.away_team_goal) AS away_goals
FROM Team
INNER JOIN Match ON Match.away_team_api_id = Team.team_api_id
GROUP BY team_name
ORDER BY away_goals DESC

LIMIT 5;

-- -----------------------------------------------------------------------------

-- How many matches resulted in a tie?

SELECT
  COUNT(*) AS num_tie_games
FROM Match
WHERE Match.home_team_goal = Match.away_team_goal;

-- -----------------------------------------------------------------------------

-- What percentage of players prefer their left or right foot?

SELECT
  preferred_foot,
  ROUND(
    100. * COUNT(preferred_foot) / SUM(COUNT(preferred_foot)) OVER(),
    2) AS percent
FROM Player_Attributes
GROUP BY preferred_foot;
