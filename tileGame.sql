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
			-- `itemDurability` INTEGER NOT NULL, -- not necssary here
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
            FOREIGN KEY (mapName) REFERENCES tblMap (mapName) ON UPDATE CASCADE
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
            `itemDurability` INTEGER NOT NULL,
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
            FOREIGN KEY (`characterName`) REFERENCES tblCharacter (`characterName`) ON DELETE CASCADE ON UPDATE CASCADE,
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

INSERT INTO tblItem(`itemName`, `matchingSkill`, `maxDurability`)
Values 
('Pickaxe', 'Miner', 3),
('Basket','Gatherer', 3),
('Rod', 'Fisher', 3),
('Axe', 'Woodcutter', 3),
('Bow', 'Archer', 3),
('Hammer', 'Smith', 3);

INSERT INTO tblMine(`mineName`, `minedBy`)
Values 
('Gem', 'Pickaxe'),
('Berry', 'Basket'),
('Fish', 'Rod'),
('Tree', 'Axe'),
('Target', 'Bow'),
('Anvil', 'Hammer');

INSERT INTO tblMap(`mapName`, `homeTileXLocation`, `homeTileYLocation`,`xSize`, `ySize`)
Values

("3 by 3", 2, 2, 5, 5),
("5 by 5", 3, 3, 5, 5),
("11 by 11", 5, 5, 11, 11),
("13 by 13", 6, 6, 13, 13);

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
("11 by 11", 10, 1), ("11 by 11", 10, 2), ("11 by 11", 10, 3), ("11 by 11", 10, 4), ("11 by 11", 10, 5), ("11 by 11", 10, 6), ("11 by 11", 10, 7), ("11 by 11", 10, 8), ("11 by 11", 10, 9), ("11 by 11", 10, 10), ("11 by 11", 10, 11),
("11 by 11", 11, 1), ("11 by 11", 11, 2), ("11 by 11", 11, 3), ("11 by 11", 11, 4), ("11 by 11", 11, 5), ("11 by 11", 11, 6), ("11 by 11", 11, 7), ("11 by 11", 11, 8), ("11 by 11", 11, 9), ("11 by 11", 11, 10), ("11 by 11", 11, 11),
("13 by 13", 1, 1), ("13 by 13", 1, 2), ("13 by 13", 1, 3), ("13 by 13", 1, 4), ("13 by 13", 1, 5), ("13 by 13", 1, 6), ("13 by 13", 1, 7), ("13 by 13", 1, 8), ("13 by 13", 1, 9), ("13 by 13", 1, 10), ("13 by 13", 1, 11), ("13 by 13", 1, 12), ("13 by 13", 1, 13),
("13 by 13", 2, 1), ("13 by 13", 2, 2), ("13 by 13", 2, 3), ("13 by 13", 2, 4), ("13 by 13", 2, 5), ("13 by 13", 2, 6), ("13 by 13", 2, 7), ("13 by 13", 2, 8), ("13 by 13", 2, 9), ("13 by 13", 2, 10), ("13 by 13", 2, 11), ("13 by 13", 2, 12), ("13 by 13", 2, 13),
("13 by 13", 3, 1), ("13 by 13", 3, 2), ("13 by 13", 3, 3), ("13 by 13", 3, 4), ("13 by 13", 3, 5), ("13 by 13", 3, 6), ("13 by 13", 3, 7), ("13 by 13", 3, 8), ("13 by 13", 3, 9), ("13 by 13", 3, 10), ("13 by 13", 3, 11), ("13 by 13", 3, 12), ("13 by 13", 3, 13),
("13 by 13", 4, 1), ("13 by 13", 4, 2), ("13 by 13", 4, 3), ("13 by 13", 4, 4), ("13 by 13", 4, 5), ("13 by 13", 4, 6), ("13 by 13", 4, 7), ("13 by 13", 4, 8), ("13 by 13", 4, 9), ("13 by 13", 4, 10), ("13 by 13", 4, 11), ("13 by 13", 4, 12), ("13 by 13", 4, 13),
("13 by 13", 5, 1), ("13 by 13", 5, 2), ("13 by 13", 5, 3), ("13 by 13", 5, 4), ("13 by 13", 5, 5), ("13 by 13", 5, 6), ("13 by 13", 5, 7), ("13 by 13", 5, 8), ("13 by 13", 5, 9), ("13 by 13", 5, 10), ("13 by 13", 5, 11), ("13 by 13", 5, 12), ("13 by 13", 5, 13),
("13 by 13", 6, 1), ("13 by 13", 6, 2), ("13 by 13", 6, 3), ("13 by 13", 6, 4), ("13 by 13", 6, 5), ("13 by 13", 6, 6), ("13 by 13", 6, 7), ("13 by 13", 6, 8), ("13 by 13", 6, 9), ("13 by 13", 6, 10), ("13 by 13", 6, 11), ("13 by 13", 6, 12), ("13 by 13", 6, 13),
("13 by 13", 7, 1), ("13 by 13", 7, 2), ("13 by 13", 7, 3), ("13 by 13", 7, 4), ("13 by 13", 7, 5), ("13 by 13", 7, 6), ("13 by 13", 7, 7), ("13 by 13", 7, 8), ("13 by 13", 7, 9), ("13 by 13", 7, 10), ("13 by 13", 7, 11), ("13 by 13", 7, 12), ("13 by 13", 7, 13),
("13 by 13", 8, 1), ("13 by 13", 8, 2), ("13 by 13", 8, 3), ("13 by 13", 8, 4), ("13 by 13", 8, 5), ("13 by 13", 8, 6), ("13 by 13", 8, 7), ("13 by 13", 8, 8), ("13 by 13", 8, 9), ("13 by 13", 8, 10), ("13 by 13", 8, 11), ("13 by 13", 8, 12), ("13 by 13", 8, 13),
("13 by 13", 9, 1), ("13 by 13", 9, 2), ("13 by 13", 9, 3), ("13 by 13", 9, 4), ("13 by 13", 9, 5), ("13 by 13", 9, 6), ("13 by 13", 9, 7), ("13 by 13", 9, 8), ("13 by 13", 9, 9), ("13 by 13", 9, 10), ("13 by 13", 9, 11), ("13 by 13", 9, 12), ("13 by 13", 9, 13),
("13 by 13", 10, 1), ("13 by 13", 10, 2), ("13 by 13", 10, 3), ("13 by 13", 10, 4), ("13 by 13", 10, 5), ("13 by 13", 10, 6), ("13 by 13", 10, 7), ("13 by 13", 10, 8), ("13 by 13", 10, 9), ("13 by 13", 10, 10), ("13 by 13", 10, 11), ("13 by 13", 10, 12), ("13 by 13", 10, 13),
("13 by 13", 11, 1), ("13 by 13", 11, 2), ("13 by 13", 11, 3), ("13 by 13", 11, 4), ("13 by 13", 11, 5), ("13 by 13", 11, 6), ("13 by 13", 11, 7), ("13 by 13", 11, 8), ("13 by 13", 11, 9), ("13 by 13", 11, 10), ("13 by 13", 11, 11), ("13 by 13", 11, 12), ("13 by 13", 11, 13),
("13 by 13", 12, 1), ("13 by 13", 12, 2), ("13 by 13", 12, 3), ("13 by 13", 12, 4), ("13 by 13", 12, 5), ("13 by 13", 12, 6), ("13 by 13", 12, 7), ("13 by 13", 12, 8), ("13 by 13", 12, 9), ("13 by 13", 12, 10), ("13 by 13", 12, 11), ("13 by 13", 12, 12), ("13 by 13", 12, 13),
("13 by 13", 13, 1), ("13 by 13", 13, 2), ("13 by 13", 13, 3), ("13 by 13", 13, 4), ("13 by 13", 13, 5), ("13 by 13", 13, 6), ("13 by 13", 13, 7), ("13 by 13", 13, 8), ("13 by 13", 13, 9), ("13 by 13", 13, 10), ("13 by 13", 13, 11), ("13 by 13", 13, 12), ("13 by 13", 13, 13);

 INSERT INTO tblTileItem(`mapName`, `xLocation`, `yLocation`, `itemName`)
 VALUES
 ('3 by 3', 1, 1, 'Pickaxe'),
 ('3 by 3', 3, 3, 'Basket'),
 ('5 by 5', 2, 4, 'Pickaxe'),
 ('5 by 5', 3, 5, 'Rod'),
 ('5 by 5', 4, 3, 'Axe'),
 ('5 by 5', 5, 5, 'Bow'),
 ('5 by 5', 1, 3, 'Hammer');

