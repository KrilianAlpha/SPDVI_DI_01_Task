namespace DIO1_Tarea
{
    partial class Form1
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
            this.label1 = new System.Windows.Forms.Label();
            this.searchBar = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.categoryBox = new System.Windows.Forms.ComboBox();
            this.subCategoryBox = new System.Windows.Forms.ComboBox();
            this.sizeBox = new System.Windows.Forms.ComboBox();
            this.productlineBox = new System.Windows.Forms.ComboBox();
            this.classBox = new System.Windows.Forms.ComboBox();
            this.styleBox = new System.Windows.Forms.ComboBox();
            this.priceBox = new System.Windows.Forms.ComboBox();
            this.avaibleCheck = new System.Windows.Forms.CheckBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.productList = new System.Windows.Forms.ListBox();
            this.productsTracker = new System.Windows.Forms.Label();
            this.pagesTracker = new System.Windows.Forms.Label();
            this.pagesBox = new System.Windows.Forms.ComboBox();
            this.back = new System.Windows.Forms.Button();
            this.next = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.lenguageBox = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.searchM = new System.Windows.Forms.Button();
            this.searchN = new System.Windows.Forms.Button();
            this.traker = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(11, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Search";
            // 
            // searchBar
            // 
            this.searchBar.Location = new System.Drawing.Point(53, 12);
            this.searchBar.Name = "searchBar";
            this.searchBar.Size = new System.Drawing.Size(335, 20);
            this.searchBar.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(570, 17);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(34, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Filters";
            // 
            // categoryBox
            // 
            this.categoryBox.FormattingEnabled = true;
            this.categoryBox.Items.AddRange(new object[] {
            "-Category-"});
            this.categoryBox.Location = new System.Drawing.Point(570, 44);
            this.categoryBox.Name = "categoryBox";
            this.categoryBox.Size = new System.Drawing.Size(121, 21);
            this.categoryBox.TabIndex = 7;
            this.categoryBox.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // subCategoryBox
            // 
            this.subCategoryBox.FormattingEnabled = true;
            this.subCategoryBox.Items.AddRange(new object[] {
            "-Subcategory-"});
            this.subCategoryBox.Location = new System.Drawing.Point(697, 44);
            this.subCategoryBox.Name = "subCategoryBox";
            this.subCategoryBox.Size = new System.Drawing.Size(72, 21);
            this.subCategoryBox.TabIndex = 8;
            this.subCategoryBox.SelectedIndexChanged += new System.EventHandler(this.comboBox2_SelectedIndexChanged);
            // 
            // sizeBox
            // 
            this.sizeBox.FormattingEnabled = true;
            this.sizeBox.Items.AddRange(new object[] {
            "-Size-"});
            this.sizeBox.Location = new System.Drawing.Point(570, 73);
            this.sizeBox.Name = "sizeBox";
            this.sizeBox.Size = new System.Drawing.Size(121, 21);
            this.sizeBox.TabIndex = 9;
            this.sizeBox.SelectedIndexChanged += new System.EventHandler(this.comboBox3_SelectedIndexChanged);
            // 
            // productlineBox
            // 
            this.productlineBox.FormattingEnabled = true;
            this.productlineBox.Items.AddRange(new object[] {
            "-Product Line-"});
            this.productlineBox.Location = new System.Drawing.Point(570, 100);
            this.productlineBox.Name = "productlineBox";
            this.productlineBox.Size = new System.Drawing.Size(121, 21);
            this.productlineBox.TabIndex = 10;
            this.productlineBox.SelectedIndexChanged += new System.EventHandler(this.comboBox4_SelectedIndexChanged);
            // 
            // classBox
            // 
            this.classBox.FormattingEnabled = true;
            this.classBox.Items.AddRange(new object[] {
            "-Class-"});
            this.classBox.Location = new System.Drawing.Point(697, 100);
            this.classBox.Name = "classBox";
            this.classBox.Size = new System.Drawing.Size(72, 21);
            this.classBox.TabIndex = 11;
            this.classBox.SelectedIndexChanged += new System.EventHandler(this.comboBox5_SelectedIndexChanged);
            // 
            // styleBox
            // 
            this.styleBox.FormattingEnabled = true;
            this.styleBox.Items.AddRange(new object[] {
            "-Style-"});
            this.styleBox.Location = new System.Drawing.Point(775, 100);
            this.styleBox.Name = "styleBox";
            this.styleBox.Size = new System.Drawing.Size(68, 21);
            this.styleBox.TabIndex = 12;
            this.styleBox.SelectedIndexChanged += new System.EventHandler(this.comboBox6_SelectedIndexChanged);
            // 
            // priceBox
            // 
            this.priceBox.FormattingEnabled = true;
            this.priceBox.Items.AddRange(new object[] {
            "-List Price-"});
            this.priceBox.Location = new System.Drawing.Point(570, 127);
            this.priceBox.Name = "priceBox";
            this.priceBox.Size = new System.Drawing.Size(121, 21);
            this.priceBox.TabIndex = 13;
            this.priceBox.SelectedIndexChanged += new System.EventHandler(this.comboBox7_SelectedIndexChanged);
            // 
            // avaibleCheck
            // 
            this.avaibleCheck.AutoSize = true;
            this.avaibleCheck.Location = new System.Drawing.Point(570, 154);
            this.avaibleCheck.Name = "avaibleCheck";
            this.avaibleCheck.Size = new System.Drawing.Size(115, 17);
            this.avaibleCheck.TabIndex = 14;
            this.avaibleCheck.Text = "Show Only Avaible";
            this.avaibleCheck.UseVisualStyleBackColor = true;
            this.avaibleCheck.CheckedChanged += new System.EventHandler(this.checkBox1_CheckedChanged);
            // 
            // pictureBox1
            // 
            this.pictureBox1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.pictureBox1.Image = global::DIO1_Tarea.Properties.Resources.lOGO;
            this.pictureBox1.Location = new System.Drawing.Point(592, 190);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(249, 207);
            this.pictureBox1.TabIndex = 16;
            this.pictureBox1.TabStop = false;
            // 
            // productList
            // 
            this.productList.FormattingEnabled = true;
            this.productList.Location = new System.Drawing.Point(14, 44);
            this.productList.Name = "productList";
            this.productList.Size = new System.Drawing.Size(550, 290);
            this.productList.TabIndex = 17;
            this.productList.DoubleClick += new System.EventHandler(this.listBox1_DoubleClick);
            // 
            // productsTracker
            // 
            this.productsTracker.AutoSize = true;
            this.productsTracker.Location = new System.Drawing.Point(476, 341);
            this.productsTracker.Name = "productsTracker";
            this.productsTracker.Size = new System.Drawing.Size(91, 13);
            this.productsTracker.TabIndex = 18;
            this.productsTracker.Text = "ProductsFound: 0";
            // 
            // pagesTracker
            // 
            this.pagesTracker.AutoSize = true;
            this.pagesTracker.Location = new System.Drawing.Point(394, 341);
            this.pagesTracker.Name = "pagesTracker";
            this.pagesTracker.Size = new System.Drawing.Size(46, 13);
            this.pagesTracker.TabIndex = 19;
            this.pagesTracker.Text = "0 Pages";
            // 
            // pagesBox
            // 
            this.pagesBox.FormattingEnabled = true;
            this.pagesBox.Items.AddRange(new object[] {
            "10",
            "20",
            "50"});
            this.pagesBox.Location = new System.Drawing.Point(421, 376);
            this.pagesBox.Name = "pagesBox";
            this.pagesBox.Size = new System.Drawing.Size(96, 21);
            this.pagesBox.TabIndex = 20;
            this.pagesBox.SelectedIndexChanged += new System.EventHandler(this.comboBox8_SelectedIndexChanged);
            // 
            // back
            // 
            this.back.Location = new System.Drawing.Point(190, 341);
            this.back.Name = "back";
            this.back.Size = new System.Drawing.Size(75, 40);
            this.back.TabIndex = 21;
            this.back.Text = "<";
            this.back.UseVisualStyleBackColor = true;
            this.back.Click += new System.EventHandler(this.button1_Click);
            // 
            // next
            // 
            this.next.Location = new System.Drawing.Point(271, 341);
            this.next.Name = "next";
            this.next.Size = new System.Drawing.Size(75, 40);
            this.next.TabIndex = 22;
            this.next.Text = ">";
            this.next.UseVisualStyleBackColor = true;
            this.next.Click += new System.EventHandler(this.button2_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(418, 360);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(99, 13);
            this.label5.TabIndex = 23;
            this.label5.Text = "Products Per Page:";
            // 
            // lenguageBox
            // 
            this.lenguageBox.FormattingEnabled = true;
            this.lenguageBox.Items.AddRange(new object[] {
            "en",
            "fr"});
            this.lenguageBox.Location = new System.Drawing.Point(17, 360);
            this.lenguageBox.Name = "lenguageBox";
            this.lenguageBox.Size = new System.Drawing.Size(53, 21);
            this.lenguageBox.TabIndex = 24;
            this.lenguageBox.SelectedIndexChanged += new System.EventHandler(this.comboBox9_SelectedIndexChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(15, 341);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(55, 13);
            this.label6.TabIndex = 25;
            this.label6.Text = "Lenguage";
            // 
            // searchM
            // 
            this.searchM.Location = new System.Drawing.Point(482, 12);
            this.searchM.Name = "searchM";
            this.searchM.Size = new System.Drawing.Size(82, 20);
            this.searchM.TabIndex = 26;
            this.searchM.Text = "ProductModel";
            this.searchM.UseVisualStyleBackColor = true;
            this.searchM.Click += new System.EventHandler(this.button4_Click);
            // 
            // searchN
            // 
            this.searchN.Location = new System.Drawing.Point(394, 12);
            this.searchN.Name = "searchN";
            this.searchN.Size = new System.Drawing.Size(82, 20);
            this.searchN.TabIndex = 27;
            this.searchN.Text = "Name";
            this.searchN.UseVisualStyleBackColor = true;
            this.searchN.Click += new System.EventHandler(this.button3_Click);
            // 
            // traker
            // 
            this.traker.AutoSize = true;
            this.traker.Location = new System.Drawing.Point(697, 294);
            this.traker.Name = "traker";
            this.traker.Size = new System.Drawing.Size(38, 13);
            this.traker.TabIndex = 28;
            this.traker.Text = "nofilter";
            this.traker.Visible = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(853, 409);
            this.Controls.Add(this.traker);
            this.Controls.Add(this.searchN);
            this.Controls.Add(this.searchM);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.lenguageBox);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.next);
            this.Controls.Add(this.back);
            this.Controls.Add(this.pagesBox);
            this.Controls.Add(this.pagesTracker);
            this.Controls.Add(this.productsTracker);
            this.Controls.Add(this.productList);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.avaibleCheck);
            this.Controls.Add(this.priceBox);
            this.Controls.Add(this.styleBox);
            this.Controls.Add(this.classBox);
            this.Controls.Add(this.productlineBox);
            this.Controls.Add(this.sizeBox);
            this.Controls.Add(this.subCategoryBox);
            this.Controls.Add(this.categoryBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.searchBar);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox searchBar;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox categoryBox;
        private System.Windows.Forms.ComboBox subCategoryBox;
        private System.Windows.Forms.ComboBox sizeBox;
        private System.Windows.Forms.ComboBox productlineBox;
        private System.Windows.Forms.ComboBox classBox;
        private System.Windows.Forms.ComboBox styleBox;
        private System.Windows.Forms.ComboBox priceBox;
        private System.Windows.Forms.CheckBox avaibleCheck;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.ListBox productList;
        private System.Windows.Forms.Label productsTracker;
        private System.Windows.Forms.Label pagesTracker;
        private System.Windows.Forms.ComboBox pagesBox;
        private System.Windows.Forms.Button back;
        private System.Windows.Forms.Button next;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox lenguageBox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button searchM;
        private System.Windows.Forms.Button searchN;
        private System.Windows.Forms.Label traker;
    }
}

