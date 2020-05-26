DROP DATABASE IF EXISTS dbTileGame;
CREATE DATABASE dbTileGame;
USE dbTileGame;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Procdure to create the all of the tables in the database
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
CREATE PROCEDURE makeTileGameDB()
	BEGIN 
		CREATE TABLE tblUser(
			`username` VARCHAR(32) PRIMARY KEY,
            -- `userID` INTEGER AUTO_INCREMENT PRIMARY KEY, 
			`email` VARCHAR(64) NOT NULL,
            `userPassword` VARCHAR(64) NOT NULL,
            `loginAttempts` TINYINT NOT NULL DEFAULT 0,
            `userScore` INTEGER NOT NULL DEFAULT 0,
            `isLocked` BOOLEAN NOT NULL DEFAULT FALSE,
            `isAdmin` BOOLEAN NOT NULL DEFAULT FALSE, 
            `isOnline` BOOLEAN NOT NULL DEFAULT FALSE
			);
            
		CREATE TABLE tblSkill (
			`skillName` VARCHAR(20) PRIMARY KEY,
            -- `skillID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `skilldescription` VARCHAR(255) NOT NULL
			);

		CREATE TABLE tblItem(
            `itemName` VARCHAR(32) PRIMARY KEY,
            -- `itemID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `matchingSkill` VARCHAR(20) NOT NULL,
			`itemDurability` TINYINT NOT NULL,
            `maxDurability` TINYINT NOT NULL,
			FOREIGN KEY (matchingSkill) REFERENCES tblSkill (skillName) ON UPDATE CASCADE
			);
            
		CREATE TABLE tblMine(
            `mineName` VARCHAR(20) PRIMARY KEY,
            -- `mineID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `minedBy` VARCHAR(32) NOT NULL,
            FOREIGN KEY (minedBy) REFERENCES tblItem (itemName) ON UPDATE CASCADE
			);
            
        CREATE TABLE tblMap(
			`mapID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `homeTileXLocation` TINYINT NOT NULL,
            `homeTileYLocation` TINYINT NOT NULL,
            `xSize` TINYINT NOT NULL,
            `ySize` TINYINT NOT NULL
			);

        CREATE TABLE tblTile(
			`tileID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `mapID` INTEGER NOT NULL,
            `xLocation` TINYINT NOT NULL,
            `yLocation` TINYINT NOT NULL,
            FOREIGN KEY (mapID) REFERENCES tblMap (mapID)
            );

        CREATE TABLE tblTileItem(
			`tileID` INTEGER NOT NULL,
            `itemName` VARCHAR(32) NOT NULL,
            FOREIGN KEY (tileID) REFERENCES tblTile (tileID), 
            FOREIGN KEY (itemName) REFERENCES tblItem (itemName) ON UPDATE CASCADE,
            PRIMARY KEY (tileID, itemName)
            );

        CREATE TABLE tblCharacter(
            `characterName` VARCHAR(32) PRIMARY KEY,
            -- `characterID` INTEGER AUTO_INCREMENT ,
            `username` VARCHAR(32) NOT NULL,
            `xPosition` TINYINT,
            `yPosition` TINYINT,
            `characterScoreTotal` INTEGER NOT NULL DEFAULT 0,
            `isActive` BOOLEAN DEFAULT FALSE,
            FOREIGN KEY (username) REFERENCES tblUser (username) ON DELETE CASCADE ON UPDATE CASCADE
            );

        CREATE TABLE tblCharacterSkill(
			`characterName` VARCHAR(32) NOT NULL,
            `skillName`  VARCHAR(20) NOT NULL,
            FOREIGN KEY (characterName) REFERENCES tblCharacter (characterName) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY (skillName) REFERENCES tblSkill (skillName) ON UPDATE CASCADE,
            PRIMARY KEY (characterName, skillName)
			);

        CREATE TABLE tblChat(
			`chatID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `sender` VARCHAR(32) NOT NULL,
            `message` VARCHAR(255) NOT NULL,
            `timesent` DATETIME,
            FOREIGN KEY (sender) REFERENCES tblCharacter (characterName) ON DELETE CASCADE ON UPDATE CASCADE
            );

        CREATE TABLE tblCharacterItem(
			`characterName` VARCHAR(32) NOT NULL,
            `itemName` VARCHAR(32) NOT NULL,
            `quantity` TINYINT, 
            PRIMARY KEY (characterName, itemName),
            FOREIGN KEY (characterName) REFERENCES tblCharacter (characterName) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY (itemName) REFERENCES tblItem (itemName) ON UPDATE CASCADE
			);

        CREATE TABLE tblCharacterMap(
            `characterName` VARCHAR(32) NOT NULL,
            `mapID` INTEGER NOT NULL,
            `score` INTEGER DEFAULT 0,
            PRIMARY KEY (characterName, mapID),
            FOREIGN KEY (characterName) REFERENCES tblCharacter (characterName) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY (mapID) REFERENCES tblMap (mapID)
            );

        CREATE TABLE tblMineTile(
			`mineName` VARCHAR(20) NOT NULL,
            `tileID` INTEGER NOT NULL,
            PRIMARY KEY (mineName, tileID),
            FOREIGN KEY (mineName) REFERENCES tblMine (mineName),
            FOREIGN KEY (tileID) REFERENCES tblTile (tileID)
            );

        CREATE TABLE tblCharacterTile(
			`characterName` VARCHAR(32) NOT NULL,
            `tileID` INTEGER NOT NULL,
            PRIMARY KEY (characterName, tileID),
            FOREIGN KEY (characterName) REFERENCES tblCharacter (characterName),
            FOREIGN KEY (tileID) REFERENCES tblTile (tileID)
            );
	END//