INSERT INTO tblCharacter(`characterName`, `username`, `xPosition`, `yPosition`,`characterScoreTotal`, `isActive`)
Values 
('MarkCharacter', 'Mark', 2, 2, 0, false),
('MaryCharacter', 'Mary', 2, 2, 0, false),
('JohnCharacter', 'John', 2, 2, 0, false),
('StepehnCharacter', 'Stephen', 3, 3, 0, false),
('MichaelCharacter', 'Michael', 3, 3, 0, false);

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

INSERT INTO tblCharacterItem(`characterName`, `itemName`, `quantity`, `itemDurability`)
Values ('MarkCharacter','Pickaxe',1,3),
('MarkCharacter','Basket',1,3),
('MarkCharacter','Rod',1,3),
('MaryCharacter','Bow',1,3),
('MaryCharacter','Rod',1,3),
('MaryCharacter','Axe',1,3),
('JohnCharacter','Bow',1,3),
('JohnCharacter','Basket',1,3),
('JohnCharacter','Hammer',1,3),
('JohnCharacter','Pickaxe',1,3),
('StepehnCharacter','Hammer',1,3),
('StepehnCharacter','Bow',1,3),
('StepehnCharacter','Rod',1,3),
('StepehnCharacter','Axe',1,3),
('MichaelCharacter','Bow',1,3),
('MichaelCharacter','Basket',1,3),
('MichaelCharacter','Hammer',1,3),
('MichaelCharacter','Pickaxe',1,3);

