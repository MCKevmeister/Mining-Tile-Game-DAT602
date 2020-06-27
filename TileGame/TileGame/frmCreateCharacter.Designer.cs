namespace TileGame
{
    partial class frmCreateCharacter
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
            this.lblCharacterCreation = new System.Windows.Forms.Label();
            this.txtCharacterName = new System.Windows.Forms.TextBox();
            this.lblCharacterName = new System.Windows.Forms.Label();
            this.btnConfirm = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.lblSkills = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.clbSkills = new System.Windows.Forms.CheckedListBox();
            this.SuspendLayout();
            // 
            // lblCharacterCreation
            // 
            this.lblCharacterCreation.AutoSize = true;
            this.lblCharacterCreation.Font = new System.Drawing.Font("Microsoft Sans Serif", 20F);
            this.lblCharacterCreation.Location = new System.Drawing.Point(212, 7);
            this.lblCharacterCreation.Name = "lblCharacterCreation";
            this.lblCharacterCreation.Size = new System.Drawing.Size(282, 39);
            this.lblCharacterCreation.TabIndex = 0;
            this.lblCharacterCreation.Text = "Character Builder";
            // 
            // txtCharacterName
            // 
            this.txtCharacterName.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.txtCharacterName.Location = new System.Drawing.Point(260, 62);
            this.txtCharacterName.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.txtCharacterName.Multiline = true;
            this.txtCharacterName.Name = "txtCharacterName";
            this.txtCharacterName.Size = new System.Drawing.Size(396, 32);
            this.txtCharacterName.TabIndex = 1;
            // 
            // lblCharacterName
            // 
            this.lblCharacterName.AutoSize = true;
            this.lblCharacterName.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.lblCharacterName.Location = new System.Drawing.Point(54, 65);
            this.lblCharacterName.Name = "lblCharacterName";
            this.lblCharacterName.Size = new System.Drawing.Size(155, 25);
            this.lblCharacterName.TabIndex = 2;
            this.lblCharacterName.Text = "Character Name";
            // 
            // btnConfirm
            // 
            this.btnConfirm.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnConfirm.Location = new System.Drawing.Point(391, 219);
            this.btnConfirm.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnConfirm.Name = "btnConfirm";
            this.btnConfirm.Size = new System.Drawing.Size(184, 35);
            this.btnConfirm.TabIndex = 10;
            this.btnConfirm.Text = "Confirm";
            this.btnConfirm.UseVisualStyleBackColor = true;
            this.btnConfirm.Click += new System.EventHandler(this.btnConfirm_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancel.Location = new System.Drawing.Point(391, 271);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(184, 35);
            this.btnCancel.TabIndex = 11;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // lblSkills
            // 
            this.lblSkills.AutoSize = true;
            this.lblSkills.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F);
            this.lblSkills.Location = new System.Drawing.Point(64, 121);
            this.lblSkills.Name = "lblSkills";
            this.lblSkills.Size = new System.Drawing.Size(173, 29);
            this.lblSkills.TabIndex = 12;
            this.lblSkills.Text = "Select 4 Skills";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.label4.Location = new System.Drawing.Point(405, 138);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(133, 25);
            this.label4.TabIndex = 13;
            this.label4.Text = "Choose Color";
            this.label4.Visible = false;
            // 
            // listBox1
            // 
            this.listBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.listBox1.FormattingEnabled = true;
            this.listBox1.ItemHeight = 25;
            this.listBox1.Items.AddRange(new object[] {
            "Red",
            "Orange",
            "Yellow",
            "Green",
            "Blue",
            "Indigo",
            "Violet"});
            this.listBox1.Location = new System.Drawing.Point(410, 165);
            this.listBox1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(121, 29);
            this.listBox1.TabIndex = 14;
            this.listBox1.Visible = false;
            // 
            // clbSkills
            // 
            this.clbSkills.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F);
            this.clbSkills.FormattingEnabled = true;
            this.clbSkills.Items.AddRange(new object[] {
            "Miner",
            "Gatherer",
            "Fisher",
            "Woodcutter",
            "Archer",
            "Smith"});
            this.clbSkills.Location = new System.Drawing.Point(27, 153);
            this.clbSkills.Name = "clbSkills";
            this.clbSkills.Size = new System.Drawing.Size(266, 179);
            this.clbSkills.TabIndex = 16;
            // 
            // frmCreateCharacter
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(681, 358);
            this.Controls.Add(this.clbSkills);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.lblSkills);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnConfirm);
            this.Controls.Add(this.lblCharacterName);
            this.Controls.Add(this.txtCharacterName);
            this.Controls.Add(this.lblCharacterCreation);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "frmCreateCharacter";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblCharacterCreation;
        private System.Windows.Forms.Label lblCharacterName;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Label lblSkills;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ListBox listBox1;
        public System.Windows.Forms.CheckedListBox clbSkills;
        public System.Windows.Forms.TextBox txtCharacterName;
        public System.Windows.Forms.Button btnConfirm;
    }
}