USE ting17_project;

CREATE TABLE `Divisions` (
  `division_id` INT AUTO_INCREMENT,
  `division_name` VARCHAR(255),
  PRIMARY KEY (`division_id`) 
);

INSERT INTO Divisions (`division_id`, `division_name`)
VALUES	(1, 'Pacific'),
		(2, 'Northwest'),
        (3, 'Southwest');

CREATE TABLE `Teams` (
  `team_id` INT AUTO_INCREMENT,
  `team_name` VARCHAR(255),
  `city` VARCHAR(255),
  `arena` VARCHAR(255),
  `division_id` INT,
  PRIMARY KEY (`team_id`),
  FOREIGN KEY (`division_id`) REFERENCES `Divisions`(`division_id`)
);

-- Teams are professional basketball teams

INSERT INTO Teams (`team_id`, `team_name`, `city`, `arena`, `division_id`)
VALUES	(1, 'Phoenix Suns', 'Phoenix', 'Footprint Center', 1),
		(2, 'Utah Jazz', 'Salt Lake City', 'Delta Center', 2),
        (3, 'Dallas Mavericks', 'Dallas',  'American Airlines Center', 3),
		(4, 'Houston Rockets', 'Houston',  'Toyota Center', 3);
        
CREATE TABLE `Coaches` (
  `coach_id` INT AUTO_INCREMENT,
  `coach_name` VARCHAR(255),
  `coach_role` VARCHAR(255),
  `team_id` INT,
  PRIMARY KEY (`coach_id`),
  FOREIGN KEY (`team_id`) REFERENCES `Teams`(`team_id`)
);

INSERT INTO Coaches (`coach_id`, `coach_name`, `coach_role`, `team_id`)
VALUES	(1, 'Rudy One', 'Head Coach', 1),
		(2, 'Rudy Two', 'Assistant Coach', 1),
        (3, 'Rudy Three', 'Head Coach', 1);

CREATE TABLE `Players` (
  `player_id` INT AUTO_INCREMENT,
  `player_name` VARCHAR(255),
  `position` VARCHAR(255),
  `team_id` INT,
  PRIMARY KEY (`player_id`),
  FOREIGN KEY (`team_id`) REFERENCES `Teams`(`team_id`)
);

INSERT INTO Players (`player_id`, `player_name`, `position`, `team_id`)
VALUES	(1, 'One Rudy', 'Point Guard', 1),
		(2, 'Two Rudy', 'Shooting Guard', 1),
        (3, 'Three Rudy', 'Small Forward', 1),
		(4, 'Four Rudy', 'Power Forward', 2);
  
-- Transactions are the means by which teams acquire players, including trading or signing.
  
CREATE TABLE `Transactions` (
  `transaction_id` INT AUTO_INCREMENT,
  `player_id` INT,
  `transaction_type` VARCHAR(255),
  `transaction_date` DATE,
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`player_id`) REFERENCES `Players`(`player_id`)
);

INSERT INTO Transactions (`transaction_id`, `player_id`, `transaction_type`, `transaction_date`)
VALUES	(1, 1, 'Trade', '2024-01-01'),
		(2, 2, 'Trade', '2024-01-01'),
        (3, 3, 'Trade', '2024-01-01');

CREATE TABLE `Seasons` (
  `season_id` INT AUTO_INCREMENT,
  `start_date` DATE,
  `end_date` DATE,
  PRIMARY KEY (`season_id`)
);

INSERT INTO Seasons (`season_id`, `start_date`, `end_date`)
VALUES	(1, '2023-01-01', '2023-12-31'),
		(2, '2024-01-01', '2024-12-31'),
        (3, '025-01-01', '2025-12-31');
     
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

INSERT INTO Games (`game_id`, `date`, `arena`, `home_team_id`, `away_team_id`)
VALUES	(1, '2024-01-01', 'Footprint Center', 1, 2),
		(2, '2024-01-02', 'Footprint Center', 1, 2),
        (3, '2024-01-03', 'Footprint Center', 1, 2);
        
CREATE TABLE `Players_Stats` (
  `player_id` INT ,
  `game_id` INT,
  `points` INT,
  `rebounds` INT,
  `assists` INT,
  `fouls` INT,
  `turnovers` INT,
  FOREIGN KEY (`player_id`) REFERENCES `Players`(`player_id`),
  FOREIGN KEY (`game_id`) REFERENCES `Games`(`game_id`)
);