INSERT INTO tblCharacterMap(`characterName`, `mapName`, `score`)
Values
('MarkCharacter',"3 by 3",0),
('MaryCharacter',"3 by 3",0),
('JohnCharacter',"5 by 5",0),
('StepehnCharacter',"5 by 5",0),
('MichaelCharacter',"5 by 5",0);

INSERT INTO tblMineTile(`mineName`, `mapName`, `xLocation`, `yLocation`)
Values
('Gem', "3 by 3", 1, 3),
('Berry',"3 by 3", 3, 1),
('Fish', "5 by 5", 1, 2),
('Tree', "5 by 5", 2, 3),
('Target', "5 by 5", 4, 4),
('Anvil', "5 by 5", 4, 1),
('Gem',	 "5 by 5", 2, 5);

INSERT INTO tblCharacterTile(`characterName`, `mapName`, `xLocation`, `yLocation`)
Values
('MarkCharacter', "3 by 3", 2, 2),
('MaryCharacter', "3 by 3", 2, 2),
('JohnCharacter', "5 by 5", 3, 3),
('StepehnCharacter', "5 by 5", 3, 3),
('MichaelCharacter', "5 by 5", 3, 3);

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
call registeruser("foo", "foo", "foo");

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
    DECLARE lcUserLoginAttempts INT;
    START TRANSACTION;
        SELECT `username`, `userPassword`, `islocked`, `loginAttempts`
        FROM tblUser
        WHERE `username` = pUsername
        INTO lcUserName, lcUserPassword, lcUserIsLocked, lcUserLoginAttempts;
        IF (lcUserName IS NULL)
        THEN
            BEGIN
                SELECT "Username doesn't exist" AS `MESSAGE`;
            END;
        ELSEIF ((lcUserName = pUserName) AND (lcUserPassword <> pUserPassword)) THEN
            BEGIN
                UPDATE tbluser
                SET `loginAttempts` = lcUserLoginAttempts + 1
                WHERE `username` = pUserName;
                SET lcUserLoginAttempts = lcUserLoginAttempts + 1;
                SELECT "Incorrect Password" AS `MESSAGE`;
            END;
        ELSEIF ((lcUserName = pUserName) AND (lcUserPassword = pUserPassword) AND ((lcUserLoginAttempts >= 5) OR (lcUserIsLocked)))
        THEN
            BEGIN
                UPDATE tblUser
                SET `isLocked` = 1
                WHERE `username` = pUserName;
                SELECT "User has been is locked out. Please contact an administrator to get this user unlocked" AS `MESSAGE`;
            END;
        ELSEIF ((lcUserName = pUserName) AND (lcUserPassword = pUserPassword) AND (lcUserIsLocked = 0) AND (lcUserLoginAttempts < 5))
        THEN
            BEGIN
                UPDATE tbluser
                SET `isOnline` = true, `loginAttempts` = 0
                WHERE (`username` = pUserName AND `userPassword` = pUserPassword);
                SELECT CONCAT(pUserName, " is now Online") AS `MESSAGE`;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