DELIMITER ;

CALL makeTileGameDB();


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- INSERT Statements
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

INSERT INTO tblUser(username, email, userPassword, loginAttempts, userscore, isLocked, isAdmin, isOnline)
Values 
('Mark', 'kevin-christison@live.nmit.ac.nz', 'MarksPassword', 0, 0, false, true, false),
('John', 'johnsTilegameaccount@gmail.com', 'JohnsPassword', 0, 0, false, false, false),
('Mary', 'marysemail@yahoo.com', 'Maryhadalittlelamb', 0, 0, false, false, false),
('Stephen', 'stephen@gmail.com', 'stevesteve', 0, 0, false, true, false),
('Michael', 'mikeridesbikes@bikemail.com', 'bikebikebike', 0, 0, false, false, false);


INSERT INTO tblSkill(skillName, skillDescription)
Values 
('Miner', 'Gets points for mining gems with a pickaxe'),
('Gatherer', 'Gets points for collecting berries into the basket'),
('Fisher', 'Gets points for catching fish with a rod'),
('Woodcutter', 'Gets points for cutting down trees with an axe'),
('Archer', 'Gets points for shooting targets with a bow'),
('Smith', 'Gets points for using a hammer on an anvil');

INSERT INTO tblItem(itemName, matchingSkill, itemDurability, maxDurability)
Values 
('Pickaxe', 'Miner', 3, 3),
('Basket','Gatherer', 3, 3),
('Rod', 'Fisher', 3, 3),
('Axe', 'Woodcutter', 3, 3),
('Bow', 'Archer', 3, 3),
('Hammer', 'Smith', 3, 3);

INSERT INTO tblMine(mineName, minedBy)
Values 
('Gem', 'Pickaxe'),
('Berry', 'Basket'),
('Fish', 'Rod'),
('Tree', 'Axe'),
('Target', 'Bow'),
('Anvil', 'Hammer');

INSERT INTO tblMap(homeTileXLocation, homeTileYLocation, xSize, ySize)
Values
(5, 5, 11, 11),
(2, 2, 3, 3),
(3, 3, 5, 5),
(4, 4, 7, 7),
(6, 6, 13, 13);

