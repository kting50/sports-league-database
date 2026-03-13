CREATE TABLE `Divisions` (
  `division_id` INT AUTO_INCREMENT,
  `division_name` VARCHAR(255),
  PRIMARY KEY (`division_id`) 
);

INSERT INTO Divisions (`division_name`)
VALUES ('Pacific'), ('Northwest'), ('Southwest');

CREATE TABLE `Teams` (
  `team_id` INT AUTO_INCREMENT,
  `team_name` VARCHAR(255),
  `city` VARCHAR(255),
  `arena` VARCHAR(255),
  `division_id` INT,
  PRIMARY KEY (`team_id`),
  FOREIGN KEY (`division_id`) REFERENCES `Divisions`(`division_id`)
);

INSERT INTO Teams (`team_name`, `city`, `arena`, `division_id`)
VALUES ('Phoenix Suns', 'Phoenix', 'Footprint Center', 1),
       ('Utah Jazz', 'Salt Lake City', 'Delta Center', 2),
       ('Dallas Mavericks', 'Dallas', 'American Airlines Center', 3);

CREATE TABLE `Coaches` (
  `coach_id` INT AUTO_INCREMENT,
  `coach_name` VARCHAR(255),
  `coach_role` VARCHAR(255),
  `team_id` INT,
  PRIMARY KEY (`coach_id`),
  FOREIGN KEY (`team_id`) REFERENCES `Teams`(`team_id`)
);

CREATE TABLE `Players` (
  `player_id` INT AUTO_INCREMENT,
  `player_name` VARCHAR(255),
  `position` VARCHAR(255),
  `team_id` INT,
  PRIMARY KEY (`player_id`),
  FOREIGN KEY (`team_id`) REFERENCES `Teams`(`team_id`)
);

CREATE TABLE `Transactions` (
  `transaction_id` INT AUTO_INCREMENT,
  `player_id` INT,
  `transaction_type` VARCHAR(255),
  `transaction_date` DATE,
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`player_id`) REFERENCES `Players`(`player_id`)
);

CREATE TABLE `Seasons` (
  `season_id` INT AUTO_INCREMENT,
  `start_date` DATE,
  `end_date` DATE,
  PRIMARY KEY (`season_id`)
);

INSERT INTO Seasons (`start_date`, `end_date`)
VALUES ('2023-01-01', '2023-12-31'),
       ('2024-01-01', '2024-12-31'),
       ('2025-01-01', '2025-12-31');

CREATE TABLE `Games` (
  `game_id` INT AUTO_INCREMENT,
  `date` DATE,
  `arena` VARCHAR(255),
  `home_team_id` INT,
  `away_team_id` INT,
  PRIMARY KEY (`game_id`),
  FOREIGN KEY (`home_team_id`) REFERENCES `Teams`(`team_id`),
  FOREIGN KEY (`away_team_id`) REFERENCES `Teams`(`team_id`)
);

CREATE TABLE `Players_Stats` (
  `player_id` INT,
  `game_id` INT,
  `points` INT,
  `rebounds` INT,
  `assists` INT,
  `fouls` INT,
  `turnovers` INT,
  FOREIGN KEY (`player_id`) REFERENCES `Players`(`player_id`),
  FOREIGN KEY (`game_id`) REFERENCES `Games`(`game_id`)
);

CREATE TABLE `Officials` (
  `official_id` INT AUTO_INCREMENT,
  `official_name` VARCHAR(255),
  PRIMARY KEY (`official_id`)
);

CREATE TABLE `Game_Officials` (
  `official_id` INT,
  `game_id` INT,
  FOREIGN KEY (`official_id`) REFERENCES `Officials`(`official_id`),
  FOREIGN KEY (`game_id`) REFERENCES `Games`(`game_id`)
);    

CREATE TABLE `Teams_Stats` (
  `team_id` INT,
  `game_id` INT,
  `points` INT,
  `rebounds` INT,
  `assists` INT,
  `fouls` INT,
  `turnovers` INT,
  FOREIGN KEY (`team_id`) REFERENCES `Teams`(`team_id`),
  FOREIGN KEY (`game_id`) REFERENCES `Games`(`game_id`)
);

CREATE TABLE `Injury_Types` (
  `injury_type_id` INT AUTO_INCREMENT,
  `injury_type_name` VARCHAR(255),
  `injury_type_description` VARCHAR(255),
  PRIMARY KEY (`injury_type_id`)
);

CREATE TABLE `Injury_Status_Type` (
  `injury_status_type_id` INT AUTO_INCREMENT,
  `injury_status_type_name` VARCHAR(255),
  PRIMARY KEY (`injury_status_type_id`)
);

CREATE TABLE `Injuries` (
  `injury_id` INT AUTO_INCREMENT,
  `injury_type_id` INT,
  `player_id` INT,
  `injury_status_type_id` INT, 
  PRIMARY KEY (`injury_id`),
  FOREIGN KEY (`injury_type_id`) REFERENCES `Injury_Types`(`injury_type_id`),
  FOREIGN KEY (`player_id`) REFERENCES `Players`(`player_id`),
  FOREIGN KEY (`injury_status_type_id`) REFERENCES `Injury_Status_Type`(`injury_status_type_id`)
);

CREATE TABLE `Game_Results` (
  `game_id` INT,
  `win_team_id` INT,
  `lose_team_id` INT,
  FOREIGN KEY (`game_id`) REFERENCES `Games`(`game_id`),
  FOREIGN KEY (`win_team_id`) REFERENCES `Teams`(`team_id`),
  FOREIGN KEY (`lose_team_id`) REFERENCES `Teams`(`team_id`)
);

-- Procedures for managing roster updates and player movement.

DROP PROCEDURE IF EXISTS update_player_team;

DELIMITER //
CREATE PROCEDURE update_player_team(IN p_player_id INT, IN p_new_team_id INT)
BEGIN
    UPDATE Players
    SET team_id = p_new_team_id
    WHERE player_id = p_player_id;
END//
DELIMITER ;

-- Functions for calculating performance metrics and player availability.

DROP FUNCTION IF EXISTS points_per_game_by_players;

DELIMITER //
CREATE FUNCTION points_per_game_by_players(p_player_id INT)
RETURNS FLOAT DETERMINISTIC
BEGIN
    DECLARE avg_point FLOAT;
    SELECT AVG(points) INTO avg_point
    FROM Players_Stats
    WHERE player_id = p_player_id;
    RETURN IFNULL(avg_point, 0);
END//
DELIMITER ;

DROP FUNCTION IF EXISTS is_the_player_injured;

DELIMITER //
CREATE FUNCTION is_the_player_injured(p_player_id INT)
RETURNS VARCHAR(15) DETERMINISTIC
BEGIN
    DECLARE player_injured_count INT;
    SELECT COUNT(*) INTO player_injured_count
    FROM Injuries
    WHERE player_id = p_player_id;
    IF player_injured_count > 0 THEN
        RETURN 'Yes';
    ELSE
        RETURN 'No';
    END IF;
END//
DELIMITER ;

-- Indexing for performance optimization on high-frequency columns.

CREATE INDEX idx_player_stats_player_id ON Players_Stats(player_id);