call userLogin("steve", "steve");
SELECT * FROM tblUser;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Edit User 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS editUser//
CREATE PROCEDURE editUser(pUserName VARCHAR(32), pNewUserName VARCHAR(32), pNewUserPassword VARCHAR(64), pNewUserEmail VARCHAR(64))
BEGIN
    START TRANSACTION;
		IF NOT EXISTS (SELECT * FROM tblUser WHERE `username` = pUserName) THEN
			BEGIN
				SELECT CONCAT("Sorry, the user ", pUserName, " doesn't exist") AS MESSAGE;
			END;
		ELSEIF EXISTS (SELECT * FROM tblUser WHERE `username` = pNewUserName) THEN
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

call editUser("steve", "foo", "foo", "foo");

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
		END IF;
    COMMIT;
END//
DELIMITER ;

call deleteUser("foo");
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- User Creates Character (inlcuding character skills created) WORKING
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS createCharacter//
CREATE PROCEDURE createCharacter(pUserName VARCHAR(32), pCharacterName VARCHAR(32), pSkill1 VARCHAR(20), pSkill2 VARCHAR(20), pSkill3 VARCHAR(20), pSkill4 VARCHAR(20))
BEGIN
	START TRANSACTION;
		IF EXISTS(SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName)
		THEN
			BEGIN
				SELECT CONCAT("Sorry, the character ", pCharacterName, " has already been taken") AS MESSAGE;
			END;
		ELSE
			BEGIN
				INSERT INTO tblCharacter(`characterName`, `username`)
				VALUES(pCharacterName, pUserName);
				
				INSERT INTO tblCharacterSkill(`characterName`, `skillName`)
				VALUES(pCharacterName, pSkill1),(pCharacterName, pSkill2),(pCharacterName,pSkill3),(pCharacterName,pSkill4);
                SELECT CONCAT(pCharacterName, " has been created with ", pSkill1, ", ", pSkill2, ", ", pSkill3, " and ", pSkill4, " as skills") AS MESSAGE;
			END;
		END IF;
	COMMIT;
END//
DELIMITER ;

call createCharacter("steve", "stever", "Miner","Gatherer","Fisher","Woodcutter");
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- User Deletes Character
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return all characters a user has. Also used in select character to play game

DELIMITER //
DROP PROCEDURE IF EXISTS getAllUserCharacters//
CREATE PROCEDURE getAllUserCharacters(pUserName VARCHAR(32))
BEGIN
    START TRANSACTION;
        SELECT `characterName`
        FROM tblCharacter
        WHERE `username` = pUserName;
    COMMIT;
END//
DELIMITER ;

call getAllUserCharacters("steve");

DELIMITER //
DROP PROCEDURE IF EXISTS deleteCharacter//
CREATE PROCEDURE deleteCharacter(pCharacterName VARCHAR(32), pUserName VARCHAR(32))
BEGIN
    START TRANSACTION;
        IF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `username` = pUserName)) THEN
			BEGIN
				DELETE FROM tblCharacter
				WHERE `characterName` = pCharacterName;
				SELECT CONCAT(pCharacterName, " has been deleted") AS MESSAGE;
			END;
        ELSE
			BEGIN
				SELECT CONCAT(pCharacterName, " hasn't been deleted") AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

call deleteCharacter("bar", "foo");

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Select Character to play game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- user selects character to play with
DELIMITER //
DROP PROCEDURE IF EXISTS selectCharacter//
CREATE PROCEDURE selectCharacter(pCharacterName VARCHAR(32), pUserName VARCHAR(32))
BEGIN
    START TRANSACTION;
        IF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` = pUserName)) THEN
            BEGIN
                UPDATE `tblcharacter`
                SET isActive = 1
                WHERE `characterName` = pCharactername;
            END;
        ELSEIF (EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` <> pUserName))) THEN
            SELECT CONCAT(pCharacterName, " doesn't belong to this player") AS MESSAGE;
        ELSEIF (NOT EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName))) THEN
            SELECT CONCAT(pCharacterName, " doesn't exist") AS MESSAGE;
        END IF;
    COMMIT;
END//
DELIMITER ;

call selectCharacter("stever", "steve"); -- might need to signal some how TODO SIGNAL STATE???
SELECT * FROM tblCharacter;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Display a list of online characters
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS onlineCharacters//
CREATE PROCEDURE onlineCharacters()
BEGIN
    START TRANSACTION;
        SELECT `characterName`
        FROM tblcharacter
        WHERE `isActive` = true;
    COMMIT;
END//
DELIMITER ;

call onlineCharacters();
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Create Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Returns list of maps
-- User chooses from list of maps to play in C# app
-- set character location to home tile of map
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

call getMaps();

