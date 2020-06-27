namespace TileGame
{
    partial class frmlogin
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblUsername = new System.Windows.Forms.Label();
            this.txtUsername = new System.Windows.Forms.TextBox();
            this.lblGameLogin = new System.Windows.Forms.Label();
            this.btnLogin = new System.Windows.Forms.Button();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.lblPassword = new System.Windows.Forms.Label();
            this.lblNewUserPassword = new System.Windows.Forms.Label();
            this.txtNewUserPassword = new System.Windows.Forms.TextBox();
            this.lblCreateNewUser = new System.Windows.Forms.Label();
            this.lblNewUserEmail = new System.Windows.Forms.Label();
            this.txtNewUserEmail = new System.Windows.Forms.TextBox();
            this.btnCreateAccount = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnTestConnection = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lblUsername
            // 
            this.lblUsername.AutoSize = true;
            this.lblUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblUsername.Location = new System.Drawing.Point(69, 74);
            this.lblUsername.Name = "lblUsername";
            this.lblUsername.Size = new System.Drawing.Size(113, 26);
            this.lblUsername.TabIndex = 0;
            this.lblUsername.Text = "Username";
            // 
            // txtUsername
            // 
            this.txtUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtUsername.Location = new System.Drawing.Point(192, 73);
            this.txtUsername.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtUsername.Name = "txtUsername";
            this.txtUsername.Size = new System.Drawing.Size(341, 30);
            this.txtUsername.TabIndex = 1;
            // 
            // lblGameLogin
            // 
            this.lblGameLogin.AutoSize = true;
            this.lblGameLogin.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblGameLogin.Location = new System.Drawing.Point(193, 7);
            this.lblGameLogin.Name = "lblGameLogin";
            this.lblGameLogin.Size = new System.Drawing.Size(202, 39);
            this.lblGameLogin.TabIndex = 2;
            this.lblGameLogin.Text = "Game Login";
            // 
            // btnLogin
            // 
            this.btnLogin.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnLogin.Location = new System.Drawing.Point(117, 140);
            this.btnLogin.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnLogin.Name = "btnLogin";
            this.btnLogin.Size = new System.Drawing.Size(173, 51);
            this.btnLogin.TabIndex = 3;
            this.btnLogin.Text = "Login";
            this.btnLogin.UseVisualStyleBackColor = true;
            this.btnLogin.Click += new System.EventHandler(this.btnLogin_Click);
            // 
            // txtPassword
            // 
            this.txtPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtPassword.Location = new System.Drawing.Point(192, 106);
            this.txtPassword.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.Size = new System.Drawing.Size(341, 30);
            this.txtPassword.TabIndex = 2;
            this.txtPassword.UseSystemPasswordChar = true;
            // 
            // lblPassword
            // 
            this.lblPassword.AutoSize = true;
            this.lblPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblPassword.Location = new System.Drawing.Point(69, 106);
            this.lblPassword.Name = "lblPassword";
            this.lblPassword.Size = new System.Drawing.Size(108, 26);
            this.lblPassword.TabIndex = 11;
            this.lblPassword.Text = "Password";
            // 
            // lblNewUserPassword
            // 
            this.lblNewUserPassword.AutoSize = true;
            this.lblNewUserPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblNewUserPassword.Location = new System.Drawing.Point(69, 258);
            this.lblNewUserPassword.Name = "lblNewUserPassword";
            this.lblNewUserPassword.Size = new System.Drawing.Size(108, 26);
            this.lblNewUserPassword.TabIndex = 0;
            this.lblNewUserPassword.Text = "Password";
            this.lblNewUserPassword.Visible = false;
            // 
            // txtNewUserPassword
            // 
            this.txtNewUserPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtNewUserPassword.Location = new System.Drawing.Point(192, 258);
            this.txtNewUserPassword.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtNewUserPassword.Name = "txtNewUserPassword";
            this.txtNewUserPassword.Size = new System.Drawing.Size(341, 30);
            this.txtNewUserPassword.TabIndex = 4;
            this.txtNewUserPassword.Visible = false;
            // 
            // lblCreateNewUser
            // 
            this.lblCreateNewUser.AutoSize = true;
            this.lblCreateNewUser.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCreateNewUser.Location = new System.Drawing.Point(162, 204);
            this.lblCreateNewUser.Name = "lblCreateNewUser";
            this.lblCreateNewUser.Size = new System.Drawing.Size(278, 39);
            this.lblCreateNewUser.TabIndex = 0;
            this.lblCreateNewUser.Text = "Create New User";
            this.lblCreateNewUser.Visible = false;
            // 
            // lblNewUserEmail
            // 
            this.lblNewUserEmail.AutoSize = true;
            this.lblNewUserEmail.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblNewUserEmail.Location = new System.Drawing.Point(112, 298);
            this.lblNewUserEmail.Name = "lblNewUserEmail";
            this.lblNewUserEmail.Size = new System.Drawing.Size(68, 26);
            this.lblNewUserEmail.TabIndex = 0;
            this.lblNewUserEmail.Text = "Email";
            this.lblNewUserEmail.Visible = false;
            // 
            // txtNewUserEmail
            // 
            this.txtNewUserEmail.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtNewUserEmail.Location = new System.Drawing.Point(192, 298);
            this.txtNewUserEmail.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtNewUserEmail.Name = "txtNewUserEmail";
            this.txtNewUserEmail.Size = new System.Drawing.Size(341, 30);
            this.txtNewUserEmail.TabIndex = 5;
            this.txtNewUserEmail.Visible = false;
            // 
            // btnCreateAccount
            // 
            this.btnCreateAccount.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnCreateAccount.Location = new System.Drawing.Point(116, 335);
            this.btnCreateAccount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnCreateAccount.Name = "btnCreateAccount";
            this.btnCreateAccount.Size = new System.Drawing.Size(174, 41);
            this.btnCreateAccount.TabIndex = 6;
            this.btnCreateAccount.Text = "Create Account";
            this.btnCreateAccount.UseVisualStyleBackColor = true;
            this.btnCreateAccount.Visible = false;
            this.btnCreateAccount.Click += new System.EventHandler(this.btnCreateAccount_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnCancel.Location = new System.Drawing.Point(324, 335);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(175, 41);
            this.btnCancel.TabIndex = 7;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Visible = false;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnTestConnection
            // 
            this.btnTestConnection.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnTestConnection.Location = new System.Drawing.Point(324, 141);
            this.btnTestConnection.Name = "btnTestConnection";
            this.btnTestConnection.Size = new System.Drawing.Size(175, 50);
            this.btnTestConnection.TabIndex = 12;
            this.btnTestConnection.Text = "Test Connection";
            this.btnTestConnection.UseVisualStyleBackColor = true;
            this.btnTestConnection.Click += new System.EventHandler(this.btnTestConnection_Click);
            // 
            // frmlogin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(588, 387);
            this.Controls.Add(this.btnTestConnection);
            this.Controls.Add(this.txtPassword);
            this.Controls.Add(this.lblPassword);
            this.Controls.Add(this.btnLogin);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnCreateAccount);
            this.Controls.Add(this.txtNewUserEmail);
            this.Controls.Add(this.lblNewUserEmail);
            this.Controls.Add(this.lblCreateNewUser);
            this.Controls.Add(this.txtNewUserPassword);
            this.Controls.Add(this.lblNewUserPassword);
            this.Controls.Add(this.lblGameLogin);
            this.Controls.Add(this.txtUsername);
            this.Controls.Add(this.lblUsername);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "frmlogin";
            this.Text = "Log In";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblUsername;
        private System.Windows.Forms.TextBox txtUsername;
        private System.Windows.Forms.Label lblGameLogin;
        private System.Windows.Forms.Button btnLogin;
        private System.Windows.Forms.TextBox txtPassword;
        private System.Windows.Forms.Label lblPassword;
        private System.Windows.Forms.Label lblNewUserPassword;
        private System.Windows.Forms.TextBox txtNewUserPassword;
        private System.Windows.Forms.Label lblCreateNewUser;
        private System.Windows.Forms.Label lblNewUserEmail;
        private System.Windows.Forms.TextBox txtNewUserEmail;
        private System.Windows.Forms.Button btnCreateAccount;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnTestConnection;
    }
}