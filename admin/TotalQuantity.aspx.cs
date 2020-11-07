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
            var s = from a in dc.Medicine_In_Stocks
                    group a by a.MedicineName into grpName
                  //  orderby grpName.Select(x => x.MedicineName)
                    
                    select new 
                    {
                       MedicineName=grpName.First().MedicineName,
                       Quantity=grpName.Select(x=>x.Amount).Sum()
                    };
            gvTotalQuantity.DataSource = s;
            gvTotalQuantity.DataBind();
        }
        }
         else
         {
             Response.Redirect("../startbootstrap/main.aspx");
         }
    }
}