-- Returns a list of online characters
-- Character is selected as opponent
DELIMITER //
DROP PROCEDURE IF EXISTS chooseOpponent//
CREATE PROCEDURE chooseOpponent(pCharacterName VARCHAR(32))
BEGIN
START TRANSACTION;
    SELECT `characterName`
    FROM tblCharacter
    WHERE (`isActive` = 1 AND `characterName` <> pCharacterName);
COMMIT;
END//
DELIMITER ;

call chooseOpponent("steve");
DELIMITER //
DROP PROCEDURE IF EXISTS createGame//
CREATE PROCEDURE createGame(pCharacter1 VARCHAR(32), pCharacter2 VARCHAR(32), pMap VARCHAR(16))
BEGIN
	DECLARE lcXHome INTEGER;
    DECLARE lcYHome INTEGER;
    DECLARE lcXMax INTEGER;
    DECLARE lcYMax INTEGER;
    DECLARE i INTEGER;
    DECLARE xSpawn INTEGER;
    DECLARE ySpawn INTEGER;
    DECLARE itemSpawn INTEGER;
    DECLARE itemSpawnName VARCHAR(32);
    DECLARE itemCount INTEGER;
    DECLARE mineSpawn INTEGER;
    DECLARE mineSpawnName VARCHAR(32);
    START TRANSACTION;
		SELECT COUNT(`itemName`) FROM tblItem INTO itemCount;
        SELECT `homeTileXLocation`, `homeTileYLocation`
        FROM tblMap
        WHERE `mapName` = pMap
        INTO lcXHome, lcYHome;

        SELECT xSize, ySize
        FROM tblMap
        WHERE `mapName` = pMap
        INTO lcXMax, lcYMax;
        IF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacter1) AND 
			EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacter2 AND `isActive` = 1) AND 
			EXISTS (SELECT * FROM tblMap WHERE `mapname` = pMap)) THEN
            BEGIN
                INSERT INTO tblCharacterMap (`characterName`, `mapName`)
                VALUES(pCharacter1, pMap), (pCharacter2, pMap);
                INSERT INTO tblCharacterTile(`characterName`, `mapName`, `xLocation`, `yLocation`)
                VALUES (pCharacter1, pMap, lcXHome, lcYHome), (pCharacter2, pMap, lcXHome, lcYHome);
                BEGIN
                spawnItem: LOOP
                    IF (i < lcXMax) THEN -- using X map size arbitarily to not spawn that many items for a certian map size
                            SELECT round((RAND() * (lcXMax)) + 1) into xSpawn;
                            SELECT round((RAND() * (lcXMax)) + 1) into ySpawn;
		                    SELECT round((RAND() * (itemCount)) + 1) into itemSpawn;
                            CASE itemSpawn
                                WHEN 1 THEN SET itemSpawnName = 'Pickaxe';
                                WHEN 2 THEN SET itemSpawnName = 'Basket';
                                WHEN 3 THEN SET itemSpawnName = 'Rod'; 
                                WHEN 4 THEN SET itemSpawnName = 'Axe'; 
                                WHEN 5 THEN SET itemSpawnName = 'Bow'; 
                                WHEN 6 THEN SET itemSpawnName = 'Hammer';  -- switch case to catch all the 6 outcomes
                            END CASE;
							INSERT INTO tblTileItem (`mapName`, `xLocation`, `yLocation`, `itemName`)
                            VALUES (pMap, xSpawn, ySpawn, itemSpawn);
							SET i = i + 1;
							ITERATE spawnItem;
                    END IF;
                    LEAVE spawnItem;
                END LOOP spawnItem;
                spawnMine: LOOP
                    IF (i < lcXMax) THEN -- using X map size arbitarily to not spawn that many mines for a certian map size
                            SELECT round(RAND() * (lcXMax)) + 1 into xSpawn;
                            SELECT round(RAND() * (lcXMax)) + 1 into ySpawn;
		                    SELECT round(RAND() * (itemCount)) + 1 into mineSpawn;
                            IF EXISTS(SELECT * FROM tblTileItem WHERE ((`mapName` = pMap) AND (`xLocation` = xSpawn) AND (`yLocation` = ySpawn))) THEN
                                    ITERATE spawnMine;
							END IF;
                            CASE itemSpawn 
                                WHEN 1 THEN SET mineSpawnName = 'Gem';
                                WHEN 2 THEN SET mineSpawnName = 'Berry';
                                WHEN 3 THEN SET mineSpawnName = 'Fish'; 
                                WHEN 4 THEN SET mineSpawnName = 'Tree'; 
                                WHEN 5 THEN SET mineSpawnName = 'Target'; 
                                WHEN 6 THEN SET mineSpawnName = 'Anvil';
                            END CASE;

							INSERT INTO tblTileItem (`mapName`, `xLocation`, `yLocation`, `mineName`) 
                            VALUES (pMap, xSpawn, ySpawn, mineSpawn);
							SET i = i + 1;
							ITERATE spawnMine;
                    END IF;
                    LEAVE spawnMine;
                END LOOP spawnMine;
                END;
                SELECT CONCAT(pCharacter1, " and ", pCharacter2, " are now playing on ", pMap) AS MESSAGE;
            END;
        ELSE
            BEGIN
                SELECT "Unable to Create Game" AS MESSAGE;
            END;
		END IF;
    COMMIT;
