using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.IO;
using System.Text;

public partial class admin_SaleReturnReport : System.Web.UI.Page
{

    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
         if (Session["AdminUserID"] != null)
        {
        if (!IsPostBack)
        {
            //var st = from a in dc.Sales_Invoices
            //         join sale in dc.Sales on a.SaleID equals sale.SaleID
            //         join order in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals order.OrderIDByMS
            //         //join medicalstore in dc.Medical_Stores on order.OrderIDByMS equals medicalstore.MedicalStoreID
            //         where Convert.ToDateTime(a.sInvoiceDate).Month == 4
            //         select new
            //         {
            //             SaleInvoice = a.sInvoiceID,
            //             SaleInvoiceDate = a.sInvoiceDate,
            //             //MedicalStoreName = medicalstore.MedicalStoreName,
            //             StoreEmployee = order.Placed_By,
            //             Quantity = a.Quantity,
            //             Price = a.Price
            //         };
            //var st=from a in dc.Purchase_Returns
            //       select a;
            ////gvtest.DataSource = st;
            ////gvtest.DataBind();
            //var s = from a in dc.Sales_Invoices

            //        join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
            //        join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
            //        group new { a, ords } by new { (Convert.ToDateTime(a.Date)).Year, ords.OrderIDByMS } into grpYear
            //        group a by Convert.ToDateTime(a.sInvoiceDate).Year into grpYear

            //        orderby Convert.ToDateTime(grpYear.First().sInvoiceDate).Year

            //        select new
            //        {
            //            Year = Convert.ToDateTime(grpYear.First().sInvoiceDate).Year,
            //            TotalSales = grpYear.Select(x => x.SaleID).Count(),
            //            TotalQuantity = grpYear.Select(x => x.Quantity).Sum(),
            //            TotalPrice = grpYear.Select(x => x.Price).Sum()
            //        };
            //gvReport.DataSource = s;
            //gvReport.DataBind();
            var sr = from a in dc.Sales_Return_Invoices
                     // join sales in dc.Sales
                     // join ord in dc.Order_By_Medical_Stores on a.OrderID equals ord.OrderIDByMS
                     //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                     // group new { a, ords } by new { (Convert.ToDateTime(a.Date)).Year, ords.OrderIDByMS } into grpYear
                     group a by Convert.ToDateTime(a.srInvoiceDate).Year into grpYear

                     orderby Convert.ToDateTime(grpYear.First().srInvoiceDate).Year

                     select new
                     {
                         sYear = Convert.ToDateTime(grpYear.First().srInvoiceDate).Year,
                         sTotalSales = grpYear.Select(x => x.SaleReturnID).Count(),
                         sTotalQuantity = grpYear.Select(x => x.Quantity).Sum(),
                         sTotalPrice = grpYear.Select(x => x.Price).Sum()
                     };
            gvSaleReturnReport.DataSource = sr;
            gvSaleReturnReport.DataBind();
        }
        }
         else
         {
             Response.Redirect("../startbootstrap/main.aspx");
         }
    }
    //protected void gvReport_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Label lblYear = (Label)e.Row.FindControl("lblYear");
    //        GridView gv_Child = (GridView)e.Row.FindControl("gv_Child");

    //        var s = from a in dc.Sales_Invoices
    //                group a by Convert.ToDateTime(a.sInvoiceDate).Month into grpMonth

    //                orderby Convert.ToDateTime(grpMonth.First().sInvoiceDate).Year

    //                select new
    //                {
    //                    Month = Convert.ToDateTime(grpMonth.First().sInvoiceDate),
    //                    TotalSales = grpMonth.Select(x => x.SaleID).Count(),
    //                    TotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
    //                    TotalPrice = grpMonth.Select(x => x.Price).Sum()
    //                };
    //        gv_Child.DataSource = s;
    //        gv_Child.DataBind();

    //    }
    //}
    protected void gvSaleReturnReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblYear = (Label)e.Row.FindControl("slblYear");
            GridView gv_Childs = (GridView)e.Row.FindControl("gvSaleReturnChild");

            var s = from a in dc.Sales_Return_Invoices

                    
                    group a by Convert.ToDateTime(a.srInvoiceDate).Month into grpMonth

                    orderby Convert.ToDateTime(grpMonth.First().srInvoiceDate).Year

                    select new
                    {
                        sMonth = Convert.ToDateTime(grpMonth.First().srInvoiceDate),
                        sTotalSales = grpMonth.Select(x => x.SaleReturnID).Count(),
                        sTotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
                        sTotalPrice = grpMonth.Select(x => x.Price).Sum()
                    };
            gv_Childs.DataSource = s;
            gv_Childs.DataBind();

        }
    }
    Label month;
    protected void gv_Child_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            month = (Label)e.Row.FindControl("lblmonthnum");
            GridView gv_Childs = (GridView)e.Row.FindControl("gv_NestedChild");
            
            var s = from a in dc.Sales_Invoices
                    join sale in dc.Sales on a.SaleID equals sale.SaleID
                    join order in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals order.OrderIDByMS
                    join medicalstore in dc.Medical_Stores on order.MedicalStoreID equals medicalstore.MedicalStoreID
                    where Convert.ToDateTime(a.sInvoiceDate).Month == Convert.ToDateTime(month.Text).Month
                    select new
                    {
                        SaleInvoice = a.sInvoiceID,
                        SaleInvoiceDate = a.sInvoiceDate,
                        MedicalStoreName = medicalstore.MedicalStoreName,
                        StoreEmployee = order.Placed_By,
                        Quantity = a.Quantity,
                        Price = a.Price
                    };
           
            gv_Childs.DataSource = s;
            gv_Childs.DataBind();
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void btnexport_Click(object sender, EventArgs e)
    {

       
    }
    protected void gvSaleReturnChild_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            month = (Label)e.Row.FindControl("lblmonthnumReturn");
            GridView gv_Childs = (GridView)e.Row.FindControl("gv_NestedChildReturn");
           
            var s = from sr in dc.Sales_Return_Invoices
                    join a in dc.Sales_Returns on sr.SaleReturnID equals a.SaleReturnID
                    join sale in dc.Sales on a.SaleID equals sale.SaleID
                    join order in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals order.OrderIDByMS
                    join medicalstore in dc.Medical_Stores on order.MedicalStoreID equals medicalstore.MedicalStoreID
                    where Convert.ToDateTime(a.ReturnDate).Month == Convert.ToDateTime(month.Text).Month
                    select new
                    {
                        SaleReturnInvoice = sr.srInvoice,
                        SaleReturnInvoiceDate = sr.srInvoiceDate,
                        MedicalStoreName = medicalstore.MedicalStoreName,
                        StoreEmployee = order.Placed_By,
                        Quantity = sr.Quantity,
                        Price = sr.Price
                    };
           

            gv_Childs.DataSource = s;
            gv_Childs.DataBind();
        }
    }
}