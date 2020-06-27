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
    public partial class frmCreateCharacter : Form
    {
        public frmCreateCharacter()
        {
            InitializeComponent();
        }
        private string _CharacterName;

        public string CharacterName { get => _CharacterName; set => _CharacterName = value; }

        private void check(object sender, ItemCheckEventArgs e)
        {
            if (e.NewValue == CheckState.Indeterminate)
                e.NewValue = CheckState.Unchecked;
            if (clbSkills.CheckedItems.Count > 4)
            {
                e.NewValue = CheckState.Unchecked;
                MessageBox.Show("Please only select 4 skills");
            }   
        }

        private void btnConfirm_Click(object sender, EventArgs e)
        {
            string[] Skills = new string[6];
            CharacterName = txtCharacterName.Text;
            int i = 0;
            foreach (Object item in clbSkills.CheckedItems)
            {
                Console.WriteLine(item.ToString());
                Skills[i] += item.ToString(); //https://stackoverflow.com/questions/496896/how-to-delete-an-element-from-an-array-in-c-sharp
                i++;
            }
            if (i > 4)
            {
                MessageBox.Show("Please Only Select 4 Skills");
            }
            else
            { 
                DataSet createCharacter = ClsDataAccess.createCharacter(CharacterName, Skills[0], Skills[1], Skills[2], Skills[3]);
                foreach (DataRow aDataRow in createCharacter.Tables[0].Rows)
                {
                    MessageBox.Show(aDataRow["Message"].ToString());
                    if (aDataRow["Message"].ToString() == CharacterName + " has been created")
                    {
                        frmCharacterSelect CharacterSelect = new frmCharacterSelect();
                        CharacterSelect.Show();
                        Hide();
                    }
                }
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Hide();
            frmCharacterSelect characterSelect = new frmCharacterSelect();
            characterSelect.Show();
        }
    }
 }
