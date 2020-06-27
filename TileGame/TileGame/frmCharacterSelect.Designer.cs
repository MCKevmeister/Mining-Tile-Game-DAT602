namespace TileGame
{
    partial class frmCharacterSelect
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
            this.btnDeleteCharacter = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.btnPlayCharacter = new System.Windows.Forms.Button();
            this.btnNewCharacter = new System.Windows.Forms.Button();
            this.lblCurrentUser = new System.Windows.Forms.Label();
            this.btnEditUser = new System.Windows.Forms.Button();
            this.btnDeleteUser = new System.Windows.Forms.Button();
            this.lblSelectedCharacter = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.lbCharacters = new System.Windows.Forms.ListBox();
            this.lblSkills = new System.Windows.Forms.Label();
            this.btnLogout = new System.Windows.Forms.Button();
            this.btnAdminMenu = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnDeleteCharacter
            // 
            this.btnDeleteCharacter.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnDeleteCharacter.Location = new System.Drawing.Point(25, 449);
            this.btnDeleteCharacter.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnDeleteCharacter.Name = "btnDeleteCharacter";
            this.btnDeleteCharacter.Size = new System.Drawing.Size(191, 38);
            this.btnDeleteCharacter.TabIndex = 1;
            this.btnDeleteCharacter.Text = "Delete Character";
            this.btnDeleteCharacter.UseVisualStyleBackColor = true;
            this.btnDeleteCharacter.Click += new System.EventHandler(this.btnDeleteCharacter_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F);
            this.label1.Location = new System.Drawing.Point(224, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(316, 39);
            this.label1.TabIndex = 2;
            this.label1.Text = "Character Selection";
            // 
            // btnPlayCharacter
            // 
            this.btnPlayCharacter.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnPlayCharacter.Location = new System.Drawing.Point(25, 492);
            this.btnPlayCharacter.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnPlayCharacter.Name = "btnPlayCharacter";
            this.btnPlayCharacter.Size = new System.Drawing.Size(191, 38);
            this.btnPlayCharacter.TabIndex = 14;
            this.btnPlayCharacter.Text = "Play Character";
            this.btnPlayCharacter.UseVisualStyleBackColor = true;
            this.btnPlayCharacter.Click += new System.EventHandler(this.btnPlayCharacter_Click);
            // 
            // btnNewCharacter
            // 
            this.btnNewCharacter.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnNewCharacter.Location = new System.Drawing.Point(25, 407);
            this.btnNewCharacter.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnNewCharacter.Name = "btnNewCharacter";
            this.btnNewCharacter.Size = new System.Drawing.Size(191, 38);
            this.btnNewCharacter.TabIndex = 15;
            this.btnNewCharacter.Text = "New Character";
            this.btnNewCharacter.UseVisualStyleBackColor = true;
            this.btnNewCharacter.Click += new System.EventHandler(this.btnNewCharacter_Click);
            // 
            // lblCurrentUser
            // 
            this.lblCurrentUser.AutoSize = true;
            this.lblCurrentUser.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCurrentUser.Location = new System.Drawing.Point(44, 67);
            this.lblCurrentUser.Name = "lblCurrentUser";
            this.lblCurrentUser.Size = new System.Drawing.Size(161, 29);
            this.lblCurrentUser.TabIndex = 16;
            this.lblCurrentUser.Text = "Current User: ";
            // 
            // btnEditUser
            // 
            this.btnEditUser.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnEditUser.Location = new System.Drawing.Point(25, 151);
            this.btnEditUser.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnEditUser.Name = "btnEditUser";
            this.btnEditUser.Size = new System.Drawing.Size(191, 38);
            this.btnEditUser.TabIndex = 17;
            this.btnEditUser.Text = "Edit User";
            this.btnEditUser.UseVisualStyleBackColor = true;
            this.btnEditUser.Click += new System.EventHandler(this.btnEditUser_Click);
            // 
            // btnDeleteUser
            // 
            this.btnDeleteUser.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnDeleteUser.Location = new System.Drawing.Point(25, 194);
            this.btnDeleteUser.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnDeleteUser.Name = "btnDeleteUser";
            this.btnDeleteUser.Size = new System.Drawing.Size(191, 38);
            this.btnDeleteUser.TabIndex = 18;
            this.btnDeleteUser.Text = "Delete User";
            this.btnDeleteUser.UseVisualStyleBackColor = true;
            this.btnDeleteUser.Click += new System.EventHandler(this.btnDeleteUser_Click);
            // 
            // lblSelectedCharacter
            // 
            this.lblSelectedCharacter.AutoSize = true;
            this.lblSelectedCharacter.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSelectedCharacter.Location = new System.Drawing.Point(20, 324);
            this.lblSelectedCharacter.Name = "lblSelectedCharacter";
            this.lblSelectedCharacter.Size = new System.Drawing.Size(225, 29);
            this.lblSelectedCharacter.TabIndex = 19;
            this.lblSelectedCharacter.Text = "Selected Character:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label2.Location = new System.Drawing.Point(480, 71);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(108, 25);
            this.label2.TabIndex = 3;
            this.label2.Text = "Characters";
            // 
            // lbCharacters
            // 
            this.lbCharacters.FormattingEnabled = true;
            this.lbCharacters.ItemHeight = 16;
            this.lbCharacters.Location = new System.Drawing.Point(315, 99);
            this.lbCharacters.Name = "lbCharacters";
            this.lbCharacters.Size = new System.Drawing.Size(458, 164);
            this.lbCharacters.TabIndex = 22;
            this.lbCharacters.SelectedIndexChanged += new System.EventHandler(this.lbCharacters_SelectedIndexChanged);
            // 
            // lblSkills
            // 
            this.lblSkills.AutoSize = true;
            this.lblSkills.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.lblSkills.Location = new System.Drawing.Point(503, 276);
            this.lblSkills.Name = "lblSkills";
            this.lblSkills.Size = new System.Drawing.Size(64, 25);
            this.lblSkills.TabIndex = 23;
            this.lblSkills.Text = "Skills:";
            // 
            // btnLogout
            // 
            this.btnLogout.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnLogout.Location = new System.Drawing.Point(25, 236);
            this.btnLogout.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnLogout.Name = "btnLogout";
            this.btnLogout.Size = new System.Drawing.Size(191, 38);
            this.btnLogout.TabIndex = 14;
            this.btnLogout.Text = "Log out";
            this.btnLogout.UseVisualStyleBackColor = true;
            this.btnLogout.Click += new System.EventHandler(this.btnLogout_Click);
            // 
            // btnAdminMenu
            // 
            this.btnAdminMenu.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnAdminMenu.Location = new System.Drawing.Point(25, 279);
            this.btnAdminMenu.Name = "btnAdminMenu";
            this.btnAdminMenu.Size = new System.Drawing.Size(191, 38);
            this.btnAdminMenu.TabIndex = 24;
            this.btnAdminMenu.Text = "Admin Menu";
            this.btnAdminMenu.UseVisualStyleBackColor = true;
            this.btnAdminMenu.Click += new System.EventHandler(this.btnAdminMenu_Click);
            // 
            // frmCharacterSelect
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(826, 554);
            this.Controls.Add(this.btnAdminMenu);
            this.Controls.Add(this.lblSkills);
            this.Controls.Add(this.lbCharacters);
            this.Controls.Add(this.lblSelectedCharacter);
            this.Controls.Add(this.btnDeleteUser);
            this.Controls.Add(this.btnEditUser);
            this.Controls.Add(this.lblCurrentUser);
            this.Controls.Add(this.btnNewCharacter);
            this.Controls.Add(this.btnLogout);
            this.Controls.Add(this.btnPlayCharacter);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnDeleteCharacter);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "frmCharacterSelect";
            this.Text = "Character Select";
            this.Load += new System.EventHandler(this.CharacterSelect_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button btnDeleteCharacter;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnPlayCharacter;
        private System.Windows.Forms.Button btnNewCharacter;
        private System.Windows.Forms.Label lblCurrentUser;
        private System.Windows.Forms.Button btnEditUser;
        private System.Windows.Forms.Button btnDeleteUser;
        private System.Windows.Forms.Label lblSelectedCharacter;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ListBox lbCharacters;
        private System.Windows.Forms.Label lblSkills;
        private System.Windows.Forms.Button btnLogout;
        private System.Windows.Forms.Button btnAdminMenu;
    }
}