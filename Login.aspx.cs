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
public partial class Login : System.Web.UI.Page
{
    string roles = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (this.Page.User.Identity.IsAuthenticated)
        //{
        //    FormsAuthentication.SignOut();
        //    Response.Redirect("~/Login.aspx");
        //}
    }
    //protected void ValidateUser(object sender, EventArgs e)
    //{
    //    int userId = 0;
        
    //    string constr = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\Uzair\Documents\Visual Studio 2012\WebSites\DealerApp\App_Data\Debis Pharma DB.mdf;Integrated Security=True;Connect Timeout=30";
    //    using (SqlConnection con = new SqlConnection(constr))
    //    {
    //        using (SqlCommand cmd = new SqlCommand("Validate_User"))
    //        {
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@Username", Login1.UserName);
    //            cmd.Parameters.AddWithValue("@Password", Login1.Password);
    //            cmd.Connection = con;
    //            con.Open();
    //            SqlDataReader reader = cmd.ExecuteReader();
    //            reader.Read();
    //            userId = Convert.ToInt32(reader["UserId"]);
    //            roles = reader["Roles"].ToString();
    //            con.Close();
    //        }
    //        switch (userId)
    //        {
    //            case -1:
    //                Login1.FailureText = "Username and/or password is incorrect.";
    //                break;
    //            case -2:
    //                Login1.FailureText = "Account has not been activated.";
    //                break;
    //            default:
    //                //FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, Login1.UserName, DateTime.Now, DateTime.Now.AddMinutes(2880), Login1.RememberMeSet, roles, FormsAuthentication.FormsCookiePath);
    //                //string hash = FormsAuthentication.Encrypt(ticket);
    //                //HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hash);

    //                //if (ticket.IsPersistent)
    //                //{
    //                //    cookie.Expires = ticket.Expiration;
    //                //}
    //                //Response.Cookies.Add(cookie);
    //                //Response.Redirect(FormsAuthentication.GetRedirectUrl(Login1.UserName, Login1.RememberMeSet));
                    
    //                if (roles == "Administrator")
    //                {
    //                    Session["AdminUserID"] = userId;
    //                    Response.Redirect("~/sb-admin/Medicines.aspx");
    //                }
    //                if (roles == "Sales Representative")
    //                {
    //                    Session["SaleUserID"] = userId;
    //                    Response.Redirect("~/Sale Representatives/OrderBook.aspx");
    //                }
    //                break;
    //        }
    //        //if (roles == "Administrator")
    //        //{
    //        //    Response.Redirect("~/sb-admin/Medicines.aspx");
    //        //}
    //    }
    //}


    //protected void Login1_LoggedIn(object sender, EventArgs e)
    //{
    //    //if (roles == "Administrator")
    //    //{
    //    //    Response.Redirect("~/sb-admin/Medicines.aspx");
    //    //}
    //}
    //protected void Login1_LoggingIn(object sender, LoginCancelEventArgs e)
    //{
    //    if (roles == "Administrator")
    //    {
    //        Response.Redirect("~/sb-admin/Medicines.aspx");
    //    }
    //}
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
                        lblMessage.Text = "Username and/or password is incorrect.";
                        break;
                    case -2:
                        lblMessage.Text = "Account has not been activated.";
                        break;
                    default:
                        if (roles == "Administrator")
                        {
                            Session["AdminUserID"] = userId;
                            Response.Redirect("~/admin/Medicines.aspx");
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