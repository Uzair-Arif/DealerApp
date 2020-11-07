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
using ControlFreak;
using System.Data;
public partial class admin_Default : System.Web.UI.Page
{
	DataClassesDataContext dc = new DataClassesDataContext();
    int orderid;
    TextBox txtReturn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataSales();
            }
        }
        else 
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
	void BindGridDataSales() 
	{
        if (ddlMedicalStore.SelectedValue == "0" || ddlMedicalStore.SelectedValue == string.Empty)
        {
            var s = from sa in dc.Sales
                    join ord in dc.Order_By_Medical_Stores on sa.OrderIDByMS equals ord.OrderIDByMS
                    join medicalstore in dc.Medical_Stores on ord.MedicalStoreID equals medicalstore.MedicalStoreID
                    orderby sa.SaleID descending
                    select new 
                    {
                      sa.SaleID,
                      sa.Date,
                      ord.OrderIDByMS,
                      medicalstore.MedicalStoreName
                    
                    };
            this.gvSales.Columns[0].Visible = false;
            gvSales.DataSource = s;
            gvSales.DataBind();
        }
        else
        {
            var s = from sa in dc.Sales
                    join ord in dc.Order_By_Medical_Stores on sa.OrderIDByMS equals ord.OrderIDByMS
                    join medicalstore in dc.Medical_Stores on ord.MedicalStoreID equals medicalstore.MedicalStoreID
                    where medicalstore.MedicalStoreName==ddlMedicalStore.SelectedValue
                    orderby sa.SaleID descending
                    select new
                    {
                        sa.SaleID,
                        sa.Date,
                        ord.OrderIDByMS,
                        medicalstore.MedicalStoreName

                    };
            this.gvSales.Columns[0].Visible = false;
            gvSales.DataSource = s;
            gvSales.DataBind();
        }
	}
	protected void lnkViewDetails_Click(object sender, EventArgs e)
	{
		LinkButton lnk = (LinkButton)sender;
        //orderid = Convert.ToInt32(lnk.CommandArgument);
        Session["OrderID"] = Convert.ToInt32(lnk.CommandArgument);
        var o = from s in dc.Order_by_Medical_Store_Per_Medicines
                join m in dc.Medicine_In_Stocks on s.MedicineID equals m.MedicineID
                join medicalstore in dc.Order_By_Medical_Stores on s.OrderIDByMS equals medicalstore.OrderIDByMS
                join medicalstorename in dc.Medical_Stores on medicalstore.MedicalStoreID equals medicalstorename.MedicalStoreID
                where s.OrderIDByMS == Convert.ToInt32(lnk.CommandArgument)
                select new 
                {
                  s.OrderIDByMS,
                  medicalstorename.MedicalStoreName,
                  m.MedicineName,
                  s.Amount
                };
		gvSalesDetail.DataSource = o;
		gvSalesDetail.DataBind();
        mp1.Show();
	}
    protected void btnClose_Click(object sender, EventArgs e)
    {
        
    }
   // RequiredFieldValidator rv;
    protected void btn1_Click(object sender, EventArgs e)
    {
        Button btn=(Button)sender;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null) 
        {
            txtReturn = ( gvrow.FindControl("txtAddReturn") as TextBox);
           // rv = (gvrow.FindControl("rvReturn") as RequiredFieldValidator);
        }
        //if (txtReturn.Text.Length < 1)
        //{
        //    //rv.ErrorMessage = "Please enter Value";
        //    rv.Visible = true;
        //}
        var sa = (from a in dc.Sales
                 join s in dc.Order_By_Medical_Stores on a.OrderIDByMS equals s.OrderIDByMS
                 join obmp in dc.Order_by_Medical_Store_Per_Medicines on s.OrderIDByMS equals obmp.OrderIDByMS
                 join medi in dc.Medicine_In_Stocks on obmp.MedicineID equals medi.MedicineID
                 where s.OrderIDByMS == Convert.ToDecimal( Session["OrderID"]) && medi.MedicineName == btn.CommandArgument
                 select a.SaleID).Single();
        
        var msa = from a in dc.Sales
                  join sr in dc.Sales_Returns on a.SaleID equals sr.SaleID
                  join s in dc.Order_By_Medical_Stores on a.OrderIDByMS equals s.OrderIDByMS
                  join obmp in dc.Order_by_Medical_Store_Per_Medicines on s.OrderIDByMS equals obmp.OrderIDByMS
                  join medi in dc.Medicine_In_Stocks on obmp.MedicineID equals medi.MedicineID
                  where sr.SaleID == sa && medi.MedicineName == btn.CommandArgument && obmp.ReturnStatus=="Returned"
                  select sr;
        if (txtReturn.Text != string.Empty)
        {
            if (msa.Any())
            {
                foreach (Sales_Return sr in msa)
                {
                    sr.ReturnAmount = sr.ReturnAmount + Convert.ToDecimal(txtReturn.Text);
                    sr.ReturnDate = DateTime.Now.Date;
                }
                try
                {
                    dc.SubmitChanges();
                }
                catch (Exception ex)
                {
                    lblerr.Text = ex.ToString();
                }
            }
            else
            {

                Sales_Return sr = new Sales_Return
                {
                    SaleID = sa,
                    ReturnAmount = Convert.ToDecimal(txtReturn.Text),
                    ReturnDate = DateTime.Now.Date

                };
                dc.Sales_Returns.InsertOnSubmit(sr);
                dc.SubmitChanges();

                //mp1.Hide();

            }
            var ord = from a in dc.Sales
                      join s in dc.Order_By_Medical_Stores on a.OrderIDByMS equals s.OrderIDByMS
                      join obmp in dc.Order_by_Medical_Store_Per_Medicines on s.OrderIDByMS equals obmp.OrderIDByMS
                      join medi in dc.Medicine_In_Stocks on obmp.MedicineID equals medi.MedicineID
                      where s.OrderIDByMS == Convert.ToDecimal(Session["OrderID"]) && medi.MedicineName == btn.CommandArgument
                      select obmp; ///get order with the specific medicine
            var price = (from a in dc.Medicine_In_Stocks
                         join b in dc.Order_by_Medical_Store_Per_Medicines on a.MedicineID equals b.MedicineID
                         where b.OrderIDByMS == Convert.ToDecimal(Session["OrderID"]) && a.MedicineName == btn.CommandArgument
                         select a.Price).Single();/// get price of that medicine 
            var orpm = (from a in dc.Medicine_In_Stocks
                        join b in dc.Order_by_Medical_Store_Per_Medicines on a.MedicineID equals b.MedicineID
                        where b.OrderIDByMS == Convert.ToDecimal(Session["OrderID"]) && a.MedicineName == btn.CommandArgument
                        select b.OrderIDByMS).Single();///get orderidbymsp of that medicine
            foreach (Order_by_Medical_Store_Per_Medicine ords in ord)   //make modifications in order per medicine
            {
                var s = (from a in dc.Medicine_In_Stocks
                         where a.MedicineID == ords.MedicineID
                         select a.Price).First();
                if (ords.Discount > 0)
                {
                    if (ords.Amount - Convert.ToDecimal(txtReturn.Text) > 0)     //discount calculation discountamount=((price*quantity)*discount%)/100)
                    {                                                             //discount finalized=((price*quantity)-discountamount)
                        ords.Amount = ords.Amount - Convert.ToDecimal(txtReturn.Text);
                        ords.ReturnStatus = "Returned";
                        ords.ReturnDate = DateTime.Now.Date;
                        ords.ReturnAmount = Convert.ToDecimal(txtReturn.Text);
                        ords.DiscountAmount = ((price * (ords.Amount - Convert.ToDecimal(txtReturn.Text))) * Convert.ToInt32(ords.Discount)) / 100;
                        ords.NetAmount = ((ords.Amount - Convert.ToDecimal(txtReturn.Text)) * s) - ords.DiscountAmount;//(price * (ords.Amount - Convert.ToDecimal(txtReturn.Text))) - (((price * (ords.Amount - Convert.ToDecimal(txtReturn.Text))) * Convert.ToInt32(ords.Discount)) / 100);
                        ords.ReturnNetAmount = price * Convert.ToDecimal(txtReturn.Text);
                    }
                }
                else
                {
                    if (ords.Amount - Convert.ToDecimal(txtReturn.Text) > 0)     //without discount calculation
                    {
                        ords.Amount = ords.Amount - Convert.ToDecimal(txtReturn.Text);
                        ords.ReturnStatus = "Returned";
                        ords.ReturnDate = DateTime.Now.Date;
                        ords.ReturnAmount = Convert.ToDecimal(txtReturn.Text);
                        //ords.DiscountAmount = ((price * (ords.Amount - Convert.ToDecimal(txtReturn.Text))) * Convert.ToInt32(ords.Discount)) / 100;
                        ords.NetAmount = (ords.Amount - Convert.ToDecimal(txtReturn.Text)) * s; //(price * (ords.Amount - Convert.ToDecimal(txtReturn.Text))) - (((price * (ords.Amount - Convert.ToDecimal(txtReturn.Text)))));
                        ords.ReturnNetAmount = price * Convert.ToDecimal(txtReturn.Text);
                    }
                }
                lblReturnMessage.Text = "Return Added";
            }

            try
            {
                dc.SubmitChanges();
                //txtReturn.Text = "Return Added";
            }
            catch (Exception ex)
            {
                lblerr.Text = ex.ToString();
            }
        }
       string popupScript = "";
       popupScript = "<script language='javascript'>" +
