using Dapper;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DIO1_Tarea
{
    public partial class Form1 : Form
    {
        int productsPerPage;
        int numberOfPages;
        int currentPage;
        private List<Product> products;
        string sql = "";
        string selldate = "no";

        public Form1()
        {
            InitializeComponent();
            subCategoryBox.Enabled = false;
            pagesBox.SelectedIndex = 1;
            lenguageBox.SelectedIndex = 0;
            categoryBox.SelectedIndex = 0;
            subCategoryBox.SelectedIndex = 0;
            sizeBox.SelectedIndex = 0;
            productlineBox.SelectedIndex = 0;
            classBox.SelectedIndex = 0;
            styleBox.SelectedIndex = 0;
            priceBox.SelectedIndex = 0;
            classBox.Enabled = false;
            styleBox.Enabled = false;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectiongString);
            sql = "exec dbo.getCategory";
            List<string> categories = new List<string>();
            categories = connection.Query<string>(sql).ToList();
            foreach (var category in categories)
            {
                categoryBox.Items.Add(category);
            }
            sql = "exec dbo.getSize";
            List<string> sizes = new List<string>();
            sizes = connection.Query<string>(sql).ToList();
            foreach (var size in sizes)
            {
                sizeBox.Items.Add(size);
            }
            sql = "exec dbo.getProductLine";
            List<string> productL = new List<string>();
            productL = connection.Query<string>(sql).ToList();
            foreach (var pl in productL)
            {
                productlineBox.Items.Add(pl);    
            }
            sql = "exec dbo.getListPrice";
            List<string> listprice = new List<string>();
            listprice = connection.Query<string>(sql).ToList();
            foreach (var price in listprice)
            {
                priceBox.Items.Add(price);
            }
            connection.Close();
            currentPage = 0;
            back.Enabled = false;
            next.Enabled = true;
            UpdateProductFilmsView();
        }

        private void CheckButton()
        {
            if (numberOfPages == 1)
            {
                next.Enabled = false;
            } else
            {
                next.Enabled = true;
            }
        }

        private void SearchModelFilter()
        {
            traker.Text = "searchM";
            productList.Items.Clear();
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;

            SqlConnection connection = new SqlConnection(connectiongString);
            sql = "exec dbo.getProduct_SearchProductModel '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + searchBar.Text + "%'";
            products = new List<Product>();
            products = connection.Query<Product>(sql).ToList();
            foreach (Product product in products)
            {
                productList.Items.Add($"{product.Name}: {product.Description}");
            }
            sql = "exec dbo.getProduct_SearchProductModelPages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + searchBar.Text + "%'";
            products = new List<Product>();
            products = connection.Query<Product>(sql).ToList();
            int totalProductPage = products.Count;
            productsTracker.Text = totalProductPage + " Products Found";
            numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            CheckButton();
        }

        private void SearchNameFilter()
        {
            traker.Text = "searchN";
            productList.Items.Clear();
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;

            SqlConnection connection = new SqlConnection(connectiongString);
            sql = "exec dbo.getProduct_SearchName '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + searchBar.Text + "%'";
            products = new List<Product>();
            products = connection.Query<Product>(sql).ToList();
            foreach (Product product in products)
            {
                productList.Items.Add($"{product.Name}: {product.Description}");
            }
            sql = "exec dbo.getProduct_SearchNamePages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + searchBar.Text + "%'";
            products = new List<Product>();
            products = connection.Query<Product>(sql).ToList();
            int totalProductPage = products.Count;
            productsTracker.Text = totalProductPage + " Products Found";
            numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            CheckButton();
        }

        private void ListPriceFilter()
        {
            traker.Text = "listprice";
            categoryBox.Enabled = false;
            productlineBox.Enabled = false;
            sizeBox.Enabled = false;
            productList.Items.Clear();
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;

            SqlConnection connection = new SqlConnection(connectiongString);
            string opcion = priceBox.Text;
            products = new List<Product>();
            if (opcion == "-List Price-")
            {
                categoryBox.Enabled = true;
                productlineBox.Enabled = true;
                sizeBox.Enabled = true;
                UpdateProductFilmsView();
            }
            else
            {
                sql = "exec dbo.getProduct_filterListPrice '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + opcion + "'";
                products = connection.Query<Product>(sql).ToList();
                foreach (var product in products)
                {
                    productList.Items.Add($"{product.Name}: {product.Description}");
                }
                sql = "exec dbo.getProduct_filterListPricePages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + opcion + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                int totalProductPage = products.Count;
                productsTracker.Text = totalProductPage + " Products Found";
                numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            }
            CheckButton();
        }

        private void StyleFilter()
        {
            traker.Text = "style";
            classBox.Enabled = false;
            productList.Items.Clear();
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;

            SqlConnection connection = new SqlConnection(connectiongString);
            string opcion = productlineBox.Text;
            string opcion2 = styleBox.Text;
            products = new List<Product>();
            if (opcion2 == "-Style-")
            {
                classBox.Enabled = true;
                sql = "exec dbo.getProduct_filterProductLine '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + opcion + "'";
                products = connection.Query<Product>(sql).ToList();
                sql = "exec dbo.getProduct_filterProductLinePages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + opcion + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                int totalProductPage = products.Count;
                productsTracker.Text = totalProductPage + " Products Found";
                numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";

            }
            else
            {
                sql = "exec dbo.getProduct_filterStyle '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + opcion + "', '" + opcion2 + "'";
                products = connection.Query<Product>(sql).ToList();
                sql = "exec dbo.getProduct_filterStylePages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + opcion + "', '" + opcion2 + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                int totalProductPage = products.Count;
                productsTracker.Text = totalProductPage + " Products Found";
                numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";

            }
            foreach (var product in products)
            {
                productList.Items.Add($"{product.Name}: {product.Description}");
            }
            CheckButton();
        }

        private void ClassFilter()
        {
            traker.Text = "class";
            styleBox.Enabled = false;
            productList.Items.Clear();
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;

            SqlConnection connection = new SqlConnection(connectiongString);
            string opcion = productlineBox.Text;
            string opcion2 = classBox.Text;
            products = new List<Product>();
            if (opcion2 == "-Class-")
            {
                styleBox.Enabled = true;
                sql = "exec dbo.getProduct_filterProductLine '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + opcion + "'";
                products = connection.Query<Product>(sql).ToList();
                sql = "exec dbo.getProduct_filterProductLinePages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + opcion + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                int totalProductPage = products.Count;
                productsTracker.Text = totalProductPage + " Products Found";
                numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            }
            else
            {
                sql = "exec dbo.getProduct_filterClass '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + opcion + "', '" + opcion2 + "'";
                products = connection.Query<Product>(sql).ToList();
                sql = "exec dbo.getProduct_filterClassPages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + opcion + "', '" + opcion2 + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                int totalProductPage = products.Count;
                productsTracker.Text = totalProductPage + " Products Found";
                numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            }
            foreach (var product in products)
            {
                productList.Items.Add($"{product.Name}: {product.Description}");
            }
            CheckButton();
        }

        private void ProductLineFilter()
        {
            traker.Text = "productline";
            classBox.Enabled = true;
            styleBox.Enabled = true;
            categoryBox.Enabled = false;
            sizeBox.Enabled = false;
            priceBox.Enabled = false;
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectiongString);
            string opcion = productlineBox.Text;
            productList.Items.Clear();
            sql = "exec dbo.getProduct_filterProductLine '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + opcion + "'";
            products = new List<Product>();
            products = connection.Query<Product>(sql).ToList();
            if (opcion == "-Product Line-")
            {
                classBox.Enabled = false;
                styleBox.Enabled = false;
                categoryBox.Enabled = true;
                sizeBox.Enabled = true;
                priceBox.Enabled = true;
                UpdateProductFilmsView();
            }
            else
            {
                foreach (var product in products)
                {
                    productList.Items.Add($"{product.Name}: {product.Description}");
                    sql = "exec dbo.getProduct_filterProductLinePages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + opcion + "'";
                    products = new List<Product>();
                    products = connection.Query<Product>(sql).ToList();
                    int totalProductPage = products.Count;
                    productsTracker.Text = totalProductPage + " Products Found";
                    numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
                }
                classBox.Items.Clear();
                sql = "exec dbo.getClass '" + opcion + "'";
                List<string> classes = new List<string>();
                classes = connection.Query<string>(sql).ToList();
                foreach (var classe in classes)
                {
                    classBox.Items.Add(classe);
                }
                classBox.Items.Add("-Class-");
                styleBox.Items.Clear();
                sql = "exec dbo.getStyle '" + opcion + "'";
                List<string> styles = new List<string>();
                styles = connection.Query<string>(sql).ToList();
                foreach (var style in styles)
                {
                    styleBox.Items.Add(style);
                }
                styleBox.Items.Add("-Style-");
            }
            CheckButton();
        }

        private void SizeFilter()
        {
            traker.Text = "size";
            categoryBox.Enabled = false;
            productlineBox.Enabled = false;
            priceBox.Enabled = false;
            productList.Items.Clear();
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;

            SqlConnection connection = new SqlConnection(connectiongString);
            string opcion = sizeBox.Text;
            products = new List<Product>();
            if (opcion == "-Size-")
            {
                categoryBox.Enabled = true;
                productlineBox.Enabled = true;
                priceBox.Enabled = true;
                UpdateProductFilmsView();
            }
            else
            {
                sql = "exec dbo.getProduct_filterSize '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + opcion + "'";
                products = connection.Query<Product>(sql).ToList();
                foreach (var product in products)
                {
                    productList.Items.Add($"{product.Name}: {product.Description}");
                }
                sql = "exec dbo.getProduct_filterSizePages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + opcion + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                int totalProductPage = products.Count;
                productsTracker.Text = totalProductPage + " Products Found";
                numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            }
            CheckButton();
        }

        private void SubCategoryFilter()
        {
            traker.Text = "subcategory";
            productList.Items.Clear();
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;

            SqlConnection connection = new SqlConnection(connectiongString);
            products = new List<Product>();
            sql = "exec dbo.getProduct_filterSubCategory '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ", '" + categoryBox.SelectedItem.ToString() + "', '" + subCategoryBox.SelectedItem.ToString() + "'";
            products = connection.Query<Product>(sql).ToList();
            foreach (var product in products)
            {
                productList.Items.Add($"{product.Name}: {product.Description}");
                sql = "exec dbo.getProduct_filterSubCategoryPages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + categoryBox.SelectedItem.ToString() + "', '" + subCategoryBox.SelectedItem.ToString() + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                int totalProductPage = products.Count;
                productsTracker.Text = totalProductPage + " Products Found";
                numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            }
            CheckButton();
        }

        private void CategoryFilter()
        {
            traker.Text = "category";
            subCategoryBox.Enabled = true;
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectiongString);
            string opcion = categoryBox.Text;
            sizeBox.Enabled = false;
            productlineBox.Enabled = false;
            priceBox.Enabled = false;
            productList.Items.Clear();
            if (opcion == "-Category-")
            {
                sizeBox.Enabled = true;
                productlineBox.Enabled = true;
                priceBox.Enabled = true;
                subCategoryBox.Enabled = false;
                UpdateProductFilmsView();
            }
            else
            {
                sql = "exec dbo.getProducts_filterCategory '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", " + productsPerPage + ",'" + categoryBox.SelectedItem.ToString() + "'";
                products = new List<Product>();
                products = connection.Query<Product>(sql).ToList();
                foreach (var product in products)
                {
                    productList.Items.Add($"{product.Name}: {product.Description}");
                    sql = "exec dbo.getProducts_filterCategoryPages '" + lenguageBox.SelectedItem.ToString() + "', '" + selldate + "', '" + categoryBox.SelectedItem.ToString() + "'";
                    products = new List<Product>();
                    products = connection.Query<Product>(sql).ToList();
                    int totalProductPage = products.Count;
                    productsTracker.Text = totalProductPage + " Products Found";
                    numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
                    connection.Close();
                }
                subCategoryBox.Items.Clear();
                sql = "exec dbo.getSubCategory '" + categoryBox.SelectedItem.ToString() + "'";
                List<string> subcategorys = new List<string>();
                subcategorys = connection.Query<string>(sql).ToList();
                foreach (var subcategory in subcategorys)
                {
                    subCategoryBox.Items.Add(subcategory);
                }
            }
            CheckButton();
        }

        private void UpdateProductFilmsView()
        {
            traker.Text = "nofilter";
            productList.Items.Clear();
            productsPerPage = int.Parse(pagesBox.Text);
            string connectiongString = ConfigurationManager.ConnectionStrings["AdventureWorks"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectiongString);
            string sql = "exec dbo.getProducts '" + lenguageBox.Text + "', '" + selldate + "', " + (currentPage * productsPerPage) + ", "+ productsPerPage + "";
            products = new List<Product>();
            products = connection.Query<Product>(sql).ToList();
            foreach (Product product in products)
            {
                productList.Items.Add($"{product.Name}: {product.Description}");
            }
            sql = "exec dbo.getProductPages '" + lenguageBox.Text + "', '" + selldate + "'";
            products = connection.Query<Product>(sql).ToList();
            int totalProductPage = products.Count;
            productsTracker.Text = totalProductPage + " Products Found";
            numberOfPages = totalProductPage / int.Parse(pagesBox.Text) + 1; pagesTracker.Text = (currentPage + 1) + " of " + numberOfPages + " pages";
            CheckButton();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            CategoryFilter();
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            SubCategoryFilter();
        }

        private void comboBox4_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProductLineFilter();   
        }

        private void comboBox5_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClassFilter();
        }

        private void comboBox6_SelectedIndexChanged(object sender, EventArgs e)
        {
            StyleFilter();
        }

        private void comboBox3_SelectedIndexChanged(object sender, EventArgs e)
        {
            SizeFilter();
        }

        private void comboBox7_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListPriceFilter();
        }
        private void comboBox9_SelectedIndexChanged(object sender, EventArgs e)
        {
            string opcion = traker.Text;
            switch (opcion)
            {
                case "nofilter":
                    UpdateProductFilmsView();
                    break;
                case "category":
                    CategoryFilter();
                    break;
                case "subcategory":
                    SubCategoryFilter();
                    break;
                case "size":
                    SizeFilter();
                    break;
                case "productline":
                    ProductLineFilter();
                    break;
                case "class":
                    ClassFilter();
                    break;
                case "style":
                    StyleFilter();
                    break;
                case "listprice":
                    ListPriceFilter();
                    break;
                case "searchN":
                    SearchNameFilter();
                    break;
                case "searchM":
                    SearchModelFilter();
                    break;
            }
        }

        private void listBox1_DoubleClick(object sender, EventArgs e)
        {
            string text = productList.SelectedItem.ToString();
            string[] identifier = text.Split(':');
            string name = identifier[0];
            string description = identifier[1];
            string lenguage = lenguageBox.Text;
            Dialog dialog = new Dialog(name, description, lenguage);
            dialog.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            SearchNameFilter();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            SearchModelFilter();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (avaibleCheck.Checked == true)
            {
                selldate = "yes";
            }
            else {
                selldate = "no";
            }
            string opcion = traker.Text;
            switch (opcion)
            {
                case "nofilter":
                    UpdateProductFilmsView();
                    break;
                case "category":
                    CategoryFilter();
                    break;
                case "subcategory":
                    SubCategoryFilter();
                    break;
                case "size":
                    SizeFilter();
                    break;
                case "productline":
                    ProductLineFilter();
                    break;
                case "class":
                    ClassFilter();
                    break;
                case "style":
                    StyleFilter();
                    break;
                case "listprice":
                    ListPriceFilter();
                    break;
                case "searchN":
                    SearchNameFilter();
                    break;
                case "searchM":
                    SearchModelFilter();
                    break;
            }
        }
        private void comboBox8_SelectedIndexChanged(object sender, EventArgs e)
        {
            productsPerPage = int.Parse(pagesBox.Text);
            string opcion = traker.Text;
            switch (opcion)
            {
                case "nofilter":
                    UpdateProductFilmsView();
                    break;
                case "category":
                    CategoryFilter();
                    break;
                case "subcategory":
                    SubCategoryFilter();
                    break;
                case "size":
                    SizeFilter();
                    break;
                case "productline":
                    ProductLineFilter();
                    break;
                case "class":
                    ClassFilter();
                    break;
                case "style":
                    StyleFilter();
                    break;
                case "listprice":
                    ListPriceFilter();
                    break;
                case "searchN":
                    SearchNameFilter();
                    break;
                case "searchM":
                    SearchModelFilter();
                    break;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            currentPage++;
            if (currentPage == numberOfPages - 1)
            {
                next.Enabled = false;
            }
            back.Enabled = true;
            string opcion = traker.Text;
            switch(opcion)
            {
                case "nofilter":
                    UpdateProductFilmsView();
                    break;
                case "category":
                    CategoryFilter();
                    break;
                case "subcategory":
                    SubCategoryFilter();
                    break;
                case "size":
                    SizeFilter();
                    break;
                case "productline":
                    ProductLineFilter();
                    break;
                case "class":
                    ClassFilter();
                    break;
                case "style":
                    StyleFilter();
                    break;
                case "listprice":
                    ListPriceFilter();
                    break;
                case "searchN":
                    SearchNameFilter();
                    break;
                case "searchM":
                    SearchModelFilter();
                    break;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            currentPage--;
            if(currentPage == 0)
            {
                back.Enabled = false;
            }
            next.Enabled = true;
            string opcion = traker.Text;
            switch (opcion)
            {
                case "nofilter":
                    UpdateProductFilmsView();
                    break;
                case "category":
                    CategoryFilter();
                    break;
                case "subcategory":
                    SubCategoryFilter();
                    break;
                case "size":
                    SizeFilter();
                    break;
                case "productline":
                    ProductLineFilter();
                    break;
                case "class":
                    ClassFilter();
                    break;
                case "style":
                    StyleFilter();
                    break;
                case "listprice":
                    ListPriceFilter();
                    break;
                case "searchN":
                    SearchNameFilter();
                    break;
                case "searchM":
                    SearchModelFilter();
                    break;
            }
        }
    }
}