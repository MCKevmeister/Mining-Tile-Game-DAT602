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
        private static object _userName;
        private static object  _characterName;
        private static object _mapName;

        public static object getUserName()
        {
            return _userName;
        }
        public static object getCharacterName()
        {
            return _characterName;
        }
        public static string testConnection()
        {
            MySqlConnection testcon = new MySqlConnection(connection);
            Console.Write("Validating credentials");
            testcon.Open();
            if (testcon.State == ConnectionState.Open)
            {
                return "\nConnected to server";
            }
            else
            {
                return "\nError Connecting to server";
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
            catch (MySql.Data.MySqlClient.MySqlException e)
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

            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "userLogin(@Username,@UserPassword)", ParamList.ToArray());
            //userName = pUsername;

            foreach (DataRow aRow in aDataSet.Tables[0].Rows)
            {
                _userName = (aRow["userName"]); //Stores username as a local variable to be used by the user menu
            }
            return aDataSet;
        }
        public static DataSet editUser(string pNewUserName, string pNewUserPassword, string pNewUserEmail)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            var paramNewUsername = new MySqlParameter("@NewUsername", MySqlDbType.VarChar, 32);
            var paramNewUserPassword = new MySqlParameter("@NewUserPassword", MySqlDbType.VarChar, 64);
            var paramNewUserEmail = new MySqlParameter("@NewUserEmail", MySqlDbType.VarChar, 64);

            paramUserName.Value = _userName;
            paramNewUsername.Value = pNewUserName;
            paramNewUserPassword.Value = pNewUserPassword;
            paramNewUserEmail.Value = pNewUserEmail;

            ParamList.Add(paramUserName);
            ParamList.Add(paramNewUsername);
            ParamList.Add(paramNewUserPassword);
            ParamList.Add(paramNewUserEmail);

            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL editUser(@Username, @NewUsername, @NewUserPassword, @NewUserEmail)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet deleteUser()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            paramUsername.Value = _userName; //Accesses the stored username from the userMenu
            ParamList.Add(paramUsername);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL deleteUser(@Username)", ParamList.ToArray());

            return aDataSet;
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
            paramUserName.Value = _userName;
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
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL createCharacter(@Username, @CharacterName, @Skill1, @Skill2, @Skill3, @Skill4)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet getAllUserCharacters()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            paramUserName.Value = _userName;
            ParamList.Add(paramUserName);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getAllUserCharacters(@Username)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet deleteCharacter()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            paramUserName.Value = _userName;
            paramCharacterName.Value = _characterName;
            ParamList.Add(paramUserName);
            ParamList.Add(paramCharacterName);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL deleteCharacter(@CharacterName, @UserName)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet selectCharacter(string pCharacterName)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            var paramUserName = new MySqlParameter("@UserName", MySqlDbType.VarChar, 32);
            paramUserName.Value = _userName;
            paramCharacterName.Value = pCharacterName;
            ParamList.Add(paramCharacterName);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL selectCharacter(@CharacterName, @UserName)", ParamList.ToArray());
            try
            {
                foreach (DataRow aRow in aDataSet.Tables[0].Rows)
                {
                    _characterName = (aRow["characterName"]); //Stores character as a local variable to be used by the character menu
                }
                return aDataSet;
            }
            catch
            {
                return aDataSet;
            }
        }
        public static DataSet onlineCharacters()
        {
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL onlineCharacters()");
            return aDataSet;
        }
        public static DataSet getMaps()
        {
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getMaps()");
            return aDataSet;
        }
        public static DataSet chooseOpponent()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacterName.Value = _characterName;
            ParamList.Add(paramCharacterName);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL chooseOpponent(@Character)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet createGame(string pOpponent, string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter1 = new MySqlParameter("@Character1", MySqlDbType.VarChar, 32);
            var paramCharacter2 = new MySqlParameter("@Character2", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter1.Value = _characterName;
            paramCharacter2.Value = pOpponent;
            paramMap.Value = pMap;
            ParamList.Add(paramCharacter1);
            ParamList.Add(paramCharacter2);
            ParamList.Add(paramMap);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL createGame(@Character1, @Character2, @Map)", ParamList.ToArray()); // maybe a try/catch
            return aDataSet;
        }
        public static DataSet getCharactersMaps()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacter.Value = _characterName;
            ParamList.Add(paramCharacter);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getCharactersMaps(@Character)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet leaveCharacterMap(string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = _characterName;
            paramMap.Value = pMap;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getCharactersMaps(@Character, @Map)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet endCharacterGame(string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = _characterName;
            paramMap.Value = pMap;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL endCharacterGame(@Character, @Map)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet getMapsCharacterCanRejoin()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacter.Value = _characterName;
            ParamList.Add(paramCharacter);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getMapsCharacterCanRejoin(@Character)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet characterReturnToMap(string pMap, string pDirection)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            var paramDirection = new MySqlParameter("@Direction", MySqlDbType.VarChar, 16);
            paramCharacter.Value = _characterName;
            paramMap.Value = pMap;
            paramDirection.Value = pDirection;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            ParamList.Add(paramDirection);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterReturnToMap(@Character, @Map), @Direction", ParamList.ToArray()); // maybe a try/catch
            return aDataSet;
        }
        public static DataSet characterMakesMove(string pDirection)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramDirection = new MySqlParameter("@Direction", MySqlDbType.VarChar, 5);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = _characterName;
            paramDirection.Value = pDirection;
            paramMap.Value = _mapName;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramDirection);
            ParamList.Add(paramMap);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterMakesMove(@Character, @Direction, @Map)", ParamList.ToArray()); // maybe a try/catch
            return aDataSet;
        }
        public static DataSet characterPicksUpItem(string pDirection)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = _characterName;
            paramMap.Value = _mapName;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramMap);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL characterPicksUpItem(@Character, @Map)", ParamList.ToArray()); // maybe a try/catch
            return aDataSet;
        }
        public static DataSet getCharacterItems(string pDirection)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            paramCharacter.Value = _characterName;
            ParamList.Add(paramCharacter);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getCharacterItems(@Character, @Direction, @Map)", ParamList.ToArray());
            return aDataSet;
        }
        public static DataSet useItem(string pItem, string pMap)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacter = new MySqlParameter("@Character", MySqlDbType.VarChar, 32);
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            var paramItemName = new MySqlParameter("@ItemName", MySqlDbType.VarChar, 32);
            var paramMap = new MySqlParameter("@Map", MySqlDbType.VarChar, 16);
            paramCharacter.Value = _characterName;
            paramUsername.Value = _userName;
            paramItemName.Value = pItem;
            paramMap.Value = pMap;
            ParamList.Add(paramCharacter);
            ParamList.Add(paramUsername);
            ParamList.Add(paramItemName);
            ParamList.Add(paramMap);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL useItem(@Character, @Direction, @Map)", ParamList.ToArray()); //ttry catch??
            return aDataSet;
        }
        //useItem(pCharacterName VARCHAR(32), pUserName VARCHAR(32), pItemName VARCHAR(32), pMap VARCHAR(16)) 

        // Characater Chats
        //characterChats(pCharacterName VARCHAR(32), pMessage VARCHAR(255)) 

        //Check if Admin to Access Admin Menu
        //checkIfAdmin(pUserName VARCHAR(32), pUserPassword VARCHAR(64)) 

        //Admin Kills Running Game
        //getActiveGames()
        //adminKillGame(pMapName VARCHAR(16)) 

        // Admin adds User
        //adminAddUser(pUserName VARCHAR(32), pEmail VARCHAR(64), pUserPassword VARCHAR(64), pIsAdmin BOOLEAN)

        // Admin edits User
        // adminEditUser(pAdminUserName VARCHAR(32), pUserName VARCHAR(32) , pNewUserName VARCHAR(64), pEmail VARCHAR(64), pNewUserEmail VARCHAR(64), pUserPassword VARCHAR(64), pLoginAttempts INTEGER, pUserScore INTEGER, pIsLocked BOOLEAN, pIsAdmin BOOLEAN)

        // Admin deletes user
        // adminGetAllUsers(pAdminUserName VARCHAR(32))
        // adminDeleteUser(pUserName VARCHAR(32), pAdminUserName VARCHAR(32))
        public static DataSet getAllUsers()
        {
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getAllUsers()");
            return aDataSet;
        }
        public static DataSet getLockedUsers()
        {
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL getLockedUsers()");
            return aDataSet;
        }
        public static DataSet unlockUser(string pUsername)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            paramUsername.Value = pUsername;
            ParamList.Add(paramUsername);

            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminUnlockUser(@Username)", ParamList.ToArray());

            return aDataSet;
        }
    }
}