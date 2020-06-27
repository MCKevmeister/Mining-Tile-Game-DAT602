using System;
using System.Data;
using System.Windows.Forms;

namespace TileGame
{
    public partial class frmlogin : Form
    {
        public frmlogin()
        {
            InitializeComponent();
        }
        private string _Username;
        private string _Password;
        private string _Email;

        public string Username { get => _Username; set => _Username = value; }
        public string Password { get => _Password; set => _Password = value; }
        public string Email { get => _Email; set => _Email = value; }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            Console.WriteLine(txtUsername.Text);
            Console.WriteLine(txtPassword.Text);
            Username = txtUsername.Text;
            Password = txtPassword.Text;    
            DataSet UserLogin = ClsDataAccess.userLogin(Username, Password);
            foreach (DataRow aRow in UserLogin.Tables[0].Rows)
            {
                string response = aRow["Message"].ToString();
                if (response == Username + " is now Online") // sucess login message
                {
                    ClsDataAccess.UserName = Username; // set username inside data access class
                    MessageBox.Show(aRow["Message"].ToString());
                    frmCharacterSelect CharacterSelect = new frmCharacterSelect();
                    CharacterSelect.Show();
                    Hide();
                }
                else if(aRow["Message"].ToString() == "Username doesn't exist") // player doesn't exist in database
                {
                    DialogResult result = MessageBox.Show("Would you like to make a new Character?", "Username doesn't exit", MessageBoxButtons.YesNo);
                    if (result == DialogResult.Yes)
                    {
                        lblCreateNewUser.Show();
                        lblNewUserEmail.Show();
                        lblNewUserPassword.Show();
                        txtNewUserEmail.Show();
                        txtNewUserPassword.Show();
                        btnCreateAccount.Show();
                        btnCreateAccount.Show();
                        btnCancel.Show();
                    }            
                }
                else
                {
                    MessageBox.Show(aRow["Message"].ToString());
                }
            }
        }
        private void btnCreateAccount_Click(object sender, EventArgs e)
        {
            Email = txtNewUserEmail.Text;
            Password = txtNewUserPassword.Text;
            Username = txtUsername.Text;
            screenReset();
            DataSet RegisterUser = ClsDataAccess.registerUser(Username, Email, Password);
            foreach (DataRow RegisterUserRow in RegisterUser.Tables[0].Rows)
            {
                MessageBox.Show(RegisterUserRow["Message"].ToString());
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            screenReset();
        }

        private void btnTestConnection_Click(object sender, EventArgs e)
        {
            MessageBox.Show(ClsDataAccess.testConnection());
            
        }
        private void screenReset()
        {
            lblCreateNewUser.Hide();
            lblNewUserEmail.Hide();
            lblNewUserPassword.Hide();
            txtNewUserEmail.Clear();
            txtNewUserEmail.Hide();
            txtNewUserPassword.Clear();
            txtNewUserPassword.Hide();
            btnCreateAccount.Hide();
            btnCancel.Hide();
        }
    }
}
