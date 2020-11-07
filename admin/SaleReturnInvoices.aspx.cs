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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataSaleInvoice();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
    public void BindGridDataSaleInvoice()
    {
        var s = from a in dc.Sales_Return_Invoices
                orderby a.srInvoice descending
                select a;
        this.gvSaleReturnInvoices.Columns[0].Visible = false;
        //this.gvSaleReturnInvoices.Columns[4].Visible = false;
        gvSaleReturnInvoices.DataSource = s;
        gvSaleReturnInvoices.DataBind();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void lnkSaleReturnInvoiceDetail_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        var s = from a in dc.Sales_Returns
                join sale in dc.Sales on a.SaleID equals sale.SaleID
                join ord in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals ord.OrderIDByMS
                join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                where a.SaleReturnID == Convert.ToDecimal(lnk.CommandArgument)
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
                };
        var medicalstore = from sr in dc.Sales_Returns
                           join a in dc.Sales on sr.SaleID equals a.SaleID
                           join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                           join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                           join medical in dc.Medical_Stores on ord.MedicalStoreID equals medical.MedicalStoreID
                           join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                           where sr.SaleReturnID == Convert.ToInt32(lnk.CommandArgument)
                           select new { medical.MedicalStoreName, medical.Phone, medical.Address, medical.Email };
        lblStoreNamewdc.Text = medicalstore.First().MedicalStoreName;
        lblPhonewdc.Text = Convert.ToString(medicalstore.First().Phone);
        lblStoreAddresswdc.Text = medicalstore.First().Address;
        lblEmailwdc.Text = medicalstore.First().Email;
        var sales = from a in dc.Sales_Return_Invoices
                    where a.SaleReturnID== Convert.ToInt32(lnk.CommandArgument)
                    select new { a.Price, a.srInvoiceDate };
        var net = (from a in dc.Sales
                   join saler in dc.Sales_Returns on a.SaleID equals saler.SaleID
                   join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                   join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                   where saler.SaleReturnID == Convert.ToInt32(lnk.CommandArgument)
                   select ords.ReturnNetAmount).Sum();
        lblAmountwdc.Text = Convert.ToString(net);
        lblDatewdc.Text = Convert.ToString(sales.First().srInvoiceDate);
        gvInvoice.DataSource = s;
        gvInvoice.DataBind();
        //var invoiceid = (from a in dc.Sales_Return_Invoices
        //                 where a.SaleReturnID == Convert.ToInt32(lnk.CommandArgument)
        //                 select a.srInvoice).Single();
        //lblInvoiceID.Text = invoiceid.ToString();
        ModalPopupExtender1.Show();
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
    protected void gvInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
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
            ReturnNetTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ReturnNetAmount"));

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
            e.Row.Cells[11].Text = ReturnNetTotal.ToString();
            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Font.Bold = true;
        }
    }
    //protected void btnExport_Click(object sender, EventArgs e)
    //{

    //}
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
    protected void gvSaleReturnInvoices_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSaleReturnInvoices.PageIndex = e.NewPageIndex;
        gvSaleReturnInvoices.DataBind();
        BindGridDataSaleInvoice();
    }
}