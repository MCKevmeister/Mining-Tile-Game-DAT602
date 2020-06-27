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
    public partial class frmAdmin : Form
    {
        public frmAdmin()
        {
            InitializeComponent();
        }
        private string _SelectedUser;
        private string _SelectedLockedUser;
        private string _SelectedGame;
        public string SelectedUser { get => _SelectedUser; set => _SelectedUser = value; }
        public string SelectedLockedUser { get => _SelectedLockedUser; set => _SelectedLockedUser = value; }
        public string SelectedGame { get => _SelectedGame; set => _SelectedGame = value; }
        private void frmAdmin_Load(object sender, EventArgs e)
        {
            updateDisplay();
        }
        private void updateDisplay()
        {
            lbActiveGames.Items.Clear();
            lbAllUsers.Items.Clear();
            lbLockedUsers.Items.Clear();
            DataSet allUsers = ClsDataAccess.adminGetAllUsers();
            foreach(DataRow user in allUsers.Tables[0].Rows)
                lbAllUsers.Items.Add(user[0].ToString());
            DataSet lockedUsers = ClsDataAccess.adminGetLockedUsers();
            foreach (DataRow locked in lockedUsers.Tables[0].Rows)
                lbLockedUsers.Items.Add(locked[0].ToString());
            DataSet activeGames = ClsDataAccess.getActiveGames();
            foreach (DataRow game in activeGames.Tables[0].Rows)
                lbActiveGames.Items.Add(game[0].ToString());
            }
        private void lbAllUsers_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = lbAllUsers.SelectedIndex;
            SelectedUser = lbAllUsers.Items[index].ToString();
        }
        private void lbLockedUsers_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = lbLockedUsers.SelectedIndex;
            SelectedLockedUser = lbLockedUsers.Items[index].ToString();
        }
        private void lbActiveGames_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = lbActiveGames.SelectedIndex;
            SelectedGame = lbActiveGames.Items[0].ToString();
        }
        private void btnAddAccount_Click(object sender, EventArgs e)
        {
            frmAdminAddUser adminAddUser = new frmAdminAddUser();
            adminAddUser.Show();
            Hide();
        }
        private void btnEditAccount_Click(object sender, EventArgs e)
        {
            frmAdminEditUser adminEditUser = new frmAdminEditUser();
            adminEditUser.Show();
            Hide();
        }
        private void btnUnlockUser_Click(object sender, EventArgs e)
        {
            DataSet userToUnlock = ClsDataAccess.adminUnlockUser(SelectedLockedUser);
            foreach (DataRow locked in userToUnlock.Tables[0].Rows)
                MessageBox.Show(locked[0].ToString());
            updateDisplay();
        }
        private void btnKillGame_Click(object sender, EventArgs e)
        {
            DataSet gameToKill = ClsDataAccess.adminKillGame(SelectedGame);
            foreach (DataRow killedGame in gameToKill.Tables[0].Rows)
                MessageBox.Show(killedGame[0].ToString());
            updateDisplay();
        }

        private void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            DataSet deletedUser = ClsDataAccess.adminDeleteUser(SelectedUser);
            foreach (DataRow user in deletedUser.Tables[0].Rows)
                MessageBox.Show(user[0].ToString());
        }
    }
}