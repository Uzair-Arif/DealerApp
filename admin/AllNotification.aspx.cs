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
        if (!IsPostBack) 
        {
           
            var s = from a in dc.Notifications
                    join u in dc.Users on a.UserID equals u.UserId
                    select new 
                    {
                        a.OrderNumber,
                        a.Message,
                        u.Username
                    };
            this.gvShowAllNotification.Columns[0].Visible = false;
            gvShowAllNotification.DataSource = s;
            gvShowAllNotification.DataBind();
        }
        Label lb = (Label)Master.FindControl("lblNotifyNumber");
        lb.Visible = false;
        var d = from a in dc.Notifications
                where a.Status == "Unseen"
                select a;
        foreach (Notification nf in d) 
        {
            nf.Status = "Seen";
        }
        try
        {
            dc.SubmitChanges();
        }
        catch(Exception ex)
        {
            lblerr.Text = "Not Submmited";
        }

    }
    
}