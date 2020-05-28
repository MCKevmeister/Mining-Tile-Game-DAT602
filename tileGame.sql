DROP DATABASE IF EXISTS dbTileGame;
CREATE DATABASE dbTileGame;
USE dbTileGame;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Procdure to create the all of the tables in the database
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS makeTileGameDB//
CREATE PROCEDURE makeTileGameDB()
	BEGIN 
		CREATE TABLE tblUser(
			`username` VARCHAR(32) PRIMARY KEY,
            -- `userID` INTEGER AUTO_INCREMENT PRIMARY KEY, 
			`email` VARCHAR(64) NOT NULL,
            `userPassword` VARCHAR(64) NOT NULL,
            `loginAttempts` INTEGER NOT NULL DEFAULT 0,
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
			`itemDurability` INTEGER NOT NULL,
            `maxDurability` INTEGER NOT NULL,
			FOREIGN KEY (`matchingSkill`) REFERENCES tblSkill (`skillName`) ON UPDATE CASCADE
			);
            
		CREATE TABLE tblMine(
            `mineName` VARCHAR(20) PRIMARY KEY,
            -- `mineID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `minedBy` VARCHAR(32) NOT NULL,
            FOREIGN KEY (`minedBy`) REFERENCES tblItem (`itemName`) ON UPDATE CASCADE
			);
            
        CREATE TABLE tblMap(
			-- `mapID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `mapName` VARCHAR(16) PRIMARY KEY,
            `homeTileXLocation` INTEGER NOT NULL,
            `homeTileYLocation` INTEGER NOT NULL,
            `xSize` INTEGER NOT NULL,
            `ySize` INTEGER NOT NULL
			);

        CREATE TABLE tblTile(
			-- `tileID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `mapName` VARCHAR(16) NOT NULL,
            `xLocation` INTEGER NOT NULL,
            `yLocation` INTEGER NOT NULL,
            PRIMARY KEY (`mapName`, `xLocation`, `yLocation`),
            FOREIGN KEY (`mapName`) REFERENCES tblMap (`mapName`)
            );

        CREATE TABLE tblTileItem(
            `mapName` VARCHAR(16) NOT NULL,
            `xLocation` INTEGER NOT NULL,
            `yLocation` INTEGER NOT NULL,
            `itemName` VARCHAR(32) NOT NULL,
            FOREIGN KEY (`mapName`, `xLocation`, `yLocation`) REFERENCES tblTile (`mapName`, `xLocation`, `yLocation`), 
            FOREIGN KEY (`itemName`) REFERENCES tblItem (`itemName`) ON UPDATE CASCADE ON DELETE CASCADE,
            PRIMARY KEY (`mapName`, `xLocation`, `yLocation`, `itemName`)
            );

        CREATE TABLE tblCharacter(
            `characterName` VARCHAR(32) PRIMARY KEY,
            -- `characterID` INTEGER AUTO_INCREMENT ,
            `username` VARCHAR(32) NOT NULL,
            `xPosition` INTEGER,
            `yPosition` INTEGER,
            `characterScoreTotal` INTEGER NOT NULL DEFAULT 0,
            `isActive` BOOLEAN DEFAULT FALSE,
            FOREIGN KEY (`username`) REFERENCES tblUser (`username`) ON DELETE CASCADE ON UPDATE CASCADE
            );

        CREATE TABLE tblCharacterSkill(
			`characterName` VARCHAR(32) NOT NULL,
            `skillName`  VARCHAR(20) NOT NULL,
            FOREIGN KEY (`characterName`) REFERENCES tblCharacter (`characterName`) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY (`skillName`) REFERENCES tblSkill (`skillName`) ON UPDATE CASCADE,
            PRIMARY KEY (`characterName`, `skillName`)
			);

        CREATE TABLE tblChat(
			`chatID` INTEGER AUTO_INCREMENT PRIMARY KEY,
            `sender` VARCHAR(32) NOT NULL,
            `message` VARCHAR(255) NOT NULL,
            `timesent` DATETIME,
            FOREIGN KEY (`sender`) REFERENCES tblCharacter (`characterName`) ON DELETE CASCADE ON UPDATE CASCADE
            );

        CREATE TABLE tblCharacterItem(
            -- `characterItemID` AUTO_INCREMENT PRIMARY KEY,
			`characterName` VARCHAR(32) NOT NULL,
            `itemName` VARCHAR(32) NOT NULL,
            `quantity` INTEGER, 
            -- PRIMARY KEY (`characterName`, `itemName`),
            FOREIGN KEY (`characterName`) REFERENCES tblCharacter (`characterName`) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY (`itemName`) REFERENCES tblItem (`itemName`) ON UPDATE CASCADE
			);

        CREATE TABLE tblCharacterMap(
            `characterName` VARCHAR(32) NOT NULL,
            `mapName` VARCHAR(16) NOT NULL,
            `score` INTEGER DEFAULT 0,
            PRIMARY KEY (`characterName`, `mapName`),
            FOREIGN KEY (`characterName`) REFERENCES tblCharacter (`characterName`) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY (`mapName`) REFERENCES tblMap (`mapName`)
            );

        CREATE TABLE tblMineTile(
			`mineName` VARCHAR(20) NOT NULL,
            `mapName` VARCHAR(16) NOT NULL,
            `xLocation` INTEGER NOT NULL,
            `yLocation` INTEGER NOT NULL,
            PRIMARY KEY (`mineName`, `mapName`, `xLocation`, `yLocation`),
            FOREIGN KEY (`mineName`) REFERENCES tblMine (`mineName`),
            FOREIGN KEY (`mapName`, `xLocation`, `yLocation`) REFERENCES tblTile (`mapName`, `xLocation`, `yLocation`)
            );

        CREATE TABLE tblCharacterTile(
			`characterName` VARCHAR(32) NOT NULL,
            `mapName` VARCHAR(16) NOT NULL,
            `xLocation` INTEGER NOT NULL,
            `yLocation` INTEGER NOT NULL,
            PRIMARY KEY (`characterName`, `mapName`, `xLocation`, `yLocation`),
            FOREIGN KEY (`characterName`) REFERENCES tblCharacter (`characterName`),
            FOREIGN KEY (`mapName`, `xLocation`, `yLocation`) REFERENCES tblTile (`mapName`, `xLocation`, `yLocation`)
            );
	END//
DELIMITER ;

CALL makeTileGameDB();

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- INSERT Statements
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

INSERT INTO tblUser(`username`, `email`, `userPassword`, `loginAttempts`, `userscore`, `isLocked`, `isAdmin`, `isOnline`)
Values 
('Mark', 'kevin-christison@live.nmit.ac.nz', 'MarksPassword', 0, 0, false, true, false),
('John', 'johnsTilegameaccount@gmail.com', 'JohnsPassword', 0, 0, false, false, false),
('Mary', 'marysemail@yahoo.com', 'Maryhadalittlelamb', 0, 0, false, false, false),
('Stephen', 'stephen@gmail.com', 'stevesteve', 0, 0, false, true, false),
('Michael', 'mikeridesbikes@bikemail.com', 'bikebikebike', 0, 0, false, false, false);


INSERT INTO tblSkill(`skillName`, `skillDescription`)
Values 
('Miner', 'Gets points for mining gems with a pickaxe'),
('Gatherer', 'Gets points for collecting berries into the basket'),
('Fisher', 'Gets points for catching fish with a rod'),
('Woodcutter', 'Gets points for cutting down trees with an axe'),
('Archer', 'Gets points for shooting targets with a bow'),
('Smith', 'Gets points for using a hammer on an anvil');

INSERT INTO tblItem(`itemName`, `matchingSkill`, `itemDurability`, `maxDurability`)
Values 
('Pickaxe', 'Miner', 3, 3),
('Basket','Gatherer', 3, 3),
('Rod', 'Fisher', 3, 3),
('Axe', 'Woodcutter', 3, 3),
('Bow', 'Archer', 3, 3),
('Hammer', 'Smith', 3, 3);

INSERT INTO tblMine(`mineName`, `minedBy`)
Values 
('Gem', 'Pickaxe'),
('Berry', 'Basket'),
('Fish', 'Rod'),
('Tree', 'Axe'),
('Target', 'Bow'),
('Anvil', 'Hammer');

INSERT INTO tblMap(`homeTileXLocation`, `homeTileYLocation`,`xSize`, `ySize`)
Values

(3, 3, 5, 5),
(4, 4, 7, 7),
(5, 5, 11, 11),
(6, 6, 13, 13);

INSERT INTO tblTile(`mapName`, `xLocation`, `yLocation`)
Values 

("3 by 3", 1, 1), ("3 by 3", 1, 2), ("3 by 3", 1, 3),
("3 by 3", 2, 1), ("3 by 3", 2, 2), ("3 by 3", 2, 3),
("3 by 3", 3, 1), ("3 by 3", 3, 2), ("3 by 3", 3, 3),
("5 by 5", 1, 1), ("5 by 5", 1, 2), ("5 by 5", 1, 3), ("5 by 5", 1, 4), ("5 by 5", 1, 5),
("5 by 5", 2, 1), ("5 by 5", 2, 2), ("5 by 5", 2, 3), ("5 by 5", 2, 4), ("5 by 5", 2, 5),
("5 by 5", 3, 1), ("5 by 5", 3, 2), ("5 by 5", 3, 3), ("5 by 5", 3, 4), ("5 by 5", 3, 5),
("5 by 5", 4, 1), ("5 by 5", 4, 2), ("5 by 5", 4, 3), ("5 by 5", 4, 4), ("5 by 5", 4, 5),
("5 by 5", 5, 1), ("5 by 5", 5, 2), ("5 by 5", 5, 3), ("5 by 5", 5, 4), ("5 by 5", 5, 5),
("11 by 11", 1, 1), ("11 by 11", 1, 2), ("11 by 11", 1, 3), ("11 by 11", 1, 4), ("11 by 11", 1, 5), ("11 by 11", 1, 6), ("11 by 11", 1, 7), ("11 by 11", 1, 8), ("11 by 11", 1, 9), ("11 by 11", 1, 10), ("11 by 11", 1, 11),
("11 by 11", 2, 1), ("11 by 11", 2, 2), ("11 by 11", 2, 3), ("11 by 11", 2, 4), ("11 by 11", 2, 5), ("11 by 11", 2, 6), ("11 by 11", 2, 7), ("11 by 11", 2, 8), ("11 by 11", 2, 9), ("11 by 11", 2, 10), ("11 by 11", 2, 11),
("11 by 11", 3, 1), ("11 by 11", 3, 2), ("11 by 11", 3, 3), ("11 by 11", 3, 4), ("11 by 11", 3, 5), ("11 by 11", 3, 6), ("11 by 11", 3, 7), ("11 by 11", 3, 8), ("11 by 11", 3, 9), ("11 by 11", 3, 10), ("11 by 11", 3, 11),
("11 by 11", 4, 1), ("11 by 11", 4, 2), ("11 by 11", 4, 3), ("11 by 11", 4, 4), ("11 by 11", 4, 5), ("11 by 11", 4, 6), ("11 by 11", 4, 7), ("11 by 11", 4, 8), ("11 by 11", 4, 9), ("11 by 11", 4, 10), ("11 by 11", 4, 11),
("11 by 11", 5, 1), ("11 by 11", 5, 2), ("11 by 11", 5, 3), ("11 by 11", 5, 4), ("11 by 11", 5, 5), ("11 by 11", 5, 6), ("11 by 11", 5, 7), ("11 by 11", 5, 8), ("11 by 11", 5, 9), ("11 by 11", 5, 10), ("11 by 11", 5, 11),
("11 by 11", 6, 1), ("11 by 11", 6, 2), ("11 by 11", 6, 3), ("11 by 11", 6, 4), ("11 by 11", 6, 5), ("11 by 11", 6, 6), ("11 by 11", 6, 7), ("11 by 11", 6, 8), ("11 by 11", 6, 9), ("11 by 11", 6, 10), ("11 by 11", 6, 11),
("11 by 11", 7, 1), ("11 by 11", 7, 2), ("11 by 11", 7, 3), ("11 by 11", 7, 4), ("11 by 11", 7, 5), ("11 by 11", 7, 6), ("11 by 11", 7, 7), ("11 by 11", 7, 8), ("11 by 11", 7, 9), ("11 by 11", 7, 10), ("11 by 11", 7, 11),
("11 by 11", 8, 1), ("11 by 11", 8, 2), ("11 by 11", 8, 3), ("11 by 11", 8, 4), ("11 by 11", 8, 5), ("11 by 11", 8, 6), ("11 by 11", 8, 7), ("11 by 11", 8, 8), ("11 by 11", 8, 9), ("11 by 11", 8, 10), ("11 by 11", 8, 11),
("11 by 11", 9, 1), ("11 by 11", 9, 2), ("11 by 11", 9, 3), ("11 by 11", 9, 4), ("11 by 11", 9, 5), ("11 by 11", 9, 6), ("11 by 11", 9, 7), ("11 by 11", 9, 8), ("11 by 11", 9, 9), ("11 by 11", 9, 10), ("11 by 11", 9, 11),
("11 by 11", 10, 1), ("11 by 11", 10, 2), ("11 by 11", 10, 3), ("11 by 11", 10, 4), ("11 by 11"1, 10, 5), ("11 by 11", 10, 6), ("11 by 11", 10, 7), ("11 by 11", 10, 8), ("11 by 11", 10, 9), ("11 by 11", 10, 10), ("11 by 11", 10, 11),
("11 by 11", 11, 1), ("11 by 11", 11, 2), ("11 by 11", 11, 3), ("11 by 11", 11, 4), ("11 by 11"1, 11, 5), ("11 by 11", 11, 6), ("11 by 11", 11, 7), ("11 by 11", 11, 8), ("11 by 11", 11, 9), ("11 by 11", 11, 10), ("11 by 11", 11, 11),
("13 by 13", 1, 1), ("13 by 11", 1, 2), ("13 by 13", 1, 3), ("13 by 13", 1, 4), ("13 by 13", 1, 5), ("13 by 13", 1, 6), ("13 by 13", 1, 7), ("13 by 13", 1, 8), ("13 by 13", 1, 9), ("13 by 13", 1, 10), ("13 by 13", 1, 11), ("13 by 13", 1, 12), ("13 by 13", 1, 13),
("13 by 13", 2, 1), ("13 by 13", 2, 2), ("13 by 13", 2, 3), ("13 by 13", 2, 4), ("13 by 13", 2, 5), ("13 by 13", 2, 6), ("13 by 13", 2, 7), ("13 by 13", 2, 8), ("13 by 13", 2, 9), ("13 by 13", 2, 10), ("13 by 13", 2, 11), ("13 by 13", 2, 12), ("13 by 13", 2, 13),
("13 by 13", 3, 1), ("13 by 13", 3, 2), ("13 by 13", 3, 3), ("13 by 13", 3, 4), ("13 by 13", 3, 5), ("13 by 13", 3, 6), ("13 by 13", 3, 7), ("13 by 13", 3, 8), ("13 by 13", 3, 9), ("13 by 13", 3, 10), ("13 by 13", 3, 11), ("13 by 13", 3, 12), ("13 by 13", 3, 13),
("13 by 13", 4, 1), ("13 by 13", 4, 2), ("13 by 13", 4, 3), ("13 by 13", 4, 4), ("13 by 13", 4, 5), ("13 by 13", 4, 6), ("13 by 13", 4, 7), ("13 by 13", 4, 8), ("13 by 13", 4, 9), ("13 by 13", 4, 10), ("13 by 13", 4, 11), ("13 by 13", 4, 12), ("13 by 13", 4, 13),
("13 by 13", 5, 1), ("13 by 13", 5, 2), ("13 by 13", 5, 3), ("13 by 13", 5, 4), ("13 by 13", 5, 5), ("13 by 13", 5, 6), ("13 by 13", 5, 7), ("13 by 13", 5, 8), ("13 by 13", 5, 9), ("13 by 13", 5, 10), ("13 by 13", 5, 11), ("13 by 13", 5, 12), ("13 by 13", 5, 13),
("13 by 13", 6, 1), ("13 by 13", 6, 2), ("13 by 13", 6, 3), ("13 by 13", 6, 4), ("13 by 13", 6, 5), ("13 by 13", 6, 6), ("13 by 13", 6, 7), ("13 by 13", 6, 8), ("13 by 13", 6, 9), ("13 by 13", 6, 10), ("13 by 13", 6, 11), ("13 by 13", 6, 12), ("13 by 13", 6, 13),
("13 by 13", 7, 1), ("13 by 13", 7, 2), ("13 by 13", 7, 3), ("13 by 13", 7, 4), ("13 by 13", 7, 5), ("13 by 13", 7, 6), ("13 by 13", 7, 7), ("13 by 13", 7, 8), ("13 by 13", 7, 9), ("13 by 13", 7, 10), ("13 by 13", 7, 11), ("13 by 13", 7, 12), ("13 by 13", 7, 13),
("13 by 13", 8, 1), ("13 by 13", 8, 2), ("13 by 13", 8, 3), ("13 by 13", 8, 4), ("13 by 13", 8, 5), ("13 by 13", 8, 6), ("13 by 13", 8, 7), ("13 by 13", 8, 8), ("13 by 13", 8, 9), ("13 by 13", 8, 10), ("13 by 13", 8, 11), ("13 by 13", 8, 12), ("13 by 13", 8, 13),
("13 by 13", 9, 1), ("13 by 13", 9, 2), ("13 by 13", 9, 3), ("13 by 13", 9, 4), ("13 by 13", 9, 5), ("13 by 13", 9, 6), ("13 by 13", 9, 7), ("13 by 13", 9, 8), ("13 by 13", 9, 9), ("13 by 13", 9, 10), ("13 by 13", 9, 11), ("13 by 13", 9, 12), ("13 by 13", 9, 13),
("13 by 13", 10, 1), ("13 by 13", 10, 2), ("13 by 13", 10, 3), ("13 by 13", 10, 4), ("13 by 13"1, 10, 5), ("13 by 13", 10, 6), ("13 by 13", 10, 7), ("13 by 13", 10, 8), ("13 by 13", 10, 9), ("13 by 13", 10, 10), ("13 by 13", 10, 11), ("13 by 13", 10, 12), ("13 by 13", 10, 13),
("13 by 13", 11, 1), ("13 by 13", 11, 2), ("13 by 13", 11, 3), ("13 by 13", 11, 4), ("13 by 13"1, 11, 5), ("13 by 13", 11, 6), ("13 by 13", 11, 7), ("13 by 13", 11, 8), ("13 by 13", 11, 9), ("13 by 13", 11, 10), ("13 by 13", 11, 11), ("13 by 13", 11, 12), ("13 by 13", 11, 13),
("13 by 13", 12, 1), ("13 by 13", 12, 2), ("13 by 13", 12, 3), ("13 by 13", 12, 4), ("13 by 13"1, 12, 5), ("13 by 13", 12, 6), ("13 by 13", 12, 7), ("13 by 13", 12, 8), ("13 by 13", 12, 9), ("13 by 13", 12, 10), ("13 by 13", 12, 11), ("13 by 13", 12, 12), ("13 by 13", 12, 13),
("13 by 13", 13, 1), ("13 by 13", 13, 2), ("13 by 13", 13, 3), ("13 by 13", 13, 4), ("13 by 13"1, 13, 5), ("13 by 13", 13, 6), ("13 by 13", 13, 7), ("13 by 13", 13, 8), ("13 by 13", 13, 9), ("13 by 13", 13, 10), ("13 by 13", 13, 11), ("13 by 13", 13, 12), ("13 by 13", 13, 13);

 INSERT INTO tblTileItem(`mapName`, `xLocation`, `yLocation`, `itemName`)
 VALUES
 ('3 by 3', 1, 1, 'Pickaxe');
-- (18, 'Basket'),
-- (119, 'Rod'),
-- (78, 'Axe'),
-- (65, 'Bow'),
-- (50, 'Hammer'),
-- (128, 'Rod'),
-- (129, 'Bow'),
-- (130, 'Basket'); -- TODO

INSERT INTO tblCharacter(`characterName`, `username`, `xPosition`, `yPosition`,`characterScoreTotal`, `isActive`)
Values 
('MarkCharacter', 'Mark', 5, 5, 0, false),
('MaryCharacter', 'Mary', 5, 5, 0, false),
('JohnCharacter', 'John', 5, 5, 0, false),
('StepehnCharacter', 'Stephen', 2, 2, 0, false),
('MichaelCharacter', 'Michael', 2, 2, 0, false);

INSERT INTO tblCharacterSkill(`characterName`, `skillName`)
Values 
('MarkCharacter', 'Miner'), ('MarkCharacter','Gatherer'), ('MarkCharacter', 'Fisher'), ('MarkCharacter', 'Woodcutter'),
('MaryCharacter', 'Smith'), ('MaryCharacter', 'Archer'), ('MaryCharacter', 'Fisher'), ('MaryCharacter', 'Woodcutter'),
('JohnCharacter', 'Archer'), ('JohnCharacter', 'Gatherer'), ('JohnCharacter', 'Smith'), ('JohnCharacter', 'Miner'),
('StepehnCharacter', 'Smith'), ('StepehnCharacter', 'Archer'), ('StepehnCharacter', 'Fisher'), ('StepehnCharacter', 'Woodcutter'),
('MichaelCharacter', 'Archer'), ('MichaelCharacter', 'Gatherer'), ('MichaelCharacter', 'Smith'), ('MichaelCharacter', 'Miner');

INSERT INTO tblChat(`sender`, `message`)
Values 
('MarkCharacter', 'Hello world!'), ('MarkCharacter', 'Goodbye world!'),
('MaryCharacter', 'more words'), ('MaryCharacter', 'nice'),
('JohnCharacter', 'great'), ('JohnCharacter', 'less'),
('StepehnCharacter', 'I mean we could'), ('StepehnCharacter', 'That sounds great'),
('MichaelCharacter', 'Chocolate rain'), ('MichaelCharacter', 'we woo');

INSERT INTO tblCharacterItem(`characterName`, `itemName`, `quantity`)
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

--  TODO
-- INSERT INTO tblCharacterMap(`characterName`, `mapName`, `score`)
-- Values
-- ('MarkCharacter',"13 by 13",0),
-- ('MaryCharacter',"13 by 13",0),
-- ('JohnCharacter',"13 by 13",0),
-- ('StepehnCharacter',"5 by 5",0),
-- ('MichaelCharacter',"5 by 5",0);


-- INSERT INTO tblMineTile(`mineName`, `mapName`, `xLocation`, `yLocation`)-- needs updating
-- Values
-- ('Gem',2),
-- ('Berry',99),
-- ('Fish',27),
-- ('Tree',18),
-- ('Target',68),
-- ('Anvil',97),
-- ('Gem',	122),
-- ('Berry',123),
-- ('Fish'	,124);

-- INSERT INTO tblCharacterTile(`characterName`, `mapName`, `xLocation`, `yLocation`)-- needs updating
-- Values
-- ('MarkCharacter',60),
-- ('MaryCharacter',60),
-- ('JohnCharacter',60),
-- ('StepehnCharacter',126),
-- ('MichaelCharacter',126);

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
-- Register a User 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DROP PROCEDURE IF EXISTS registerUser;

DELIMITER //
CREATE PROCEDURE registerUser(pUserName VARCHAR(32), pEmail VARCHAR(64), pUserPassword VARCHAR(64))
BEGIN
START TRANSACTION;
    IF EXISTS (SELECT * FROM tblUser WHERE `username` = pUserName OR `email` = pEmail) THEN
        BEGIN
            SELECT "Username or Email already exists" AS `MESSAGE`;
        END;
    ELSE
        BEGIN
            INSERT INTO tblUser(`username` , `email`, `userPassword`) VALUES (pUserName, pEmail, pUserPassword);
            SELECT concat(pUserName ," has been registered") AS `MESSAGE`;
        END;
    END IF;
COMMIT;
END//
DELIMITER ;

CALL registerUser("steve", "steve", "steve");

SELECT * FROM tbluser;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Login with a user  
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DROP PROCEDURE IF EXISTS userLogin;

DELIMITER //
CREATE PROCEDURE userLogin(pUserName VARCHAR(32), pUserPassword VARCHAR(64))
BEGIN
    DECLARE lcUserName VARCHAR(32);
    DECLARE lcUserPassword VARCHAR(64);
    DECLARE lcUserIsLocked BOOLEAN;
    DECLARE lcUserLoginAttemps INT;
    START TRANSACTION;
        SELECT `username`, `userPassword`, `islocked`, `loginAttempts`
        FROM tblUser
        WHERE `username` = pUsername
        INTO lcUserName, lcUserPassword, lcUserIsLocked, lcUserLoginAttemps;
        IF (lcUserName IS NULL)
        THEN
            BEGIN
                SELECT "Username doesn't exist" AS `MESSAGE`;
            END;
        ELSEIF ((lcUserName = pUserName) AND (lcUserPassword <> pUserPassword))
        THEN 
            IF (lcUserLoginAttemps >= 5)
            THEN
                BEGIN
                    UPDATE tblUser
                    SET `isLocked` = 1
                    WHERE `username` = pUserName;
                    SELECT "User has been is locked out. Please contact an administrator to get this user unlocked" AS `MESSAGE`;
                END;
            ELSE
            BEGIN
                UPDATE tbluser
                SET `loginAttempts` = loginAttempts + 1
                WHERE `username` = pUserName;
                SELECT "Incorrect Password" AS `MESSAGE`;
            END;
            END IF;
        ELSEIF ((lcUserName = pUserName) AND (lcUserPassword = pUserPassword) AND (lcUserIsLocked = 0) AND (lcUserLoginAttemps < 5))
        THEN
            BEGIN
                UPDATE tbluser
                SET `isOnline` = true
                WHERE (`username` = pUserName AND `userPassword` = pUserPassword);
                SELECT CONCAT(pUserName, " is now Online") AS `MESSAGE`;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

call userLogin("foo", "f0oo");
SELECT * FROM tblUser;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Edit User 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS editUser//
CREATE PROCEDURE editUser(pUserName VARCHAR(32), pNewUserName VARCHAR(32), pNewUserPassword VARCHAR(64), pNewUserEmail VARCHAR(64))
BEGIN
    START TRANSACTION;
    IF EXISTS (SELECT * FROM tblUser WHERE `username` = pNewUserName) THEN
        BEGIN
            SELECT CONCAT("Sorry, the user name ", pNewUserName, " has already been taken") AS `Message`;
        END;
    ELSEIF EXISTS (SELECT * FROM tblUser WHERE `email` = pNewUserEmail)
    THEN
        BEGIN
            SELECT CONCAT("Sorry, the email ", pNewUserEmail, " is already is use") AS `Message`;
        END;
    ELSE
        BEGIN
            UPDATE tblUser
            SET `email` = pNewUserEmail, `userPassword` = pNewUserPassword, `username` = pNewUserName
            WHERE pUserName = `username`;
            SELECT "User detials have been updated" AS `Message`;
        END;
    END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Delete User 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS deleteUser//
CREATE PROCEDURE deleteUser(pUserName VARCHAR(32))
BEGIN
    START TRANSACTION;
        IF(EXISTS(SELECT * FROM tblUser WHERE `username` = pUserName)) THEN
            DELETE FROM tblUser
            WHERE `username` = pUserName;
            SELECT CONCAT(pUserName, " has been deleted") AS MESSAGE;
        ELSE
            SELECT CONCAT(pUserName, " doesn't exists") AS MESSAGE;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- User Creates Character (inlcuding character skills created) WORKING
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS createCharacter//
CREATE PROCEDURE createCharacter(pUserName VARCHAR(32), pCharacterName VARCHAR(32), pSkill1 VARCHAR(20), pSkill2 VARCHAR(20), pSkill3 VARCHAR(20), pSkill4 VARCHAR(20))
BEGIN
	START TRANSACTION;
    IF EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName)
	THEN
        BEGIN
            SELECT CONCAT("Sorry, the character ", pCharacterName, " has already been taken") AS MESSAGE;
        END;
    ELSE
		BEGIN
            INSERT INTO tblCharacter (`characterName`, `username`)
            VALUES(pCharacterName, pUserName);
            INSERT INTO tblCharacterSkill(`characterName`, `skillName`)
            VALUES(pCharacterName, pSkill1), (pCharacterName, pSkill2), (pCharacterName, pSkill3), (pCharacterName, pSkill4);
            SELECT CONCAT(pCharacterName, " has been created with ", pSkill1, ", ", pSkill2, ", ", pSkill3, "and ", pSkill4,, " as skills") AS MESSAGE;
        END;
	END IF;
	COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- User Deletes Character
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Get
DELIMITER //
DROP PROCEDURE IF EXISTS deleteCharacter//
CREATE PROCEDURE deleteCharacter(pCharacterName VARCHAR(32), pUserName VARCHAR(32))
BEGIN
    START TRANSACTION;
        IF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `username` = pUserName)
            DELETE FROM tblCharacter
            WHERE `characterName` = pCharacterName;
            SELECT CONCAT(pCharacterName, " has been deleted") AS MESSAGE;
        ELSE
            SELECT CONCAT(pCharacterName, " hasn't been deleted") AS MESSAGE;
        END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Select Character to play game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Return all characters a user has. usefull in a few places.
DELIMITER //
DROP PROCEDURE IF EXISTS getAllUserCharacters()//
CREATE PROCEDURE selectChagetAllUserCharactersracter(pUserName VARCHAR(32))
BEGIN
    START TRANSACTION;
        SELECT `characterName`
        FROM tblCharacter
        WHERE `username` = pUserName;
    COMMIT;
END//
DELIMITER ;

-- user selects character to play with
DELIMITER //
DROP PROCEDURE IF EXISTS selectCharacter//
CREATE PROCEDURE selectCharacter(pCharacterName VARCHAR(32))
BEGIN
    START TRANSACTION;
        IF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` = pUserName))
            BEGIN
                UPDATE `tblcharacter`
                SET isActive = 1
                WHERE `characterName` = pCharactername;
            END;
        ELSEIF (EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` <> pUserName))
            SELECT CONCAT(pCharacterName, " doesn't belong to this player") AS MESSAGE;
        ELSEIF (NOT EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName))
            SELECT CONCAT(pCharacterName, " doesn't exist") AS MESSAGE;
        END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Display a list of online characters
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS onlineCharacters//
CREATE PROCEDURE onlineCharacters()
BEGIN
    START TRANSACTION;
        SELECT *
        FROM tblcharacter
        WHERE `isOnline` = true;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Create Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Returns list of maps
-- User chooses from list of maps to play
DELIMITER //
DROP PROCEDURE IF EXISTS getMaps//
CREATE PROCEDURE getMaps()
BEGIN
    START TRANSACTION;
        SELECT `mapName`
        FROM tblmap;
    COMMIT;
END//
DELIMITER ;

-- Returns a list of online characters
-- Character is selected as opponent

DELIMITER //
DROP PROCEDURE IF EXISTS chooseOpponent//
CREATE PROCEDURE chooseOpponent()
BEGIN
START TRANSACTION;
    SELECT `characterName`
    FROM tblCharacter
    WHERE (`isActive`) = 1;
COMMIT;
END//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS createGame//
CREATE PROCEDURE createGame(pCharacter1 VARCHAR(32), pCharacter2 VARCHAR(32), pMap VARCHAR(16))
BEGIN
    START TRANSACTION;
        IF (EXISTS(SELECT * FROM tblCharacter WHERE `characterName` = pCharacter1) AND (SELECT * FROM tblCharacter WHERE `characterName` = pCharacter2 AND (SELECT * FROM tblMap WHERE `mapname` = pMap)))
            INSERT INTO tblCharacterMap 
            VALUES(pCharacter1, pMap), (pCharacter2, pMap);
            -- Spawn Items TODO
            -- Spawn Mines TODO
            SELECT CONCAT(pCharacter1, " and ", pCharacter2, " are now playing on ", pMap) AS MESSAGE
        ELSE
            SELECT "Unable to Create Game" AS MESSAGE;
    COMMIT;
END//
DELIMITER ;


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Leave Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Return a list of games the character is currently in
-- User makes a selection for game to leave

DELIMITER //
DROP PROCEDURE IF EXISTS getCharactersMaps//
CREATE PROCEDURE getCharactersMaps(pCharacterName VARCHAR(32))
BEGIN
START TRANSACTION;
    SELECT `mapName`
    FROM tblCharacterMap
    WHERE `characterName` = pCharacterName;
COMMIT;
END//
DELIMITER ;

-- Delete from tlbCharacterMap
DELIMITER //
DROP PROCEDURE IF EXISTS leaveCharacterMap//
CREATE PROCEDURE leaveCharacterMap(pCharacterName VARCHAR(32), pMap VARCHAR(16))
BEGIN
START TRANSACTION;
    DELETE FROM tblCharacterMap
    WHERE `characterName` = pCharacterName AND `mapName` = pMap;
COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return to Game in Progress
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- More of a GUI thing, switching from menu to game window?
-- Not really able to simulate in CLI??

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character makes Move
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS characterMakesMove//
CREATE PROCEDURE characterMakesMove(pCharacterName VARCHAR(32), pDirection VARCHAR(5), pMapName VARCHAR(16)) 
BEGIN
    START TRANSACTION;
    IF (pDirection = "left")
        IF (EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName))AND (NOT EXISTS (
                SELECT * 
                FROM tblCharacter c, tblCharacter t
                WHERE 
                (c.characterName = pCharacterName AND ((
                c.xPosition - 1 = t.xPosition AND
                c.yPosition = t.yPosition  AND
                t.characterName <> c.characterName) 
                OR c.xPosition - 1 < 1 ))
            ) 
            THEN 
            BEGIN
                UPDATE tblCharacter
                SET `xPosition` = `xPosition` - 1
                WHERE (characterName = pCharacterName);

                UPDATE tblCharacterMap
                SET `xPosition` = `xPosition` - 1
                WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                
                SELECT 'Moved Left' AS MESSAGE, pCharacterName as characterName;
            END; 
        ELSE
            SELECT 'Not able to move left' AS MESSAGE;
        END IF;
    ELSEIF (pDirection = "right")
        IF (EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName))AND (NOT EXISTS (
                SELECT * 
                FROM tblCharacter c, tblCharacter t
                WHERE 
                (c.characterName = pCharacterName AND ((
                c.xPosition + 1 = t.xPosition AND
                c.yPosition = t.yPosition  AND
                t.characterName <> c.characterName) 
                OR c.xPosition + 1 > (SELECT xSize FROM tblMap WHERE mapName = pMapName))) -- map max x-size
            )
            THEN 
            BEGIN
                UPDATE tblCharacter
                SET `xPosition` = `xPosition` + 1
                WHERE (characterName = pCharacterName);

                UPDATE tblCharacterMap
                SET `xPosition` = `xPosition` + 1
                WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                
                SELECT 'Moved right' AS MESSAGE, pCharacterName as characterName;
            END; 
        ELSE
            SELECT 'Not able to move right' AS MESSAGE;
        END IF;
    ELESEIF (pDirection = "up")
        IF (EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName))AND (NOT EXISTS (
                SELECT * 
                FROM tblCharacter c, tblCharacter t
                WHERE 
                (c.characterName = pCharacterName AND ((
                c.xPosition = t.xPosition AND
                c.yPosition - 1 = t.yPosition  AND
                t.characterName <> c.characterName) 
                OR c.yPosition - 1 < 1 )) -- map minimum y-size
            ) 
            THEN 
            BEGIN
                UPDATE tblCharacter
                SET `yPosition` = `yPosition` - 1
                WHERE (characterName = pCharacterName);

                UPDATE tblCharacterMap
                SET `yPosition` = `yPosition` - 1
                WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                
                SELECT 'Moved up' AS MESSAGE, pCharacterName as characterName;
            END; 
        ELSE
            SELECT 'Not able to move up' AS MESSAGE;
        END IF;
    ELSEIF (pDirection = "down")
        IF (EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName))AND (NOT EXISTS (
                SELECT * 
                FROM tblCharacter c, tblCharacter t
                WHERE 
                (c.characterName = pCharacterName AND ((
                c.xPosition = t.xPosition AND
                c.yPosition + 1 = t.yPosition  AND
                t.characterName <> c.characterName) 
                OR c.yPosition + 1 > (SELECT ySize FROM tblMap WHERE mapName = pMapName) )) -- map max y-size
            ) 
            THEN 
            BEGIN
                UPDATE tblCharacter
                SET `yPosition` = `yPosition` + 1
                WHERE (characterName = pCharacterName);

                UPDATE tblCharacterMap
                SET `yPosition` = `yPosition` + 1
                WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                
                SELECT 'Moved up' AS MESSAGE, pCharacterName as characterName;
            END; 
        ELSE
            SELECT 'Not able to move up' AS MESSAGE;
        END IF;
    END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character picks up item
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS characterPicksUpItem//
CREATE PROCEDURE characterPicksUpItem(pCharacterName VARCHAR(32), pMap VARCHAR(16), pXLocation INTEGER, pYLocation INTEGER) 
BEGIN
    DECLARE lcItem VARCHAR(32);
    START TRANSACTION;
        SELECT `itemName` FROM tblTileItem
        WHERE ((`mapName` = pMap) AND (`xLocation` = pXLocation) AND (`yLocation` = pYLocation))
        INTO lcItem;
    IF (lcItem is NULL)
    THEN
        BEGIN
            SELECT "There is no item on the tile" AS MESSAGE;
        END;
    ELSE
        BEGIN
            INSERT INTO tblCharacterItem
            VALUES (pCharacterName, lcItem, 1);
            DELETE FROM tblTileItem
            WHERE (`mapName` = pMap) AND (`xLocation` = pXLocation) AND (`yLocation` = pYLocation) AND (`itemName` = lcItem);
            SELECT CONCAT(pCharacterName, " has picked up", lcItem) AS MESSAGE;
        END;
    END IF;
    COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character Uses Item on Mine
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- get all maps a character is playing
-- character selects map c#
-- get all itmes belonging to a player
-- character selects item to use c#
-- check if tile has mine
    -- if true, check if item matches mine
        -- if true use item
            -- reduce itemDurability
            -- if itemDurability is <=0 DELETE item
            -- Add points to character and user

-- get all maps a character is playing
DELIMITER //
DROP PROCEDURE IF EXISTS getCharacterMaps//
CREATE PROCEDURE getCharacterMaps(pCharacterName VARCHAR(32))
BEGIN
    START TRANSACTION;
    IF EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName) THEN
        SELECT `mapName` FROM tblCharacterMap WHERE `characterName`= pCharacterName;
    ELSE
        SELECT CONCAT(pCharacterName, " does not exist") AS MESSAGE;
    END IF;
    COMMIT;
END//
DELIMITER ;       

DELIMITER //
DROP PROCEDURE IF EXISTS getCharacterItems//
CREATE PROCEDURE getCharacterItems(pCharacterName VARCHAR(32)) 
BEGIN
    START TRANSACTION;
        IF EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName) THEN
            SELECT `itemName` FROM tblCharacterItem WHERE `characterName` = pCharacterName;
        ELSE
            SELECT CONCAT(pCharacterName, " does not exist") AS MESSAGE;
        END IF;
    COMMIT;    --
END//

DELIMITER ;
DROP PROCEDURE IF EXISTS useItem//
CREATE PROCEDURE useItem(pCharacterName VARCHAR(32), pUserName VARCHAR(32), pItemName VARCHAR(32), pMap VARCHAR(16), pXLocation INTEGER, pYLocation INTEGER) 
BEGIN
    DECLARE lcMine VARCHAR(20);
    START TRANSACTION;
        SELECT `mineName` FROM tblMineTile
        WHERE ((`mapName` = pMap) AND (`xLocation` = pXLocation) AND (`yLocation` = pYLocation))
        INTO lcMine;
        IF (lcMine is NULL) THEN -- check if tile has mine
            SELECT "There is nothing to mine on this tile" AS MESSAGE;
        ELSEIF (EXISTS (SELECT * FROM tblMine WHERE (`mineName` = lcMine AND `minedBy` = pItemName))) THEN -- if true, check if item matches mine
            BEGIN
                UPDATE tblCharacterItem
                SET `itemDurability` = `itemDurability` - 1
                WHERE `itemName` = pItemName;-- this will do it for all items a character has of the same name...... grrr
                UPDATE tblCharacter -- Add points to character and user
                SET `characterScoreTotal` = `characterScoreTotal` + 1;
                UPDATE tblCharacterMap
                SET `score` = `score` + 1;
                UPDATE tblUser
                SET `userScore` = `userScore` + 1
                WHERE `username` = pUserName;
                IF (SELECT `itemDurability` FROM tblCharacterItem WHERE `itemDurability` <= 0) THEN
                    BEGIN
                        DELETE FROM tblCharacterItem
                        WHERE `itemDurability` <= 0;
                    END;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pItemName, "doesn't mine", lcMine) AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character chats
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS characterChats//
CREATE PROCEDURE characterChats(pCharacterName VARCHAR(32), pMessage VARCHAR(255)) 
BEGIN
    START TRANSACTION;
        INSERT INTO tblChat
        VALUES (pCharacterName, pMessage, NOW())
    COMMIT;
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
    START TRANSACTION;
        SELECT isAdmin
        FROM tblUser
        WHERE `username` = pUserName AND `userPassword` = pUserPassword;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin Kills Running Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return list of active games first
-- Admin selects game to end after


DROP PROCEDURE IF EXISTS getActiveGames;
DELIMITER //
CREATE PROCEDURE getActiveGames()
BEGIN
    START TRANSACTION;
        SELECT t1.characterName, t1.mapName, t2.characterName
        FROM tblCharacterMap AS t1, tblCharacterMap AS t2
        WHERE ((t1.charactername <> t2.CharacterName) AND (t1.mapName = t2.mapName));
    COMMIT;
END//
DELIMITER ; -- Doesn't yet work TODO

DELIMITER //
DROP PROCEDURE IF EXISTS adminKillGame//
CREATE PROCEDURE adminKillGame(pUserName VARCHAR(32)) 
BEGIN
-- TODO
END//
DELIMITER ;

call getActiveGames();

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
        WHERE `username` = pUserName OR `email` = pEmail)
    THEN
        BEGIN
            SELECT 'Username or Email already exists' AS MESSAGE;
        END;
    ELSE
        BEGIN
            INSERT INTO tblUser(`username` , `email`, `userPassword`, `isAdmin`)
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
CREATE PROCEDURE adminEditUser(pUserName VARCHAR(32) , pNewUserName VARCHAR(64), pEmail VARCHAR(64), pNewUserEmail VARCHAR(64), pUserPassword VARCHAR(64), pLoginAttempts INTEGER, pUserScore INTEGER, pIsLocked BOOLEAN, pIsAdmin BOOLEAN)
BEGIN
START TRANSACTION;
    IF EXISTS (SELECT * FROM tblUser WHERE `username` = pNewUserName)
    THEN
        BEGIN
            SELECT CONCAT("Sorry, the user name ", pNewUserName, " has already been taken") AS `Message`;
        END;
    ELSE IF EXISTS (SELECT * FROM tblUser WHERE `email` = pNewUserEmail)
    THEN
        BEGIN
            SELECT CONCAT("Sorry, the email ", pNewUserEmail, " is already is use") AS `Message`;
        END;
    ELSE
        UPDATE tblUser
        SET `email` = username, pNewUserName = pNewUserEmail, `userPassword` = pNewUserPassword, `loginAttempts` = pLoginAttempts, `userScore` = pUserScore
        WHERE pUserName = `username`;
    END IF;
    END IF;
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
    SELECT `username`
    FROM tblUser;
END//
DELIMITER ;

-- Delete a user
DELIMITER //
DROP PROCEDURE IF EXISTS adminDeleteUser//
CREATE PROCEDURE adminDeleteUser(pUserName VARCHAR(32))
START TRANSACTION;
	DELETE FROM tblUser 
    WHERE `username` = pUserName;

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
    SELECT `username`
    FROM tblUser
    WHERE `isLocked` = true;
END//
DELIMITER ;
-- Choose user to unlock
DELIMITER //
DROP PROCEDURE IF EXISTS adminUnlockUser//
CREATE PROCEDURE adminUnlockUser(pUserName VARCHAR(32)) 
BEGIN
    UPDATE tblUser
    SET `isLocked` = false, `loginAttempts` = 0
    WHERE `username` = pUserName;

    SELECT CONCAT(pUserName + " has been unlocked") as Message;
END//
DELIMITER ;