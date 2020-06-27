using Org.BouncyCastle.Bcpg.OpenPgp;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TileGame
{
    public partial class frmCharacterSelect : Form
    {
        private string _SelectedCharacter;
        public frmCharacterSelect()
        {
            InitializeComponent();
        }
        public string SelectedCharacter { get => _SelectedCharacter; set => _SelectedCharacter = value; }

        private void CharacterSelect_Load(object sender, EventArgs e)
        {
            UpdateDisplay();
        }

        private void lbCharacters_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = lbCharacters.SelectedIndex;
            SelectedCharacter = lbCharacters.Items[index].ToString();
            lblSelectedCharacter.Text = "Selected Character:\n" + SelectedCharacter;

            DataSet CharacterSkills = ClsDataAccess.getCharacterSkills(SelectedCharacter);
            lblSkills.Text = "Skills:";
            foreach (DataRow characterSkill in CharacterSkills.Tables[0].Rows)
            {
                lblSkills.Text += "\n" + characterSkill[0].ToString();
            }
        }
        private void btnEditUser_Click(object sender, EventArgs e)
        {
            frmEditUser editUser  = new frmEditUser();
            editUser.Show();
            Hide();
        }

        private void btnDeleteUser_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Are you sure you want to delete your user?", "Confirmation", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataSet deleteUser = ClsDataAccess.deleteUser();
                foreach (DataRow aDataRow in deleteUser.Tables[0].Rows)
                {
                    MessageBox.Show(aDataRow[0].ToString());
                }
                frmlogin login = new frmlogin();
                login.Show();
                Hide();
            }
        }

        private void btnLogout_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Are you sure you want to log out?", "Confirmation", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataSet logOut = ClsDataAccess.userLogoff();
                frmlogin login = new frmlogin();
                login.Show();
                Hide();
            }
        }
        private void UpdateDisplay()
        {
            lblCurrentUser.Text = "Current User:\n " + ClsDataAccess.UserName;
            lblSelectedCharacter.Text = "Selected Charater: ";
            lblSkills.Text = "Skills:";
            DataSet UserCharacters = ClsDataAccess.getAllUserCharacters();
            lbCharacters.Items.Clear();
            foreach (DataRow characterName in UserCharacters.Tables[0].Rows)
            {
                lbCharacters.Items.Add(characterName[0].ToString());
            }

        }
        private void btnDeleteCharacter_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Are you sure you want to Delete the selected Character?", "Confirmation", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                DataSet deleteCharacter = ClsDataAccess.deleteCharacter(SelectedCharacter);
                foreach (DataRow aDataRow in deleteCharacter.Tables[0].Rows)
                {
                    MessageBox.Show(aDataRow[0].ToString());
                }
                UpdateDisplay();
            }
        }

        private void btnNewCharacter_Click(object sender, EventArgs e)
        {
            frmCreateCharacter editUser = new frmCreateCharacter();
            editUser.Show();
            Hide();
        }

        private void btnPlayCharacter_Click(object sender, EventArgs e)
        {
            if (SelectedCharacter == null)
                MessageBox.Show("Please Select a character");
            else
            {
                ClsDataAccess.CharacterName = SelectedCharacter;
                DataSet selectedChracter = ClsDataAccess.selectCharacter();
                foreach(DataRow aDataRow in selectedChracter.Tables[0].Rows)
                {
                    MessageBox.Show(aDataRow[0].ToString());
                    if (aDataRow[0].ToString() == SelectedCharacter + " is now active")
                    {
                        frmGameMenu newGame = new frmGameMenu();
                        newGame.Show();
                        Hide();
                    }
                }
            }
        }

        private void btnAdminMenu_Click(object sender, EventArgs e)
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
    }
}