INSERT INTO tblTile(mapID, xLocation, yLocation)
Values 
(1, 2, 1), (1, 2, 2), (1, 2, 3), (1, 2, 4), (1, 2, 5), (1, 2, 6), (1, 2, 7), (1, 2, 8), (1, 2, 9), (1, 2, 10), (1, 2, 11),
(1, 3, 1), (1, 3, 2), (1, 3, 3), (1, 3, 4), (1, 3, 5), (1, 3, 6), (1, 3, 7), (1, 3, 8), (1, 3, 9), (1, 3, 10), (1, 3, 11),
(1, 4, 1), (1, 4, 2), (1, 4, 3), (1, 4, 4), (1, 4, 5), (1, 4, 6), (1, 4, 7), (1, 4, 8), (1, 4, 9), (1, 4, 10), (1, 4, 11),
(1, 5, 1), (1, 5, 2), (1, 5, 3), (1, 5, 4), (1, 5, 5), (1, 5, 6), (1, 5, 7), (1, 5, 8), (1, 5, 9), (1, 5, 10), (1, 5, 11),
(1, 6, 1), (1, 6, 2), (1, 6, 3), (1, 6, 4), (1, 6, 5), (1, 6, 6), (1, 6, 7), (1, 6, 8), (1, 6, 9), (1, 6, 10), (1, 6, 11),
(1, 7, 1), (1, 7, 2), (1, 7, 3), (1, 7, 4), (1, 7, 5), (1, 7, 6), (1, 7, 7), (1, 7, 8), (1, 7, 9), (1, 7, 10), (1, 7, 11),
(1, 8, 1), (1, 8, 2), (1, 8, 3), (1, 8, 4), (1, 8, 5), (1, 8, 6), (1, 8, 7), (1, 8, 8), (1, 8, 9), (1, 8, 10), (1, 8, 11),
(1, 9, 1), (1, 9, 2), (1, 9, 3), (1, 9, 4), (1, 9, 5), (1, 9, 6), (1, 9, 7), (1, 9, 8), (1, 9, 9), (1, 9, 10), (1, 9, 11),
(1, 10, 1), (1, 10, 2), (1, 10, 3), (1, 10, 4), (1, 10, 5), (1, 10, 6), (1, 10, 7), (1, 10, 8), (1, 10, 9), (1, 10, 10), (1, 10, 11),
(2, 1, 1), (2, 1, 2), (2, 1, 3),
(2, 2, 1), (2, 2, 2), (2, 2, 3),
(2, 3, 1), (2, 3, 2), (2, 3, 3),
(3, 1, 1), (3, 1, 2), (3, 1, 3), (3, 1, 4), (3, 1, 5),
(3, 2, 1), (3, 2, 2), (3, 2, 3), (3, 2, 4), (3, 2, 5),
(3, 3, 1), (3, 3, 2), (3, 3, 3), (3, 3, 4), (3, 3, 5),
(3, 4, 1), (3, 4, 2), (3, 4, 3), (3, 4, 4), (3, 4, 5),
(3, 5, 1), (3, 5, 2), (3, 5, 3), (3, 5, 4), (3, 5, 5);

INSERT INTO tblTileItem(tileID, itemName)
Values
(69, 'Pickaxe'),
(18, 'Basket'),
(119, 'Rod'),
(78, 'Axe'),
(65, 'Bow'),
(50, 'Hammer'),
(128, 'Rod'),
(129, 'Bow'),
(130, 'Basket');

INSERT INTO tblCharacter(characterName, username, xPosition, yPosition, characterScoreTotal, isActive)
Values 
('MarkCharacter', 'Mark', 5, 5, 0, false),
('MaryCharacter', 'Mary', 5, 5, 0, false),
('JohnCharacter', 'John', 5, 5, 0, false),
('StepehnCharacter', 'Stephen', 2, 2, 0, false),
('MichaelCharacter', 'Michael', 2, 2, 0, false);

INSERT INTO tblCharacterSkill(characterName, skillName)
Values 
('MarkCharacter', 'Miner'), ('MarkCharacter','Gatherer'), ('MarkCharacter', 'Fisher'), ('MarkCharacter', 'Woodcutter'),
('MaryCharacter', 'Smith'), ('MaryCharacter', 'Archer'), ('MaryCharacter', 'Fisher'), ('MaryCharacter', 'Woodcutter'),
('JohnCharacter', 'Archer'), ('JohnCharacter', 'Gatherer'), ('JohnCharacter', 'Smith'), ('JohnCharacter', 'Miner'),
('StepehnCharacter', 'Smith'), ('StepehnCharacter', 'Archer'), ('StepehnCharacter', 'Fisher'), ('StepehnCharacter', 'Woodcutter'),
('MichaelCharacter', 'Archer'), ('MichaelCharacter', 'Gatherer'), ('MichaelCharacter', 'Smith'), ('MichaelCharacter', 'Miner');