END//
DELIMITER ;

call createGame("steve", "steve", "13 by 13"); -- note character can only play one game at a time

DELETE FROM tblCharacterMap
WHERE `characterName` = "steve" OR `characterName` = "stever";
DELETE FROM tblCharacterTile
WHERE `characterName` = "steve" OR `characterName` = "stever";

SELECT * FROM tblCharacterMap;
SELECT * FROM tblCharacterTile;
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

Call getCharactersMaps("steve");

-- Delete from tlbCharacterMap
DELIMITER //
DROP PROCEDURE IF EXISTS leaveCharacterMap//
CREATE PROCEDURE leaveCharacterMap(pCharacterName VARCHAR(32), pMap VARCHAR(16))
BEGIN
START TRANSACTION;
    DELETE FROM tblCharacterMap
    WHERE `characterName` = pCharacterName AND `mapName` = pMap;
    SELECT CONCAT(pcharacterName, " has left the game") AS MESSAGE;
COMMIT;
END//
DELIMITER ;

call leaveCharacterMap("stever", "13 by 13"); -- TODO
SELECT * FROM tblCharacterTile WHERE `characterName` = "stever";
SELECT * FROM tblCharactermap WHERE `characterName` = "stever";
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return to Game in Progress
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS getMapsCharacterHasLeft//
CREATE PROCEDURE getMapsCharacterHasLeft(pCharacterName VARCHAR(32))
BEGIN
DECLARE lcMap VARCHAR(32);
-- DECLARE lcX INTEGER;
-- DECLARE lcY INTEGER;
START TRANSACTION;
	SELECT `mapName`
	FROM tblCharacterTile
    WHERE `characterName` = pCharacterName
    INTO lcMap;
    -- SELECT `xPosition`, `yPosition`
    -- FROM tblCharacter
    -- WHERE `characterName` = pCharacterName;
    IF (lcMap IS NOT NULL) AND
    (NOT EXISTS (
        SELECT `mapName`
        FROM tblCharacterMap
        WHERE (`characterName` = pCharacterName))) THEN
        BEGIN
            INSERT INTO tblCharacterMap
            VALUES (pCharacterName, lcMap);
            SELECT CONCAT(pCharacterName, " has rejoined the game") -- TODO double check when not tired
        END;
    END IF;
COMMIT;
END//
DELIMITER ;

