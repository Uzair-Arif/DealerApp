using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Default : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] == null)
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            var s = (from a in dc.Users
                     where a.UserId == Convert.ToInt32(Session["AdminUserID"])
                     select a.Password).First();
            if (s == txtCurrentPassword.Text)
            {
                var p = from a in dc.Users
                        where a.UserId == Convert.ToInt32(Session["AdminUserID"])
                        select a;
                foreach (User u in p)
                {
                    u.Password = txtNewPassword.Text;
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
            else
            {
                lblInCorrectPassword.Text = "Incorrect Password";
            }
        }
        if (Session["SaleUserID"] != null)
        {
            var s = (from a in dc.Users
                     where a.UserId == Convert.ToInt32(Session["SaleUserID"])
                     select a.Password).First();
            if (s == txtCurrentPassword.Text)
            {
                var p = from a in dc.Users
                        where a.UserId == Convert.ToInt32(Session["SaleUserID"])
                        select a;
                foreach (User u in p)
                {
                    u.Password = txtNewPassword.Text;
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
            else
            {
                lblInCorrectPassword.Text = "Incorrect Password";
            }
        }
        if (Session["DeliveryUserID"] != null)
        {
            var s = (from a in dc.Users
                     where a.UserId == Convert.ToInt32(Session["DeliveryUserID"])
                     select a.Password).First();
            if (s == txtCurrentPassword.Text)
            {
                var p = from a in dc.Users
                        where a.UserId == Convert.ToInt32(Session["DeliveryUserID"])
                        select a;
                foreach (User u in p)
                {
                    u.Password = txtNewPassword.Text;
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
            else
            {
                lblInCorrectPassword.Text = "Incorrect Password";
            }
        }
    }
}