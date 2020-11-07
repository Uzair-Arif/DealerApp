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
    int orderid;
    TextBox txtReturn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDatapurchases();
                //rv.Visible = false;
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
    void BindGridDatapurchases()
    {
        if (ddlMedicineCompanyName.SelectedValue == "0" || ddlMedicineCompanyName.SelectedValue == string.Empty)
        {
            var s = from sa in dc.Purchases
                    join ord in dc.Order_To_Medicine_Companies on sa.OrderIDToMC equals ord.OrderIDToMC
                    join medicalstore in dc.Medicine_Companies on ord.MedicineCompanyID equals medicalstore.MedicineCompanyID
                    orderby sa.PurchaseID descending
                    select new
                    {
                        sa.PurchaseID,
                        sa.Date,
                        ord.OrderIDToMC,
                        medicalstore.MedicineCompanyName

                    };
            this.gvPurchases.Columns[0].Visible = false;
            gvPurchases.DataSource = s;
            gvPurchases.DataBind();
        }
        else
        {
            var s = from sa in dc.Purchases
                    join ord in dc.Order_To_Medicine_Companies on sa.OrderIDToMC equals ord.OrderIDToMC
                    join medicalstore in dc.Medicine_Companies on ord.MedicineCompanyID equals medicalstore.MedicineCompanyID
                    where medicalstore.MedicineCompanyName == ddlMedicineCompanyName.SelectedValue
                    orderby sa.PurchaseID descending
                    select new
                    {
                        sa.PurchaseID,
                        sa.Date,
                        ord.OrderIDToMC,
                        medicalstore.MedicineCompanyName

                    };
            this.gvPurchases.Columns[0].Visible = false;
            gvPurchases.DataSource = s;
            gvPurchases.DataBind();
        }
    }
    protected void lnkViewDetails_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        //orderid = Convert.ToInt32(lnk.CommandArgument);
        Session["OrderID"] = Convert.ToInt32(lnk.CommandArgument);
        var o = from s in dc.Order_To_Medicine_Company_Per_Medicines
                join m in dc.Medicine_In_Stocks on s.MedicineID equals m.MedicineID
                join medicalstore in dc.Order_To_Medicine_Companies on s.OrderIDToMC equals medicalstore.OrderIDToMC
                join medicalstorename in dc.Medicine_Companies on medicalstore.MedicineCompanyID equals medicalstorename.MedicineCompanyID
                where s.OrderIDToMC == Convert.ToInt32(lnk.CommandArgument)
                select new
                {
                    s.OrderIDToMC,
                    medicalstorename.MedicineCompanyName,
                    m.MedicineName,
                    s.Amount
                };
        gvPurchasesDetail.DataSource = o;
        gvPurchasesDetail.DataBind();
        mp1.Show();
    }
  //  RequiredFieldValidator rv;
    protected void btn1_Click(object sender, EventArgs e)
    {

        Button btn=(Button)sender;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null) 
        {
            txtReturn = ( gvrow.FindControl("txtAddReturn") as TextBox);
     //       rv=(gvrow.FindControl("rvReturn") as RequiredFieldValidator);
        }
        //if (txtReturn.Text.Length < 1) 
        //{
        //    rv.ErrorMessage = "Please enter Value";
        //}
        var sa = (from a in dc.Purchases
                 join s in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals s.OrderIDToMC
                 join obmp in dc.Order_To_Medicine_Company_Per_Medicines on s.OrderIDToMC equals obmp.OrderIDToMC
                 join medi in dc.Medicine_In_Stocks on obmp.MedicineID equals medi.MedicineID
                 where s.OrderIDToMC == Convert.ToDecimal( Session["OrderID"]) && medi.MedicineName == btn.CommandArgument
                 select a.PurchaseID).Single();
        
        var msa = from a in dc.Purchases
                  join sr in dc.Purchase_Returns on a.PurchaseID equals sr.PurchaseID
                  join s in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals s.OrderIDToMC
                  join obmp in dc.Order_To_Medicine_Company_Per_Medicines on s.OrderIDToMC equals obmp.OrderIDToMC
                  join medi in dc.Medicine_In_Stocks on obmp.MedicineID equals medi.MedicineID
                  where sr.PurchaseID == sa && medi.MedicineName == btn.CommandArgument && obmp.ReturnStatus=="Returned"
                  select sr;

        if (txtReturn.Text  != String.Empty)
        {
            if (msa.Any())
            {
                foreach (Purchase_Return sr in msa)
                {
                    sr.ReturnAmount = sr.ReturnAmount + Convert.ToDecimal(txtReturn.Text);
                    sr.ReturnDate = DateTime.Now;
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
                Purchase_Return sr = new Purchase_Return
               {
                   PurchaseID = sa,
                   ReturnAmount = Convert.ToDecimal(txtReturn.Text),
                   ReturnDate = DateTime.Now

               };
                dc.Purchase_Returns.InsertOnSubmit(sr);
                dc.SubmitChanges();
            }
            var ord = from a in dc.Purchases
                      join s in dc.Order_To_Medicine_Company_Per_Medicines on a.OrderIDToMC equals s.OrderIDToMC
                      join obmp in dc.Order_To_Medicine_Company_Per_Medicines on s.OrderIDToMC equals obmp.OrderIDToMC
                      join medi in dc.Medicine_In_Stocks on obmp.MedicineID equals medi.MedicineID
                      where s.OrderIDToMC == Convert.ToDecimal(Session["OrderID"]) && medi.MedicineName == btn.CommandArgument
                      select obmp;
            foreach (Order_To_Medicine_Company_Per_Medicine ords in ord)
            {
                var s = (from a in dc.Medicine_In_Stocks
                         where a.MedicineID == ords.MedicineID
                         select a.Price).First();

                if (ords.Amount - Convert.ToDecimal(txtReturn.Text) > 0)
                {
                    ords.Amount = ords.Amount - Convert.ToDecimal(txtReturn.Text);
                    ords.NetAmount = (ords.Amount - Convert.ToDecimal(txtReturn.Text)) * s;
                    ords.ReturnStatus = "Returned";
                    ords.ReturnDate = DateTime.Now;
                    ords.ReturnAmount = Convert.ToDecimal(txtReturn.Text);
                    ords.ReturnNetAmount = Convert.ToDecimal(txtReturn.Text) * s;

                }
                var sf = (from a in dc.Medicine_In_Stocks
                          where a.MedicineID == ords.MedicineID
                          select a);
                foreach (Medicine_In_Stock item in sf)
                {
                    item.Amount = item.Amount - Convert.ToDecimal(txtReturn.Text);
                }
                try
                {
                    dc.SubmitChanges();
                }
                catch (Exception ex)
                {

                    lblerr.Text = ex.ToString();
                }
                // sf.Amount = sf.Amount - Convert.ToDecimal(txtReturn.Text);

            }
            try
            {
                dc.SubmitChanges();
            }
            catch (Exception ex)
            {
                lblerr.Text = ex.ToString();
            }
            lblReturnMessage.Text = "Return Added";
        }
    }
    decimal priceTotal = 0;
    int quantityTotal = 0;
    int discountPercantageTotal = 0;
    decimal discountAmount = 0;
    decimal Price = 0;
    decimal amount = 0;
    decimal NetTotal = 0;
    protected void lnkGenrateInvoice_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        var s = from a in dc.Purchases
                join ord in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ord.OrderIDToMC
                join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                where a.PurchaseID == Convert.ToDecimal(lnk.CommandArgument)
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
        var chk = from a in dc.Purchase_Invoices
                  where a.PurchaseID == Convert.ToInt32(lnk.CommandArgument)
                  select a.PurchaseID;
        if (!chk.Any())
        {
            var sp = (from a in dc.Purchases
                      join ord in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ord.OrderIDToMC
                      join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                      join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                      where a.PurchaseID == Convert.ToDecimal(lnk.CommandArgument)
                      select ords.NetAmount).Sum();
            var sa = (from a in dc.Purchases
                      join ord in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ord.OrderIDToMC
                      join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                      join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                      where a.PurchaseID == Convert.ToDecimal(lnk.CommandArgument)
                      select ords.Amount).Sum();
            Purchase_Invoice si = new Purchase_Invoice
            {
                PurchaseID = Convert.ToDecimal(lnk.CommandArgument),
                Price = sp,
                Quantity = sa,
                pInvoiceDate = DateTime.Now
            };
            dc.Purchase_Invoices.InsertOnSubmit(si);
            dc.SubmitChanges();
        }
        var medicalstore = from a in dc.Purchases
                           join ord in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ord.OrderIDToMC
                           join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                           join medical in dc.Medicine_Companies on ord.MedicineCompanyID equals medical.MedicineCompanyID
                           join medi in dc.Medicine_In_Stocks on ords.MedicineID equals medi.MedicineID
                           where a.PurchaseID == Convert.ToInt32(lnk.CommandArgument)
                           select new { medical.MedicineCompanyName, medical.Phone, medical.Address, medical.Email };
        lblStoreName.Text = medicalstore.First().MedicineCompanyName;
        lblPhone.Text = Convert.ToString(medicalstore.First().Phone);
        lblAddress.Text = medicalstore.First().Address;
        lblemail.Text = medicalstore.First().Email;
        var sale = from a in dc.Purchase_Invoices
                   where a.PurchaseID == Convert.ToInt32(lnk.CommandArgument)
                   select new { a.Price, a.pInvoiceDate };
        var net = (from a in dc.Purchases
                   join ord in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ord.OrderIDToMC
                   join ords in dc.Order_To_Medicine_Company_Per_Medicines on ord.OrderIDToMC equals ords.OrderIDToMC
                   where a.PurchaseID == Convert.ToInt32(lnk.CommandArgument)
                   select ords.NetAmount).Sum();
        lblAmount.Text = Convert.ToString(net);//Convert.ToString( NetTotal); //Convert.ToString(sale.First().Price);
        lblDate.Text = Convert.ToString(sale.First().pInvoiceDate);
        gvInvoice.DataSource = s;
        gvInvoice.DataBind();
        ModalPopupExtender1.Show();
    }
    protected void gvInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // add the UnitPrice and QuantityTotal to the running total variables
            priceTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            Price = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
            quantityTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Amount"));
           // discountPercantageTotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Discount"));
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
            //e.Row.Cells[7].Text = discountPercantageTotal.ToString();
            //e.Row.Cells[8].Text = discountAmount.ToString();
            e.Row.Cells[7].Text = NetTotal.ToString();

            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            //e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
            //e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
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
    protected void gvPurchases_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPurchases.PageIndex = e.NewPageIndex;
        gvPurchases.DataBind();
        BindGridDatapurchases();
    }
    TextBox returnAmount;
    protected void cvReturnAmount_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            returnAmount = (gvrow.FindControl("txtAddReturn") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("^[0-9]+$");
        args.IsValid = r.IsMatch(returnAmount.Text);
    }
    protected void ddlMedicineCompanyName_DataBound(object sender, EventArgs e)
    {
        ddlMedicineCompanyName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
    }
    protected void ddlMedicineCompanyName_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGridDatapurchases();
    }
}