INSERT INTO tblChat(sender, message)
Values 
('MarkCharacter', 'Hello world!'), ('MarkCharacter', 'Goodbye world!'),
('MaryCharacter', 'more words'), ('MaryCharacter', 'nice'),
('JohnCharacter', 'great'), ('JohnCharacter', 'less'),
('StepehnCharacter', 'I mean we could'), ('StepehnCharacter', 'That sounds great'),
('MichaelCharacter', 'Chocolate rain'), ('MichaelCharacter', 'we woo');

INSERT INTO tblCharacterItem(characterName, itemName, quantity)
Values ('MarkCharacter','Pickaxe',1),
('MarkCharacter','Basket',1),
('MarkCharacter','Rod',1),
('MaryCharacter','Bow',1),
('MaryCharacter','Rod',1),
('MaryCharacter','Axe',1),
('JohnCharacter','Bow',1),
('JohnCharacter','Basket',1),
('JohnCharacter','Hammer',1),
('JohnCharacter','Pickaxe',1),
('StepehnCharacter','Hammer',1),
('StepehnCharacter','Bow',1),
('StepehnCharacter','Rod',1),
('StepehnCharacter','Axe',1),
('MichaelCharacter','Bow',1),
('MichaelCharacter','Basket',1),
('MichaelCharacter','Hammer',1),
('MichaelCharacter','Pickaxe',1);


INSERT INTO tblCharacterMap(characterName, mapID, score)
Values
('MarkCharacter',1,	0),
('MaryCharacter',1,	0),
('JohnCharacter',1,	0),
('StepehnCharacter',2,0),
('MichaelCharacter',2,0);


INSERT INTO tblMineTile(mineName, tileID)
Values
('Gem',2),
('Berry',99),
('Fish',27),
('Tree',18),
('Target',68),
('Anvil',97),
('Gem',	122),
('Berry',123),
('Fish'	,124);

INSERT INTO tblCharacterTile(characterName, tileID)
Values
('MarkCharacter',60),
('MaryCharacter',60),
('JohnCharacter',60),
('StepehnCharacter',126),
('MichaelCharacter',126);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- UPDATE Statements
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- UPDATE tblUser
-- SET username = 'Kram'
-- WHERE username = 'Mark';

-- UPDATE tblSkill
-- SET skillName = 'Retired'
-- WHERE skillName = 'Miner';

-- UPDATE tblItem
-- SET itemDurability = itemDurability - 1
-- WHERE itemDurability = 3;

-- UPDATE tblMine
-- SET mineName = 'Ruby'
-- WHERE mineName = 'Gem';

-- UPDATE tblMap
-- SET xSize = 15 AND ySize = 15
-- WHERE xSize = 11 AND ySize = 11;

-- UPDATE tblTile
-- SET xLocation = xLocation + 1
-- WHERE xLocation = 1;

-- UPDATE tblTileItem
-- SET itemID = 2
-- WHERE itemID = 1;

-- UPDATE tblCharacter
-- SET characterName = 'bazbarfoo'
-- WHERE characterName = 'MarkCharacter';

-- UPDATE tblCharacterSkill
-- SET skillID = 3
-- WHERE skillID = 1;

-- UPDATE tblChat
-- SET message = 'HELLLOOOOOOOOO World!'
-- WHERE message = 'Hello World!';

-- UPDATE tblCharacterItem
-- SET quantity = 10
-- WHERE quantity <= 5;

-- UPDATE tblCharacterMap
-- SET score = 100
-- WHERE characterID = 1;

-- UPDATE tblMineTile
-- SET mineID = 3
-- WHERE mineID = 1;

-- UPDATE tblCharacterTile
-- SET tileID = 15
-- WHERE tileID = 14;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- SELECT Statements
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT * FROM tblUser;

SELECT * FROM tblSkill;

SELECT * FROM tblItem;

SELECT * FROM tblMine;

SELECT * FROM tblMap;

SELECT * FROM tblTile;

SELECT * FROM tblTileItem;

SELECT * FROM tblCharacter;

SELECT * FROM tblCharacterSkill;

SELECT * FROM tblChat;

