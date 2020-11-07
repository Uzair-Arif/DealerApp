using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_PurchaseReturnReport : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
         if (Session["AdminUserID"] != null)
        {
        if (!IsPostBack)
        {
            //var st = from a in dc.Purchase_Invoices
            //         join sale in dc.Purchases on a.PurchaseID equals sale.PurchaseID
            //         join order in dc.Order_To_Medicine_Companies on sale.OrderIDToMC equals order.OrderIDToMC
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
            //var s = from a in dc.Purchase_Invoices

            //        //join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
            //        //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
            //        //group new { a,ords } by new { (Convert.ToDateTime(a.Date)).Year,ords.OrderIDByMS } into grpYear
            //        group a by Convert.ToDateTime(a.pInvoiceDate).Year into grpYear

            //        orderby Convert.ToDateTime(grpYear.First().pInvoiceDate).Year

            //        select new
            //        {
            //            Year = Convert.ToDateTime(grpYear.First().pInvoiceDate).Year,
            //            TotalPurchases = grpYear.Select(x => x.PurchaseID).Count(),
            //            TotalQuantity = grpYear.Select(x => x.Quantity).Sum(),
            //            TotalPrice = grpYear.Select(x => x.Price).Sum()
            //        };
            //gvReport.DataSource = s;
            //gvReport.DataBind();
            var sr = from a in dc.Purchase_Return_Invoices
                     // join sales in dc.Sales
                     // join ord in dc.Order_By_Medical_Stores on a.OrderID equals ord.OrderIDByMS
                     //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                     // group new { a, ords } by new { (Convert.ToDateTime(a.Date)).Year, ords.OrderIDByMS } into grpYear
                     group a by Convert.ToDateTime(a.prInvoiceDate).Year into grpYear

                     orderby Convert.ToDateTime(grpYear.First().prInvoiceDate).Year

                     select new
                     {
                         pYear = Convert.ToDateTime(grpYear.First().prInvoiceDate).Year,
                         pTotalPurchasesReturn = grpYear.Select(x => x.PurchaseReturnID).Count(),
                         pTotalQuantity = grpYear.Select(x => x.Quantity).Sum(),
                         pTotalPrice = grpYear.Select(x => x.Price).Sum()
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

    protected void gvReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblYear = (Label)e.Row.FindControl("lblYear");
            GridView gv_Child = (GridView)e.Row.FindControl("gv_Child");

            var s = from a in dc.Purchase_Invoices
                    group a by Convert.ToDateTime(a.pInvoiceDate).Month into grpMonth

                    orderby Convert.ToDateTime(grpMonth.First().pInvoiceDate).Year

                    select new
                    {
                        Month = Convert.ToDateTime(grpMonth.First().pInvoiceDate),
                        TotalPurchases = grpMonth.Select(x => x.PurchaseID).Count(),
                        TotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
                        TotalPrice = grpMonth.Select(x => x.Price).Sum()
                    };
            gv_Child.DataSource = s;
            gv_Child.DataBind();

        }
    }
    Label month;
    protected void gv_Child_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            month = (Label)e.Row.FindControl("lblmonthnum");
            GridView gv_Childs = (GridView)e.Row.FindControl("gv_NestedChild");
            //string txtempid = lblYear.Text; 
            //DataSet ds = new DataSet();
            //conn.Open();
            //string cmdstr = "Select * from Salary_Details where empid=@empid";
            //SqlCommand cmd = new SqlCommand(cmdstr, conn);
            //cmd.Parameters.AddWithValue("@empid", txtempid);
            //SqlDataAdapter adp = new SqlDataAdapter(cmd);
            //adp.Fill(ds);
            //conn.Close();
            //var s = from a in dc.Purchase_Invoices
            //        join sale in dc.Purchases on a.PurchaseID equals sale.PurchaseID
            //        join order in dc.Order_To_Medicine_Companies on sale.OrderIDToMC equals order.OrderIDToMC
            //        join medicalstore in dc.Medicine_Companies on order.MedicineCompanyID equals medicalstore.MedicineCompanyID
            //        where Convert.ToDateTime(a.pInvoiceDate).Month == Convert.ToDateTime(month.Text).Month
            //        select new
            //        {
            //            PurchaseInvoice = a.pInvoiceID,
            //            PurchaseInvoiceDate = a.pInvoiceDate,
            //            MedicineCompanyName = medicalstore.MedicineCompanyName,
            //            PharmaEmployee = order.Placed_By,
            //            Quantity = a.Quantity,
            //            Price = a.Price
            //        };
            //gvtest.DataSource = s;
            //gvtest.DataBind();

            //join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
            //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
            //group new { a,ords } by new { (Convert.ToDateTime(a.Date)).Year,ords.OrderIDByMS } into grpYear
            //        group a by Convert.ToDateTime(a.srInvoiceDate).Month into grpMonth

            //        orderby Convert.ToDateTime(grpMonth.First().srInvoiceDate).Year

            //        select new
            //        {
            //            sMonth = Convert.ToDateTime(grpMonth.First().srInvoiceDate),
            //            sTotalSales = grpMonth.Select(x => x.SaleReturnID).Count(),
            //            sTotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
            //            sTotalPrice = grpMonth.Select(x => x.Price).Sum()
            //        };

            //gv_Childs.DataSource = s;
            //gv_Childs.DataBind();

        }
    }
    protected void gvSaleReturnReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblYear = (Label)e.Row.FindControl("slblYear");
            GridView gv_Childs = (GridView)e.Row.FindControl("gvSaleReturnChild");

            var s = from a in dc.Purchase_Return_Invoices

                    //join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                    //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                    //group new { a,ords } by new { (Convert.ToDateTime(a.Date)).Year,ords.OrderIDByMS } into grpYear
                    group a by Convert.ToDateTime(a.prInvoiceDate).Month into grpMonth

                    orderby Convert.ToDateTime(grpMonth.First().prInvoiceDate).Year

                    select new
                    {
                        pMonth = Convert.ToDateTime(grpMonth.First().prInvoiceDate),
                        pTotalPurchasesReturn = grpMonth.Select(x => x.PurchaseReturnID).Count(),
                        pTotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
                        pTotalPrice = grpMonth.Select(x => x.Price).Sum()
                    };
            gv_Childs.DataSource = s;
            gv_Childs.DataBind();


        }
    }
    protected void gvSaleReturnChild_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            month = (Label)e.Row.FindControl("lblmonthnumReturn");
            GridView gv_Childs = (GridView)e.Row.FindControl("gv_NestedChildReturn");
            //string txtempid = lblYear.Text; 
            //DataSet ds = new DataSet();
            //conn.Open();
            //string cmdstr = "Select * from Salary_Details where empid=@empid";
            //SqlCommand cmd = new SqlCommand(cmdstr, conn);
            //cmd.Parameters.AddWithValue("@empid", txtempid);
            //SqlDataAdapter adp = new SqlDataAdapter(cmd);
            //adp.Fill(ds);
            //conn.Close();
            var s = from sr in dc.Purchase_Return_Invoices
                    join a in dc.Purchase_Returns on sr.PurchaseReturnID equals a.PurchaseReturnID
                    join sale in dc.Purchases on a.PurchaseID equals sale.PurchaseID
                    join order in dc.Order_To_Medicine_Companies on sale.OrderIDToMC equals order.OrderIDToMC
                    join medicalstore in dc.Medicine_Companies on order.MedicineCompanyID equals medicalstore.MedicineCompanyID
                    where Convert.ToDateTime(a.ReturnDate).Month == Convert.ToDateTime(month.Text).Month
                    select new
                    {
                        PurchaseReturnInvoice = sr.prInvoice,
                        PurchaseReturnInvoiceDate = sr.prInvoiceDate,
                        MedicineCompanyName = medicalstore.MedicineCompanyName,
                        PharmaEmployee = order.Placed_By,
                        Quantity = sr.Quantity,
                        Price = sr.Price
                    };
            //gvtest.DataSource = s;
            //gvtest.DataBind();

            //join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
            //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
            //group new { a,ords } by new { (Convert.ToDateTime(a.Date)).Year,ords.OrderIDByMS } into grpYear
            //        group a by Convert.ToDateTime(a.srInvoiceDate).Month into grpMonth

            //        orderby Convert.ToDateTime(grpMonth.First().srInvoiceDate).Year

            //        select new
            //        {
            //            sMonth = Convert.ToDateTime(grpMonth.First().srInvoiceDate),
            //            sTotalSales = grpMonth.Select(x => x.SaleReturnID).Count(),
            //            sTotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
            //            sTotalPrice = grpMonth.Select(x => x.Price).Sum()
            //        };

            gv_Childs.DataSource = s;
            gv_Childs.DataBind();
        }
    }
}