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
public partial class admin_Default : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
        if (!IsPostBack)
        {
            var st = from a in dc.Sales_Invoices
                     join sale in dc.Sales on a.SaleID equals sale.SaleID
                     join order in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals order.OrderIDByMS
                     //join medicalstore in dc.Medical_Stores on order.OrderIDByMS equals medicalstore.MedicalStoreID
                     where Convert.ToDateTime(a.sInvoiceDate).Month == 4
                     select new
                     {
                         SaleInvoice = a.sInvoiceID,
                         SaleInvoiceDate = a.sInvoiceDate,
                         //MedicalStoreName = medicalstore.MedicalStoreName,
                         StoreEmployee = order.Placed_By,
                         Quantity = a.Quantity,
                         Price = a.Price
                     };
            //var st=from a in dc.Purchase_Returns
            //       select a;
            ////gvtest.DataSource = st;
            ////gvtest.DataBind();
            var s = from a in dc.Sales_Invoices
                    
                    
                   group a by Convert.ToDateTime(a.sInvoiceDate).Year into grpYear
                    
                    orderby Convert.ToDateTime(grpYear.First().sInvoiceDate).Year
                    
                    select new
                    {
                        Year=Convert.ToDateTime(grpYear.First().sInvoiceDate).Year,
                        TotalSales=grpYear.Select(x=>x.SaleID).Count(),
                       TotalQuantity=grpYear.Select(x=>x.Quantity).Sum(),
                       TotalPrice=grpYear.Select(x=>x.Price).Sum()
                    };
            gvReport.DataSource = s;
            gvReport.DataBind();
            //var sr = from a in dc.Sales_Return_Invoices
            //        // join sales in dc.Sales
            //        // join ord in dc.Order_By_Medical_Stores on a.OrderID equals ord.OrderIDByMS
            //         //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
            //        // group new { a, ords } by new { (Convert.ToDateTime(a.Date)).Year, ords.OrderIDByMS } into grpYear
            //         group a by Convert.ToDateTime(a.srInvoiceDate).Year into grpYear

            //         orderby Convert.ToDateTime(grpYear.First().srInvoiceDate).Year

            //         select new
            //         {
            //             sYear = Convert.ToDateTime(grpYear.First().srInvoiceDate).Year,
            //             sTotalSales = grpYear.Select(x => x.SaleReturnID).Count(),
            //             sTotalQuantity = grpYear.Select(x => x.Quantity).Sum(),
            //             sTotalPrice = grpYear.Select(x => x.Price).Sum()
            //         };
            //gvSaleReturnReport.DataSource = sr;
            //gvSaleReturnReport.DataBind();
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
           
            var s = from a in dc.Sales_Invoices
                    group a by Convert.ToDateTime(a.sInvoiceDate).Month into grpMonth

                    orderby Convert.ToDateTime(grpMonth.First().sInvoiceDate).Year

                    select new
                    {
                        Month = Convert.ToDateTime(grpMonth.First().sInvoiceDate),
                        TotalSales = grpMonth.Select(x => x.SaleID).Count(),
                        TotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
                        TotalPrice = grpMonth.Select(x => x.Price).Sum()
                    };
            gv_Child.DataSource = s;
            gv_Child.DataBind();
           
        }
    }
    //protected void gvSaleReturnReport_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Label lblYear = (Label)e.Row.FindControl("slblYear");
    //        GridView gv_Childs = (GridView)e.Row.FindControl("gvSaleReturnChild");
            
    //        var s = from a in dc.Sales_Return_Invoices

    //                //join ord in dc.Order_By_Medical_Stores on a.OrderIDByMS equals ord.OrderIDByMS
    //                //join ords in dc.Order_by_Medical_Store_Per_Medicines on ord.OrderIDByMS equals ords.OrderIDByMS
    //                //group new { a,ords } by new { (Convert.ToDateTime(a.Date)).Year,ords.OrderIDByMS } into grpYear
    //                group a by Convert.ToDateTime(a.srInvoiceDate).Month into grpMonth

    //                orderby Convert.ToDateTime(grpMonth.First().srInvoiceDate).Year

    //                select new
    //                {
    //                    sMonth = Convert.ToDateTime(grpMonth.First().srInvoiceDate),
    //                    sTotalSales = grpMonth.Select(x => x.SaleReturnID).Count(),
    //                    sTotalQuantity = grpMonth.Select(x => x.Quantity).Sum(),
    //                    sTotalPrice = grpMonth.Select(x => x.Price).Sum()
    //                };
    //        gv_Childs.DataSource = s;
    //        gv_Childs.DataBind();

    //    }
    //}
    Label month;
    protected void gv_Child_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //GridView gv=(GridView)sender;
        //var gvrow = (GridViewRow)gv.NamingContainer;
        //if (gvrow != null) 
        //{
        //    month = ( gvrow.FindControl("lblMonth") as Label);
        //}
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
            var s = from a in dc.Sales_Invoices
                    join sale in dc.Sales on a.SaleID equals sale.SaleID
                    join order in dc.Order_By_Medical_Stores on sale.OrderIDByMS equals order.OrderIDByMS
                    join medicalstore in dc.Medical_Stores on order.MedicalStoreID equals medicalstore.MedicalStoreID
                    where Convert.ToDateTime(a.sInvoiceDate).Month ==Convert.ToDateTime(month.Text).Month
                    select new
                    {
                        SaleInvoice = a.sInvoiceID,
                        SaleInvoiceDate = a.sInvoiceDate,
                        MedicalStoreName = medicalstore.MedicalStoreName,
                        StoreEmployee = order.Placed_By,
                        Quantity = a.Quantity,
                        Price = a.Price
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
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void btnexport_Click(object sender, EventArgs e)
    {
        
        //Response.ContentType = "application/pdf";
        //Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter hw = new HtmlTextWriter(sw);
        //panel1.RenderControl(hw);
        //StringReader sr = new StringReader(sw.ToString());
        //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //pdfDoc.Open();
        //htmlparser.Parse(sr);
        //pdfDoc.Close();
        //Response.Write(pdfDoc);
        //Response.End();
        //Response.ContentType = "application/pdf";
        //Response.ContentType = "application/pdf";
        //Response.ContentType = "application/pdf";
        //Response.AddHeader("content-disposition",
        //    "attachment;filename=GridViewExport.pdf");
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter hw = new HtmlTextWriter(sw);
        //GridView1.AllowPaging = false;
        //GridView1.DataBind();
        //GridView1.RenderControl(hw);
        //panel1.RenderControl(hw);
        //StringReader sr = new StringReader(sw.ToString());
        //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //pdfDoc.Open();
        //htmlparser.Parse(sr);
        //pdfDoc.Close();
        //Response.Write(pdfDoc);
        //Response.End(); 
        //server folder path which is stored your PDF documents
    //       string path = Server.MapPath("PDF-Files");
    //        string imagepath = Server.MapPath("Images");
    //       string filename = path + "/Doc1.pdf"; 
    //       //Create new PDF document
    //       Document document = new Document(PageSize.A4, 20f, 20f, 20f, 20f);
    //try
    //{
    //    PdfWriter.GetInstance(document, new FileStream(filename, FileMode.Create)); 
    //    //Create object for image
    //    iTextSharp.text.Image gif = iTextSharp.text.Image.GetInstance(imagepath + "/plus.jpg");
    //     iTextSharp.text.Image gif1 =iTextSharp.text.Image.GetInstance(imagepath+"/minus.jpg");
    //   // paragraph.Alignment = Element.ALIGN_JUSTIFIED;   
    //    document.Open();
    //    document.Add(gif);
    //    document.Add(;
        //Response.Clear();
        //Response.Buffer = true;
        //Response.AddHeader("content-disposition",
        // "attachment;filename=GridViewExport.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-excel";
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter hw = new HtmlTextWriter(sw);
        // gvReport.AllowPaging = false;
        //gvReport.DataBind();
        //for (int i = 0; i < gvReport.Rows.Count; i++)
        //{
        //    GridViewRow row = gvReport.Rows[i];
        //    //Apply text style to each Row
        //    row.Attributes.Add("class", "textmode");
        //}
        //gvReport.RenderControl(hw);

        ////style to format numbers to string
        //string style = @"<style> .textmode { mso-number-format:\@; } </style>";
        //Response.Write(style);
        //Response.Output.Write(sw.ToString());
        //Response.Flush();
        //Response.End();
        //Response.Clear();
        //Response.Buffer = true;
        //Response.AddHeader("content-disposition",
        //  "attachment;filename=GridViewExport.doc");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-word ";
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter hw = new HtmlTextWriter(sw);
        //gvtest.AllowPaging = false;
        //gvtest.DataBind();
        //gvtest.RenderControl(hw);
        //Response.Output.Write(sw.ToString());
        //Response.Flush();
        //Response.End();
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