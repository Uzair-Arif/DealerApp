using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class startbootstrap_modern_business_1 : System.Web.UI.Page
{
    string roles = string.Empty;
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var s = (from a in dc.Distributors
                     select a.Email).First();
            lblmailAddress.Text = s;
        }
        //Session["AdminUserID"] = null;
        //Session["SaleUserID"] = null;
        //Session["DeliveryUserID"] = null;
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        int userId = 0;

        //string constr = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\Uzair\Documents\Visual Studio 2012\WebSites\DealerApp\App_Data\Debis Pharma DB.mdf;Integrated Security=True;Connect Timeout=30";
        string constr = System.Configuration.ConfigurationManager.ConnectionStrings["Debis_Pharma_DBConnectionString"].ToString();

        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("Validate_User"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", Username.Text);
                cmd.Parameters.AddWithValue("@Password", Password.Text);
                cmd.Connection = con;
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                userId = Convert.ToInt32(reader["UserId"]);
                roles = reader["Roles"].ToString();
                con.Close();
            }
            switch (userId)
            {
                case -1:
                    //lblMessage.Text = "Username and/or password is incorrect.";
                    lblMessage.Text = "Username and/or password is incorrect.";
                    break;
                case -2:
                    //lblMessage.Text = "Account has not been activated.";
                    lblMessage.Text = "Account has not been activated.";
                    string messageAC = "Account has not been activated.";
                        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + messageAC + "');", true);
                    break;
                default:
                    if (roles == "Administrator")
                    {
                        Session["AdminUserID"] = userId;
                        Response.Redirect("~/admin/Dashboard.aspx");
                    }
                    if (roles == "Sales Representative")
                    {
                        Session["SaleUserID"] = userId;
                        Response.Redirect("~/Sale Representatives/OrderBook.aspx");
                    }
                    if (roles == "Delivery Person")
                    {
                        Session["DeliveryUserID"] = userId;
                        Response.Redirect("~/Delivery Person/DeliveryBook.aspx");
                    }
                    break;
            }
        }
    }
}