call getMapsCharacterhasLeft("steve");
-- More of a GUI thing, switching from menu to game window?
-- Not really able to simulate in CLI??
-- maybe more a menu switch in C# app to allow new inputs

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character makes Move
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DELIMITER //
DROP PROCEDURE IF EXISTS characterMakesMove//
CREATE PROCEDURE characterMakesMove(pCharacterName VARCHAR(32), pDirection VARCHAR(5), pMapName VARCHAR(16)) 
BEGIN
    START TRANSACTION;
    IF (pDirection = "left") THEN
        IF (EXISTS (SELECT * FROM tblCharacterMap WHERE characterName = pCharacterName)) AND 
            (EXISTS (SELECT * 
				FROM tblCharacterTile as CT
				WHERE (
                CT.characterName = pCharacterName AND
                CT.mapName = pMapName AND
                CT.xLocation - 1 >= 1))) AND
            (NOT EXISTS (
                SELECT * 
                FROM tblCharacterTile c, tblCharacterTile t, tblMap q
                WHERE 
                (c.characterName = pCharacterName AND ( -- check if character exists, no character exists at new x and y and and map x and y are inside map boundary
                c.xLocation - 1 = t.xLocation AND
                c.yLocation = t.yLocation  AND
                c.mapName = t.mapName AND
                t.characterName <> c.characterName)))) THEN
            BEGIN
                UPDATE tblCharacter
                SET `xPosition` = `xPosition` - 1
                WHERE (characterName = pCharacterName);
                UPDATE tblCharacterTile
                SET `xLocation` = `xLocation` - 1
                WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                SELECT CONCAT(pCharacterName, ' Moved Left') AS MESSAGE, pCharacterName as characterName;
            END; 
        ELSE
            SELECT 'Not able to move left' AS MESSAGE;
        END IF;
    ELSEIF (pDirection = "right") THEN
        IF (EXISTS (SELECT * FROM tblCharacterMap WHERE characterName = pCharacterName)) AND
            (EXISTS (SELECT * 
				FROM tblCharacterTile as CT
				WHERE (
                CT.characterName = pCharacterName AND
                CT.mapName = pMapName AND
                CT.xLocation + 1 <= (SELECT xSize FROM tblMap WHERE mapName = pMapName)))) AND
            (NOT EXISTS (
                SELECT * 
                FROM tblCharacterTile c, tblCharacterTile t, tblMap q
                WHERE 
                (c.characterName = pCharacterName AND (
                c.xLocation + 1 = t.xLocation AND
                c.yLocation = t.yLocation  AND
                c.mapName = t.mapName AND
                t.characterName <> c.characterName)))) THEN 
				BEGIN
					UPDATE tblCharacter
					SET `xPosition` = `xPosition` + 1
					WHERE (characterName = pCharacterName);
					UPDATE tblCharacterTile
					SET `xLocation` = `xLocation` + 1
					WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
					SELECT CONCAT(pCharacterName, ' Moved right') AS MESSAGE, pCharacterName as characterName;
				END; 
        ELSE
			BEGIN
				SELECT 'Not able to move right' AS MESSAGE;
			END; 	
        END IF;
    ELSEIF (pDirection = "up") THEN
        IF (EXISTS (SELECT * FROM tblCharacterMap WHERE characterName = pCharacterName)) AND 
            (EXISTS (SELECT * 
				FROM tblCharacterTile as CT
				WHERE (
                CT.characterName = pCharacterName AND
                CT.mapName = pMapName AND
                CT.yLocation - 1 >= 1 ))) AND
            (NOT EXISTS (
                SELECT * 
                FROM tblCharacterTile c, tblCharacterTile t
                WHERE 
                (c.characterName = pCharacterName AND 
                (c.xLocation = t.xLocation AND c.yLocation - 1 = t.yLocation  AND
                c.mapName = t.mapName AND t.characterName <> c.characterName)))) THEN
            BEGIN
                UPDATE tblCharacter
                SET `yPosition` = `yPosition` - 1
                WHERE (characterName = pCharacterName);
                UPDATE tblCharacterTile
                SET `yLocation` = `yLocation` - 1
                WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                
                SELECT CONCAT(pCharacterName, ' Moved up') AS MESSAGE, pCharacterName as characterName; -- do i need to pass back the character name??
            END; 
        ELSE
            SELECT 'Not able to move up' AS MESSAGE;
        END IF;
    ELSEIF (pDirection = "down") THEN
        IF (EXISTS (SELECT * FROM tblCharacterMap WHERE characterName = pCharacterName) AND 
			(EXISTS (SELECT * 
				FROM tblCharacterTile as CT
				WHERE (
                CT.characterName = pCharacterName AND
                CT.mapName = pMapName AND
                CT.yLocation + 1 <= (SELECT ySize FROM tblMap WHERE mapName = pMapName)))) AND
			(NOT EXISTS 
				(SELECT * 
				FROM tblCharacterTile c, tblCharacterTile t
				WHERE 
                (c.characterName = pCharacterName AND 
				(c.xLocation = t.xLocation AND c.yLocation + 1 = t.yLocation AND 
				c.mapName = t.mapName AND t.characterName <> c.characterName))))) -- map max y-size
            THEN
            BEGIN
                UPDATE tblCharacter
                SET `yPosition` = `yPosition` + 1
                WHERE (characterName = pCharacterName);
                UPDATE tblCharacterTile
                SET `yLocation` = `yLocation` + 1
                WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);               
                SELECT CONCAT(pCharacterName, ' Moved down') AS MESSAGE, pCharacterName as characterName;
            END; 
        ELSE
            SELECT 'Not able to move down' AS MESSAGE;
        END IF;
    END IF;
    COMMIT;
END//
DELIMITER ;

call characterMakesMove("MarkCharacter", "left", "3 by 3");

