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
            var s = from a in dc.Sales
                    join si in dc.Sales_Invoices on a.SaleID equals si.SaleID
                    join order in dc.Order_By_Medical_Stores on a.OrderIDByMS equals order.OrderIDByMS
                    join medicalstore in dc.Medical_Stores on order.MedicalStoreID equals medicalstore.MedicalStoreID
                    group new { si,medicalstore } by new { (Convert.ToDateTime(si.sInvoiceDate)).Year,medicalstore.MedicalStoreName } into grpYear
                    //group order by Convert.ToDateTime(order.MedicalStoreID).Year into grpMedicalStore
                    orderby Convert.ToDateTime(grpYear.First().si.sInvoiceDate).Year
                    select new 
                    {
                       Year=Convert.ToDateTime( grpYear.First().si.sInvoiceDate).Year,
                       MedicalStoreName=grpYear.First().medicalstore.MedicalStoreName,
                       Quantity=grpYear.Select(x=>x.si.Quantity).Sum()

                    };
            gvMedicalStoreReport.DataSource = s;
            gvMedicalStoreReport.DataBind();
        }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
}