INSERT INTO Players_Stats (`player_id`, `game_id`, `points`, `rebounds`, `assists`, `fouls`, `turnovers`)
VALUES	(1, 1, 10, 1, 1, 1, 1),
		(2, 1, 20, 2, 2, 2, 2),
        (3, 1, 30, 3, 3, 3, 3),
        (1, 2, 10, 1, 1, 1, 1),
		(2, 2, 20, 2, 2, 2, 2),
        (3, 2, 30, 3, 3, 3, 3),
        (1, 3, 10, 1, 1, 1, 1),
		(2, 3, 20, 2, 2, 2, 2),
        (3, 3, 30, 3, 3, 3, 3);

CREATE TABLE `Officials` (
	`official_id` INT AUTO_INCREMENT,
    `official_name` VARCHAR(255),
	PRIMARY KEY (`official_id`)
    );

INSERT INTO Officials (`official_id`, `official_name`)
VALUES	(1, 'Roy One'),
		(2, 'Roy Two'),
        (3, 'Roy Three'),
        (4, 'Roy Four');

CREATE TABLE `Game_Officials` (
  `official_id` INT,
  `game_id` INT,
  FOREIGN KEY (`official_id`) REFERENCES `Officials`(`official_id`),
  FOREIGN KEY (`game_id`) REFERENCES `Games`(`game_id`)
);    

INSERT INTO Game_Officials (`official_id`, `game_id`)
VALUES	(1, 1),
		(2, 2),
        (4, 3);
        
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

INSERT INTO Teams_Stats (`team_id`, `game_id`, `points`, `rebounds`, `assists`, `fouls`,`turnovers`)
VALUES	(1, 1, 121, 50, 32, 20, 8),
		(2, 1, 118, 43, 20, 26, 11),
        (1, 2, 125, 45, 38, 5, 13),
        (2, 2, 108, 40, 24, 7, 18),
        (1, 3, 94, 50, 20, 12, 16),
        (2, 3, 109, 47, 21, 10, 22);
 
 -- Injury types are typical injuries such as knee soreness, sprained ankle, etc.
 
CREATE TABLE `Injury_Types` (
  `injury_type_id` INT AUTO_INCREMENT,
  `injury_type_name` VARCHAR(255),
  `injury_type_description` VARCHAR(255),
  PRIMARY KEY (`injury_type_id`)
);

INSERT INTO `Injury_Types`( `injury_type_id`, `injury_type_name`, `injury_type_description`)
VALUES	(1, 'Skin Abrasions', 'A wear off of the skin caused by a scrape');

-- Injury status type refers to the player’s observation and recovery after injury.

CREATE TABLE `Injury_Status_Type` (
	`injury_status_type_id` INT AUTO_INCREMENT,
    `injury_status_type_name` VARCHAR(255),
    PRIMARY KEY (`injury_status_type_id`)
);

INSERT INTO `Injury_Status_Type` (`injury_status_type_id`, `injury_status_type_name`)
VALUES 	(1, 'Day to day'),
		(2, 'Out of season');

-- Injuries are records of player injuries.

CREATE TABLE `Injuries` (
  `injury_Id` INT AUTO_INCREMENT,
  `injury_type_id` INT,
  `player_id` INT,
  `injury_status_type_id` INT, 
  PRIMARY KEY (`injury_Id`),
  FOREIGN KEY (`injury_type_id`) REFERENCES `Injury_Types`(`injury_type_id`),
  FOREIGN KEY (`player_id`) REFERENCES `Players`(`player_id`),
  FOREIGN KEY (`injury_status_type_id`) REFERENCES `Injury_Status_Type`(`injury_status_type_id`)
);

INSERT INTO  `Injuries` ( `injury_Id`, `injury_type_id` , `player_id`, `injury_status_type_id`)
VALUES (1, 1, 1, 1);
   
CREATE TABLE `Game_Results` (
  `game_id` INT,
  `win_team_id` INT,
  `lose_team_id` INT,
  FOREIGN KEY (`game_id`) REFERENCES `Games`(`game_id`),
  FOREIGN KEY (`win_team_id`) REFERENCES `Teams`(`team_id`),
  FOREIGN KEY (`lose_team_id`) REFERENCES `Teams`(`team_id`)
 );

INSERT INTO`Game_Results` (`game_id`, `win_team_id`, `lose_team_id`)
VALUES	(1, 1, 2),
		(2, 1, 2),
		(3, 2, 1);
        
