namespace TileGame
{
    partial class frmAdminEditUser
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
            this.cbLocked = new System.Windows.Forms.CheckBox();
            this.cbAdmin = new System.Windows.Forms.CheckBox();
            this.txtUserScore = new System.Windows.Forms.TextBox();
            this.txtLoginAttempts = new System.Windows.Forms.TextBox();
            this.txtEmail = new System.Windows.Forms.TextBox();
            this.lblPassword = new System.Windows.Forms.Label();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnConfirm = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.lblLoginAttempts = new System.Windows.Forms.Label();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.lblEmail = new System.Windows.Forms.Label();
            this.txtUsername = new System.Windows.Forms.TextBox();
            this.lblUsername = new System.Windows.Forms.Label();
            this.lblEditUserAccount = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // cbLocked
            // 
            this.cbLocked.AutoSize = true;
            this.cbLocked.Enabled = false;
            this.cbLocked.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.cbLocked.Location = new System.Drawing.Point(397, 234);
            this.cbLocked.Name = "cbLocked";
            this.cbLocked.Size = new System.Drawing.Size(104, 30);
            this.cbLocked.TabIndex = 36;
            this.cbLocked.Text = "Locked";
            this.cbLocked.UseVisualStyleBackColor = true;
            // 
            // cbAdmin
            // 
            this.cbAdmin.AutoSize = true;
            this.cbAdmin.Enabled = false;
            this.cbAdmin.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.cbAdmin.Location = new System.Drawing.Point(397, 198);
            this.cbAdmin.Name = "cbAdmin";
            this.cbAdmin.Size = new System.Drawing.Size(97, 30);
            this.cbAdmin.TabIndex = 37;
            this.cbAdmin.Text = "Admin";
            this.cbAdmin.UseVisualStyleBackColor = true;
            // 
            // txtUserScore
            // 
            this.txtUserScore.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtUserScore.Location = new System.Drawing.Point(274, 236);
            this.txtUserScore.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtUserScore.Name = "txtUserScore";
            this.txtUserScore.ReadOnly = true;
            this.txtUserScore.Size = new System.Drawing.Size(83, 30);
            this.txtUserScore.TabIndex = 32;
            // 
            // txtLoginAttempts
            // 
            this.txtLoginAttempts.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtLoginAttempts.Location = new System.Drawing.Point(274, 198);
            this.txtLoginAttempts.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtLoginAttempts.Name = "txtLoginAttempts";
            this.txtLoginAttempts.ReadOnly = true;
            this.txtLoginAttempts.Size = new System.Drawing.Size(83, 30);
            this.txtLoginAttempts.TabIndex = 33;
            // 
            // txtEmail
            // 
            this.txtEmail.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtEmail.Location = new System.Drawing.Point(163, 154);
            this.txtEmail.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtEmail.Name = "txtEmail";
            this.txtEmail.Size = new System.Drawing.Size(341, 30);
            this.txtEmail.TabIndex = 34;
            // 
            // lblPassword
            // 
            this.lblPassword.AutoSize = true;
            this.lblPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblPassword.Location = new System.Drawing.Point(41, 121);
            this.lblPassword.Name = "lblPassword";
            this.lblPassword.Size = new System.Drawing.Size(108, 26);
            this.lblPassword.TabIndex = 31;
            this.lblPassword.Text = "Password";
            // 
            // btnCancel
            // 
            this.btnCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnCancel.Location = new System.Drawing.Point(297, 281);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(174, 30);
            this.btnCancel.TabIndex = 30;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            // 
            // btnConfirm
            // 
            this.btnConfirm.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnConfirm.Location = new System.Drawing.Point(88, 281);
            this.btnConfirm.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnConfirm.Name = "btnConfirm";
            this.btnConfirm.Size = new System.Drawing.Size(174, 30);
            this.btnConfirm.TabIndex = 29;
            this.btnConfirm.Text = "Confirm";
            this.btnConfirm.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.label1.Location = new System.Drawing.Point(147, 238);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(121, 26);
            this.label1.TabIndex = 25;
            this.label1.Text = "User Score";
            // 
            // lblLoginAttempts
            // 
            this.lblLoginAttempts.AutoSize = true;
            this.lblLoginAttempts.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblLoginAttempts.Location = new System.Drawing.Point(110, 200);
            this.lblLoginAttempts.Name = "lblLoginAttempts";
            this.lblLoginAttempts.Size = new System.Drawing.Size(158, 26);
            this.lblLoginAttempts.TabIndex = 26;
            this.lblLoginAttempts.Text = "Login Attempts";
            // 
            // txtPassword
            // 
            this.txtPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtPassword.Location = new System.Drawing.Point(163, 121);
            this.txtPassword.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.Size = new System.Drawing.Size(341, 30);
            this.txtPassword.TabIndex = 28;
            // 
            // lblEmail
            // 
            this.lblEmail.AutoSize = true;
            this.lblEmail.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblEmail.Location = new System.Drawing.Point(83, 154);
            this.lblEmail.Name = "lblEmail";
            this.lblEmail.Size = new System.Drawing.Size(68, 26);
            this.lblEmail.TabIndex = 27;
            this.lblEmail.Text = "Email";
            // 
            // txtUsername
            // 
            this.txtUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtUsername.Location = new System.Drawing.Point(163, 87);
            this.txtUsername.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtUsername.Name = "txtUsername";
            this.txtUsername.Size = new System.Drawing.Size(341, 30);
            this.txtUsername.TabIndex = 24;
            // 
            // lblUsername
            // 
            this.lblUsername.AutoSize = true;
            this.lblUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F);
            this.lblUsername.Location = new System.Drawing.Point(41, 88);
            this.lblUsername.Name = "lblUsername";
            this.lblUsername.Size = new System.Drawing.Size(113, 26);
            this.lblUsername.TabIndex = 23;
            this.lblUsername.Text = "Username";
            // 
            // lblEditUserAccount
            // 
            this.lblEditUserAccount.AutoSize = true;
            this.lblEditUserAccount.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblEditUserAccount.Location = new System.Drawing.Point(89, 25);
            this.lblEditUserAccount.Name = "lblEditUserAccount";
            this.lblEditUserAccount.Size = new System.Drawing.Size(415, 39);
            this.lblEditUserAccount.TabIndex = 35;
            this.lblEditUserAccount.Text = "Admin - Edit User Account";
            // 
            // frmAdminEditUser
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(590, 355);
            this.Controls.Add(this.cbLocked);
            this.Controls.Add(this.cbAdmin);
            this.Controls.Add(this.lblEditUserAccount);
            this.Controls.Add(this.txtUserScore);
            this.Controls.Add(this.txtLoginAttempts);
            this.Controls.Add(this.txtEmail);
            this.Controls.Add(this.lblPassword);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnConfirm);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.lblLoginAttempts);
            this.Controls.Add(this.txtPassword);
            this.Controls.Add(this.lblEmail);
            this.Controls.Add(this.txtUsername);
            this.Controls.Add(this.lblUsername);
            this.Name = "frmAdminEditUser";
            this.Text = "frmAdminEditUser";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.CheckBox cbLocked;
        private System.Windows.Forms.CheckBox cbAdmin;
        private System.Windows.Forms.TextBox txtUserScore;
        private System.Windows.Forms.TextBox txtLoginAttempts;
        private System.Windows.Forms.TextBox txtEmail;
        private System.Windows.Forms.Label lblPassword;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnConfirm;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblLoginAttempts;
        private System.Windows.Forms.TextBox txtPassword;
        private System.Windows.Forms.Label lblEmail;
        private System.Windows.Forms.TextBox txtUsername;
        private System.Windows.Forms.Label lblUsername;
        private System.Windows.Forms.Label lblEditUserAccount;
    }
}