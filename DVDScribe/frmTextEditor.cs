﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace DVDScribe
{
    public partial class frmTextEditor : Form
    {
        public frmTextEditor()
        {
            InitializeComponent();
        }

        private void btnSelectFont_Click(object sender, EventArgs e)
        {
            if (dlgFont.ShowDialog() == DialogResult.OK)
            {
                txtText.Font = dlgFont.Font;
            }
        }

        private void frmTextEditor_Load(object sender, EventArgs e)
        {

        }
    }
}