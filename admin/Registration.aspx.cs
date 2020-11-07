using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.Data.SqlClient;
using System.Data;
public partial class admin_Default : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    System.Data.SqlClient.SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] == null) 
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
        
        
    }
    protected void RegisterUser(object sender, EventArgs e)
    {
        var q = (from a in dc.Roles
                 where a.RoleName == ddlRole.SelectedValue
                 select a.RoleId).First();
        int userId = 0;
        string constr = System.Configuration.ConfigurationManager.ConnectionStrings["Debis_Pharma_DBConnectionString"].ToString();
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("Insert_User"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Connection = con;
                    con.Open();
                    userId = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                    var us = from a in dc.Users
                             where a.UserId == userId
                             select a;
                    foreach (User u in us)
                    {
                        u.RoleId = q;
                    }
                    try
                    {
                        dc.SubmitChanges();
                    }
                    catch
                    {
                        lblerr.Text = "Error Occured";
                    }
                }
            }
            string message = string.Empty;
            switch (userId)
            {
                case -1:
                    message = "Username already exists.\\nPlease choose a different username.";
                    break;
                case -2:
                    message = "Supplied email address has already been used.";
                    break;
                default:
                    message = "Registration successful. Activation email has been sent.";
                    SendActivationEmail(userId);
                    break;
            }
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + message + "');", true);
        }
    }
        private void SendActivationEmail(int userId)
    {
        string constr = System.Configuration.ConfigurationManager.ConnectionStrings["Debis_Pharma_DBConnectionString"].ToString();
        string activationCode = Guid.NewGuid().ToString();
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO UserActivation VALUES(@UserId, @ActivationCode)"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@ActivationCode", activationCode);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }
        using (MailMessage mm = new MailMessage("debispharma@gmail.com", txtEmail.Text))
        {
            mm.Subject = "Account Activation";
            string body = "Hello " + txtUsername.Text.Trim() + ",";
            body += "<br/>Your Password: "+txtPassword.Text;
            body += "<br /><br />Please click the following link to activate your account";
            body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("Registration.aspx", "../Activation.aspx?ActivationCode=" + activationCode) + "'>Click here to activate your account.</a>";
            body += "<br /><br />Thanks";
            mm.Body = body;
            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            
            NetworkCredential NetworkCred = new NetworkCredential("debispharma@gmail.com", "debispharma22");
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
            
        }
    }
}