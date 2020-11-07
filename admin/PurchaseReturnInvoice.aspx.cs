﻿using System;
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
                BindGridDataPurchaseReturnInvoice();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
    public void BindGridDataPurchaseReturnInvoice()
    {
        var s = from a in dc.Purchase_Return_Invoices
                orderby a.prInvoice descending
                select a;
        this.gvPurchaseReturnInvoices.Columns[0].Visible = false;
        //this.gvSaleReturnInvoices.Columns[4].Visible = false;
        gvPurchaseReturnInvoices.DataSource = s;
        gvPurchaseReturnInvoices.DataBind();
    }
    protected void lnkPurchaseReturnInvoiceDetail_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        var s = from a in dc.Purchase_Returns
                join sale in dc.Purchases on a.PurchaseID equals sale.PurchaseID
                join ord in dc.Order_To_Medicine_Companies on sale.OrderIDToMC equals ord.OrderIDToMC
                join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                where a.PurchaseReturnID == Convert.ToDecimal(lnk.CommandArgument)
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
                    //ords.Discount,
                    //ords.DiscountAmount,
                    ords.NetAmount,
                    ords.ReturnNetAmount
                };
        var medicalstore =   from pr in dc.Purchase_Returns 
                           join a in dc.Purchases on pr.PurchaseID equals a.PurchaseID
                           join ord in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ord.OrderIDToMC
                           join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                           join medical in dc.Medicine_Companies on ord.MedicineCompanyID equals medical.MedicineCompanyID
                           join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                           where pr.PurchaseReturnID == Convert.ToInt32(lnk.CommandArgument)
                           select new { medical.MedicineCompanyName, medical.Phone, medical.Address, medical.Email };
        lblStoreName.Text = medicalstore.First().MedicineCompanyName;
        lblPhone.Text = Convert.ToString(medicalstore.First().Phone);
        lblAddress.Text = medicalstore.First().Address;
        lblemail.Text = medicalstore.First().Email;
        var sales = from a in dc.Purchase_Return_Invoices
                    where a.PurchaseReturnID == Convert.ToInt32(lnk.CommandArgument)
                    select new { a.Price, a.prInvoiceDate };
        var net = (from a in dc.Purchases
                   join pr in dc.Purchase_Returns on a.PurchaseID equals pr.PurchaseID
                   join ord in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ord.OrderIDToMC
                   join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                   where pr.PurchaseReturnID == Convert.ToInt32(lnk.CommandArgument)
                   select ords.ReturnNetAmount).Sum();
        lblAmount.Text = Convert.ToString(net);
        lblDate.Text = Convert.ToString(sales.First().prInvoiceDate);
        gvPurchaseReturnInvoice.DataSource = s;
        gvPurchaseReturnInvoice.DataBind();
        //var invoiceid = (from a in dc.Sales_Return_Invoices
        //                 where a.SaleReturnID == Convert.ToInt32(lnk.CommandArgument)
        //                 select a.srInvoice).Single();
        //lblInvoiceID.Text = invoiceid.ToString();
        ModalPopupExtender1.Show();
    }
    decimal priceTotal = 0;
    int quantityTotal = 0;
    int discountPercantageTotal = 0;
    decimal discountAmount = 0;
    decimal Price = 0;
    decimal amount = 0;
    decimal NetTotal = 0;
    decimal ReturnNetTotal = 0;
    protected void gvPurchaseReturnInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // add the UnitPrice and QuantityTotal to the running total variables
            priceTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            Price = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            quantityTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ReturnAmount"));
            // discountPercantageTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Discount"));
            //discountAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DiscountAmount"));
            amount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount"));
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
            e.Row.Cells[6].Text = quantityTotal.ToString();
            // e.Row.Cells[7].Text = discountPercantageTotal.ToString();
            // e.Row.Cells[8].Text = discountAmount.ToString();
            e.Row.Cells[7].Text = amount.ToString();
            e.Row.Cells[8].Text = NetTotal.ToString();
            e.Row.Cells[9].Text = ReturnNetTotal.ToString();
            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Font.Bold = true;
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
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
    protected void gvPurchaseReturnInvoices_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPurchaseReturnInvoice.PageIndex = e.NewPageIndex;
        gvPurchaseReturnInvoice.DataBind();
        BindGridDataPurchaseReturnInvoice();
    }
}