SELECT * FROM tblCharacterItem;

SELECT * FROM tblCharacterMap;

SELECT * FROM tblMineTile;

SELECT * FROM tblCharacterTile;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- DELETE Statements
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELETE FROM tblCharacterTile;

DELETE FROM tblMineTile;

DELETE FROM tblCharacterMap;

DELETE FROM tblCharacterItem;

DELETE FROM tblChat;

DELETE FROM tblCharacterSkill;

DELETE FROM tblCharacter;

DELETE FROM tblTileItem;

DELETE FROM tblTile;

DELETE FROM tblMap;

DELETE FROM tblMine;

DELETE FROM tblItem;

DELETE FROM tblSkill;

DELETE FROM tblUser;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Register a User WORKING
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP PROCEDURE IF EXISTS registerUser;

DELIMITER //
CREATE PROCEDURE registerUser(pUserName VARCHAR(32), pEmail VARCHAR(64), pUserPassword VARCHAR(64))
BEGIN
START TRANSACTION;
    IF EXISTS (SELECT * FROM tblUser WHERE username = pUserName OR email = pEmail) THEN
        BEGIN
            SELECT "Username or Email already exists" AS MESSAGE;
            -- SIGNAL SQLSTATE '45000'
            -- SET MESSAGE_TEXT = 'Username or Email already exists';
        END;
    ELSE
        BEGIN
            INSERT INTO tblUser(username , email, userPassword) VALUES (pUserName, pEmail, pUserPassword);
            -- SIGNAL SQLSTATE '77777'
			-- SET MESSAGE_TEXT = 'User has been registered';
            SELECT "User has been registered" AS MESSAGE;
        END;
    END IF;
COMMIT;
END//
DELIMITER ;

CALL registerUser("foobaaz", "foobaaz", "foobaaz");

SELECT * FROM tbluser;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Login with a user WORKING
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP PROCEDURE IF EXISTS userLogin;

DELIMITER //
CREATE PROCEDURE userLogin(pUserName VARCHAR(32), pUserPassword VARCHAR(64))
-- DECLARE @lcUserName VARCHAR(32)DEFAULT 'ads';
-- DECLARE @lcUserPassword VARCHAR(64)DEFAULT 'sdadsf';
-- DECLARE @lcUserIsLocked BOOLEAN DEFAULT FALSE;
-- DECLARE @lcUserLoginAttemps TINYINT DEFAULT 0;
BEGIN
START TRANSACTION;
    -- SELECT username, userPassword, islocked, loginAttempts
    -- FROM tblUser
    -- WHERE username = pUsername
    -- INTO lcUserName, lcUserPassword, lcuserIsLocked, lcuserLoginAttemps;
    -- IF lcUserName IS NULL THEN
    IF NOT EXISTS (SELECT * FROM tbluser WHERE username = pUserName) THEN
        BEGIN
            SELECT "Username doesn't exist" AS MESSAGE;
        END;
    ELSE IF EXISTS( SELECT *
            FROM tbluser
            WHERE username = pUserName) THEN
        -- ELSE IF (lcUserName = pUserName) AND (lcUserPassword = pUserPassword)
            IF EXISTS (SELECT * FROM tbluser WHERE username = pUserName AND userPassword = pUserPassword) THEN
                -- IF (lcUserLoginAttemps >= 5)
                IF EXISTS (SELECT * FROM tbluser WHERE username = pUserName AND userPassword = pUserPassword AND loginAttempts >= 5) THEN
                    BEGIN
                        SELECT "User is locked out" AS MESSAGE;
                    END;
                ELSE
                    BEGIN
                        UPDATE tbluser
                        SET isOnline = true
                        WHERE (username = pUserName AND userPassword = pUserPassword);
                        SELECT CONCAT(pUserName, " Is now Online") AS MESSAGE;
                    END;
                END IF;
            ELSE
                BEGIN
                    UPDATE tlbuser
                    SET loginAttemps = loginAttemps + 1;
                    SELECT "Incorrect Password, Please try again" AS MESSAGE;
                END;
            END IF;
        END IF;
    END IF;
COMMIT;
END//
DELIMITER ;

