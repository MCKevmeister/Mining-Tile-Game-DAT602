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
    public partial class frmAdminEditUser : Form
    {
        public frmAdminEditUser()
        {
            InitializeComponent();
        }
        private string _originalUsername;
        private string _newUsername;
        private string _password;
        private string _email;
        private int _userscore;
        private int _loginAttempts;
        private int _isAdmin;
        private int _isLocked;
        public string NewUsername { get => _newUsername; set => _newUsername = value; }
        public string Password { get => _password; set => _password = value; }
        public string Email { get => _email; set => _email = value; }
        public int IsAdmin { get => _isAdmin; set => _isAdmin = value; }
        public int LoginAttempts { get => _loginAttempts; set => _loginAttempts = value; }
        public int IsLocked { get => _isLocked; set => _isLocked = value; }
        public string OriginalUsername { get => _originalUsername; set => _originalUsername = value; }
        public int Userscore { get => _userscore; set => _userscore = value; }

        private void frmEditUser_Load(object sender, EventArgs e)
        {
            DataSet UserDetails = ClsDataAccess.getUserDetails();
            foreach (DataRow userDetail in UserDetails.Tables[0].Rows)
            {
                Console.WriteLine(userDetail[0].ToString());
                Console.WriteLine(userDetail[1].ToString());
                Console.WriteLine(userDetail[2].ToString());
                Console.WriteLine(userDetail[3].ToString());
                Console.WriteLine(userDetail[4].ToString());
                Console.WriteLine(userDetail[5].ToString());
                Console.WriteLine(userDetail[6].ToString());
                OriginalUsername = userDetail[0].ToString();
                txtUsername.Text = userDetail[0].ToString();
                txtEmail.Text = userDetail[1].ToString();
                txtPassword.Text = userDetail[2].ToString();
                txtLoginAttempts.Text = userDetail[3].ToString();
                txtUserScore.Text = userDetail[4].ToString();
                if (Convert.ToInt32(userDetail[5]) == 1)
                {
                    cbLocked.Checked = true;
                }
                else
                {
                    cbLocked.Checked = false;
                }
                if (Convert.ToInt32(userDetail[6]) == 1)
                {
                    cbAdmin.Checked = true;
                    txtLoginAttempts.ReadOnly = false;
                    cbAdmin.Enabled = true;
                    cbLocked.Enabled = true;
                }
                else
                {
                    cbAdmin.Checked = false;
                }
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            frmAdmin admin = new frmAdmin();
            admin.Show();
            Hide();
        }

        private void btnConfirm_Click(object sender, EventArgs e)
        {
            NewUsername = txtUsername.Text;
            Password = txtPassword.Text;
            Email = txtEmail.Text;
            Userscore = Convert.ToInt32(txtUserScore.Text);
            IsAdmin = Convert.ToInt32(cbAdmin.Checked);
            IsLocked = Convert.ToInt32(cbLocked.Checked);

            DataSet adminEditUser = ClsDataAccess.adminEditUser(OriginalUsername, NewUsername, Email, Password, LoginAttempts, Userscore, IsLocked, IsAdmin);
            foreach (DataRow aRow in adminEditUser.Tables[0].Rows)
            {
                MessageBox.Show(aRow["Message"].ToString());
                if (aRow["Message"].ToString() == "The user has been updated")
                {
                    ClsDataAccess.UserName = NewUsername;
                    frmAdmin admin = new frmAdmin();
                    admin.Show();
                    Hide();
                }
            }
        }
    }
}