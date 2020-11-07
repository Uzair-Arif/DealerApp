using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tube : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var s = from mis in dc.Medicine_In_Stocks

                    group mis by mis.MedicineName into g
                    join mc in dc.Medicine_Categories on g.First().MedicineCategoryID equals mc.MedicineCategoryID
                    where mc.MedicineCategoryName == "Tube"
                    //select g.OrderBy(p => p.MedicineName).First()
                    select new
                    {
                        Image = g.First().Image,
                        MedicineName = (g.OrderBy(p => p.MedicineName).FirstOrDefault()).MedicineName,
                        Description = g.First().Description,
                        PackSize = g.First().PackSize,

                        //Price = g.First().Price,
                        MedicineCategoryName = mc.MedicineCategoryName
                    };
            gvTube.DataSource = s;
            gvTube.DataBind();

        }
    }
}