call userLogin("foo", "foo");
SELECT * FROM tblUser;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Edit User WORKING
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS editUser//
CREATE PROCEDURE editUser(pUserName VARCHAR(32), pNewUserName VARCHAR(32), pNewUserPassword VARCHAR(64), pNewUserEmail VARCHAR(64))
BEGIN
START TRANSACTION;
	UPDATE tblUser
	SET email = pNewUserEmail, userPassword = pNewUserPassword, username = pNewUserName
	WHERE pUserName = username;   
COMMIT;
END//
DELIMITER ;

call editUser("foo", "fooer", "fooer", "fooer");

select * from tblUser;

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--Delete User WORKING
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS deleteUser//
CREATE PROCEDURE deleteUser(pUserName VARCHAR(32))
BEGIN
START TRANSACTION;
	DELETE FROM tblUser
	WHERE username = pUserName;
    SELECT CONCAT( pUserName + " has been deleted")
COMMIT;
END//
DELIMITER ;

call deleteUser ("foobaz");

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--User Creates Character (inlcuding character skills created) WORKING
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS createCharacter//
CREATE PROCEDURE createCharacter(pUserName VARCHAR(32), pCharacterName VARCHAR(32), pSkill1 VARCHAR(20), pSkill2 VARCHAR(20), pSkill3 VARCHAR(20), pSkill4 VARCHAR(20))
BEGIN
	START TRANSACTION;
		INSERT INTO tblCharacter (characterName, username)
		VALUES(pCharacterName, pUserName);

		INSERT INTO tblCharacterSkill(characterName, skillName)
		VALUES(pCharacterName, pSkill1), (pCharacterName, pSkill2), (pCharacterName, pSkill3), (pCharacterName, pSkill4);
	COMMIT;
END//
DELIMITER ;

call createCharacter("bar", "bar bar baram", "Miner", "Fisher", "Gatherer", "Woodcutter");

SELECT * FROM tblCharacter WHERE characterName = "bar bar baram";

SELECT * FROM tblCharacterSkill
WHERE characterName = "bar bar baram";

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- User Deletes Character
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS deleteCharacter//
CREATE PROCEDURE deleteCharacter(pCharacterName VARCHAR(32))
BEGIN
    START TRANSACTION;
        DELETE FROM tblCharacter
        WHERE tblCharacter.characterName = pCharacterName;
    COMMIT;
END//
DELIMITER ;

call deleteCharacter("bar bar baram");

select * from tblCharacter where characterName = "bar bar baram";

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Select Character to play game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS selectCharacter//
CREATE PROCEDURE selectCharacter(pUserName VARCHAR(32), pCharacterName VARCHAR(32))
BEGIN
    START TRANSACTION;
	-- TODO
    SELECT *
    FROM tblcharacter
    WHERE characterName = pCharacterName AND username = pUserName;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Get list of online characters
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS onlineCharacters//
CREATE PROCEDURE onlineCharacters()
BEGIN
    START TRANSACTION;
    SELECT *
    FROM tblcharacter
    WHERE isOnline = true;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Create Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS createGame//
CREATE PROCEDURE createGame()
BEGIN
-- Maybe game generates items and mines??
-- Returns list of maps
-- User chooses from list of maps
-- Returns a list of online characters that can be chanllenged
-- Returns a list of online players that can be challenged
-- Selected player is channenged
-- Database ran
-- TODO
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Leave Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS leaveGame//
CREATE PROCEDURE leaveGame(pUserName VARCHAR(32))
BEGIN
-- TODO
-- Return a list of games the character is currently in
-- User makes a selection
-- Delete from tlbCharacterMap
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return to Game in Progress
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS returnToGame//
CREATE PROCEDURE returnToGame(pUserName VARCHAR(32))
BEGIN
-- TODO
-- More of a GUI thing, switching from menu to game window?
-- Not really able to simulate in CLI??
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character makes Move
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS characterMakesMove//
CREATE PROCEDURE characterMakesMove(pUserName VARCHAR(32)) 
BEGIN
-- TODO
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character picks up item
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS characterPicksUpItem//
CREATE PROCEDURE characterPicksUpItem(pUserName VARCHAR(32)) 
BEGIN
-- TODO
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character Uses Item on Mine
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS useItem//
CREATE PROCEDURE useItem(pUserName VARCHAR(32)) 
BEGIN
-- TODO
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character chats
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS useItem//
CREATE PROCEDURE useItem(pUserName VARCHAR(32)) 
BEGIN
-- TODO
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~Admin~~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Check if Admin to Access Admin Menu
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS checkIfAdmin//
CREATE PROCEDURE checkIfAdmin(pUserName VARCHAR(32), pUserPassword VARCHAR(64)) 
BEGIN
    SELECT isAdmin
    FROM tblUser
    WHERE pUserName = username
    AND pUserPassword = userPassword;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin Kills Running Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return list of active games first
