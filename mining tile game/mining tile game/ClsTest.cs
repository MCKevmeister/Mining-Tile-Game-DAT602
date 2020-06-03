using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace miningTileGame
{
    class ClsTest
    {
        private const String connection = "Server=localhost;Port=3306;Database=dbTileGame;Uid =root;password=W7oUmiLaiTrznc;";
        private static readonly MySqlConnection mySqlConnection = new MySqlConnection(connection);
        private static object  _UserName;
        private static object  _CharacterName;
        private static object _MapName;

        public static object UserName { get => _UserName; set => _UserName = value; }
        public static object CharacterName { get => _CharacterName; set => _CharacterName = value; }
        public static object MapName { get => _MapName; set => _MapName = value; }
        public static string testConnection()
        {
            MySqlConnection testcon = new MySqlConnection(connection);
            Console.Write("Validating credentials");
            
            try
            {
                testcon.Open();
                if (testcon.State == ConnectionState.Open)
                { return "\nConnected to server"; }
                else { return "\nError"; }
            }
            catch(MySql.Data.MySqlClient.MySqlException e)
            {
                return e.ToString(); // "\nError Connecting to server";
            }
        }
        public static DataSet registerUser(string pUsername, string pEmail, string pPassword)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            var paramEmail = new MySqlParameter("@Email", MySqlDbType.VarChar, 64);
            var paramPassword = new MySqlParameter("@Password", MySqlDbType.VarChar, 64);

            paramUsername.Value = pUsername;
            paramEmail.Value = pEmail;
            paramPassword.Value = pPassword;

            ParamList.Add(paramUsername);
            ParamList.Add(paramEmail);
            ParamList.Add(paramPassword);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL registerUser(@Username, @Email, @Password)", ParamList.ToArray());
                return aDataSet;
            }
            catch (MySqlException e)
            {
                Console.WriteLine(e.Message);
                //if (e.InnerException != null)
                //    Console.WriteLine("Register error from MySQL inner: " + e.InnerException.Message);
                return null;
            }
        }
        public static DataSet userLogin(string pUsername, string pPassword)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            var paramUserPassword = new MySqlParameter("@UserPassword", MySqlDbType.VarChar, 64);
            paramUsername.Value = pUsername;
            paramUserPassword.Value = pPassword;
            ParamList.Add(paramUsername);
            ParamList.Add(paramUserPassword);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "Call userLogin(@Username, @UserPassword)", ParamList.ToArray());
            return aDataSet;
            //try
            //{
            //    var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "Call userLogin(@Username, @UserPassword)", ParamList.ToArray());
            //    return aDataSet;
            //}
            //catch (ArgumentException)
            //{
            //    return null;
            //}

        }
        public static DataSet userLogoff()
        { 
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            paramUsername.Value = UserName;
            ParamList.Add(paramUsername);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "Call userLogoff(@Username)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet editUser(string pNewUserName, string pNewUserPassword, string pNewUserEmail)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            var paramNewUsername = new MySqlParameter("@NewUsername", MySqlDbType.VarChar, 32);
            var paramNewUserPassword = new MySqlParameter("@NewUserPassword", MySqlDbType.VarChar, 64);
            var paramNewUserEmail = new MySqlParameter("@NewUserEmail", MySqlDbType.VarChar, 64);

            paramUserName.Value = _UserName;
            paramNewUsername.Value = pNewUserName;
            paramNewUserPassword.Value = pNewUserPassword;
            paramNewUserEmail.Value = pNewUserEmail;

            ParamList.Add(paramUserName);
            ParamList.Add(paramNewUsername);
            ParamList.Add(paramNewUserPassword);
            ParamList.Add(paramNewUserEmail);

            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL editUser(@Username, @NewUsername, @NewUserPassword, @NewUserEmail)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL editUser(@Username, @NewUsername, @NewUserPassword, @NewUserEmail)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet deleteUser()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            paramUsername.Value = _UserName; //Accesses the stored username from the userMenu
            ParamList.Add(paramUsername);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL deleteUser(@Username)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL deleteUser(@Username)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet createCharacter(string pCharacterName, string pskill1, string pskill2, string pskill3, string pskill4)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            var paramSkill1 = new MySqlParameter("@Skill1", MySqlDbType.VarChar, 20);
            var paramSkill2 = new MySqlParameter("@Skill2", MySqlDbType.VarChar, 20);
            var paramSkill3 = new MySqlParameter("@Skill3", MySqlDbType.VarChar, 20);
            var paramSkill4 = new MySqlParameter("@Skill4", MySqlDbType.VarChar, 20);
            paramUserName.Value = _UserName;
            paramCharacterName.Value = pCharacterName;
            paramSkill1.Value = pskill1;
            paramSkill2.Value = pskill2;
            paramSkill3.Value = pskill3;
            paramSkill4.Value = pskill4;
            ParamList.Add(paramUserName);
            ParamList.Add(paramCharacterName);
            ParamList.Add(paramSkill1);
            ParamList.Add(paramSkill2);
            ParamList.Add(paramSkill3);
            ParamList.Add(paramSkill4);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL createCharacter(@Username, @CharacterName, @Skill1, @Skill2, @Skill3, @Skill4)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL createCharacter(@Username, @CharacterName, @Skill1, @Skill2, @Skill3, @Skill4)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getAllUserCharacters()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            paramUserName.Value = _UserName;
            ParamList.Add(paramUserName);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getAllUserCharacters(@Username)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getAllUserCharacters(@Username)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet deleteCharacter()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            paramUserName.Value = _UserName;
            paramCharacterName.Value = CharacterName;
            ParamList.Add(paramUserName);
            ParamList.Add(paramCharacterName);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL deleteCharacter(@CharacterName, @UserName)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL deleteCharacter(@CharacterName, @UserName)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet selectCharacter(string pCharacterName)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            paramUserName.Value = _UserName;
            paramCharacterName.Value = pCharacterName;
            ParamList.Add(paramCharacterName);
            // var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL selectCharacter(@CharacterName, @UserName)", ParamList.ToArray());
            // return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL selectCharacter(@CharacterName, @UserName)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet changeCharacter()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            paramUserName.Value = UserName;
            paramCharacterName.Value = CharacterName;
            ParamList.Add(paramCharacterName);
            // var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL changeCharacter(@CharacterName, @UserName)", ParamList.ToArray());
            // return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL changeCharacter(@CharacterName, @UserName)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet onlineCharacters()
        {
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL onlineCharacters()");
            // return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL onlineCharacters()");
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getMaps()
        {
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getMaps()");
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getMaps()");
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet chooseOpponent()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacterName.Value = CharacterName;
            ParamList.Add(paramCharacterName);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL chooseOpponent(@Character)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL chooseOpponent(@Character)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet createGame(string pOpponent, string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter1 = new MySqlParameter("@Character1", MySqlDbType.VarChar, 32);
            var paramCharacter2 = new MySqlParameter("@Character2", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter1.Value = CharacterName;
            paramCharacter2.Value = pOpponent;
            paramMap.Value = pMap;
            ParamList.Add(paramCharacter1);
            ParamList.Add(paramCharacter2);
            ParamList.Add(paramMap);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL createGame(@Character1, @Character2, @Map)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL createGame(@Character1, @Character2, @Map)", ParamList.ToArray());
                return aDataSet;
             }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getCharactersMaps()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacter.Value = CharacterName;
            ParamList.Add(paramCharacter);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getCharactersMaps(@Character)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getCharactersMaps(@Character)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet leaveCharacterMap()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = CharacterName;
            paramMap.Value = MapName;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL leaveCharacterMap(@Character, @Map)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL leaveCharacterMap(@Character, @Map)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet endCharacterGame(string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = CharacterName;
            paramMap.Value = pMap;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL endCharacterGame(@Character, @Map)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL endCharacterGame(@Character, @Map)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getMapsCharacterCanRejoin()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacter.Value = CharacterName;
            ParamList.Add(paramCharacter);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getMapsCharacterCanRejoin(@Character)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getMapsCharacterCanRejoin(@Character)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterReturnToMap(string pMap, string pDirection)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            var paramDirection = new MySqlParameter("@Direction", MySqlDbType.VarChar, 16);
            paramCharacter.Value = CharacterName;
            paramMap.Value = pMap;
            paramDirection.Value = pDirection;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            ParamList.Add(paramDirection);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterReturnToMap(@Character, @Map), @Direction", ParamList.ToArray()); 
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterReturnToMap(@Character, @Map), @Direction", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterMakesMove(string pDirection)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramDirection = new MySqlParameter("@Direction", MySqlDbType.VarChar, 5);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = CharacterName;
            paramDirection.Value = pDirection;
            paramMap.Value = MapName;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramDirection);
            ParamList.Add(paramMap);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterMakesMove(@Character, @Direction, @Map)", ParamList.ToArray()); // maybe a try/catch
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterMakesMove(@Character, @Direction, @Map)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterPicksUpItem()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = CharacterName;
            paramMap.Value = MapName;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterPicksUpItem(@Character, @Map)", ParamList.ToArray()); // maybe a try/catch
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterPicksUpItem(@Character, @Map)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getCharacterItems(string pDirection)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacter.Value = CharacterName;
            ParamList.Add(paramCharacter);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getCharacterItems(@Character, @Direction, @Map)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getCharacterItems(@Character, @Direction, @Map)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet useItem(string pItem, string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            var paramItemName = new MySqlParameter("@ItemName", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = CharacterName;
            paramUsername.Value = _UserName;
            paramItemName.Value = pItem;
            paramMap.Value = pMap;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramUsername);
            ParamList.Add(paramItemName);
            ParamList.Add(paramMap);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL useItem(@Character, @Username, @ItemName, @Map)", ParamList.ToArray()); //ttry catch??
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL useItem(@Character, @Username, @ItemName, @Map)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet characterChats(string pMessage)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMessage = new MySqlParameter("@Message", MySqlDbType.VarChar, 32);
            paramCharacter.Value = CharacterName;
            paramMessage.Value = pMessage;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMessage);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterChats(@Character, @Message", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterChats(@Character, @Message", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet checkIfAdmin()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            paramUsername.Value = _UserName;
            ParamList.Add(paramUsername);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL checkIfAdmin(@Username", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL checkIfAdmin(@Username", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet getActiveGames()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            paramUsername.Value = _UserName;
            ParamList.Add(paramUsername);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getActiveGames(@Username)");
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getActiveGames(@Username)");
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminKillGame(string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32);
            paramMap.Value = pMap;
            paramAdminUsername.Value = _UserName;
            ParamList.Add(paramMap);
            ParamList.Add(paramAdminUsername);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminKillGame(@Map, @AdminUsername)");
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminKillGame(@Map, @AdminUsername)");
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminAddUser(string pUsername, string pEmail, string pPassword, Boolean pIsAdmin)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32);
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            var paramEmail = new MySqlParameter("@Email", MySqlDbType.VarChar, 64);
            var paramPassword = new MySqlParameter("@Password", MySqlDbType.VarChar, 64);
            var paramIsAdmin = new MySqlParameter("@IsAdmin", MySqlDbType.Int16); // mysql connection has issues with numbers that arn't integers
            paramAdminUsername.Value = _UserName;
            paramUsername.Value = pUsername;
            paramEmail.Value = pEmail;
            paramPassword.Value = pPassword;
            paramIsAdmin.Value = pIsAdmin;
            ParamList.Add(paramAdminUsername);
            ParamList.Add(paramUsername);
            ParamList.Add(paramEmail);
            ParamList.Add(paramPassword);
            ParamList.Add(paramIsAdmin);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminAddUser(@AdminUsername, @Username, @Email, @Password, @IsAdmin)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminAddUser(@AdminUsername, @Username, @Email, @Password, @IsAdmin)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null; 
            }
        }
        public static DataSet adminEditUser(string pUsername, string pNewUserName, string pNewUserEmail, string pNewUserPassword, int pNewLoginAttempts, int pNewUserScore, int pNewIsLocked, string pIsAdmin)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32);
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            var paramNewUsername = new MySqlParameter("@NewUsername", MySqlDbType.VarChar, 32);
            var paramNewUserPassword = new MySqlParameter("@NewUserPassword", MySqlDbType.VarChar, 64);
            var paramNewUserEmail = new MySqlParameter("@NewUserEmail", MySqlDbType.VarChar, 64);
            var paramNewLoginAttempts = new MySqlParameter("@NewLoginAttempts", MySqlDbType.Int16);
            var paramNewUserScore = new MySqlParameter("@NewUserScore", MySqlDbType.Int16);
            var paramNewIsLocked = new MySqlParameter("@NewIsLocked", MySqlDbType.Bit);
            var paramIsAdmin = new MySqlParameter("@IsAdmin", MySqlDbType.Bit);
            paramAdminUsername.Value = UserName;
            paramUsername.Value = pUsername;
            paramNewUsername.Value = pNewUserName;
            paramNewUserPassword.Value = pNewUserPassword;
            paramNewUserEmail.Value = pNewUserEmail;
            paramNewLoginAttempts.Value = pNewLoginAttempts;
            paramNewIsLocked.Value = pNewIsLocked;
            paramNewUserScore.Value = pNewUserScore;
            paramIsAdmin.Value = pIsAdmin;
            ParamList.Add(paramAdminUsername);
            ParamList.Add(paramUsername);
            ParamList.Add(paramNewUsername);
            ParamList.Add(paramNewUserPassword);
            ParamList.Add(paramNewUserEmail);
            ParamList.Add(paramNewLoginAttempts);
            ParamList.Add(paramNewUserScore);
            ParamList.Add(paramNewIsLocked);
            ParamList.Add(paramIsAdmin);
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminEditUser(@AdminUsername, @Username, @NewUsername, @NewUserEmail, @NewUserPassword, @NewLoginAttempts, @NewUserScore, @NewIsLocked, @IsAdmin)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminGetAllUsers()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32);
            paramAdminUsername.Value = _UserName;
            ParamList.Add(paramAdminUsername);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminGetAllUsers(@AdminUsername)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminGetAllUsers(@AdminUsername)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminDeleteUser(string pUsername)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32);
            var paramDeleteUser = new MySqlParameter("@DeleteUser", MySqlDbType.VarChar, 32);
            paramAdminUsername.Value = _UserName;
            paramDeleteUser.Value = pUsername;
            ParamList.Add(paramAdminUsername);
            ParamList.Add(paramDeleteUser);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminDeleteUser(@DeleteUser, @AdminUsername)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminDeleteUser(@DeleteUser, @AdminUsername)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminGetLockedUsers()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32);
            paramAdminUsername.Value = _UserName;
            ParamList.Add(paramAdminUsername);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminGetLockedUsers(@AdminUsername)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminGetLockedUsers(@AdminUsername)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static DataSet adminUnlockUser(string pUsername)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUnlockUser = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            var paramAdminUsername = new MySqlParameter("@AdminUsername", MySqlDbType.VarChar, 32);
            paramUnlockUser.Value = pUsername;
            paramAdminUsername.Value = _UserName;
            ParamList.Add(paramUnlockUser);
            ParamList.Add(paramAdminUsername);
            //var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminUnlockUser(@Username, @AdminUsername)", ParamList.ToArray());
            //return aDataSet;
            try
            {
                var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminUnlockUser(@Username, @AdminUsername)", ParamList.ToArray());
                return aDataSet;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
    }
}