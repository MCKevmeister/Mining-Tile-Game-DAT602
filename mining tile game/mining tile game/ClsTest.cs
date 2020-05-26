using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace mining_tile_game
{
    class ClsTest
    {
        private static readonly String connection = "Server=localhost;Port=3306;Database=dbTileGame;Uid =root;password=W7oUmiLaiTrznc;"; 
        private static readonly MySqlConnection mySqlConnection = new MySqlConnection(connection);
        private static object userName;
   
        public static object getUserName()
        {
            return userName;
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
        public void CreateMySqlCommand(string myExecuteQuery, MySqlConnection myConnection)
        {
            MySqlCommand myCommand = new MySqlCommand(myExecuteQuery, myConnection);
            myCommand.Connection.Open();
            myCommand.ExecuteNonQuery();
            myConnection.Close();
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
            userName = pUsername;

            foreach (DataRow aRow in aDataSet.Tables[0].Rows)
            {
                userName = (aRow["userName"]);
            }
            return aDataSet;
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
        public static DataSet deleteUser(string pUsername)
        {
            List<MySqlParameter> ParamList = new List<MySqlParameter>();
            var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
            paramUsername.Value = pUsername;
            ParamList.Add(paramUsername);

            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL adminDeleteUser(@Username)", ParamList.ToArray());

            return aDataSet;
        }
        //public static DataSet lockedUserCheck(string pUsername)
        //{
        //    List<MySqlParameter> ParamList = new List<MySqlParameter>();
        //    var paramUsername = new MySqlParameter("@Username", MySqlDbType.VarChar, 32);
        //    paramUsername.Value = pUsername;
        //    ParamList.Add(paramUsername);

        //    var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL lockedUserCheck(@Username)", ParamList.ToArray());

        //    return aDataSet;
        //}
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
        public static DataSet unlockUser( string pUsername)
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