"showSuccessToast();" +
"</script>";
       Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
    }
    decimal priceTotal = 0;
    int quantityTotal = 0;
    int discountPercantageTotal = 0;
    decimal discountAmount = 0;
    decimal Price = 0;
    decimal amount = 0;
    decimal NetTotal = 0;
   
    protected void lnkGenerateInvoice_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        var s = from a in dc.Sales
                join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                where a.SaleID ==Convert.ToDecimal(lnk.CommandArgument) && ords.Discount>0
                select new
                {
                    medi.MedicineID,
                    medi.MedicineName,
                    medi.PackSize,
                    medi.BatchNo,
                    medi.ExpiryDate,
                    medi.Price,
                    ords.Amount,
                    ords.Discount,
                    ords.DiscountAmount,
                    ords.NetAmount
                };
        var withoutdc = from a in dc.Sales
                join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                where a.SaleID == Convert.ToDecimal(lnk.CommandArgument) && ords.Discount==0
                select new
                {
                    medi.MedicineID,
                    medi.MedicineName,
                    medi.PackSize,
                    medi.BatchNo,
                    medi.ExpiryDate,
                    medi.Price,
                    ords.Amount,
                   // ords.Discount,
                   // ords.DiscountAmount,
                    ords.NetAmount
                };
        var chk = from a in dc.Sales_Invoices
                  where a.SaleID == Convert.ToDecimal( lnk.CommandArgument)
                  select a.SaleID;
        if (!chk.Any())
        {
            var sp = (from a in dc.Sales
                      join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                      join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                      join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                      where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                      select ords.NetAmount).Sum();
            var sa = (from a in dc.Sales
                      join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                      join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                      join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                      where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                      select ords.Amount).Sum();
            Sales_Invoice si = new Sales_Invoice
            {
                SaleID = Convert.ToDecimal(lnk.CommandArgument),
                Price = sp,
                Quantity = sa,
                sInvoiceDate = DateTime.Now
            };
            dc.Sales_Invoices.InsertOnSubmit(si);
            dc.SubmitChanges();
        }
        if (s.Any())
        {
            var medicalstore = from a in dc.Sales
                               join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                               join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                               join medical in dc.Medical_Stores on ord.MedicalStoreID equals medical.MedicalStoreID
                               join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                               where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                               select new { medical.MedicalStoreName, medical.Phone, medical.Address, medical.Email };
            lblStoreName.Text = medicalstore.First().MedicalStoreName;
            lblPhone.Text = Convert.ToString(medicalstore.First().Phone);
            lblAddress.Text = medicalstore.First().Address;
            lblemail.Text = medicalstore.First().Email;
            var sale = from a in dc.Sales_Invoices
                       where a.SaleID == Convert.ToInt32(lnk.CommandArgument)
                       select new { a.Price, a.sInvoiceDate };
            var net = (from a in dc.Sales
                      join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                      join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                      where a.SaleID == Convert.ToInt32(lnk.CommandArgument)
                      select ords.NetAmount).Sum();
            lblAmount.Text =Convert.ToString( net);//Convert.ToString( NetTotal); //Convert.ToString(sale.First().Price);
            lblDate.Text = Convert.ToString(sale.First().sInvoiceDate);
            gvInvoice.DataSource = s;
            gvInvoice.DataBind();
            ModalPopupExtender1.Show();
        }
        if (withoutdc.Any()) 
        {
            var medicalstore = from a in dc.Sales
                               join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                               join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                               join medical in dc.Medical_Stores on ord.MedicalStoreID equals medical.MedicalStoreID
                               join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                               where a.SaleID == Convert.ToDecimal(lnk.CommandArgument)
                               select new { medical.MedicalStoreName, medical.Phone, medical.Address, medical.Email };
            Label txtBox = (Label)Panel3.FindControl("lblStoreNamewdc");
            txtBox.Text = medicalstore.First().MedicalStoreName;
            lblPhonewdc.Text = Convert.ToString(medicalstore.First().Phone);
            lblStoreAddresswdc.Text = medicalstore.First().Address;
            lblEmailwdc.Text = medicalstore.First().Email;
            var sale = from a in dc.Sales_Invoices
                       where a.SaleID == Convert.ToInt32(lnk.CommandArgument)
                       select new { a.Price, a.sInvoiceDate };
            var net = (from a in dc.Sales
                       join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
                       join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
                       where a.SaleID == Convert.ToInt32(lnk.CommandArgument)
                       select ords.NetAmount).Sum();
            lblAmountwdc.Text = Convert.ToString(net);
            lblDatewdc.Text = Convert.ToString(sale.First().sInvoiceDate);
            gvWithoutdc.DataSource = withoutdc;
            gvWithoutdc.DataBind();
            ModalPopupExtender2.Show();
        }
    }
   
    protected void gvInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // add the UnitPrice and QuantityTotal to the running total variables
            priceTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            Price = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            quantityTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Amount"));
            discountPercantageTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Discount"));
            discountAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DiscountAmount"));
            amount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DiscountAmount"));
            NetTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "NetAmount"));
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
            e.Row.Cells[7].Text = discountPercantageTotal.ToString();
            e.Row.Cells[8].Text = discountAmount.ToString();
            e.Row.Cells[9].Text = NetTotal.ToString();

            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Font.Bold = true;
        }
    }
    protected void gvWithoutdc_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // add the UnitPrice and QuantityTotal to the running total variables
            priceTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
           // Price = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            quantityTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Amount"));
            //discountPercantageTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Discount"));
            //discountAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DiscountAmount"));
            //amount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DiscountAmount"));
            NetTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "NetAmount"));
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
            e.Row.Cells[7].Text = NetTotal.ToString();

            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            //e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
            //e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Font.Bold = true;
        }
    }
    protected void btnCloseInvoiceWithoutdc_Click(object sender, EventArgs e)
    {
       
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
        Panel3.RenderControl(hw);
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
    protected void btnExportDC_Click(object sender, EventArgs e)
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
       // ExportPanel1.ExportType = ExportPanel.AppType.Excel;
    }
    protected void gvSales_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSales.PageIndex = e.NewPageIndex;
        gvSales.DataBind();
        BindGridDataSales();
    }
   // TextBox returnAmount;
    //protected void cvReturnAmount_ServerValidate(object source, ServerValidateEventArgs args)
    //{
    //    CustomValidator btn = (CustomValidator)source;
    //    var gvrow = (GridViewRow)btn.NamingContainer;
    //    if (gvrow != null)
    //    {
    //        returnAmount = (gvrow.FindControl("txtAddReturn") as TextBox);
    //    }
    //    System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("^[0-9]+$");
    //    args.IsValid = r.IsMatch(returnAmount.Text);
    //}
    protected void ddlMedicalStore_DataBound(object sender, EventArgs e)
    {
        ddlMedicalStore.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
    }
    protected void ddlMedicalStore_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGridDataSales();
    }
}