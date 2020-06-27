using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Text;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TileGame
{
    public partial class frmGameMenu : Form
    {
        public frmGameMenu()
        {
            InitializeComponent();
        }
        private string _SelectedOpponent;
        private string _SelectedGame;
        private string _SelectedMap;
        private string _GameInProgress;
        public string SelectedOpponent { get => _SelectedOpponent; set => _SelectedOpponent = value; }
        public string SelectedGame { get => _SelectedGame; set => _SelectedGame = value; }
        public string SelectedMap { get => _SelectedMap; set => _SelectedMap = value; }
        public string GameInProgress { get => _GameInProgress; set => _GameInProgress = value; }

        private void frmGameMenu_Load(object sender, EventArgs e)
        {
            updateDisplay();
            GameInProgress = null;
        }
        public void updateDisplay()
        {
            txtChatInput.Text = "Type a message";
            lblCurrentCharacter.Text = "Current Character: \n" + ClsDataAccess.CharacterName;
            DataSet CharacterSkills = ClsDataAccess.getCharacterSkills(ClsDataAccess.CharacterName);
            lblSkills.Text = "Skills:";
            foreach (DataRow characterSkill in CharacterSkills.Tables[0].Rows)
            {
                lblSkills.Text += "\n" + characterSkill[0].ToString();
            }
            DataSet choosenOpponent = ClsDataAccess.chooseOpponent();
            foreach (DataRow opponent in choosenOpponent.Tables[0].Rows)
            {
                // string opponentAndPoints = opponent[0].ToString() + opponent[1].ToString(); this line only if I go with a listbox
                Console.WriteLine(opponent[0].ToString());
                Console.WriteLine(opponent[1].ToString()); //remove after testing
                dgvChooseOpponent.Rows.Add(opponent[0].ToString(), opponent[1].ToString());
            }
            DataSet CurrentGames = ClsDataAccess.getMapsCharacterCanRejoin();
            lbGamesInProgress.Items.Clear();
            foreach (DataRow currentGame in CurrentGames.Tables[0].Rows)
            {
                lbGamesInProgress.Items.Add(currentGame[0].ToString());
            }
            dudMaps.Items.Add("5 by 5"); // hard coding this for testing purposes only so there is only one map. The below is the dynamic code 

            //DataSet mapsAvailable = ClsDataAccess.getMaps();
            //foreach (DataRow map in mapsAvailable.Tables[0].Rows)
            //{
            //    dudMaps.Items.Add(map[0].ToString());
            //}
            DataSet chatMessages = ClsDataAccess.getCharacterMessages();
            lbChat.Items.Clear();
            foreach (DataRow message in chatMessages.Tables[0].Rows)
            {
                string messageAndSender = message[0].ToString() + ": " + message[1].ToString();
                lbChat.Items.Add(messageAndSender);
            }
        }
        private void btnChangeCharacter_Click(object sender, EventArgs e)
        {
            ClsDataAccess.changeCharacter();
            frmCharacterSelect changeCharacter = new frmCharacterSelect();
            changeCharacter.Show();
            Hide();
        }
        private void btnAdmin_Click(object sender, EventArgs e)
        {
            string isAdmin;
            DataSet adminCheck = ClsDataAccess.checkIfAdmin();
            foreach (DataRow aDataRow in adminCheck.Tables[0].Rows)
            {
                isAdmin = aDataRow[0].ToString();
                Console.WriteLine(isAdmin);
                if (isAdmin == ClsDataAccess.UserName + " is an Admin")
                {
                    frmAdmin adminMenu = new frmAdmin();
                    adminMenu.Show();
                }
                else
                {
                    MessageBox.Show(aDataRow[0].ToString());
                }
            }
        }
        private void btnChallangeCharacter_Click(object sender, EventArgs e)
        {
            Console.WriteLine("Opponent = " + SelectedOpponent);
            Console.WriteLine("Map = " + SelectedMap); // remove after testing
            DataSet newGame = ClsDataAccess.createGame(SelectedOpponent, SelectedMap);
            foreach (DataRow aDataRow in newGame.Tables[0].Rows)
            {
                MessageBox.Show(aDataRow[0].ToString());
                if (aDataRow[0].ToString() == ClsDataAccess.CharacterName + " and " + SelectedOpponent + " are now playing on " + SelectedMap)
                {
                    frmGame game = new frmGame();
                    game.Show();
                    Hide();
                }
            }
            updateDisplay();
        }
        private void btnRejoinGame_Click(object sender, EventArgs e)
        {
            if (GameInProgress == null)
            {
                MessageBox.Show("Please select a game to return to");
            }
            else
            {
                var rbChecked = gbRejoinDirection.Controls.OfType<RadioButton>().FirstOrDefault(r => r.Checked); // source https://stackoverflow.com/questions/1797907/which-radio-button-in-the-group-is-checked
                string direction = rbChecked.Text;
                Console.WriteLine(direction);//remove after testing
                {
                    DataSet returnToMap = ClsDataAccess.characterReturnToMap(direction, GameInProgress);
                    foreach (DataRow aDataRow in returnToMap.Tables[0].Rows)
                    {
                        if (aDataRow[0].ToString() == ClsDataAccess.CharacterName + " has rejoined. Score reset")
                        {
                            frmGame rejoinedGame = new frmGame();
                            Hide();
                            rejoinedGame.Show();
                        }
                    }
                }
            }
        }
        private void dudMaps_SelectedItemChanged(object sender, EventArgs e)
        {
            int index = dudMaps.SelectedIndex;
            SelectedMap = dudMaps.Items[index].ToString();
        }
        private void dgvOnlineCharacters_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvChooseOpponent.SelectedCells[0].Value != null)
                SelectedOpponent = dgvChooseOpponent.SelectedCells[0].Value.ToString();
        }

        private void btnEndGame_Click(object sender, EventArgs e)
        {
            DataSet endGame = ClsDataAccess.endCharacterGame(GameInProgress); /// fix me TODO
            foreach (DataRow aDataRow in endGame.Tables[0].Rows)
            {
                MessageBox.Show(aDataRow[0].ToString());
            }
        }

        private void lbGamesInProgress_SelectedIndexChanged(object sender, EventArgs e)
        {
            GameInProgress = lbGamesInProgress.SelectedIndex.ToString();
            Console.WriteLine(GameInProgress); //remove after testing
        }

        private void btnChat_Click(object sender, EventArgs e)
        {
            ClsDataAccess.characterChats(txtChatInput.Text);
            updateDisplay();
        }

        private void txtChatInput_MouseClick(object sender, MouseEventArgs e)
        {
            txtChatInput.Text = "";
        }

        private void btnEndGame_Click_1(object sender, EventArgs e)
        {
            if(GameInProgress == null)
            {
                MessageBox.Show("Please select a game to end");
            }
            else
            {
                DataSet endGame = ClsDataAccess.endCharacterGame(GameInProgress);
                foreach (DataRow aDataRow in endGame.Tables[0].Rows)
                {
                    MessageBox.Show(aDataRow[0].ToString());
                }
            }
        }
    }
}
