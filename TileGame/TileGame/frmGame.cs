using Google.Protobuf.WellKnownTypes;
using MySql.Data;
using Org.BouncyCastle.Asn1.BC;
using Org.BouncyCastle.Crypto.Agreement.Kdf;
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
    public partial class frmGame : Form
    {
        public frmGame()
        {
            InitializeComponent();
        }
    } //remove
}// remove
//        private void frmGame_Load(object sender, EventArgs e)
//        {
//            putPictureBoxesIntoAnArray();
//            drawCurrentPlayers();
//        }
//        private void btnUp_Click(object sender, EventArgs e)
//        {
//            DataSet moveUp = ClsDataAccess.characterMakesMove("Up");
//            foreach (DataRow aDataRow in moveUp.Tables[0].Rows)
//            {
//                MessageBox.Show(aDataRow[0].ToString());
//            }
//        }

//        private void btnLeft_Click(object sender, EventArgs e)
//        {
//            DataSet moveLeft = ClsDataAccess.characterMakesMove("Left");
//            foreach (DataRow aDataRow in moveLeft.Tables[0].Rows)
//            {
//                MessageBox.Show(aDataRow[0].ToString());
//            }
//        }

//        private void btnDown_Click(object sender, EventArgs e)
//        {
//            DataSet moveDown = ClsDataAccess.characterMakesMove("Down");
//            foreach (DataRow aDataRow in moveDown.Tables[0].Rows)
//            {
//                MessageBox.Show(aDataRow[0].ToString());
//            }
//        }

//        private void btnRight_Click(object sender, EventArgs e)
//        {
//            DataSet moveRight = ClsDataAccess.characterMakesMove("Right");
//            foreach (DataRow aDataRow in moveRight.Tables[0].Rows)
//            {
//                MessageBox.Show(aDataRow[0].ToString());
//            }
//        }
//    }
//    public class PlayerForm
//    {
//        private PictureBox[] lcPictureBoxes = new PictureBox[4, 4];
//        private void putPictureBoxesIntoAnArray()
//        {
//            Control cControl;
//            int row;
//            int col;

//            row = 1;
//            col = 1;
//            foreach (PictureBox tile in lcPictureBoxes)
//            {
//                if (cControl is PictureBox)
//                {
//                    lcPictureBoxes[row, col] = cControl;
//                    col = col + 1;
//                    if (col > 3)
//                    {
//                        col = 1;
//                        row = row + 1;
//                        if (row > 3)
//                            break;
//                    }
//                }
//            }
//        }
//        private void drawPlayers()
//        {
//            DataSet allCharacters = ClsDataAccess.getAllCharactersInMap();
//            foreach (DataRow character in allCharacters.Tables[0].Rows)
//                drawPlayers(character[0].ToString(), Convert.ToInt16(character[1]), Convert.ToInt16(character[2]));
//        }
//        private void drawItems()
//        {
//            DataSet allItems = ClsDataAccess.getAllItemsInMap();
//            foreach (DataRow item in allItems.Tables[0].Rows)
//                drawItem(item[0].ToString(), Convert.ToInt16(item[1]), Convert.ToInt16(item[2]));
//        }

//        private void drawItem(string pName, int pRow, int pCol)
//        {
//            PictureBox item;
//            item = lcPictureBoxes[pRow, pCol];
//            switch (pName)
//                {
//                case "Anvil":
//                    item.Image = Properties.Resources.Anvil;
//                    break;
//                case "Axe":
//                    item.Image = Properties.Resources.Axe;
//                    break;
//                case "":
//                    break;
//            }
//            item.Load();
//        }
//    }
//}
