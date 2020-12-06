using Dapper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DIO1_Tarea
{
    public partial class Dialog : Form
    {
        string sql;
        int c = 0;
        public Dialog(string name, string description, string lenguage)
        {
            InitializeComponent();
            if (name.Contains("'"))
            {
                name = name.Replace("'", "''");
            }
            sql = "exec dbo.getProductDialog '"+ lenguage +"', '"+ name +"'";
        }

        private void Dialog_Load(object sender, EventArgs e)
        {
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectiongString);
            List<Product> product = new List<Product>();
            product = connection.Query<Product>(sql).ToList();

            model.Text = product[0].ProductModel;
            description.Text = product[0].Description;
            name.Text = product[0].Name;
            number.Text = product[0].ProductNumber;
            colorP.Text = product[0].Color;
            price.Text = product[0].ListPrice.ToString();
            size.Text = product[0].Size;
            productLine.Text = product[0].ProductLine;
            classe.Text = product[0].Classe;
            styleP.Text = product[0].Style;
            category.Text = product[0].ProductCategory;
            subCategory.Text = product[0].ProductSubcategory;
            
            model.Enabled = false;
            description.Enabled = false;
            name.Enabled = false;
            number.Enabled = false;
            colorP.Enabled = false;
            price.Enabled = false;
            size.Enabled = false;
            productLine.Enabled = false;
            classe.Enabled = false;
            styleP.Enabled = false;
            category.Enabled = false;
            subCategory.Enabled = false;
            update.Enabled = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if(c == 0)
            {
                c = 1;
                number.Enabled = true;
                colorP.Enabled = true;
                price.Enabled = true;
                size.Enabled = true;
                productLine.Enabled = true;
                classe.Enabled = true;
                styleP.Enabled = true;
                edit.Text = "Cancel Edit";
                update.Enabled = true;
            } else {
                c = 0;
                model.Enabled = false;
                description.Enabled = false;
                name.Enabled = false;
                number.Enabled = false;
                colorP.Enabled = false;
                price.Enabled = false;
                size.Enabled = false;
                productLine.Enabled = false;
                classe.Enabled = false;
                styleP.Enabled = false;
                category.Enabled = false;
                subCategory.Enabled = false;
                edit.Text = "Edit";
                update.Enabled = false;
            }
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectiongString);

            sql = "exec dbo.updateProduct '" + name.Text + "', '" + number.Text + "', '" + colorP.Text + "', " + price.Text + ", '" + size.Text + "', '" + productLine.Text + "', '" + classe.Text + "', '" + styleP.Text + "'";
            connection.Execute(sql);
        }
    }
}
