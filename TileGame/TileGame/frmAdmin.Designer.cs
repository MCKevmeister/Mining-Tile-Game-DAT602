namespace TileGame
{
    partial class frmAdmin
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
            this.btnKillGame = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.txtChat = new System.Windows.Forms.TextBox();
            this.btnChat = new System.Windows.Forms.Button();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.btnEditAccount = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.btnAddAccount = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.btnUnlockUser = new System.Windows.Forms.Button();
            this.btnDeleteAccount = new System.Windows.Forms.Button();
            this.lbAllUsers = new System.Windows.Forms.ListBox();
            this.lbLockedUsers = new System.Windows.Forms.ListBox();
            this.lbActiveGames = new System.Windows.Forms.ListBox();
            this.SuspendLayout();
            // 
            // btnKillGame
            // 
            this.btnKillGame.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnKillGame.Location = new System.Drawing.Point(419, 285);
            this.btnKillGame.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnKillGame.Name = "btnKillGame";
            this.btnKillGame.Size = new System.Drawing.Size(172, 28);
            this.btnKillGame.TabIndex = 23;
            this.btnKillGame.Text = "Kill Game";
            this.btnKillGame.UseVisualStyleBackColor = true;
            this.btnKillGame.Click += new System.EventHandler(this.btnKillGame_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label4.Location = new System.Drawing.Point(769, 9);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(54, 25);
            this.label4.TabIndex = 27;
            this.label4.Text = "Chat";
            // 
            // txtChat
            // 
            this.txtChat.Font = new System.Drawing.Font("Microsoft Sans Serif", 8F);
            this.txtChat.Location = new System.Drawing.Point(650, 314);
            this.txtChat.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtChat.Multiline = true;
            this.txtChat.Name = "txtChat";
            this.txtChat.Size = new System.Drawing.Size(205, 29);
            this.txtChat.TabIndex = 26;
            this.txtChat.Text = "Type Message to Chat\r\n";
            // 
            // btnChat
            // 
            this.btnChat.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnChat.Location = new System.Drawing.Point(860, 314);
            this.btnChat.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnChat.Name = "btnChat";
            this.btnChat.Size = new System.Drawing.Size(92, 28);
            this.btnChat.TabIndex = 25;
            this.btnChat.Text = "Chat";
            this.btnChat.UseVisualStyleBackColor = true;
            // 
            // textBox2
            // 
            this.textBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8F);
            this.textBox2.Location = new System.Drawing.Point(650, 35);
            this.textBox2.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.textBox2.Multiline = true;
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(303, 275);
            this.textBox2.TabIndex = 24;
            this.textBox2.Text = "Michael: Hello\r\nJane: Hi Michael\r\nMark: Hey Jane, do you want to play a game?\r\nJa" +
    "ne: Sure\r\nMark: Lets Go!";
            // 
            // btnEditAccount
            // 
            this.btnEditAccount.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnEditAccount.Location = new System.Drawing.Point(39, 328);
            this.btnEditAccount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnEditAccount.Name = "btnEditAccount";
            this.btnEditAccount.Size = new System.Drawing.Size(171, 28);
            this.btnEditAccount.TabIndex = 32;
            this.btnEditAccount.Text = "Edit Account";
            this.btnEditAccount.UseVisualStyleBackColor = true;
            this.btnEditAccount.Click += new System.EventHandler(this.btnEditAccount_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label1.Location = new System.Drawing.Point(437, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(134, 25);
            this.label1.TabIndex = 34;
            this.label1.Text = "Active Games";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label3.Location = new System.Drawing.Point(44, 8);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(140, 25);
            this.label3.TabIndex = 36;
            this.label3.Text = "User Accounts";
            // 
            // btnAddAccount
            // 
            this.btnAddAccount.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnAddAccount.Location = new System.Drawing.Point(39, 285);
            this.btnAddAccount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnAddAccount.Name = "btnAddAccount";
            this.btnAddAccount.Size = new System.Drawing.Size(171, 28);
            this.btnAddAccount.TabIndex = 37;
            this.btnAddAccount.Text = "Add Account";
            this.btnAddAccount.UseVisualStyleBackColor = true;
            this.btnAddAccount.Click += new System.EventHandler(this.btnAddAccount_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label5.Location = new System.Drawing.Point(225, 8);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(163, 25);
            this.label5.TabIndex = 40;
            this.label5.Text = "Locked Accounts";
            // 
            // btnUnlockUser
            // 
            this.btnUnlockUser.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnUnlockUser.Location = new System.Drawing.Point(230, 285);
            this.btnUnlockUser.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnUnlockUser.Name = "btnUnlockUser";
            this.btnUnlockUser.Size = new System.Drawing.Size(169, 28);
            this.btnUnlockUser.TabIndex = 41;
            this.btnUnlockUser.Text = "Unlock Account";
            this.btnUnlockUser.UseVisualStyleBackColor = true;
            this.btnUnlockUser.Click += new System.EventHandler(this.btnUnlockUser_Click);
            // 
            // btnDeleteAccount
            // 
            this.btnDeleteAccount.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnDeleteAccount.Location = new System.Drawing.Point(39, 371);
            this.btnDeleteAccount.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnDeleteAccount.Name = "btnDeleteAccount";
            this.btnDeleteAccount.Size = new System.Drawing.Size(171, 28);
            this.btnDeleteAccount.TabIndex = 37;
            this.btnDeleteAccount.Text = "Delete Account";
            this.btnDeleteAccount.UseVisualStyleBackColor = true;
            this.btnDeleteAccount.Click += new System.EventHandler(this.btnDeleteAccount_Click);
            // 
            // lbAllUsers
            // 
            this.lbAllUsers.FormattingEnabled = true;
            this.lbAllUsers.ItemHeight = 16;
            this.lbAllUsers.Location = new System.Drawing.Point(39, 36);
            this.lbAllUsers.Name = "lbAllUsers";
            this.lbAllUsers.Size = new System.Drawing.Size(169, 244);
            this.lbAllUsers.TabIndex = 42;
            this.lbAllUsers.SelectedIndexChanged += new System.EventHandler(this.lbAllUsers_SelectedIndexChanged);
            // 
            // lbLockedUsers
            // 
            this.lbLockedUsers.FormattingEnabled = true;
            this.lbLockedUsers.ItemHeight = 16;
            this.lbLockedUsers.Location = new System.Drawing.Point(230, 36);
            this.lbLockedUsers.Name = "lbLockedUsers";
            this.lbLockedUsers.Size = new System.Drawing.Size(169, 244);
            this.lbLockedUsers.TabIndex = 42;
            this.lbLockedUsers.SelectedIndexChanged += new System.EventHandler(this.lbLockedUsers_SelectedIndexChanged);
            // 
            // lbActiveGames
            // 
            this.lbActiveGames.FormattingEnabled = true;
            this.lbActiveGames.ItemHeight = 16;
            this.lbActiveGames.Location = new System.Drawing.Point(419, 35);
            this.lbActiveGames.Name = "lbActiveGames";
            this.lbActiveGames.Size = new System.Drawing.Size(169, 244);
            this.lbActiveGames.TabIndex = 42;
            this.lbActiveGames.SelectedIndexChanged += new System.EventHandler(this.lbActiveGames_SelectedIndexChanged);
            // 
            // frmAdmin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(986, 420);
            this.Controls.Add(this.lbActiveGames);
            this.Controls.Add(this.lbLockedUsers);
            this.Controls.Add(this.lbAllUsers);
            this.Controls.Add(this.btnUnlockUser);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.btnDeleteAccount);
            this.Controls.Add(this.btnAddAccount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnEditAccount);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtChat);
            this.Controls.Add(this.btnChat);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.btnKillGame);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "frmAdmin";
            this.Text = "Admin Menu";
            this.Load += new System.EventHandler(this.frmAdmin_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnKillGame;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtChat;
        private System.Windows.Forms.Button btnChat;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Button btnEditAccount;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button btnAddAccount;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button btnUnlockUser;
        private System.Windows.Forms.Button btnDeleteAccount;
        private System.Windows.Forms.ListBox lbAllUsers;
        private System.Windows.Forms.ListBox lbLockedUsers;
        private System.Windows.Forms.ListBox lbActiveGames;
    }
}