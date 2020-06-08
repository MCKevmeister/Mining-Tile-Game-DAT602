using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

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
                        foreach (DataRow aRow in RegisterUser.Tables[0].Rows)
                        {
                            Console.WriteLine(aRow["Message"]);
                        }
                    menu();
                    break;

                case "3": //Login with a user
                    Console.WriteLine("Please enter a username:");
                    String loginUsername = Console.ReadLine();
                    Console.WriteLine("Please enter password for " + loginUsername + ":");
                    String loginPassword = Console.ReadLine();
                    DataSet UserLogin = ClsTest.userLogin(loginUsername, loginPassword);
                    foreach (DataRow aRow in UserLogin.Tables[0].Rows)
                    {
                        if (aRow["Message"].ToString() ==  loginUsername +" is now Online") // sucess message
                        {
                            ClsTest.UserName = loginUsername; // set username inside cls test
                            Console.WriteLine(aRow["Message"]);
                            userMenu();
                        }
                        else
                        {
                            Console.WriteLine(aRow["Message"]);
                            menu();
                        }
                    }
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
            Console.WriteLine("The current User is " + ClsTest.UserName);
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~User Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                "\n1) Edit User\n2) Delete User\n3) User Creates Character\n4) User Deletes Character\n5) Select Character to play game\n6) Admin Menu\n7) Log off\n8) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": //Edit User
                    Console.WriteLine("Please enter a new username");
                    string editUserName = Console.ReadLine();
                    Console.WriteLine("Please enter a new password");
                    string editUserPassword = Console.ReadLine();
                    Console.WriteLine("Please enter a new email");
                    string editUserEmail = Console.ReadLine();
                    DataSet editUser = ClsTest.editUser(editUserName, editUserPassword, editUserEmail);
                    foreach (DataRow aRow in editUser.Tables[0].Rows)
                    {
                        if (aRow["Message"].ToString() == "User details have been updated") // sucess message
                        {
                            ClsTest.UserName = editUserName; // set username inside cls test
                            Console.WriteLine(aRow["Message"]);
                            userMenu();
                        }
                        else
                        {
                            Console.WriteLine(aRow["Message"]);
                            userMenu();                        }
                    }
                    break;

                case "2": //Delete User
                    Console.WriteLine("Are you sure you want to delete this user?\n\n1) Yes\n2) No");
                    string deleteUserResponse = Console.ReadLine();
                    if (deleteUserResponse == "1")
                    {
                        DataSet deleteUser = ClsTest.deleteUser();
                        foreach (DataRow aRow in deleteUser.Tables[0].Rows)
                        {
                            if (aRow["Message"].ToString() == ClsTest.UserName + " has been deleted") // sucess message
                            {
                                ClsTest.UserName = null; // set username inside cls test
                                Console.WriteLine(aRow["Message"]);
                                menu();
                            }
                            else
                            {
                                Console.WriteLine(aRow["Message"]);
                                userMenu();
                            }
                        }
                    }
                    else
                    {
                        userMenu();
                    }
                    break;

                case "3": //User Creates Character
                    Console.WriteLine("What is the name of the Character?");
                    string characterName = Console.ReadLine();
                    Console.WriteLine("Please choose 4 skills by typing in the number\n1) Miner\n2) Gatherer\n3) Fisher\n4) Woodcutter\n5)Archer\n6)Smith");
                    var skills = new List<string>();
                    for (int i = 0; i < 4; i++) // loop 4 times
                    {
                        string skillResponse = Console.ReadLine();
                        switch (skillResponse)
                        {
                            case "1":
                                skills.Add("Miner");
                                break;
                            case "2":
                                skills.Add("Gatherer");
                                break;
                            case "3":
                                skills.Add("Fisher");
                                break;
                            case "4":
                                skills.Add("Woodcutter");
                                break;
                            case "5":
                                skills.Add("Archer");
                                break;
                            case "6":
                                skills.Add("Smith");
                                break;
                            default:
                                i--;
                                break;
                        }
                    }
                    string skill1 = skills.ElementAt(0);
                    string skill2 = skills.ElementAt(1);
                    string skill3 = skills.ElementAt(2);
                    string skill4 = skills.ElementAt(3);
                    DataSet createCharacter = ClsTest.createCharacter(characterName, skill1, skill2, skill3, skill4);
                    foreach (DataRow aRow in createCharacter.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    userMenu();
                    break;

                case "4": //User Deletes Character
                    Console.WriteLine("These are you current Characters");
                    DataSet currentCharaters = ClsTest.getAllUserCharacters();
                    foreach (DataRow aRow in currentCharaters.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["characterName"]);
                    }
                    Console.WriteLine("What is the name of the Character you want to delete?");
                    string characterToDelete = Console.ReadLine();
                    DataSet deleteCharacter = ClsTest.deleteCharacter(characterToDelete);
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
                        Console.WriteLine(aRow["characterName"]);
                    }
                    Console.WriteLine("What character do you want to play with?");
                    string chosenCharacter = Console.ReadLine();
                    DataSet characterChoice = ClsTest.selectCharacter(chosenCharacter);
                    foreach (DataRow aRow in characterChoice.Tables[0].Rows)
                    {
                        if (aRow["Message"].ToString() == chosenCharacter + " is now active") // sucess message
                            {
                            ClsTest.CharacterName = chosenCharacter; // set character inside cls test
                            Console.WriteLine(aRow["Message"]);
                            characterMenu();
                        }
                        else
                        {
                            Console.WriteLine(aRow["Message"]);
                            userMenu();
                        }
                    }
                    break;

                case "6": //Admin Menu
                   DataSet adminCheck = ClsTest.checkIfAdmin();
                    foreach (DataRow aRow in adminCheck.Tables[0].Rows)
                        if (aRow["Message"].ToString() == ClsTest.UserName.ToString() + " is an Admin")
                        {
                            Console.WriteLine(aRow["Message"]);
                            adminMenu();
                        }
                        else
                        {
                            Console.WriteLine(aRow["Message"]);
                            userMenu();
                        }
                        break;

                case "7": //Log off
                    DataSet userLogoff = ClsTest.userLogoff();
                    foreach (DataRow aRow in userLogoff.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    ClsTest.UserName = "";
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
            Console.WriteLine("The current Character is " + ClsTest.CharacterName);
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Character Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
            "\n1) Create Game\n2) Character Chats\n3) Return to Game in Progress\n4) User Menu\n5) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": // Create Game
                    Console.WriteLine("Who do you want to play against?");
                    DataSet onlineCharacter = ClsTest.onlineCharacters();
                    foreach (DataRow aRow in onlineCharacter.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["characterName"]);
                    }
                    string opponent = Console.ReadLine();
                    Console.WriteLine("What map do you want to play on?");
                    DataSet allMaps = ClsTest.getMaps();
                    foreach(DataRow aRow in allMaps.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["mapName"]);
                    }
                    string map = Console.ReadLine();
                    DataSet createGame = ClsTest.createGame(opponent, map);
                    foreach (DataRow aRow in createGame.Tables[0].Rows)
                    {
                        if (aRow["Message"].ToString() == ClsTest.CharacterName + " and " + opponent + " are now playing on " + map) //
                        {
                            ClsTest.MapName = map;
                            Console.WriteLine(aRow["Message"]);
                            gameMenu();
                        }
                        else
                        {
                            Console.WriteLine(aRow["Message"]);
                            characterMenu();
                        }
                    }
                    break;

                case "2": // Character Chats
                    Console.WriteLine("What do you want to say?");
                    string message = Console.ReadLine();
                    DataSet characterChats = ClsTest.characterChats(message);
                    characterMenu();
                    break;

                case "3": //Return to Game
                     Console.WriteLine("Which game do you want to return to?");
                     DataSet currentGames = ClsTest.getMapsCharacterCanRejoin();
                     foreach (DataRow aRow in currentGames.Tables[0].Rows)
                     {
                         Console.WriteLine(aRow["Message"]);
                     }
                    string mapResponse  = Console.ReadLine();
                    Console.WriteLine("If your character needs to move to rejoin, Which direciton do you want to move");
                    string direction = Console.ReadLine();
                    DataSet returnToMap = ClsTest.characterReturnToMap(mapResponse, direction);
                    foreach (DataRow aRow in returnToMap.Tables[0].Rows)
                    {
                        if (aRow["Message"].ToString() == ClsTest.CharacterName +" has rejoined " + mapResponse + ". Score reset") //
                        {
                            ClsTest.MapName = mapResponse;
                            Console.WriteLine(aRow["Message"]);
                            gameMenu();
                        }
                        else
                        {
                            Console.WriteLine(aRow["Message"]);
                            characterMenu();
                        }
                    }
                    break;

                case "4": //Change Character
                    DataSet changeCharacter = ClsTest.changeCharacter();
                    foreach (DataRow aRow in changeCharacter.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    userMenu();
                    break;

                case "5": // Exit Program
                    Environment.Exit(0);
                    break;
            }
        }
        private static void gameMenu()
        {
            Console.Write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Character Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" + 
                "1) Leave Game\n2) Character makes Move\n3) Character picks up item\n4) Player Uses Item on Mine\n7) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": // Leave Game
                    DataSet leaveCharacterMap = ClsTest.leaveCharacterMap();
                    foreach (DataRow aRow in leaveCharacterMap.Tables[0].Rows)
                    {
                        if (aRow["Message"].ToString() == ClsTest.CharacterName +  " has left the game but can rejoin") //
                        {
                            ClsTest.MapName = "";
                            Console.WriteLine(aRow["Message"]);
                            characterMenu();
                        }
                        else
                        {
                            Console.WriteLine(aRow["Message"]);
                            gameMenu();
                        }
                    }
                    break;

                case "2": // Character makes Move
                    Console.WriteLine("Which direciton do you want to move?");
                    string direction = Console.ReadLine();
                    DataSet characterMakesMove = ClsTest.characterMakesMove(direction);
                    foreach (DataRow aRow in characterMakesMove.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    gameMenu();
                    break;

                case "3": //Character picks up item
                    DataSet characterPicksUpItem = ClsTest.characterPicksUpItem();
                    foreach (DataRow aRow in characterPicksUpItem.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["Message"]);
                    }
                    gameMenu();
                    break;

                case "5": // Exit Program
                    Environment.Exit(0);
                    break;
            }
        }
        private static void adminMenu()
        {
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~Admin Menu~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nPlease Choose from the below list" +
                        "\n1) Admin Kills Running Game\n2) Admin adds a user\n3) Admin edits user\n4) Admin deletes user\n5) Admin unlocks locked user\n6) Return to User Menu\n7) Exit Program");
            var response = Console.ReadLine();
            switch (response)
            {
                case "1": //Admin Kills Running Game
                    Console.WriteLine("Which game do you want to kill?");
                    DataSet activeGames = ClsTest.getActiveGames();
                    foreach (DataRow aRow in activeGames.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["mapName"]);
                    }
                    string gameToKill = Console.ReadLine();
                    DataSet adminKillGame = ClsTest.adminKillGame(gameToKill);
                    foreach (DataRow aRow in adminKillGame.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["MESSAGE"]);
                    }
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
                    Console.WriteLine("~~~~List of All Users~~~~");
                    DataSet allUsersEdit = ClsTest.adminGetAllUsers();
                    foreach (DataRow aRow in allUsersEdit.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["username"]);
                    }
                    Console.WriteLine("Please enter the name of the user you want to edit?");
                    string userToEdit = Console.ReadLine();
                    Console.WriteLine("Please enter the new username");
                    string newUserName = Console.ReadLine();
                    Console.WriteLine("Please enter the new password");
                    string newUserPassword = Console.ReadLine();
                    Console.WriteLine("Please enter the new email");
                    string newUserEmail = Console.ReadLine();
                    Console.WriteLine("Please enter the new login attempts amount");
                    int newLoginAttempts = Convert.ToInt16(Console.ReadLine());
                    Console.WriteLine("Please enter the new user score");
                    int newUserScore = Convert.ToInt16(Console.ReadLine());
                    Console.WriteLine("Is the user locked?\n1) Yes\n2) No");
                    string responseIsLocked = Console.ReadLine();
                    int newIsLocked;
                    if (responseIsLocked == "1")
                    {
                        newIsLocked = 1;
                    }
                    else
                    {
                        newIsLocked = 0;
                    }
                    Console.WriteLine("Is this user an admin?\n 1) Yes\n2) No");
                    string responseIsAdmin = Console.ReadLine();
                    int newIsAdmin;
                    if (responseIsAdmin == "1")
                    {
                        newIsAdmin = 1;
                    }
                    else
                    {
                        newIsAdmin = 0;
                    }
                    DataSet adminEditUser = ClsTest.adminEditUser(userToEdit, newUserName, newUserEmail, newUserPassword, newLoginAttempts, newUserScore, newIsLocked, newIsAdmin);
                    foreach (DataRow aRow in adminEditUser.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["MESSAGE"]);
                    }
                    adminMenu();
                    break;

                case "4": //Admin deletes user
                    Console.WriteLine("~~~~List of All Users~~~~");
                    DataSet allUsers = ClsTest.adminGetAllUsers();
                    foreach (DataRow aRow in allUsers.Tables[0].Rows)
                    {
                        Console.WriteLine(aRow["username"]);
                    }
                    Console.WriteLine("Please enter the name of the user you want to delete?");
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
                    userMenu();
                    break;
                case "7":
                    Environment.Exit(0);
                    break;
            }
        }
     }
}