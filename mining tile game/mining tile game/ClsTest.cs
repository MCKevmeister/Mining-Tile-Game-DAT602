using System;
using System.Collections.Generic;
using System.Data;
using MySql.Data.MySqlClient;

namespace mining_tile_game
{
    internal static class ClsTest
    {
        private const string Connection = "Server=localhost;Port=3306;Database=dbTileGame;Uid =root;password=W7oUmiLaiTrznc;";
        private static readonly MySqlConnection MySqlConnection = new MySqlConnection(Connection);
        public static string UserName { get; set; }
        public static string CharacterName { get; set; }
        public static string MapName { get; set; }
        public static string testConnection()
        {
            var testcon = new MySqlConnection(Connection);
            Console.Write("Validating credentials");
            
            try
            {
                testcon.Open();
                return testcon.State == ConnectionState.Open ? "\nConnected to server" : "\nError";
            }
            catch(MySqlException e)
            {
                return e.ToString();
            }
        }
        public static DataSet registerUser(string pUsername, string pEmail, string pPassword)
        {
            var paramList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = pUsername};
            var paramEmail = new MySqlParameter("@Email", MySqlDbType.VarChar, 64) {Value = pEmail};
            var paramPassword = new MySqlParameter("@Password", MySqlDbType.VarChar, 64) {Value = pPassword};
            paramList.Add(paramUsername);
            paramList.Add(paramEmail);
            paramList.Add(paramPassword);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL registerUser(@Username, @Email, @Password)", paramList.ToArray());
                return aDataSet;
            }
            catch (MySqlException e)
            {
                Console.WriteLine(e.Message);
                return null;
            }
        }
        public static DataSet userLogin(string pUsername, string pPassword)
        {
            var paramList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = pUsername};
            var paramUserPassword = new MySqlParameter("@UserPassword", MySqlDbType.VarChar, 64) {Value = pPassword};
            paramList.Add(paramUsername);
            paramList.Add(paramUserPassword);
            var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "Call userLogin(@Username, @UserPassword)", paramList.ToArray());
            return aDataSet;
        }
        public static DataSet userLogoff()
        { 
            var paramList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramUsername);
            var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "Call userLogoff(@Username)", paramList.ToArray());
            return aDataSet;
        }
        public static DataSet editUser(string pNewUserName, string pNewUserPassword, string pNewUserEmail)
        {
            var paramList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32) {Value = UserName};
            var paramNewUsername = new MySqlParameter("@NewUsername", MySqlDbType.VarChar, 32) {Value = pNewUserName};
            var paramNewUserPassword = new MySqlParameter("@NewUserPassword", MySqlDbType.VarChar, 64) {Value = pNewUserPassword};
            var paramNewUserEmail = new MySqlParameter("@NewUserEmail", MySqlDbType.VarChar, 64) {Value = pNewUserEmail};
            paramList.Add(paramUserName);
            paramList.Add(paramNewUsername);
            paramList.Add(paramNewUserPassword);
            paramList.Add(paramNewUserEmail);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL editUser(@Username, @NewUsername, @NewUserPassword, @NewUserEmail)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet deleteUser()
        {
            var paramList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = UserName};
            //Accesses the stored username from the userMenu
            paramList.Add(paramUsername);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL deleteUser(@Username)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet createCharacter(string pCharacterName, string pskill1, string pskill2, string pskill3, string pskill4)
        {
            var paramList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32) {Value = UserName};
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32) {Value = pCharacterName};
            var paramSkill1 = new MySqlParameter("@Skill1", MySqlDbType.VarChar, 20) {Value = pskill1};
            var paramSkill2 = new MySqlParameter("@Skill2", MySqlDbType.VarChar, 20){Value = pskill2};
            var paramSkill3 = new MySqlParameter("@Skill3", MySqlDbType.VarChar, 20){Value = pskill3};
            var paramSkill4 = new MySqlParameter("@Skill4", MySqlDbType.VarChar, 20){Value = pskill4};
            paramList.Add(paramUserName);
            paramList.Add(paramCharacterName);
            paramList.Add(paramSkill1);
            paramList.Add(paramSkill2);
            paramList.Add(paramSkill3);
            paramList.Add(paramSkill4);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL createCharacter(@Username, @CharacterName, @Skill1, @Skill2, @Skill3, @Skill4)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getAllUserCharacters()
        {
            var paramList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramUserName);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL getAllUserCharacters(@Username)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet deleteCharacter(string pCharacterName)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramUserName);
            paramList.Add(paramCharacterName);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL deleteCharacter(@CharacterName, @UserName)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet selectCharacter(string pCharacterName)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramCharacterName);
            paramList.Add(paramUserName);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL selectCharacter(@CharacterName, @UserName)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet changeCharacter()
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32) {Value = CharacterName} ;
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramCharacterName);
            paramList.Add(paramUserName);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL changeCharacter(@CharacterName, @UserName)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet onlineCharacters()
        {
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL onlineCharacters()");
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getMaps()
        {
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL getMaps()");
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet chooseOpponent()
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            paramList.Add(paramCharacterName);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL chooseOpponent(@Character)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet createGame(string pOpponent, string pMap)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter1 = new MySqlParameter("@Character1", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramCharacter2 = new MySqlParameter("@Character2", MySqlDbType.VarChar, 32) {Value = pOpponent};
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16) {Value = pMap};
            paramList.Add(paramCharacter1);
            paramList.Add(paramCharacter2);
            paramList.Add(paramMap);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL createGame(@Character1, @Character2, @Map)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getCharactersMaps()
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            paramList.Add(paramCharacter);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL getCharactersMaps(@Character)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet leaveCharacterMap()
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16) {Value = MapName};
            paramList.Add(paramCharacter);
            paramList.Add(paramMap);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL leaveCharacterMap(@Character, @Map)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet endCharacterGame(string pMap)
        {
            List<MySqlParameter> paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = CharacterName;
            paramMap.Value = pMap;
            paramList.Add(paramCharacter);
            paramList.Add(paramMap);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL endCharacterGame(@Character, @Map)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getMapsCharacterCanRejoin()
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            paramList.Add(paramCharacter);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL getMapsCharacterCanRejoin(@Character)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterReturnToMap(string pMap, string pDirection)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16) {Value = pMap};
            var paramDirection = new MySqlParameter("@Direction", MySqlDbType.VarChar, 16) {Value = pDirection};
            paramList.Add(paramCharacter);
            paramList.Add(paramMap);
            paramList.Add(paramDirection);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL characterReturnToMap(@Character, @Map, @Direction)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterMakesMove(string pDirection)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramDirection = new MySqlParameter("@Direction", MySqlDbType.VarChar, 5) {Value = pDirection};
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16) {Value = MapName};
            paramList.Add(paramCharacter);
            paramList.Add(paramDirection);
            paramList.Add(paramMap);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL characterMakesMove(@Character, @Direction, @Map)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterPicksUpItem()
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16) {Value = MapName};
            paramList.Add(paramCharacter);
            paramList.Add(paramMap);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL characterPicksUpItem(@Character, @Map)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getCharacterItems(string pDirection)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            paramList.Add(paramCharacter);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL getCharacterItems(@Character, @Direction, @Map)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet useItem(string pItem, string pMap)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = UserName};
            var paramItemName = new MySqlParameter("@ItemName", MySqlDbType.VarChar, 32) {Value = pItem};
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16) {Value = pMap};
            paramList.Add(paramCharacter);
            paramList.Add(paramUsername);
            paramList.Add(paramItemName);
            paramList.Add(paramMap);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL useItem(@Character, @Username, @ItemName, @Map)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterChats(string pMessage)
        {
            var paramList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32) {Value = CharacterName};
            var paramMessage = new MySqlParameter("@Message", MySqlDbType.VarChar, 32) {Value = pMessage};
            paramList.Add(paramCharacter);
            paramList.Add(paramMessage);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL characterChats(@Character, @Message)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet checkIfAdmin()
        {
            var paramList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramUsername);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL checkIfAdmin(@Username)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getActiveGames()
        {
            var paramList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramUsername);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL getActiveGames(@Username)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminKillGame(string pMap)
        {
            var paramList = new List<MySqlParameter>();
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16) {Value = pMap};
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramMap);
            paramList.Add(paramAdminUsername);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL adminKillGame(@Map, @AdminUsername)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminAddUser(string pUsername, string pEmail, string pPassword, Boolean pIsAdmin)
        {
            var paramList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32) {Value = UserName};
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = pUsername};
            var paramEmail = new MySqlParameter("@Email", MySqlDbType.VarChar, 64) {Value = pEmail};
            var paramPassword = new MySqlParameter("@Password", MySqlDbType.VarChar, 64) {Value = pPassword};
            var paramIsAdmin = new MySqlParameter("@IsAdmin", MySqlDbType.Int16) {Value = pIsAdmin}; // mysql connection has issues with numbers that aren't integers
            paramList.Add(paramAdminUsername);
            paramList.Add(paramUsername);
            paramList.Add(paramEmail);
            paramList.Add(paramPassword);
            paramList.Add(paramIsAdmin);
            try
            {
                // (pAdminUserName VARCHAR(32), pCurrentUserName VARCHAR(32), pNewUserName VARCHAR(32), pEmail VARCHAR(64), pUserPassword VARCHAR(64), pIsAdmin BIT)

                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL adminAddUser(@AdminUsername, @Username, @Email, @Password, @IsAdmin)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null; 
            }
        }
        public static DataSet adminEditUser(string pUsername, string pNewUserName, string pNewUserEmail, string pNewUserPassword, int pNewLoginAttempts, int pNewUserScore, int pNewIsLocked, int pIsAdmin)
        {
            var paramList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32) {Value = UserName};
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = pUsername};
            var paramNewUsername = new MySqlParameter("@NewUsername", MySqlDbType.VarChar, 32) {Value = pNewUserName};
            var paramNewUserPassword = new MySqlParameter("@NewUserPassword", MySqlDbType.VarChar, 64) {Value = pNewUserPassword};
            var paramNewUserEmail = new MySqlParameter("@NewUserEmail", MySqlDbType.VarChar, 64) {Value = pNewUserEmail};
            var paramNewLoginAttempts = new MySqlParameter("@NewLoginAttempts", MySqlDbType.Int16) {Value = pNewLoginAttempts};
            var paramNewUserScore = new MySqlParameter("@NewUserScore", MySqlDbType.Int16) {Value = pNewUserScore};
            var paramNewIsLocked = new MySqlParameter("@NewIsLocked", MySqlDbType.Bit) {Value = pNewIsLocked};
            var paramIsAdmin = new MySqlParameter("@IsAdmin", MySqlDbType.Bit) {Value = pIsAdmin};
            paramList.Add(paramAdminUsername);
            paramList.Add(paramUsername);
            paramList.Add(paramNewUsername);
            paramList.Add(paramNewUserPassword);
            paramList.Add(paramNewUserEmail);
            paramList.Add(paramNewLoginAttempts);
            paramList.Add(paramNewUserScore);
            paramList.Add(paramNewIsLocked);
            paramList.Add(paramIsAdmin);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL adminEditUser(@AdminUsername, @Username, @NewUsername, @NewUserEmail, @NewUserPassword, @NewLoginAttempts, @NewUserScore, @NewIsLocked, @IsAdmin)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminGetAllUsers()
        {
            var paramList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramAdminUsername);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL adminGetAllUsers(@AdminUsername)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminDeleteUser(string pUsername)
        {
            var paramList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32) {Value = UserName};
            var paramDeleteUser = new MySqlParameter("@DeleteUser", MySqlDbType.VarChar, 32) {Value = pUsername};
            paramList.Add(paramAdminUsername);
            paramList.Add(paramDeleteUser);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL adminDeleteUser(@DeleteUser, @AdminUsername)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminGetLockedUsers()
        {
            var paramList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramAdminUsername);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL adminGetLockedUsers(@AdminUsername)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminUnlockUser(string pUsername)
        {
            var paramList = new List<MySqlParameter>();
            var paramUnlockUser = new MySqlParameter("@Username", MySqlDbType.VarChar, 32) {Value = pUsername};
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32) {Value = UserName};
            paramList.Add(paramUnlockUser);
            paramList.Add(paramAdminUsername);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(MySqlConnection, "CALL adminUnlockUser(@Username, @AdminUsername)", paramList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
    }
}