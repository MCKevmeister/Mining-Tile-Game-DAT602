namespace TileGame
{
    partial class frmGameMenu
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
            this.btnChallangeCharacter = new System.Windows.Forms.Button();
            this.btnChangeCharacter = new System.Windows.Forms.Button();
            this.lblGameMenu = new System.Windows.Forms.Label();
            this.lblChooseOpponent = new System.Windows.Forms.Label();
            this.btnAdmin = new System.Windows.Forms.Button();
            this.btnChat = new System.Windows.Forms.Button();
            this.lblChat = new System.Windows.Forms.Label();
            this.btnRejoinGame = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.lblCurrentCharacter = new System.Windows.Forms.Label();
            this.lblSkills = new System.Windows.Forms.Label();
            this.dudMaps = new System.Windows.Forms.DomainUpDown();
            this.btnEndGame = new System.Windows.Forms.Button();
            this.dgvChooseOpponent = new System.Windows.Forms.DataGridView();
            this.characterName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.characterScoreTotal = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rbLeft = new System.Windows.Forms.RadioButton();
            this.rbUp = new System.Windows.Forms.RadioButton();
            this.rbRight = new System.Windows.Forms.RadioButton();
            this.rbDown = new System.Windows.Forms.RadioButton();
            this.label1 = new System.Windows.Forms.Label();
            this.gbRejoinDirection = new System.Windows.Forms.GroupBox();
            this.lbGamesInProgress = new System.Windows.Forms.ListBox();
            this.lbChat = new System.Windows.Forms.ListBox();
            this.txtChatInput = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.dgvChooseOpponent)).BeginInit();
            this.gbRejoinDirection.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnChallangeCharacter
            // 
            this.btnChallangeCharacter.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnChallangeCharacter.Location = new System.Drawing.Point(366, 244);
            this.btnChallangeCharacter.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnChallangeCharacter.Name = "btnChallangeCharacter";
            this.btnChallangeCharacter.Size = new System.Drawing.Size(200, 39);
            this.btnChallangeCharacter.TabIndex = 0;
            this.btnChallangeCharacter.Text = "Challange Character";
            this.btnChallangeCharacter.UseVisualStyleBackColor = true;
            this.btnChallangeCharacter.Click += new System.EventHandler(this.btnChallangeCharacter_Click);
            // 
            // btnChangeCharacter
            // 
            this.btnChangeCharacter.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnChangeCharacter.Location = new System.Drawing.Point(12, 432);
            this.btnChangeCharacter.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnChangeCharacter.Name = "btnChangeCharacter";
            this.btnChangeCharacter.Size = new System.Drawing.Size(200, 39);
            this.btnChangeCharacter.TabIndex = 1;
            this.btnChangeCharacter.Text = "Change Character";
            this.btnChangeCharacter.UseVisualStyleBackColor = true;
            this.btnChangeCharacter.Click += new System.EventHandler(this.btnChangeCharacter_Click);
            // 
            // lblGameMenu
            // 
            this.lblGameMenu.AutoSize = true;
            this.lblGameMenu.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F);
            this.lblGameMenu.Location = new System.Drawing.Point(398, 14);
            this.lblGameMenu.Name = "lblGameMenu";
            this.lblGameMenu.Size = new System.Drawing.Size(203, 39);
            this.lblGameMenu.TabIndex = 2;
            this.lblGameMenu.Text = "Game Menu";
            // 
            // lblChooseOpponent
            // 
            this.lblChooseOpponent.AutoSize = true;
            this.lblChooseOpponent.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.lblChooseOpponent.Location = new System.Drawing.Point(384, 59);
            this.lblChooseOpponent.Name = "lblChooseOpponent";
            this.lblChooseOpponent.Size = new System.Drawing.Size(173, 25);
            this.lblChooseOpponent.TabIndex = 4;
            this.lblChooseOpponent.Text = "Choose Opponent";
            // 
            // btnAdmin
            // 
            this.btnAdmin.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAdmin.Location = new System.Drawing.Point(12, 476);
            this.btnAdmin.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnAdmin.Name = "btnAdmin";
            this.btnAdmin.Size = new System.Drawing.Size(200, 39);
            this.btnAdmin.TabIndex = 6;
            this.btnAdmin.Text = "Admin";
            this.btnAdmin.UseVisualStyleBackColor = true;
            this.btnAdmin.Click += new System.EventHandler(this.btnAdmin_Click);
            // 
            // btnChat
            // 
            this.btnChat.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.btnChat.Location = new System.Drawing.Point(878, 365);
            this.btnChat.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnChat.Name = "btnChat";
            this.btnChat.Size = new System.Drawing.Size(112, 39);
            this.btnChat.TabIndex = 8;
            this.btnChat.Text = "Chat";
            this.btnChat.UseVisualStyleBackColor = true;
            this.btnChat.Click += new System.EventHandler(this.btnChat_Click);
            // 
            // lblChat
            // 
            this.lblChat.AutoSize = true;
            this.lblChat.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.lblChat.Location = new System.Drawing.Point(777, 45);
            this.lblChat.Name = "lblChat";
            this.lblChat.Size = new System.Drawing.Size(54, 25);
            this.lblChat.TabIndex = 10;
            this.lblChat.Text = "Chat";
            // 
            // btnRejoinGame
            // 
            this.btnRejoinGame.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnRejoinGame.Location = new System.Drawing.Point(305, 458);
            this.btnRejoinGame.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnRejoinGame.Name = "btnRejoinGame";
            this.btnRejoinGame.Size = new System.Drawing.Size(200, 39);
            this.btnRejoinGame.TabIndex = 11;
            this.btnRejoinGame.Text = "Rejoin Game";
            this.btnRejoinGame.UseVisualStyleBackColor = true;
            this.btnRejoinGame.Click += new System.EventHandler(this.btnRejoinGame_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label5.Location = new System.Drawing.Point(372, 310);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(224, 25);
            this.label5.TabIndex = 13;
            this.label5.Text = "Your Games in Progress";
            // 
            // lblCurrentCharacter
            // 
            this.lblCurrentCharacter.AutoSize = true;
            this.lblCurrentCharacter.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.lblCurrentCharacter.Location = new System.Drawing.Point(26, 59);
            this.lblCurrentCharacter.Name = "lblCurrentCharacter";
            this.lblCurrentCharacter.Size = new System.Drawing.Size(168, 25);
            this.lblCurrentCharacter.TabIndex = 14;
            this.lblCurrentCharacter.Text = "Current Character";
            // 
            // lblSkills
            // 
            this.lblSkills.AutoSize = true;
            this.lblSkills.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.lblSkills.Location = new System.Drawing.Point(26, 132);
            this.lblSkills.Name = "lblSkills";
            this.lblSkills.Size = new System.Drawing.Size(58, 25);
            this.lblSkills.TabIndex = 20;
            this.lblSkills.Text = "Skills";
            // 
            // dudMaps
            // 
            this.dudMaps.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.dudMaps.Location = new System.Drawing.Point(327, 209);
            this.dudMaps.Name = "dudMaps";
            this.dudMaps.Size = new System.Drawing.Size(300, 30);
            this.dudMaps.TabIndex = 23;
            this.dudMaps.Text = "Select a Map to Play";
            this.dudMaps.SelectedItemChanged += new System.EventHandler(this.dudMaps_SelectedItemChanged);
            // 
            // btnEndGame
            // 
            this.btnEndGame.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEndGame.Location = new System.Drawing.Point(305, 501);
            this.btnEndGame.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnEndGame.Name = "btnEndGame";
            this.btnEndGame.Size = new System.Drawing.Size(200, 39);
            this.btnEndGame.TabIndex = 11;
            this.btnEndGame.Text = "End Game";
            this.btnEndGame.UseVisualStyleBackColor = true;
            this.btnEndGame.Click += new System.EventHandler(this.btnEndGame_Click_1);
            // 
            // dgvChooseOpponent
            // 
            this.dgvChooseOpponent.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvChooseOpponent.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.characterName,
            this.characterScoreTotal});
            this.dgvChooseOpponent.Location = new System.Drawing.Point(305, 87);
            this.dgvChooseOpponent.Name = "dgvChooseOpponent";
            this.dgvChooseOpponent.RowHeadersVisible = false;
            this.dgvChooseOpponent.RowHeadersWidth = 51;
            this.dgvChooseOpponent.RowTemplate.Height = 24;
            this.dgvChooseOpponent.Size = new System.Drawing.Size(335, 114);
            this.dgvChooseOpponent.TabIndex = 24;
            this.dgvChooseOpponent.SelectionChanged += new System.EventHandler(this.dgvOnlineCharacters_SelectionChanged);
            // 
            // characterName
            // 
            this.characterName.HeaderText = "Character Name";
            this.characterName.MinimumWidth = 6;
            this.characterName.Name = "characterName";
            this.characterName.Width = 150;
            // 
            // characterScoreTotal
            // 
            this.characterScoreTotal.HeaderText = "Score";
            this.characterScoreTotal.MinimumWidth = 6;
            this.characterScoreTotal.Name = "characterScoreTotal";
            this.characterScoreTotal.Width = 75;
            // 
            // rbLeft
            // 
            this.rbLeft.AutoSize = true;
            this.rbLeft.Location = new System.Drawing.Point(15, 29);
            this.rbLeft.Name = "rbLeft";
            this.rbLeft.Size = new System.Drawing.Size(53, 21);
            this.rbLeft.TabIndex = 26;
            this.rbLeft.TabStop = true;
            this.rbLeft.Text = "Left";
            this.rbLeft.UseVisualStyleBackColor = true;
            // 
            // rbUp
            // 
            this.rbUp.AutoSize = true;
            this.rbUp.Location = new System.Drawing.Point(70, 11);
            this.rbUp.Name = "rbUp";
            this.rbUp.Size = new System.Drawing.Size(47, 21);
            this.rbUp.TabIndex = 26;
            this.rbUp.TabStop = true;
            this.rbUp.Text = "Up";
            this.rbUp.UseVisualStyleBackColor = true;
            // 
            // rbRight
            // 
            this.rbRight.AutoSize = true;
            this.rbRight.Location = new System.Drawing.Point(123, 29);
            this.rbRight.Name = "rbRight";
            this.rbRight.Size = new System.Drawing.Size(62, 21);
            this.rbRight.TabIndex = 26;
            this.rbRight.TabStop = true;
            this.rbRight.Text = "Right";
            this.rbRight.UseVisualStyleBackColor = true;
            // 
            // rbDown
            // 
            this.rbDown.AutoSize = true;
            this.rbDown.Location = new System.Drawing.Point(70, 50);
            this.rbDown.Name = "rbDown";
            this.rbDown.Size = new System.Drawing.Size(64, 21);
            this.rbDown.TabIndex = 26;
            this.rbDown.TabStop = true;
            this.rbDown.Text = "Down";
            this.rbDown.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label1.Location = new System.Drawing.Point(511, 437);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(274, 25);
            this.label1.TabIndex = 13;
            this.label1.Text = "Move When re-joining a game";
            // 
            // gbRejoinDirection
            // 
            this.gbRejoinDirection.Controls.Add(this.rbDown);
            this.gbRejoinDirection.Controls.Add(this.rbRight);
            this.gbRejoinDirection.Controls.Add(this.rbUp);
            this.gbRejoinDirection.Controls.Add(this.rbLeft);
            this.gbRejoinDirection.Location = new System.Drawing.Point(546, 465);
            this.gbRejoinDirection.Name = "gbRejoinDirection";
            this.gbRejoinDirection.Size = new System.Drawing.Size(191, 77);
            this.gbRejoinDirection.TabIndex = 27;
            this.gbRejoinDirection.TabStop = false;
            // 
            // lbGamesInProgress
            // 
            this.lbGamesInProgress.FormattingEnabled = true;
            this.lbGamesInProgress.ItemHeight = 16;
            this.lbGamesInProgress.Location = new System.Drawing.Point(305, 349);
            this.lbGamesInProgress.Name = "lbGamesInProgress";
            this.lbGamesInProgress.Size = new System.Drawing.Size(335, 84);
            this.lbGamesInProgress.TabIndex = 28;
            this.lbGamesInProgress.SelectedIndexChanged += new System.EventHandler(this.lbGamesInProgress_SelectedIndexChanged);
            // 
            // lbChat
            // 
            this.lbChat.FormattingEnabled = true;
            this.lbChat.ItemHeight = 16;
            this.lbChat.Location = new System.Drawing.Point(659, 83);
            this.lbChat.Name = "lbChat";
            this.lbChat.Size = new System.Drawing.Size(321, 276);
            this.lbChat.TabIndex = 29;
            // 
            // txtChatInput
            // 
            this.txtChatInput.Font = new System.Drawing.Font("Microsoft Sans Serif", 8F);
            this.txtChatInput.Location = new System.Drawing.Point(659, 365);
            this.txtChatInput.MinimumSize = new System.Drawing.Size(4, 50);
            this.txtChatInput.Name = "txtChatInput";
            this.txtChatInput.Size = new System.Drawing.Size(213, 23);
            this.txtChatInput.TabIndex = 30;
            this.txtChatInput.MouseClick += new System.Windows.Forms.MouseEventHandler(this.txtChatInput_MouseClick);
            // 
            // frmGameMenu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1021, 566);
            this.Controls.Add(this.txtChatInput);
            this.Controls.Add(this.lbChat);
            this.Controls.Add(this.lbGamesInProgress);
            this.Controls.Add(this.gbRejoinDirection);
            this.Controls.Add(this.dgvChooseOpponent);
            this.Controls.Add(this.dudMaps);
            this.Controls.Add(this.lblSkills);
            this.Controls.Add(this.lblCurrentCharacter);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.btnEndGame);
            this.Controls.Add(this.btnRejoinGame);
            this.Controls.Add(this.lblChat);
            this.Controls.Add(this.btnChat);
            this.Controls.Add(this.btnAdmin);
            this.Controls.Add(this.lblChooseOpponent);
            this.Controls.Add(this.lblGameMenu);
            this.Controls.Add(this.btnChangeCharacter);
            this.Controls.Add(this.btnChallangeCharacter);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "frmGameMenu";
            this.Text = "Game Menu";
            this.Load += new System.EventHandler(this.frmGameMenu_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvChooseOpponent)).EndInit();
            this.gbRejoinDirection.ResumeLayout(false);
            this.gbRejoinDirection.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnChallangeCharacter;
        private System.Windows.Forms.Button btnChangeCharacter;
        private System.Windows.Forms.Label lblGameMenu;
        private System.Windows.Forms.Label lblChooseOpponent;
        private System.Windows.Forms.Button btnAdmin;
        private System.Windows.Forms.Button btnChat;
        private System.Windows.Forms.Label lblChat;
        private System.Windows.Forms.Button btnRejoinGame;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label lblCurrentCharacter;
        private System.Windows.Forms.Label lblSkills;
        private System.Windows.Forms.DomainUpDown dudMaps;
        private System.Windows.Forms.Button btnEndGame;
        private System.Windows.Forms.DataGridView dgvChooseOpponent;
        private System.Windows.Forms.DataGridViewTextBoxColumn characterName;
        private System.Windows.Forms.DataGridViewTextBoxColumn characterScoreTotal;
        private System.Windows.Forms.RadioButton rbLeft;
        private System.Windows.Forms.RadioButton rbUp;
        private System.Windows.Forms.RadioButton rbRight;
        private System.Windows.Forms.RadioButton rbDown;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox gbRejoinDirection;
        private System.Windows.Forms.ListBox lbGamesInProgress;
        private System.Windows.Forms.ListBox lbChat;
        private System.Windows.Forms.TextBox txtChatInput;
    }
}