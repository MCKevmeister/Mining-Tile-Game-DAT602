using System;
using System.Data;
using MySql.Data.MySqlClient;


namespace mining_tile_game
{
    public class ClsProgram
    {
        static void Main(string[] args)
        {
            menu();
        }

        private static void menu()
        {
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Test Application for Tile Game~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                        "\n1) Test Conneciton with server\n2) Register a User\n3) Login with a user account\n4) Exit");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1":
                    string testConnection = ClsTest.testConnection();
                    Console.WriteLine(testConnection + "\n");
                    menu();
                    break;

                case "2": //Register a User
                    Console.WriteLine("User registration\nPlease enter a Username");
                    string register_username = Console.ReadLine();
                    Console.WriteLine("Please enter a Email");
                    string register_email = Console.ReadLine();
                    Console.WriteLine("Please enter a Password");
                    string register_password = Console.ReadLine();
                    DataSet RegisterUser = ClsTest.registerUser(register_username, register_email, register_password);
                    if (RegisterUser != null)
                        foreach (DataRow aRow in RegisterUser.Tables[0].Rows)
                        {
                            Console.WriteLine(aRow["Message"]);
                        }
                    menu();
                    break;

                case "3": //Login with a user
                    Console.WriteLine("Please enter a username:");
                    String login_username = Console.ReadLine();
                    Console.WriteLine("Please enter password for " + login_username + ":");
                    String login_password = Console.ReadLine();
                    DataSet UserLogin = ClsTest.userLogin(login_username, login_password);
                    foreach (DataRow aRow in UserLogin.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    userMenu();
                    break;

                case "4": //Admin Menu
                    adminMenu();
                    break;

                case "5": //Exit
                    Environment.Exit(0);
                    break;

                default:
                    menu();
                    break;

                //case "5": //Delete User
                //    Console.WriteLine("Delete User \nPlease enter the user to delete");
                //    string deleteuser_username = Console.ReadLine();
                //    DataSet DeleteUser = ClsTest.deleteUser(deleteuser_username);
                //    foreach (DataRow aRow in DeleteUser.Tables[0].Rows)
                //    {
                //        Console.WriteLine(aRow["Message"]);
                //    }
                //    userMenu();
                //    menu();
                //    break;

                //case "6": //User Locked Out Check
                //    Console.WriteLine("User Lock out check\nPlease enter the user to check if they are locked out");
                //    string userlockedcheck_username = Console.ReadLine();
                //    DataSet UserLockedOut = ClsTest.deleteUser(userlockedcheck_username);
                //    foreach (DataRow aRow in UserLockedOut.Tables[0].Rows)
                //    {
                //        Console.WriteLine(aRow["Message"]);
                //    }
                //    menu(); 
                //    break;
            }
        }
        private static void userMenu()
        {
            string currentUser = ClsTest.getUserName().ToString();
            Console.WriteLine("The current User is" + currentUser);
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~User Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                "n 1) Edit User\n2) Delete User\n3) User Creates Character\n4) User Deletes Character\n5) Select Character to play game\n6) Main Menu\n7) Exit Program");//6) Create Game\n7) Character Chats\n8) Main Menu\n 9)Admin Menu\n10) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": //Edit User
                    //TODO  
                    userMenu();
                    break;

                //case "2": //Delete User
                //    Console.WriteLine("Are you sure you want to delete this user?\n1) Yes\n2) No");
                //    string deleteUserResponse = Console.ReadLine();
                //    if(Equals(deleteUserResponse, 1))
                //    {
                //        DataSet DeleteUser = ClsTest.deleteUser();
                //        foreach (DataRow aRow in DeleteUser.Tables[0].Rows)
                //        {
                //            Console.WriteLine(aRow["Message"]);
                //        }
                //    }
                //    userMenu();
                //    break;

                case "3": //User Creates Character
                    Console.WriteLine("What is the name of the Character?");
                    string characterName = Console.ReadLine();
                    Console.WriteLine("Please choose 4 skills");
                    

                    string deleteUserResponse = Console.ReadLine();
                    userMenu();
                    break;

                case "4": //User Deletes Character
                          //TODO
                    userMenu();
                    break;

                case "5": //Select Character to play game
                    characterMenu();
                    break;

                case "6": //Main Menu
                    menu();
                    break;

                case "7": //Exit Program
                    Environment.Exit(0);
                    break;

                default:
                    userMenu();
                    break;
            }
        }
        private static void characterMenu()
        {

        }
        private static void gameMenu()
        {
                Console.Write("test");
            //1) Leave Game\n12) Game Generates Items\n13) Game Generates Mines\n14) Return to Game in Progress\n15) Character makes Move\n" +
            //"16) Character picks up item\n17) Player Uses Item on Mine\n
        }
        private static void adminMenu()
        {
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Admin Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                        "\n1) Admin Kills Running Game\n2) Admin adds a user\n3) Admin edits user\n4) Admin deletes user\n5) Admin unlocks locked user\n6) Return to main menu");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1":
                    //TODO  
                    adminMenu();
                    break;

                case "2":
                    //TODO
                    adminMenu();
                    break;

                case "3":
                    //TODO
                    adminMenu();
                    break;

                case "4":
                    Console.WriteLine("~~~~List of All Users~~~~");
                    DataSet allUsers = ClsTest.getAllUsers();
                    foreach (DataRow aRow in allUsers.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["username"]);
                    }
                    Console.WriteLine("Which user do you want to delete?");
                    var userToDelete = Console.ReadLine();
                    DataSet deleteUser = ClsTest.deleteUser(userToDelete);
                    foreach (DataRow aRow in deleteUser.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    adminMenu();
                    break;
                        
                case "5":
                    Console.WriteLine("~~~~List of All Locked Users~~~~");
                    DataSet lockedUsers = ClsTest.getLockedUsers();
                    foreach (DataRow aRow in lockedUsers.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["username"]);
                    }
                    Console.WriteLine("Which user do you want to unlock?");
                    var userToUnlock = Console.ReadLine();
                    DataSet unlockUser = ClsTest.unlockUser(userToUnlock);
                    foreach (DataRow aRow in unlockUser.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    adminMenu();
                    break;
                case "6":
                    menu();
                    break;
            }
        }
    }
}