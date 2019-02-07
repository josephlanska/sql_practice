-- -----------------------------------------------------------------------------

-- Find the number of matches played by each player in each tournament.

CREATE VIEW TotalMatchesByTournament AS
SELECT
  Player,
  Gender,
  Tournament,
  COUNT(*) AS num_matches
FROM PlayerStats
GROUP BY Tournament, Gender, Player
ORDER BY Tournament, Gender, Player ASC;

-- -----------------------------------------------------------------------------

-- Who has played the most matches total?
-- Answer for both men and women.

WITH MostMatches AS (
  SELECT
    Player,
    Gender,
    SUM(num_matches) AS total_matches
  FROM TotalMatchesByTournament
  GROUP BY Player, Gender
  ORDER BY total_matches DESC
), MostMensMatches AS (
  SELECT
    Player,
    Gender,
    total_matches
  FROM MostMatches
  WHERE Gender = 'Men'
  LIMIT 5
), MostWomensMatches AS (
  SELECT
    Player,
    Gender,
    total_matches
  FROM MostMatches
  WHERE Gender = 'Women'
  LIMIT 5
)
SELECT * FROM MostMensMatches
UNION ALL
SELECT * FROM MostWomensMatches;

-- -----------------------------------------------------------------------------

-- Who has the highest first serve percentage for a single match?

SELECT
  Player,
  Gender,
  MAX(FirstServePercentage) AS max_first_serve_percentage
FROM PlayerStats
GROUP BY Player, Gender
ORDER BY max_first_serve_percentage DESC

LIMIT 10;

-- -----------------------------------------------------------------------------

-- Unforced error % is the percentage of points lost due to unforced errors.
-- What are the unforced error percentages of the players with the most wins?

-- Note: Unforced error data is not reported for the Men's US Open.

WITH TopPlayers AS (
  SELECT
    Player,
    COUNT(*) AS Wins
  FROM PlayerStats
  WHERE Won = 1
  GROUP BY Player
  ORDER BY Wins DESC
)
SELECT
  PlayerStats.Player AS name,
  PlayerStats.Gender AS gender,
  SUM(PlayerStats.Won) AS total_wins,
  ROUND(
    100. * SUM(PlayerStats.UnforcedErrors) / SUM(PlayerStats.TotalPointsLost),
    2) AS unforced_error_percentage
FROM PlayerStats
WHERE PlayerStats.Player IN (
  SELECT
    Player
  FROM TopPlayers
  LIMIT 10
)
GROUP BY name, gender
ORDER BY total_wins DESC;

-- -----------------------------------------------------------------------------
