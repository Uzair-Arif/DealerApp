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
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataOrdersPlaced();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
        
        Label lb = (Label)Master.FindControl("lblOrdersPlaced");
        lb.Visible = false;
        var d = from a in dc.Notifications
                where a.Status == "Unseen" && a.Type == "Order Placed"
               // orderby a.NotificationId descending
                select a;
        foreach (Notification nf in d)
        {
            nf.Status = "Seen";
        }
        try
        {
            dc.SubmitChanges();
        }
        catch (Exception ex)
        {
            lblerr.Text = "Not Submmited";
        }
    }
    public void BindGridDataOrdersPlaced() 
    {
        var s = from a in dc.Notifications
                join u in dc.Users on a.UserID equals u.UserId
                where a.Type == "Order Placed"
                orderby a.NotificationId descending
                select new
                {
                    a.OrderNumber,
                    // a.NotificationId,
                    a.Message,
                    // a.Type,
                    u.Username
                };
        //this.gvOrderPalced.Columns[0].Visible = false;
        gvOrderPalced.DataSource = s;
        gvOrderPalced.DataBind();
    }
}