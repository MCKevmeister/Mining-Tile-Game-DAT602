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
			`email` VARCHAR(64) UNIQUE NOT NULL,
            `userPassword` VARCHAR(64) NOT NULL,
            `loginAttempts` INTEGER NOT NULL DEFAULT 0,
            `userScore` INTEGER NOT NULL DEFAULT 0,
            `isLocked` BIT NOT NULL DEFAULT FALSE,
            `isAdmin` BIT NOT NULL DEFAULT FALSE, 
            `isOnline` BIT NOT NULL DEFAULT FALSE
			);
            
		CREATE TABLE tblSkill (
			`skillName` VARCHAR(20) PRIMARY KEY,
            `skilldescription` VARCHAR(255) NOT NULL
			);

		CREATE TABLE tblItem(
            `itemName` VARCHAR(32) PRIMARY KEY,
            `matchingSkill` VARCHAR(20) NOT NULL,
            `maxDurability` INTEGER NOT NULL,
			FOREIGN KEY (`matchingSkill`) REFERENCES tblSkill (`skillName`) ON UPDATE CASCADE
			);
            
		CREATE TABLE tblMine(
            `mineName` VARCHAR(20) PRIMARY KEY,
            `minedBy` VARCHAR(32) NOT NULL,
            FOREIGN KEY (`minedBy`) REFERENCES tblItem (`itemName`) ON UPDATE CASCADE
			);
            
        CREATE TABLE tblMap(
            `mapName` VARCHAR(16) PRIMARY KEY,
            `homeTileXLocation` INTEGER NOT NULL,
            `homeTileYLocation` INTEGER NOT NULL,
            `xSize` INTEGER NOT NULL,
            `ySize` INTEGER NOT NULL
			);

        CREATE TABLE tblTile(
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
            `username` VARCHAR(32) NOT NULL,
            `xPosition` INTEGER,
            `yPosition` INTEGER,
            `characterScoreTotal` INTEGER NOT NULL DEFAULT 0,
            `isActive` BIT DEFAULT FALSE,
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
			`characterName` VARCHAR(32) NOT NULL,
            `itemName` VARCHAR(32) NOT NULL,
            `quantity` INTEGER,
            `itemDurability` INTEGER NOT NULL,
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
            `isPlaying` BIT NOT NULL,
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

INSERT INTO tblCharacterTile(`characterName`, `mapName`, `xLocation`, `yLocation`, `isPlaying`)
Values
('MarkCharacter', "3 by 3", 2, 2, 1),
('MaryCharacter', "3 by 3", 2, 2, 1),
('JohnCharacter', "5 by 5", 3, 3, 0),
('StepehnCharacter', "5 by 5", 3, 3, 1),
('MichaelCharacter', "5 by 5", 3, 3, 0);
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
-- DELETE FROM tblCharacterTile;
-- DELETE FROM tblMineTile;
-- DELETE FROM tblCharacterMap;
-- DELETE FROM tblCharacterItem;
-- DELETE FROM tblChat;
-- DELETE FROM tblCharacterSkill;
-- DELETE FROM tblCharacter;
-- DELETE FROM tblTileItem;
-- DELETE FROM tblTile;
-- DELETE FROM tblMap;
-- DELETE FROM tblMine;
-- DELETE FROM tblItem;
-- DELETE FROM tblSkill;
-- DELETE FROM tblUser;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Register a User 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP PROCEDURE IF EXISTS registerUser;
DELIMITER //
CREATE PROCEDURE registerUser(pUserName VARCHAR(32), pEmail VARCHAR(64), pUserPassword VARCHAR(64))
BEGIN
    DECLARE exit handler for sqlexception
        BEGIN     
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "registerUser", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Login with a user  
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP PROCEDURE IF EXISTS userLogin;
DELIMITER //
CREATE PROCEDURE userLogin(pUserName VARCHAR(32), pUserPassword VARCHAR(64))
BEGIN
    DECLARE lcUserName VARCHAR(32);
	DECLARE lcUserPassword VARCHAR(64);
	DECLARE lcUserIsLocked BIT;
	DECLARE lcUserLoginAttempts INT;
    DECLARE exit handler for sqlexception
        BEGIN
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "userLogin", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
	START TRANSACTION;
        SELECT `username`, `userPassword`, `islocked`, `loginAttempts`
        FROM tblUser
        WHERE `username` = pUserName
        INTO lcUserName, lcUserPassword, lcUserIsLocked, lcUserLoginAttempts;
        IF (lcUserName IS NULL)
        THEN
            BEGIN
                SELECT "Username doesn't exist" AS MESSAGE;
            END;
		ELSEIF (lcUserLoginAttempts > 4) OR (lcUserIsLocked = 1)
        THEN
            BEGIN
                UPDATE tblUser
                SET `isLocked` = 1
                WHERE `username` = pUserName;
                SELECT "User has been is locked out. Please contact an administrator to get this user unlocked" AS MESSAGE;
            END; 
        ELSEIF ((lcUserName = pUserName) AND (lcUserPassword <> pUserPassword)) 
        THEN
            BEGIN
                UPDATE tbluser
                SET `loginAttempts` = `loginAttempts` + 1
                WHERE `username` = pUserName;
                SET lcUserLoginAttempts = lcUserLoginAttempts + 1;
                SELECT "Incorrect Password" AS MESSAGE;
            END;
        ELSEIF ((lcUserName = pUserName) AND (lcUserPassword = pUserPassword) AND (lcUserIsLocked = 0) AND (lcUserLoginAttempts < 5))
        THEN
            BEGIN
                UPDATE tbluser
                SET `isOnline` = true, `loginAttempts` = 0
                WHERE (`username` = pUserName AND `userPassword` = pUserPassword);
                SELECT CONCAT(pUserName, " is now Online") AS MESSAGE;
            END;
        END IF;
	COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Log off 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP PROCEDURE IF EXISTS userLogoff;
DELIMITER //
CREATE PROCEDURE userLogoff(pUserName VARCHAR(32))
BEGIN
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "userLogin", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
	START TRANSACTION;
        BEGIN
            UPDATE tblUser
            SET `isOnline` = 0
            WHERE `username` = pUserName;
            SELECT CONCAT(pUserName, " has logged off") AS MESSAGE;
        END;
	COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Edit User 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS editUser//
CREATE PROCEDURE editUser(pUserName VARCHAR(32), pNewUserName VARCHAR(32), pNewUserPassword VARCHAR(64), pNewUserEmail VARCHAR(64))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "editUser", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
		IF NOT EXISTS (SELECT * FROM tblUser WHERE `username` = pUserName) THEN
			BEGIN
				SELECT CONCAT("Sorry, the user ", pUserName, " doesn't exist") AS MESSAGE;
			END;
		ELSEIF EXISTS (SELECT * FROM tblUser WHERE `username` = pNewUserName AND `username` <> pUserName) THEN
			BEGIN
				SELECT CONCAT("Sorry, the user name ", pNewUserName, " has already been taken") AS Message;
			END;
		ELSEIF EXISTS (SELECT * FROM tblUser WHERE `email` = pNewUserEmail AND `email`) -- need to allow for old password to remain TODO
        THEN
			BEGIN
				SELECT CONCAT("Sorry, the email ", pNewUserEmail, " is already is use") AS Message;
			END;
		ELSE
			BEGIN
				UPDATE tblUser
				SET `email` = pNewUserEmail, `userPassword` = pNewUserPassword, `username` = pNewUserName
				WHERE pUserName = `username`;
				SELECT "User details have been updated" AS `Message`;
			END;
		END IF;
    COMMIT;
END//
DELIMITER ;

Select * from tblUser;
Call editUser("simple", "Mark", "MarksPassword", "newagain");
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Delete User 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS deleteUser//
CREATE PROCEDURE deleteUser(pUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN       
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "deleteUser", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF EXISTS (SELECT * FROM tblUser WHERE `username` = pUserName) THEN
            DELETE FROM tblUser
            WHERE `username` = pUserName;
            SELECT CONCAT(pUserName, " has been deleted") AS Message;
        ELSE
            SELECT CONCAT(pUserName, " doesn't exists") AS Message;
		END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- User Creates Character (inlcuding character skills created)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS createCharacter//
CREATE PROCEDURE createCharacter(pUserName VARCHAR(32), pCharacterName VARCHAR(32), pSkill1 VARCHAR(20), pSkill2 VARCHAR(20), pSkill3 VARCHAR(20), pSkill4 VARCHAR(20))
BEGIN
    DECLARE exit handler for sqlexception
        BEGIN       
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "createCharacter", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
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
                SELECT CONCAT(pCharacterName, " has been created") AS MESSAGE;
            END;
		END IF;
	COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- User Deletes Character
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return all characters a user has. Also used in select character to play game
DELIMITER //
DROP PROCEDURE IF EXISTS getAllUserCharacters//
CREATE PROCEDURE getAllUserCharacters(pUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
        BEGIN
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "getAllUserCharacters", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
    START TRANSACTION;
        SELECT `characterName`
        FROM tblCharacter
        WHERE `username` = pUserName;
    COMMIT;
END//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS deleteCharacter//
CREATE PROCEDURE deleteCharacter(pCharacterName VARCHAR(32), pUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "deleteCharacter", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Select Character to play game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS selectCharacter//
CREATE PROCEDURE selectCharacter(pCharacterName VARCHAR(32), pUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "selectCharacter", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` = pUserName)) THEN
            BEGIN
                UPDATE `tblcharacter`
                SET isActive = 1
                WHERE `characterName` = pCharacterName;
                SELECT CONCAT(pCharacterName, " is now active") AS MESSAGE;
            END;
        ELSEIF (EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` <> pUserName))) THEN
            SELECT CONCAT(pCharacterName, " doesn't belong to this player") AS MESSAGE;
        ELSEIF (NOT EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName))) THEN
            SELECT CONCAT(pCharacterName, " doesn't exist") AS MESSAGE;
        END IF;
    COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Change Character to play game with
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS changeCharacter//
CREATE PROCEDURE changeCharacter(pCharactername VARCHAR(32), pUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "selectCharacter", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` = pUserName and `isActive` = 1)) THEN
            BEGIN
                UPDATE `tblcharacter`
                SET isActive = 0
                WHERE `characterName` = pCharacterName;
                SELECT CONCAT(pCharacterName, " is now not active") AS MESSAGE;
            END;
        ELSEIF (EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName AND `userName` <> pUserName))) THEN
            SELECT CONCAT(pCharacterName, " doesn't belong to this player") AS MESSAGE;
        ELSEIF (NOT EXISTS ((SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName))) THEN
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
    DECLARE exit handler for sqlexception
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "onlineCharacters", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        SELECT `characterName`, `characterScoreTotal`
        FROM tblcharacter
        WHERE `isActive` = true;
    COMMIT;
END//
DELIMITER ;

call onlineCharacters();
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Create Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS getMaps//
CREATE PROCEDURE getMaps()
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN      
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "getMaps", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        SELECT *
        FROM tblmap;
    COMMIT;
END//
DELIMITER ;

-- Returns a list of online characters
-- Character is selected as opponent
DELIMITER //
DROP PROCEDURE IF EXISTS chooseOpponent//
CREATE PROCEDURE chooseOpponent(pCharacterName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "chooseOpponent", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        SELECT `characterName`
        FROM tblCharacter
        WHERE (`isActive` = 1 AND `characterName` <> pCharacterName);
    COMMIT;
END//
DELIMITER ;

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
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "createGame", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
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
        IF (EXISTS(SELECT * FROM tblcharacterMap WHERE `characterName` = pCharacter1) OR (EXISTS(SELECT * FROM tblcharacterMap WHERE `characterName` = pCharacter2))) THEN
			BEGIN
				SELECT "Cannot make game, characters are already playing" AS MESSAGE;
			END;
        ELSEIF (EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacter1) AND 
			EXISTS (SELECT * FROM tblCharacter WHERE `characterName` = pCharacter2 AND `isActive` = 1) AND 
			EXISTS (SELECT * FROM tblMap WHERE `mapname` = pMap)) THEN
            BEGIN
                INSERT INTO tblCharacterMap (`characterName`, `mapName`)
                VALUES(pCharacter1, pMap), (pCharacter2, pMap);
                DELETE FROM tblCharacterTile 
				WHERE `characterName` = pCharacter1 AND `characterName` = pCharacter2;
                INSERT INTO tblCharacterTile(`characterName`, `mapName`, `xLocation`, `yLocation`, `isPlaying`)
                VALUES (pCharacter1, pMap, lcXHome, lcYHome, 1), (pCharacter2, pMap, lcXHome, lcYHome, 1);
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
                                WHEN 6 THEN SET itemSpawnName = 'Hammer';
                            END CASE;
							INSERT INTO tblTileItem (`mapName`, `xLocation`, `yLocation`, `itemName`)
                            VALUES (pMap, xSpawn, ySpawn, itemSpawn);
							SET i = i + 1;
							ITERATE spawnItem;
                    END IF;
                    LEAVE spawnItem;
                END LOOP spawnItem;
                spawnMine: LOOP
                    IF (i < lcXMax) THEN
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Leave Game
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Leave game but can rejoin game later
DELIMITER //
DROP PROCEDURE IF EXISTS leaveCharacterMap//
CREATE PROCEDURE leaveCharacterMap(pCharacterName VARCHAR(32), pMap VARCHAR(16))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "leaveCharacterMap", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        DELETE FROM tblCharacterMap
        WHERE `characterName` = pCharacterName AND `mapName` = pMap;
        UPDATE tblCharacterTile
        SET `isPlaying` = 0
        WHERE `characterName` = pCharacterName;
        SELECT CONCAT(pcharacterName, " has left the game but can rejoin") AS MESSAGE;
    COMMIT;
END//
DELIMITER ;

-- leave game and cannot rejoin
DELIMITER //
DROP PROCEDURE IF EXISTS endCharacterGame//
CREATE PROCEDURE endCharacterGame(pCharacterName VARCHAR(32), pMap VARCHAR(16))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "endCharacterGame", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
    END;
    DECLARE exit handler for sqlwarning
    BEGIN
        ROLLBACK;
        SHOW WARNINGS LIMIT 1;
    END;
    START TRANSACTION;
        DELETE FROM tblCharacterTile
        WHERE `characterName` = pCharacterName AND `mapName` = pMap;
        DELETE FROM tblCharacterMap
        WHERE `characterName` = pCharacterName AND `mapName` = pMap;
        SELECT CONCAT(pcharacterName, " has left the game") AS MESSAGE;
    COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Return to Game in Progress
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS getMapsCharacterCanRejoin//
CREATE PROCEDURE getMapsCharacterCanRejoin(pCharacterName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "getMapsCharacterCanRejoin", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION; 
        SELECT `mapName` 
        FROM tblCharacterTile 
        WHERE ((`characterName` = pCharacterName) AND (`isPlaying` = 0));
    COMMIT;
END//

DELIMITER //
DROP PROCEDURE IF EXISTS characterReturnToMap//
CREATE PROCEDURE characterReturnToMap(pCharacterName VARCHAR(32), pMap VARCHAR(16), pDirection VARCHAR(16))
BEGIN
    DECLARE lcCharacterX INTEGER;
    DECLARE lcCharacterY INTEGER;
    DECLARE lcHomeX INTEGER;
    DECLARE lcHomeY INTEGER;
    DECLARE exit handler for sqlexception
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "getMapsCharacterCanRejoin", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
    SELECT `homeTileXLocation`, `homeTileYLocation`
    FROM tblMap
    WHERE `mapName` = pMap
    INTO lcHomeX, lcHomeY;
    SELECT `xLocation`, `yLocation`
    FROM tblCharacterTile
    WHERE `characterName` = pCharacterName AND
    `mapName` = pMap
    INTO lcCharacterX, lcCharacterY;
    IF (NOT EXISTS(SELECT * FROM tblCharacter WHERE `characterName` = pCharacterName)) THEN
        BEGIN
            SELECT CONCAT(pCharacterName, " doesn't exist") AS MESSAGE;
        END;
    ELSEIF (NOT EXISTS(SELECT * FROM tblMap WHERE `mapName` = pMap)) THEN
        BEGIN
            SELECT CONCAT(pMap, " doesn't exist") AS MESSAGE;
        END;
    ELSE
        BEGIN
            IF (EXISTS(SELECT *
                FROM tblCharacterTile
                WHERE ((`characterName`<> pCharacterName) AND
                (`mapName` = pMap) AND
                (`xLocation` = lcCharacterX) AND
                (`xLocation` <> lcHomeX) AND
                (`yLocation` <> lcHomeY) AND
                (`yLocation` = lcCharacterY)))) THEN
                    BEGIN
                        IF(pDirection = NULL) THEN
                            BEGIN
                                SELECT ("This tile is occupied. Please choose an orthogonally adjacent tile to re-enter this game on") AS MESSAGE;
                            END;
                        ELSE
                            BEGIN
                                CASE pDirection
                                    WHEN "up" THEN SET lcCharacterY = lcCharacterY - 1;
                                    WHEN "right" THEN SET lcCharacterX = lcCharacterX + 1;
                                    WHEN "down" THEN SET lcCharacterY = lcCharacterY + 1; 
                                    WHEN "left" THEN SET lcCharacterX = lcCharacterX - 1; 
                                END CASE;
                                IF((EXISTS(SELECT *
                                    FROM tblMap
                                    WHERE `xSize` >= lcCharacterX)) AND
                                    (EXISTS(SELECT *
                                    FROM tblMap
                                    WHERE `ySize` >= lcCharacterY)) AND
                                    (lcCharacterX >= 1) AND (lcCharacterY >= 1)) THEN
                                    BEGIN
                                        INSERT INTO tblCharacterMap 
                                        VALUES (pCharacterName, pMap, 0);
                                        SELECT CONCAT(pCharacterName, " has rejoined ", pMap, ". Score reset") AS MESSAGE;
                                    END;
                                ELSE
                                    BEGIN
                                        SELECT CONCAT(pDirection, " would put ", pCharacterName, " out of the map. Please choose another direction.") AS MESSAGE;
                                    END;
                                END IF;
                            END;
                        END IF;
                    END;
            ELSE
                BEGIN
                    INSERT INTO tblCharacterMap
                    VALUES (pCharacterName, pMap, 0);
                    SELECT CONCAT(pCharacterName, " has rejoined ", pMap, ". Score reset") AS MESSAGE;
                END;
            END IF;
        END;
    END IF;
    COMMIT;
END//
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character makes Move
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS characterMakesMove//
CREATE PROCEDURE characterMakesMove(pCharacterName VARCHAR(32), pDirection VARCHAR(5), pMapName VARCHAR(16)) 
BEGIN
    DECLARE exit handler for sqlexception
        BEGIN            
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "characterMakesMove", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
    START TRANSACTION;
    IF (EXISTS(SELECT * FROM tblCharacterMap WHERE `characterName` = pCharacterName AND `mapName` = pMapName)) THEN
        IF (pDirection = "left") THEN
            IF (EXISTS (SELECT * FROM tblCharacterMap WHERE characteame = pCharacterName)) AND 
                (EXISTS (SELECT * 
                    FROM tblCharacterTile as CT
                    WHERE (
                    CT.characterName = pCharacterName AND
                    CT.mapName = pMapName AND
                    CT.xLocation - 1 >= 1))) AND
                (NOT EXISTS (
                    SELECT * 
					FROM tblCharacterTile c, tblCharacterTile t
                    WHERE 
                    (c.characterName = pCharacterName AND
                    c.xLocation - 1 = t.xLocation AND
                    c.yLocation = t.yLocation  AND
                    c.mapName = t.mapName AND
                    c.isPlaying = 1 AND t.isPlaying = 1 AND
                    t.characterName <> c.characterName))) THEN
                BEGIN
                    UPDATE tblCharacter
                    SET `xPosition` = `xPosition` - 1
                    WHERE (characterName = pCharacterName);
                    UPDATE tblCharacterTile
                    SET `xLocation` = `xLocation` - 1
                    WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                    SELECT CONCAT(pCharacterName, ' moved Left') AS MESSAGE;
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
                    (c.characterName = pCharacterName AND 
                    c.xLocation + 1 = t.xLocation AND
                    c.yLocation = t.yLocation  AND
                    c.mapName = t.mapName AND
                    c.isPlaying = 1 AND t.isPlaying = 1 AND
                    t.characterName <> c.characterName))) THEN 
                    BEGIN
                        UPDATE tblCharacter
                        SET `xPosition` = `xPosition` + 1
                        WHERE (characterName = pCharacterName);
                        UPDATE tblCharacterTile
                        SET `xLocation` = `xLocation` + 1
                        WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                        SELECT CONCAT(pCharacterName, ' moved right') AS MESSAGE;
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
                    (c.characterName = pCharacterName IN (SELECT * FROM tblCharacterMap WHERE `characterName` = pCharacterName AND `mapName` = pMapName) AND
                    (c.xLocation = t.xLocation AND c.yLocation - 1 = t.yLocation  AND c.isPlaying = 1 AND t.isPlaying = 1 AND
                    c.mapName = t.mapName AND t.characterName <> c.characterName)))) THEN
                BEGIN
                    UPDATE tblCharacter
                    SET `yPosition` = `yPosition` - 1
                    WHERE (characterName = pCharacterName);
                    UPDATE tblCharacterTile
                    SET `yLocation` = `yLocation` - 1
                    WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);
                    
                    SELECT CONCAT(pCharacterName, ' moved up') AS MESSAGE;
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
                    (c.characterName = pCharacterName) AND 
                    (c.xLocation = t.xLocation AND c.yLocation + 1 = t.yLocation) AND c.isPlaying = 1 AND t.isPlaying = 1 AND
                    (c.mapName = t.mapName AND c.characterName <> t.characterName))))
                THEN
                BEGIN
                    UPDATE tblCharacter
                    SET `yPosition` = `yPosition` + 1
                    WHERE (characterName = pCharacterName);
                    UPDATE tblCharacterTile
                    SET `yLocation` = `yLocation` + 1
                    WHERE (`characterName` = pCharacterName) AND (`mapName` = pMapName);               
                    SELECT CONCAT(pCharacterName, ' moved down') AS MESSAGE;
                END; 
            ELSE
                SELECT 'Not able to move down' AS MESSAGE;
            END IF;
        END IF;
    ELSE
        BEGIN
            SELECT CONCAT(pCharacterName, " isn't playing ", pMapName) AS MESSAGE;
        END;
    END IF;
    COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character picks up item
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS characterPicksUpItem//
CREATE PROCEDURE characterPicksUpItem(pCharacterName VARCHAR(32), pMap VARCHAR(16))
BEGIN
    DECLARE lcItem VARCHAR(32);
    DECLARE lcXLocation INTEGER;
    DECLARE lcYLocation INTEGER;
    DECLARE lcItemDurability INTEGER;
    DECLARE exit handler for sqlexception
        BEGIN            
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "characterPicksUpItem", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
    -- DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Character Uses Item on Mine
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS getCharacterMaps//
CREATE PROCEDURE getCharacterMaps(pCharacterName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "getCharacterMaps", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
    IF EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName) THEN
        BEGIN
            SELECT `mapName` FROM tblCharacterMap WHERE `characterName`= pCharacterName;
        END;
    ELSE
        BEGIN
            SELECT CONCAT(pCharacterName, " does not exist") AS MESSAGE;
        END;
    END IF;
    COMMIT;
END//
DELIMITER ;       

DELIMITER //
DROP PROCEDURE IF EXISTS getCharacterItems//
CREATE PROCEDURE getCharacterItems(pCharacterName VARCHAR(32)) 
BEGIN
    DECLARE exit handler for sqlexception
        BEGIN            
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "getCharacterItems", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
        -- DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;
    START TRANSACTION;
        IF EXISTS (SELECT * FROM tblCharacter WHERE characterName = pCharacterName) THEN
            SELECT `itemName` FROM tblCharacterItem WHERE `characterName` = pCharacterName;
        ELSE
            SELECT CONCAT(pCharacterName, " does not exist") AS MESSAGE;
        END IF;
    COMMIT;
END//

DELIMITER //
DROP PROCEDURE IF EXISTS useItem//
CREATE PROCEDURE useItem(pCharacterName VARCHAR(32), pUserName VARCHAR(32), pItemName VARCHAR(32), pMap VARCHAR(16)) 
BEGIN
    DECLARE lcMine VARCHAR(20);
    DECLARE lcX INTEGER;
    DECLARE lcY INTEGER;
    DECLARE exit handler for sqlexception
        BEGIN            
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "useItem", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
    START TRANSACTION;
        SELECT `xPosition`, `yPosition`
        FROM tblCharacterTile
        WHERE `characterName` = pCharacterName AND `mapName` = pMap
        INTo lcX, lcY;
        SELECT `mineName` FROM tblMineTile
        WHERE ((`mapName` = pMap) AND (`xLocation` = lcX) AND (`yLocation` = lcY))
        INTO lcMine;
        IF (lcMine is NULL) THEN
            BEGIN   
                SELECT "There is nothing to mine on this tile" AS MESSAGE;
            END;
        ELSEIF (EXISTS (SELECT * FROM tblMine WHERE (`mineName` = lcMine AND `minedBy` = pItemName))) THEN
            BEGIN
                UPDATE tblCharacterItem
                SET `itemDurability` = `itemDurability` - 1
                WHERE `itemName` = pItemName; -- this will do it for all items a character has of the same name
                UPDATE tblCharacter
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
                SELECT CONCAT(pItemName, " doesn't mine", lcMine) AS MESSAGE;
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
    DECLARE exit handler for sqlexception
        BEGIN            
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "characterChats", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
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
CREATE PROCEDURE checkIfAdmin(pUserName VARCHAR(32)) 
BEGIN
    DECLARE exit handler for sqlexception
        BEGIN            
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "checkIfAdmin", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
    START TRANSACTION;
        IF EXISTS (SELECT isAdmin FROM tblUser WHERE `username` = pUserName AND `isAdmin` = 1) THEN
            BEGIN
                SELECT CONCAT(pUserName, " is an Admin") AS MESSAGE;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pUsername, " is not an Admin") AS MESSAGE;
            END;
        END IF;
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
CREATE PROCEDURE getActiveGames(pAdminUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
        BEGIN            
            GET DIAGNOSTICS CONDITION 1
            @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
            SELECT "getActiveGames", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
            ROLLBACK;
        END;
    START TRANSACTION;
    IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
        BEGIN
		    SELECT `mapName` FROM tblCharacterMap GROUP BY `mapName`;
        END;
    ELSE
        BEGIN
            SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
        END;
    END IF;
    COMMIT;
END//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS adminKillGame//
CREATE PROCEDURE adminKillGame(pMapName VARCHAR(16), pAdminUserName VARCHAR(32)) 
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "adminKillGame", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    Start TRANSACTION;
        IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
            BEGIN
                DELETE FROM tblCharacterMap
                WHERE `mapName` = pMapName;
                DELETE FROM tblCharacterTile
                WHERE `mapName` = pMapName;
                DELETE FROM tblMineTile
                WHERE `mapName` = pMapName;
                DELETE FROM tblTileItem
                WHERE `mapName` = pMapName;
                SELECT CONCAT(pMapName, " has been killed") AS MESSAGE;
            End;
        ELSE
            BEGIN
                SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin adds a user
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS adminAddUser//
CREATE PROCEDURE adminAddUser(pAdminUserName VARCHAR(32), pNewUserName VARCHAR(32), pEmail VARCHAR(64), pUserPassword VARCHAR(64), pIsAdmin BIT)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "adminAddUser", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
            IF EXISTS(
                SELECT *
                FROM tblUser
                WHERE `username` = pNewUserName OR `email` = pEmail)
            THEN
                BEGIN
                    SELECT CONCAT(pNewUserName, ' or Email already exists') AS MESSAGE;
                END;
            ELSE
                BEGIN
                    INSERT INTO tblUser(`username` , `email`, `userPassword`, `isAdmin`)
                    VALUES (pNewUserName, pEmail, pUserPassword, pIsAdmin);
                    SELECT CONCAT(pNewUserName, " has been registered")  AS MESSAGE;
                END;
            END IF;
        ELSE
            BEGIN
                SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
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
CREATE PROCEDURE adminEditUser(pAdminUserName VARCHAR(32), pUserName VARCHAR(32) , pNewUserName VARCHAR(64), pNewUserEmail VARCHAR(64), pNewUserPassword VARCHAR(64), pLoginAttempts INTEGER, pUserScore INTEGER, pIsLocked BIT, pIsAdmin BIT)
BEGIN  
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "adminEditUser", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
            BEGIN
                IF EXISTS (SELECT * FROM tblUser WHERE `username` = pNewUserName AND `username` <> pUserName)
                THEN
                    BEGIN
                        SELECT CONCAT("Sorry, the user name ", pNewUserName, " has already been taken") AS MESSAGE;
                    END;
                ELSEIF EXISTS (SELECT * FROM tblUser WHERE `email` = pNewUserEmail AND `email` <> pNewUserEmail)
                THEN
                    BEGIN
                        SELECT CONCAT("Sorry, the email ", pNewUserEmail, " is already is use") AS MESSAGE;
                    END;
                ELSE
                    BEGIN
                        UPDATE tblUser
                        SET `email` = pNewUserEmail, `username` = pNewUserEmail, `userPassword` = pNewUserPassword, `loginAttempts` = pLoginAttempts, `userScore` = pUserScore
                        WHERE pUserName = `username`;
                        SELECT "The user has been updated" AS MESSAGE;
					END;
                END IF;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
            END;
        END IF;
    COMMIT;   
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin deletes user
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
DELIMITER //
DROP PROCEDURE IF EXISTS adminGetAllUsers//
CREATE PROCEDURE adminGetAllUsers(pAdminUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "adminGetAllUsers", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    DECLARE exit handler for sqlwarning
    START TRANSACTION;
        IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
            BEGIN
                SELECT `username`
                FROM tblUser;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

-- Delete a user
DELIMITER //
DROP PROCEDURE IF EXISTS adminDeleteUser//
CREATE PROCEDURE adminDeleteUser(pUserName VARCHAR(32), pAdminUserName VARCHAR(32))
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "adminDeleteUser", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
    END;
    START TRANSACTION;
        IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
            BEGIN
                DELETE FROM tblUser 
                WHERE `username` = pUserName;
                SELECT CONCAT(pUserName, " is now Deleted") AS MESSAGE;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Admin unlocks locked user
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Get list of locked users
DELIMITER //
DROP PROCEDURE IF EXISTS adminGetLockedUsers//
CREATE PROCEDURE adminGetLockedUsers(pAdminUserName VARCHAR(32)) 
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "adminGetLockedUsers", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
            BEGIN
                SELECT `username`
                FROM tblUser
                WHERE `isLocked` = true;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

-- Choose user to unlock
DELIMITER //
DROP PROCEDURE IF EXISTS adminUnlockUser//
CREATE PROCEDURE adminUnlockUser(pUserName VARCHAR(32), pAdminUserName VARCHAR(32)) 
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "adminUnlockUser", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
    IF EXISTS(SELECT * FROM tblUser WHERE `username` = pAdminUserName AND `isAdmin` = 1) THEN
        BEGIN
        IF EXISTS (SELECT * FROM tblUser WHERE `userName` = pUserName) THEN
            BEGIN
                UPDATE tblUser 
                SET `isLocked` = false, `loginAttempts` = 0
                WHERE `username` = pUserName;
                SELECT CONCAT(pUserName, " has been unlocked") as Message;
            END;
        ELSE
            BEGIN
                SELECT CONCAT("The user ", pUserName, " doesn't exist") AS MESSAGE;
            END;
        END IF;
        END;
    ELSE
        BEGIN
            SELECT CONCAT(pAdminUserName, " isn't an admin") AS MESSAGE;
		END;
	END IF;
COMMIT;
END//
DELIMITER ;

-- Added procedures for milestone 3

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Get Character Skills
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS getCharacterSkills//
CREATE PROCEDURE getCharacterSkills(pCharacterName VARCHAR(32)) 
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "getCharacterSkills", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF EXISTS(SELECT `characterName` FROM tblCharacter WHERE `characterName` = pCharacterName) THEN
            BEGIN
                SELECT `skillName` 
                FROM tblCharacterSkill 
                WHERE `characterName` = pCharacterName;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pCharacterName, " doesn't exist") AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Get User Detials
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS getUserDetails//
CREATE PROCEDURE getUserDetails(pUsername VARCHAR(32)) 
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "getUserDetails", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        IF EXISTS(SELECT * FROM tblUser WHERE `username` = pUsername) THEN
            BEGIN
                SELECT * 
                FROM tblUser 
                WHERE `username` = pUsername;
            END;
        ELSE
            BEGIN
                SELECT CONCAT(pUsername, " doesn't exist") AS MESSAGE;
            END;
        END IF;
    COMMIT;
END//
DELIMITER ;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Get Character Tile
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELIMITER //
DROP PROCEDURE IF EXISTS getCharacterTile//
CREATE PROCEDURE getCharacterTile(pCharactername VARCHAR(32), pMap VARCHAR(16)) 
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN        
        GET DIAGNOSTICS CONDITION 1
        @P1 = MYSQL_ERRNO, @P2 = MESSAGE_TEXT;
        SELECT "getCharacterTile", @P1 AS ERROR_NUM, @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;
        SELECT `xLocation`, `yLocation`
        FROM tblCharacterTile
        WHERE `mapName` = pMap;
    COMMIT;
END//
DELIMITER ;

SELECT * FROM tblUser;
SELECT * FROM tblCharacterTile;
DELETE FROM tblCharacterTile WHERE `characterName` = 'MichaelCharacter';
INSERT INTO tblCharacter(`characterName`, `username`, `xPosition`, `yPosition`,`characterScoreTotal`, `isActive`)
Values 
('Worun', 'Stephen', null, null, 0, false),
('Derer', 'Michael', null, null, 0, false);