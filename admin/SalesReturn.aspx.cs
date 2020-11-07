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
public partial class admin_Default : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    Label lbldate;
    Label lblOrder;
    Label SaleReturn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridData();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
    void BindGridData() 
    {
        var s = (from a in dc.Sales_Returns
                 
                join sales in dc.Sales on a.SaleID equals sales.SaleID
                join ord in dc.Order_By_Medical_Stores on sales.OrderIDByMS equals ord.OrderIDByMS
                join ordmps in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ordmps.OrderIDByMS
                
                where ordmps.ReturnStatus=="Returned"
                // orderby a.SaleID descending
                select new 
                {
                  a.SaleID,
                  a.ReturnDate,
                 // Convert.ToDateTime( a.ReturnDate).Date,
                 // a.SaleReturnID,
                  ordmps.OrderIDByMS
                  
                }).Distinct().OrderByDescending(x=>x.ReturnDate);
        gvSaleReturn.DataSource = s;
        gvSaleReturn.DataBind();
    }
    protected void lnkViewDetails_Click(object sender, EventArgs e)
    {
        LinkButton lnk=(LinkButton)sender;
        var gvrow = (GridViewRow)lnk.NamingContainer;
        if (gvrow != null)
        {
            lbldate = (gvrow.FindControl("lblReturnDate") as Label);
            lblOrder = (gvrow.FindControl("lblOrderIDByMS") as Label);
        }
        //var s = from a in dc.Sales_Returns
        //        join sales in dc.Sales on a.SaleID equals sales.SaleID
        //        join ord in dc.Order_By_Medical_Stores on sales.OrderIDByMS equals ord.OrderIDByMS
        //        join ordmps in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ordmps.OrderIDByMS
        //        join medi in dc.Medicine_In_Stocks on ordmps.MedicineID equals medi.MedicineID
        //        where ordmps.ReturnDate== DateTime.Parse(lbldate.Text)
        //        select new 
        //        {
        //          sales.OrderIDByMS,
        //          medi.MedicineName,
        //          a.ReturnAmount
                 
        //        };
        var s = from a in dc.Order_by_Medical_Store_Per_Medicines

                join d in dc.Medicine_In_Stocks on a.MedicineID equals d.MedicineID
                where a.ReturnDate == Convert.ToDateTime(lbldate.Text) && a.OrderIDByMS == Convert.ToDecimal(lblOrder.Text)
                select new 
                {
                  a.OrderIDByMS,
                  d.MedicineName,
                  a.ReturnAmount
                };
            gvSaleReturnDetails.DataSource = s;
            gvSaleReturnDetails.DataBind();
            mp1.Show();
        
    }
    decimal priceTotal = 0;
    int ReturnquantityTotal = 0;
    int discountPercantageTotal = 0;
    int QuantityTotal;
    decimal discountAmount = 0;
    decimal Price = 0;
    decimal amount = 0;
    decimal NetTotal = 0;
    decimal ReturnNetTotal = 0;
    protected void lnkGenerateInvoice_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        var gvrow = (GridViewRow)lnk.NamingContainer;
        //if (gvrow != null)
        //{
        //    SaleReturn = (gvrow.FindControl("lblSaleReturnID") as Label);
        //}
        var srid = (from a in dc.Sales_Returns
                    join sale in dc.Sales on a.SaleID equals sale.SaleID
                    join ord in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals ord.OrderIDByMS
                    join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                    join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                    where a.SaleID == Convert.ToDecimal(lnk.CommandArgument) && ords.ReturnStatus == "Returned"
                    select a.SaleReturnID).First() ;
        var s = (from a in dc.Sales_Returns
                 join sale in dc.Sales on a.SaleID equals sale.SaleID
                 join ord in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals ord.OrderIDByMS
                 join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                 join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                 where a.SaleID == Convert.ToDecimal(lnk.CommandArgument) && ords.ReturnStatus == "Returned"
                 select new
                 {
                     medi.MedicineID,
                     medi.MedicineName,
                     medi.PackSize,
                     medi.BatchNo,
                     medi.ExpiryDate,
                     medi.Price,
                     ords.ReturnAmount,
                     ords.Amount,
                     ords.Discount,
                     ords.DiscountAmount,
                     ords.NetAmount,
                     ords.ReturnNetAmount

                 }).Distinct();
        var chk = from a in dc.Sales_Return_Invoices
                  where a.SaleReturnID == Convert.ToDecimal( srid)
                  select a.SaleReturnID;
        if (!chk.Any())
        {
            var sp = (from a in dc.Sales
                      join sr in dc.Sales_Returns on a.SaleID equals sr.SaleID
                      join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                      join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                      join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                      where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                      select ords.NetAmount).Sum();
            var returnTotal = (from a in dc.Sales
                      join sr in dc.Sales_Returns on a.SaleID equals sr.SaleID
                      join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                      join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                      join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                      where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                      select ords.ReturnNetAmount).Sum();
            var sa = (from a in dc.Sales
                      join sr in dc.Sales_Returns on a.SaleID equals sr.SaleID
                      join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                      join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                      join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                      where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                      select ords.ReturnAmount).Sum();
            Sales_Return_Invoice si = new Sales_Return_Invoice
            {
                SaleReturnID = Convert.ToDecimal(srid),
                Price = sp,
                Quantity = sa,
                srInvoiceDate = DateTime.Now
            };
            dc.Sales_Return_Invoices.InsertOnSubmit(si);
            dc.SubmitChanges();
        }
        var medicalstore = from a in dc.Sales
                           join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                           join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                           join medical in dc.Medical_Stores on ord.MedicalStoreID equals medical.MedicalStoreID
                           join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                           where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                           select new { medical.MedicalStoreName, medical.Phone, medical.Address, medical.Email };
        lblStoreNamewdc.Text = medicalstore.First().MedicalStoreName;
        lblPhonewdc.Text = Convert.ToString(medicalstore.First().Phone);
        lblStoreAddresswdc.Text = medicalstore.First().Address;
        lblEmailwdc.Text = medicalstore.First().Email;
        var sales = from a in dc.Sales_Invoices
                   where a.SaleID == Convert.ToInt32(lnk.CommandArgument)
                   select new { a.Price, a.sInvoiceDate };
        var net = (from a in dc.Sales
                   join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                   join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                   where a.SaleID == Convert.ToInt32(lnk.CommandArgument)
                   select ords.ReturnNetAmount).Sum();
        lblAmountwdc.Text = Convert.ToString(net);
        lblDatewdc.Text = Convert.ToString(sales.First().sInvoiceDate);
        gvSaleReturnInvoice.DataSource = s;
        gvSaleReturnInvoice.DataBind();
        ModalPopupExtender1.Show();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void gvdate_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // add the UnitPrice and QuantityTotal to the running total variables
            priceTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            Price = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            ReturnquantityTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ReturnAmount"));
            QuantityTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Amount"));
            discountPercantageTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Discount"));
            discountAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DiscountAmount"));
            amount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DiscountAmount"));
            NetTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "NetAmount"));
            ReturnNetTotal+=Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem,"ReturnNetAmount"));

            // Rate =grv.FindControl("lblRate") as Label;
            // Disc=gvdate.FindControl("lblDiscount") as Label;
            // Net = gvdate.FindControl("lblNetAmount") as Label;
            // e.Row.Cells[9].Text = (Price - amount).ToString();
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "Totals:";
            // for the Footer, display the running totals
            e.Row.Cells[5].Text = priceTotal.ToString();
            e.Row.Cells[6].Text = ReturnquantityTotal.ToString();
            e.Row.Cells[7].Text = QuantityTotal.ToString();
            e.Row.Cells[8].Text = discountPercantageTotal.ToString();
            e.Row.Cells[9].Text = discountAmount.ToString();
            e.Row.Cells[10].Text = NetTotal.ToString();
            e.Row.Cells[11].Text=ReturnNetTotal.ToString();
            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Font.Bold = true;
        }
    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        Panel2.RenderControl(hw);
        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();
    }
    protected void gvSaleReturn_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSaleReturn.PageIndex = e.NewPageIndex;
        gvSaleReturn.DataBind();
        BindGridData();
    }
}