-- Assuming the professional league expands with more teams, leading to the creation of additional divisions.

DROP PROCEDURE IF EXISTS insert_division_name;

DELIMITER //
CREATE PROCEDURE insert_division_name(
						IN  division_name_param VARCHAR(255), 
						OUT division_id_param INT)
BEGIN
	
    INSERT INTO `Divisions`
		(`division_name`)
		VALUES
		(division_name_param);
        
    SELECT LAST_INSERT_ID()
    INTO division_id_param;
    
END//

CALL insert_division_name('Central', @id);
SELECT @id;

select *
from Divisions;

DROP PROCEDURE IF EXISTS insert_coach_info;

DELIMITER //
CREATE PROCEDURE insert_coach_info(
						IN  coach_name_param VARCHAR(255),
                        IN  coach_role_param VARCHAR(255), 
                        IN  team_id_param INT,
						OUT coach_id_param INT)
BEGIN
	
    INSERT INTO `Coaches`
		(`coach_name`, `coach_role`, `team_id`)
		VALUES
		(coach_name_param, coach_role_param, team_id_param);
        
    SELECT LAST_INSERT_ID()
    INTO coach_id_param;
    
END//

CALL insert_coach_info('Rudy Four', 'Assistant Coach', '1', @id);
SELECT @id;

select *
from Coaches;

DROP PROCEDURE IF EXISTS insert_team_info;

DELIMITER //
CREATE PROCEDURE insert_team_info(
						IN  team_name_param VARCHAR(255),
                        IN  city_param VARCHAR(255), 
                        IN  arena_param VARCHAR(255),
						IN  division_id_param INT, 
                        OUT team_id_param INT)
BEGIN
	
    INSERT INTO `Teams`
		(`team_name`, `city`, `arena`, `division_id`)
		VALUES
		(team_name_param, city_param, arena_param, division_id_param);
        
    SELECT LAST_INSERT_ID()
    INTO team_id_param;
    
END//

CALL insert_team_info('Denver Nuggets', 'Denver', 'Ball Arena' , 1, @id);
SELECT @id;

select *
from Teams;

-- This occurs when teams relocate to different cities, potentially resulting in assignment to a different division.

DROP PROCEDURE IF EXISTS update_team_division;

DELIMITER //
CREATE PROCEDURE update_team_division(IN team_id INT, IN new_division_id INT)
BEGIN
    UPDATE Teams
    SET division_id = new_division_id
    WHERE team_id = team_id;
END//

SELECT *
FROM Teams
WHERE team_id = 5;

CALL update_team_division(5, 2);

-- There may be a delay before the transaction is officially completed, and the transaction time will be adjusted accordingly.

DROP PROCEDURE IF EXISTS update_transaction_date;

DELIMITER //
CREATE PROCEDURE update_transaction_date(IN transaction_id INT, IN new_transaction_date DATE)
BEGIN
    UPDATE Transactions
    SET transaction_date = new_transaction_date
    WHERE transaction_id = transaction_id;
END//

SELECT *
FROM Transactions
WHERE transaction_id = 3;

CALL update_transaction_date(3, '2023-12-31');

-- When players join a new team, their information needs to be updated.

DROP PROCEDURE IF EXISTS update_player_team;

DELIMITER //
CREATE PROCEDURE update_player_team(IN player_id INT, IN new_team_id INT)
BEGIN
    UPDATE Players
    SET team_id = new_team_id
    WHERE player_id = player_id;
END//

SELECT *
FROM Players
WHERE player_id = 4;

CALL update_player_team(4, 1);

-- Confirmation of rosters following changes, including new additions and departures of former players.

DROP PROCEDURE IF EXISTS list_player_from_team;

DELIMITER //

CREATE PROCEDURE list_player_from_team(IN team_id INT)
BEGIN
    SELECT Players.player_name
    FROM  Players
    WHERE Players.team_id = team_id;
END//

CALL list_player_from_team(1);

-- The interim head coach transitions to an assistant coach role once the team hires a new head coach.

DROP PROCEDURE IF EXISTS update_coach_role;

DELIMITER //
CREATE PROCEDURE update_coach_role(IN coach_id INT, IN new_role VARCHAR(255))
BEGIN
    UPDATE Coaches
    SET coach_role = new_role
    WHERE coach_id = coach_id;
END//