-- Admin selects game to end after

DELIMITER //
DROP PROCEDURE IF EXISTS getActiveGames//
CREATE PROCEDURE getActiveGames() 
BEGIN
    Start Transaction;
        SELECT `mapID`, `characterName`
        FROM tblCharacterMap AS t1
        LEFT JOIN tblCharacterMap AS t2 ON t1.`mapID` = t2.`mapID`;
    COMMIT;
END//
DELIMITER ; -- Doesn't yet work

DELIMITER //
DROP PROCEDURE IF EXISTS adminKillGame//
CREATE PROCEDURE adminKillGame(pUserName VARCHAR(32)) 
BEGIN
            -- SIGNAL SQLSTATE '45000'
			--     SET MESSAGE_TEXT = 'Username or Email already exists';
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin adds a user
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS adminAddUser//
CREATE PROCEDURE adminAddUser(pUserName VARCHAR(32), pEmail VARCHAR(64), pUserPassword VARCHAR(64), pIsAdmin BOOLEAN)
BEGIN
START TRANSACTION;
    IF EXISTS(
        SELECT *
        FROM tblUser
        WHERE username = pUserName OR email = pEmail)
    THEN
        BEGIN
            SELECT 'Username or Email already exists' AS MESSAGE;
        END;
    ELSE
        BEGIN
            INSERT INTO tblUser(username , email, userPassword, isAdmin)
            VALUES (pUserName, pEmail, pUserPassword, pIsAdmin);

            SELECT 'User has been registered' AS MESSAGE;
        END;
    END IF;
COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin edits user
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS adminEditUser//
CREATE PROCEDURE adminEditUser(pUserName VARCHAR(32) , pNewUserName VARCHAR(64), pEmail VARCHAR(64), pNewUserEmail VARCHAR(64), pUserPassword VARCHAR(64), pLoginAttempts TINYINT, pUserScore INTEGER, pIsLocked BOOLEAN, pIsAdmin BOOLEAN)
BEGIN
START TRANSACTION;
        UPDATE tblUser
        SET email = username, pNewUserName = pNewUserEmail, userPassword = pNewUserPassword, loginAttempts = pLoginAttempts, userScore = pUserScore
        WHERE pUserName = username;
COMMIT;   
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin deletes user
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Get all users
DELIMITER //
DROP PROCEDURE IF EXISTS adminGetAllUsers//
CREATE PROCEDURE adminGetAllUsers() 
BEGIN
    SELECT username
    FROM tblUser;
END//
DELIMITER ;


-- Delete a user
DELIMITER //
DROP PROCEDURE IF EXISTS adminDeleteUser//
CREATE PROCEDURE adminDeleteUser(pUserName VARCHAR(32))
START TRANSACTION;
	DELETE FROM tblUser
	WHERE username = pUserName;

	SELECT "User is now Deleted" AS MESSAGE;
COMMIT;  
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin unlocks locked user
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Get list of locked users
DELIMITER //
DROP PROCEDURE IF EXISTS getLockedUsers//
CREATE PROCEDURE getLockedUsers(pUserName VARCHAR(32)) 
BEGIN
    SELECT username
    FROM tblUser
    WHERE isLocked = true;
END//
DELIMITER ;

-- Choose user to unlock
DELIMITER //
DROP PROCEDURE IF EXISTS adminUnlockUser//
CREATE PROCEDURE adminUnlockUser(pUserName VARCHAR(32)) 
BEGIN
    UPDATE tblUser
    SET isLocked = false, loginAttempts = 0
    WHERE username = pUserName;

    SELECT CONCAT(pUserName + " has been unlocked") as Message;
END//
DELIMITER ;