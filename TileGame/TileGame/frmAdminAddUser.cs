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
    public partial class frmAdminAddUser : Form
    {
        public frmAdminAddUser()
        {
            InitializeComponent();
        }

        private void btnCreateAccount_Click(object sender, EventArgs e)
        {
            DataSet addedUser = ClsDataAccess.adminAddUser(txtUsername.Text, txtEmail.Text, txtPassword.Text, cbAdmin.Checked);
            foreach (DataRow aDataRow in addedUser.Tables[0].Rows)
            {
               MessageBox.Show(aDataRow.ToString());
                if (aDataRow.ToString() == txtUsername.Text + " has been registered")
                {
                    frmAdmin admin = new frmAdmin();
                    admin.Show();
                    Hide();
                }
            }
        }
        private void btnCancel_Click(object sender, EventArgs e)
        {
            frmAdmin admin = new frmAdmin();
            admin.Show();
            Hide();
        }
    }
}