SELECT * FROM tblCharacterTile WHERE `characterName` = "MarkCharacter";
SELECT * FROM tblCharacterTile WHERE `mapName` = "3 by 3";
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character picks up item
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS characterPicksUpItem//
CREATE PROCEDURE characterPicksUpItem(pCharacterName VARCHAR(32), pMap VARCHAR(16)) -- , pXLocation INTEGER, pYLocation INTEGER) -- dont need to pass location, can retrieve from DB
BEGIN
    DECLARE lcItem VARCHAR(32);
    DECLARE lcXLocation INTEGER;
    DECLARE lcYLocation INTEGER;
    DECLARE lcItemDurability INTEGER;
    START TRANSACTION;
		SELECT xLocation, yLocation
        FROM tblCharacterTile
        WHERE `characterName` = pCharacterName AND `mapName` = pMap
        INTO lcXLocation, lcYLocation;
        
        SELECT `itemName` 
        FROM tblTileItem
        WHERE ((`mapName` = pMap) AND (`xLocation` = lcXLocation) AND (`yLocation` = lcYLocation))
        INTO lcItem;
    IF (lcItem is NULL)
    THEN
        BEGIN
            SELECT "There is no item on the tile" AS MESSAGE;
        END;
    ELSE
        BEGIN
            SELECT `maxDurability` FROM tblItem WHERE `itemName` = lcItem INTO lcItemDurability;
            INSERT INTO tblCharacterItem
            VALUES (pCharacterName, lcItem, 1, lcItemDurability);
            DELETE FROM tblTileItem
            WHERE (`mapName` = pMap) AND (`xLocation` = lcXLocation) AND (`yLocation` = lcYLocation) AND (`itemName` = lcItem);
            SELECT CONCAT(pCharacterName, " has picked up ", lcItem) AS MESSAGE;
        END;
    END IF;
    COMMIT;
END//
DELIMITER ;

call characterPicksUpItem("MarkCharacter", "3 by 3")
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

DELIMITER //
DROP PROCEDURE IF EXISTS useItem//
CREATE PROCEDURE useItem(pCharacterName VARCHAR(32), pUserName VARCHAR(32), pItemName VARCHAR(32), pMap VARCHAR(16), pXLocation INTEGER, pYLocation INTEGER) 
BEGIN
    DECLARE lcMine VARCHAR(20);
    START TRANSACTION;
		BEGIN
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
					END IF;
				END;
			ELSE
				BEGIN
					SELECT CONCAT(pItemName, "doesn't mine", lcMine) AS MESSAGE;
				END;
			END IF;
		END;
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
        VALUES (pCharacterName, pMessage, NOW());
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


DELIMITER //
DROP PROCEDURE IF EXISTS getActiveGames//
CREATE PROCEDURE getActiveGames()
BEGIN
    START TRANSACTION;
        SELECT characterName, mapName
        FROM tblCharacterMap;
        -- SELECT t1.characterName, t1.mapName, t2.characterName
        -- FROM tblCharacterMap AS t1, tblCharacterMap AS t2
        -- WHERE ((t1.charactername <> t2.CharacterName) AND (t1.mapName = t2.mapName));
    COMMIT;
END//
DELIMITER ; -- Doesn't yet work TODO

call getActiveGames();

SELECT * FROM tblCharacterMap;

DELIMITER //
DROP PROCEDURE IF EXISTS adminKillGame//
CREATE PROCEDURE adminKillGame(pMapName VARCHAR(16)) 
BEGIN
    Start TRANSACTION;
        DELETE FROM tblCharacterMap -- don't delete the tblMap through out the whole thing
        WHERE `mapName` = pMapName;
        DELETE FROM tblCharacterTile
        WHERE `mapName` = pMapName;
        DELETE FROM tblMineTile
        WHERE `mapName` = pMapName;
        DELETE FROM tblTileItem
        WHERE `mapName` = pMapName;
    COMMIT;
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
    ELSEIF EXISTS (SELECT * FROM tblUser WHERE `email` = pNewUserEmail)
    THEN
        BEGIN
            SELECT CONCAT("Sorry, the email ", pNewUserEmail, " is already is use") AS `Message`;
        END;
    ELSE
        UPDATE tblUser
        SET `email` = username, pNewUserName = pNewUserEmail, `userPassword` = pNewUserPassword, `loginAttempts` = pLoginAttempts, `userScore` = pUserScore
        WHERE pUserName = `username`;
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

	SELECT CONCAT(pUserName, " is now Deleted") AS MESSAGE;
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