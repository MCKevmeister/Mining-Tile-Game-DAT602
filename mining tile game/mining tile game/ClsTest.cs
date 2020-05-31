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
        private static object _characterName;

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
        public static DataSet deleteCharacter()
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            paramCharacterName.Value = _characterName;
            ParamList.Add(paramCharacterName);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL deleteCharacter(@CharacterName)", ParamList.ToArray());
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
        public static DataSet selectCharacter(string pCharacterName)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramCharacterName = new MySqlParameter("@CharacterName", MySqlDbType.VarChar, 32);
            paramCharacterName.Value = pCharacterName;
            ParamList.Add(paramCharacterName);
            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL selectCharacter(@CharacterName)", ParamList.ToArray());
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