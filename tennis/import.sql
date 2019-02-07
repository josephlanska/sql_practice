-- -----------------------------------------------------------------------------

CREATE TABLE  AusOpen_men (
  player1 VARCHAR(255),
  player2 VARCHAR(255),
  round INT,
  result INT,
  fnl1 DOUBLE PRECISION,
  fnl2 DOUBLE PRECISION,
  fsp_1 DOUBLE PRECISION,
  fsw_1 DOUBLE PRECISION,
  ssp_1 DOUBLE PRECISION,
  ssw_1 DOUBLE PRECISION,
  ace_1 INT,
  dbf_1 INT,
  wnr_1 INT,
  ufe_1 INT,
  bpc_1 INT,
  bpw_1 INT,
  npa_1 INT,
  npw_1 INT,
  tpw_1 INT,
  st1_1 INT,
  st2_1 INT,
  st3_1 INT,
  st4_1 INT,
  st5_1 INT,
  fsp_2 DOUBLE PRECISION,
  fsw_2 DOUBLE PRECISION,
  ssp_2 DOUBLE PRECISION,
  ssw_2 DOUBLE PRECISION,
  ace_2 INT,
  dbf_2 INT,
  wnr_2 INT,
  ufe_2 INT,
  bpc_2 INT,
  bpw_2 INT,
  npa_2 INT,
  npw_2 INT,
  tpw_2 INT,
  st1_2 INT,
  st2_2 INT,
  st3_2 INT,
  st4_2 INT,
  st5_2 INT
);

CREATE TABLE AusOpen_women
(LIKE AusOpen_men);

CREATE TABLE FrenchOpen_men
(LIKE AusOpen_men);

CREATE TABLE FrenchOpen_women
(LIKE AusOpen_men);

CREATE TABLE USOpen_men
(LIKE AusOpen_men);

CREATE TABLE USOpen_women
(LIKE AusOpen_men);

CREATE TABLE Wimbledon_men
(LIKE AusOpen_men);

CREATE TABLE Wimbledon_women
(LIKE AusOpen_men);

-- -----------------------------------------------------------------------------

COPY AusOpen_men
FROM '/path/AusOpen-men-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY AusOpen_women
FROM '/path/AusOpen-women-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY FrenchOpen_men
FROM '/path/FrenchOpen-men-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY FrenchOpen_women
FROM '/path/FrenchOpen-women-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY USOpen_men
FROM '/path/USOpen-men-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY USOpen_women
FROM '/path/USOpen-women-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY Wimbledon_men
FROM '/path/Wimbledon-men-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

COPY Wimbledon_women
FROM '/path/Wimbledon-women-2013.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

-- -----------------------------------------------------------------------------
