-- -----------------------------------------------------------------------------

-- Combine all tournaments for men and women into a single table

CREATE VIEW AllTournaments AS

SELECT
  *,
  'Men' AS Gender,
  'Australian Open' AS Tournament
FROM AusOpen_Men

UNION ALL

SELECT
  *,
  'Women' AS Gender,
  'Australian Open' AS Tournament
FROM AusOpen_Women

UNION ALL

SELECT
  *,
  'Men' AS Gender,
  'French Open' AS Tournament
FROM FrenchOpen_Men

UNION ALL

SELECT
  *,
  'Women' AS Gender,
  'French Open' AS Tournament
FROM FrenchOpen_Women

UNION ALL

SELECT
  *,
  'Men' AS Gender,
  'US Open' AS Tournament
FROM USOpen_Men

UNION ALL

SELECT
  *,
  'Women' AS Gender,
  'US Open' AS Tournament
FROM USOpen_Women

UNION ALL

SELECT
  *,
  'Men' AS Gender,
  'Wimbledon' AS Tournament
FROM Wimbledon_Men

UNION ALL

SELECT
  *,
  'Women' AS Gender,
  'Wimbledon' AS Tournament
FROM Wimbledon_Women;

-- -----------------------------------------------------------------------------

-- Aggregate relevant stats for each player, regardless of whether they were
-- listed as Player1 or Player2.

-- Note:
-- Result is 1 if Player1 won
-- Result is 0 if Player2 won

CREATE VIEW Player1Stats AS
SELECT
  Player1 AS Player,
  Player2 AS Opponent,
  Gender,
  Tournament,
  Round AS Round_,
  Result AS Won,
  FNL1 AS TotalGamesWon,
  FSP_1 AS FirstServePercentage,
  FSW_1 AS FirstServeWon,
  SSP_1 AS SecondServePercentage,
  SSW_1 AS SecondServeWon,
  ACE_1	AS AcesWon,
  DBF_1	AS DoubleFaults,
  WNR_1	AS WinnersEarned,
  UFE_1 AS UnforcedErrors,
  BPC_1	AS BreakPointsCreated,
  BPW_1	AS BreakPointsWon,
  NPA_1	AS NetPointsAttempted,
  NPW_1	AS NetPointsWon,
  TPW_1	AS TotalPointsWon,
  TPW_2 AS TotalPointsLost,
  ST1_1	AS Set1,
  ST2_1	AS Set2,
  ST3_1	AS Set3,
  ST4_1	AS Set4,
  ST5_1	AS Set5
FROM AllTournaments;

CREATE VIEW Player2Stats AS
SELECT
  Player2 AS Player,
  Player1 AS Opponent,
  Gender,
  Tournament,
  Round AS Round_,
  (CASE WHEN Result = 0
        THEN 1
        ELSE 0
  END) AS Won,
  FNL2 AS TotalGamesWon,
  FSP_2 AS FirstServePercentage,
  FSW_2 AS FirstServeWon,
  SSP_2 AS SecondServePercentage,
  SSW_2 AS SecondServeWon,
  ACE_2	AS AcesWon,
  DBF_2	AS DoubleFaults,
  WNR_2	AS WinnersEarned,
  UFE_2 AS UnforcedErrors,
  BPC_2	AS BreakPointsCreated,
  BPW_2	AS BreakPointsWon,
  NPA_2	AS NetPointsAttempted,
  NPW_2	AS NetPointsWon,
  TPW_2	AS TotalPointsWon,
  TPW_1 AS TotalPointsLost,
  ST1_2	AS Set1,
  ST2_2	AS Set2,
  ST3_2	AS Set3,
  ST4_2	AS Set4,
  ST5_2	AS Set5
FROM AllTournaments;

CREATE VIEW PlayerStats AS
SELECT
  *
FROM Player1Stats
UNION ALL
SELECT
  *
FROM Player2Stats
ORDER BY Player;

-- -----------------------------------------------------------------------------
