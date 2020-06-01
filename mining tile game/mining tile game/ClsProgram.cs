using System;
using System.Data;


namespace miningTileGame
{
    public class ClsProgram
    {
        static void Main(string[] args)
        {
            menu();
        }

        private static void menu()
        {
            string menuText = "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Test Application for Tile Game~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                        "\n1) Test Conneciton with server\n2) Register a User\n3) Login with a user account\n4) Exit";
            Console.WriteLine(menuText);
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": // test connection
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
                    if (ClsTest.UserName == null)
                    {
                        menu();
                        break;
                    }
                    userMenu();
                    break;

                case "4": //Exit
                    Environment.Exit(0);
                    break;

                default:
                    menu();
                    break;
            }
        }
        private static void userMenu()
        {
            //string currentUser = ClsTest.getUserName().ToString();
            Console.WriteLine("The current User is " + ClsTest.UserName.ToString());
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~User Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                "\n1) Edit User\n2) Delete User\n3) User Creates Character\n4) User Deletes Character\n5) Select Character to play game\n6) Admin Menu\n7) Main Menu\n8) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": //Edit User
                    Console.WriteLine("Please enter a new username");
                    var editUserName = Console.ReadLine();
                    Console.WriteLine("Please enter a new password");
                    var editUserPassword = Console.ReadLine();
                    Console.WriteLine("Please enter a new email");
                    var editUserEmail = Console.ReadLine();
                    DataSet editUser = ClsTest.editUser(editUserName, editUserPassword, editUserEmail);
                    foreach (DataRow aRow in editUser.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    userMenu();
                    break;

                case "2": //Delete User
                    Console.WriteLine("Are you sure you want to delete this user?\n\n1) Yes\n2) No");
                    string deleteUserResponse = Console.ReadLine();
                    if (Equals(deleteUserResponse, 1))
                    {
                        DataSet deleteUser = ClsTest.deleteUser();
                        foreach (DataRow aRow in deleteUser.Tables[0].Rows)
                        {
                            Console.WriteLine(aRow["Message"]);
                        }
                    }
                    menu();
                    break;

                case "3": //User Creates Character
                    Console.WriteLine("What is the name of the Character?");
                    string characterName = Console.ReadLine();
                    Console.WriteLine("Please choose 4 skills by typing in the numbe\n1) Miner\n2) Gatherer\n3) Fisher\n4) Woodcutter\n5)Archer\n6)Smith");
                    string[] skills = new string[3];
                    for (int i = 0; i < 4; i++)
                    {
                        string skillResponse = Console.ReadLine();
                        switch (skillResponse)
                        {
                            case "1":
                                skills[i] = "Miner";
                                break;
                            case "2":
                                skills[i] = "Gatherer";
                                break;
                            case "3":
                                skills[i] = "Fisher";
                                break;
                            case "4":
                                skills[i] = "Woodcutter";
                                break;
                            case "5":
                                skills[i] = "Archer";
                                break;
                            case "6":
                                skills[i] = "Smith";
                                break;
                        }
                    } // not sure if this will work as I expect will test later TODO

                    DataSet createCharacter = ClsTest.createCharacter(characterName, skills[0], skills[1], skills[3], skills[4]);
                    foreach (DataRow aRow in createCharacter.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    userMenu();
                    break;

                case "4": //User Deletes Character
                    Console.WriteLine("These are you current Characters");
                    ClsTest.getAllUserCharacters();
                    Console.WriteLine("What is the name of the Character you want to delete?");
                    string characterToDelete = Console.ReadLine();
                    DataSet deleteCharacter = ClsTest.deleteCharacter();
                    foreach (DataRow aRow in deleteCharacter.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    userMenu();
                    break;

                case "5": //Select Character to play game
                    Console.WriteLine("These are you current Characters");
                    DataSet currentCharacters = ClsTest.getAllUserCharacters();
                    foreach (DataRow aRow in currentCharacters.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["userName"]);
                    }
                    Console.WriteLine("What character do you want to play with?");
                    string characterChoice = Console.ReadLine();
                    _ = ClsTest.selectCharacter(characterChoice); // DataSet characterChoose =
                    string characterNameCheck = ClsTest.getCharacterName().ToString();
                    if (characterNameCheck != null)
                    {
                        characterMenu();
                    }
                    else
                    {
                        foreach (DataRow aRow in currentCharacters.Tables[0].Rows)
                        {
                            Console.WriteLine(aRow["Message"]);
                            userMenu();
                        }
                    }
                    break;

                case "6": //Admin Menu
                    adminMenu();
                    break;

                case "7": //Main Menu
                    menu();
                    break;

                case "8": // Exit Program
                    Environment.Exit(0);
                    break;

                default:
                    userMenu();
                    break;
            }
        }
        private static void characterMenu()
        {
            Console.WriteLine("The current Character is" + ClsTest.getCharacterName().ToString());
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Character Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
            "1) Create Game\n2) Character Chats\n3) Return to Game in Progress\n4)  User Menu\n5) Main Menu\n6) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": // Create Game
                          // TODO
                    gameMenu();
                    break;

                case "2": // Character Chats
                    // TODO
                    characterMenu();
                    break;

                case "3": //Return to Game in Progress
                    gameMenu();
                    break;

                case "4": //User Menu
                    userMenu();
                    break;

                case "5": // Main Menu
                    menu();
                    break;

                case "6": // Exit Program
                    Environment.Exit(0);
                    break;
            }
        }
        private static void gameMenu()
        {
            Console.Write("1) Leave Game\n2) Character makes Move\n3) Character picks up item\n4) Player Uses Item on Mine\n5)Leave Game\n6)Exit Game 7)Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": // Leave Game
                    break;

                case "2": // 
                    break;

                case "3": //Return to Game in Progress
                    gameMenu();
                    break;

                case "4": //User Menu -- redo /update
                    userMenu();
                    break;

                case "5": // Main Menu
                    menu();
                    break;

                case "6": // Exit Program
                    Environment.Exit(0);
                    break;
            }
        }
        private static void adminMenu()
        {
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Admin Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                        "\n1) Admin Kills Running Game\n2) Admin adds a user\n3) Admin edits user\n4) Admin deletes user\n5) Admin unlocks locked user\n6) Return to main menu\n7) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": //Admin Kills Running Game
                            //Get list of running games
                            //Print
                            //select game to "kill"
                            //TODO  
                    adminMenu();
                    break;

                case "2": //Admin adds a user
                    Console.WriteLine("~~ Admin ~~ User registration\nPlease enter a Username");
                    string registerUserName = Console.ReadLine();
                    Console.WriteLine("Please enter a Email");
                    string registerEmail = Console.ReadLine();
                    Console.WriteLine("Please enter a Password");
                    string registerPassword = Console.ReadLine();
                    Console.WriteLine("Is this user an Admin?\n1)Yes\n2)No");
                    string adminResponse = Console.ReadLine().ToString();
                    bool registerAdmin;
                    if (adminResponse == "1")
                    {
                        registerAdmin = true;
                    }
                    else
                    {
                        registerAdmin = false;
                    }

                    DataSet RegisterUser = ClsTest.adminAddUser(registerUserName, registerEmail, registerPassword, registerAdmin);
                    foreach (DataRow aRow in RegisterUser.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    adminMenu();
                    break;

                case "3": //Admin edits user
                    //TODO
                    adminMenu();
                    break;

                case "4": //Admin deletes user
                    Console.WriteLine("~~~~List of All Users~~~~");
                    DataSet allUsers = ClsTest.adminGetAllUsers();
                    foreach (DataRow aRow in allUsers.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["username"]);
                    }
                    Console.WriteLine("Please type the name of the user you want to delete?");
                    var userToDelete = Console.ReadLine();
                    DataSet deleteUser = ClsTest.adminDeleteUser(userToDelete);
                    foreach (DataRow aRow in deleteUser.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    adminMenu();
                    break;

                case "5": //Admin unlocks locked user
                    Console.WriteLine("~~~~List of All Locked Users~~~~");
                    DataSet lockedUsers = ClsTest.adminGetLockedUsers();
                    foreach (DataRow aRow in lockedUsers.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["username"]);
                    }
                    Console.WriteLine("Please type the name of the user you want to unlock?");
                    var userToUnlock = Console.ReadLine();
                    DataSet unlockUser = ClsTest.adminUnlockUser(userToUnlock);
                    foreach (DataRow aRow in unlockUser.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    adminMenu();
                    break;
                case "6":
                    menu();
                    break;
                case "7":
                    Environment.Exit(0);
                    break;
            }
        }
     }
}