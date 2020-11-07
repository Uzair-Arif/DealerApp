using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePassword : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        var s = (from a in dc.Users
                where a.UserId == Convert.ToInt32( Session["UserID"])
                 select a.Password).First();
        if (s == txtCurrentPassword.Text)
        {
            var p = from a in dc.Users
                    where a.UserId == Convert.ToInt32(Session["UserID"])
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