SELECT *
FROM Coaches
WHERE coach_id = 3;

CALL update_coach_role(3, 'Assistant Coach');

-- Team disbanded

DROP PROCEDURE IF EXISTS delete_team_id;

DELIMITER //
CREATE PROCEDURE delete_team_id(IN team_id_param INT)
BEGIN
    DELETE FROM Teams
    WHERE team_id = team_id_param;
END//

CALL delete_team_id(4);

-- Players banned from the league due to gambling, as well as retired players.

DROP PROCEDURE IF EXISTS delete_player_id;

DELIMITER //
CREATE PROCEDURE delete_player_id(IN player_id_param INT)
BEGIN
    DELETE FROM Players
    WHERE player_id = player_id_param;
END//

CALL delete_player_id(4);

DROP FUNCTION IF EXISTS show_game_win_team;

DELIMITER //

CREATE FUNCTION show_game_win_team(game_id_param INT)

RETURNS INT
BEGIN
	DECLARE win_team_result INT;
    SELECT win_team_id INTO win_team_result
    FROM Game_Results
    WHERE game_id = game_id_param;
	IF win_team_result IS NOT NULL THEN
        RETURN win_team_result;
    ELSE
        RETURN 0;
    END IF;
END//

SELECT
	game_id,
    show_game_win_team(game_id) AS win_team_result
FROM
	Game_Results;
    
-- To calculate the stats of the players.

DROP FUNCTION IF EXISTS points_per_game_by_players;

DELIMITER //

CREATE FUNCTION points_per_game_by_players(player_id_param INT)
RETURNS FLOAT
BEGIN
    DECLARE avg_point FLOAT;
    SELECT AVG(points) INTO avg_point
    FROM Players_Stats
    WHERE player_id = player_id_param;
    RETURN avg_point;
END//

SELECT 
	player_id, 
    points_per_game_by_players(player_id) AS avg_point
FROM 
	Players_Stats;
    
-- To verify the players' health status and review their injury reports.
  
DROP FUNCTION IF EXISTS is_the_player_injured;

DELIMITER //

CREATE FUNCTION is_the_player_injured(player_id_param INT)
RETURNS VARCHAR(15)
BEGIN
    DECLARE player_injured VARCHAR(15);
    SELECT COUNT(*) INTO player_injured
    FROM Injuries
    WHERE player_id = player_id_param;
    IF player_injured > 0 THEN
        RETURN 'Yes';
    ELSE
        RETURN 'No';
    END IF;
END//

SELECT 
	player_id, 
    is_the_player_injured(player_id) AS player_injured
FROM 
	Injuries;

DROP FUNCTION IF EXISTS most_turnovers_player_of_the_game;

DELIMITER //
CREATE FUNCTION most_turnovers_player_of_the_game(game_id_param INT)
RETURNS VARCHAR(255)
BEGIN
    DECLARE most_turnovers_player VARCHAR(255);
    SELECT player_name INTO most_turnovers_player
    FROM Players p
    JOIN Players_Stats ps ON p.player_id = ps.player_id
    WHERE ps.game_id = game_id_param
    ORDER BY ps.turnovers DESC LIMIT 1;
    RETURN most_turnovers_player;
END//


SELECT 
	ps.game_id, 
    most_turnovers_player_of_the_game(ps.game_id) AS most_turnovers_player
FROM 
	Players_Stats ps;
    
DROP FUNCTION IF EXISTS total_win_loss_record;

DELIMITER //

CREATE FUNCTION total_win_loss_record(team_id_param INT)
RETURNS VARCHAR(15)
BEGIN
	DECLARE total_win INT;
    DECLARE total_loss INT;
	DECLARE total_win_loss VARCHAR(15);
	SELECT COUNT(*) INTO total_win
    FROM Game_Results
    WHERE win_team_id = team_id_param;
	SELECT COUNT(*) INTO total_loss
    FROM Game_Results
    WHERE lose_team_id = team_id_param;
	SET total_win_loss = CONCAT(total_win,'-', total_loss);
    RETURN total_win_loss;
END//

SELECT
	win_team_id AS team_id,
    total_win_loss_record(win_team_id) AS total_win_loss
FROM
	Game_Results;

DROP INDEX idx_player_stats_player_id ON Players_Stats;
CREATE INDEX idx_player_stats__player_id ON Players_Stats(player_id);
SELECT * FROM Players_Stats WHERE player_id = 1;

