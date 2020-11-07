using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Reflection;
using System.Drawing;
public partial class admin_Default : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    int chk1 = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
       
            if (Session["AdminUserID"] != null)
            {

                if (!IsPostBack)
                {
                    BindGridDataOrders();
                    BindGridDataMedicinesToOrder();
                }
            }
            else
            {
                Response.Redirect("../startbootstrap/main.aspx");
            }
        
    }
    void BindGridDataOrders()
    {
        if (ddlMedicineCompany.SelectedValue == "0" || ddlMedicineCompany.SelectedValue == string.Empty)
        {
            var s = from obm in dc.Order_To_Medicine_Companies
                    join m in dc.Medicine_Companies on obm.MedicineCompanyID equals m.MedicineCompanyID
                    orderby obm.OrderIDToMC  descending
                    select new
                    {
                        obm.OrderIDToMC,
                        obm.Due_Date,
                        obm.Status,
                        m.MedicineCompanyName,
                        obm.Order_Date,
                        obm.Placed_By
                    };
            gvOrders.DataSource = s;
            gvOrders.DataBind();
            //gvViewOrderDetails.DataSource = s;
            //gvViewOrderDetails.DataBind();
        }
        else
        {
            var s = from obm in dc.Order_To_Medicine_Companies
                    join m in dc.Medicine_Companies on obm.MedicineCompanyID equals m.MedicineCompanyID
                    where m.MedicineCompanyName == ddlMedicineCompany.SelectedValue
                    orderby obm.OrderIDToMC descending
                    select new
                    {
                        obm.OrderIDToMC,
                        obm.Due_Date,
                        obm.Status,
                        m.MedicineCompanyName,
                        obm.Order_Date,
                        obm.Placed_By
                    };
            gvOrders.DataSource = s;
            gvOrders.DataBind();
        }
    }
    void BindGridDataMedicinesToOrder()
    {
        if (ddlMedicineCompany.SelectedValue == "0" || ddlMedicineCompany.SelectedValue == string.Empty)
        {
            var s = from mis in dc.Medicine_In_Stocks
                    group mis by mis.MedicineName into g
                    join mc in dc.Medicine_Companies on g.First().MedicineCompanyID equals mc.MedicineCompanyID
                    select new
                    {
                        MedicineName = (g.OrderBy(p => p.MedicineName).FirstOrDefault()).MedicineName,
                        Price = g.First().Price,
                        MedicineCompanyName = mc.MedicineCompanyName
                    };
            gvPlaceOrder.DataSource = s;
            gvPlaceOrder.DataBind();
        }
        else if (ddlMedicineCompany.SelectedValue != "0" || ddlMedicineCompany.SelectedValue != string.Empty)
        {
            var s = from mis in dc.Medicine_In_Stocks
                    group mis by mis.MedicineName into g
                    join mc in dc.Medicine_Companies on g.First().MedicineCompanyID equals mc.MedicineCompanyID
                    where mc.MedicineCompanyName==ddlMedicineCompany.SelectedValue
                    select new
                    {
                        MedicineName = (g.OrderBy(p => p.MedicineName).FirstOrDefault()).MedicineName,
                        Price = g.First().Price,
                        MedicineCompanyName = mc.MedicineCompanyName
                    };
            gvPlaceOrder.DataSource = s;
            gvPlaceOrder.DataBind();
          
        }
        
    }
    void placeOrder(string name, string quantity)
    {

        int? MedicineCompanyID = 0;
        string MedicineCompanyName = ddlMedicineCompany.SelectedItem.Text;
        int? MedicineID = 0;
        dc.GetMedicineID(name, ref MedicineID);
        dc.GetMedicineCompanyID(MedicineCompanyName, ref MedicineCompanyID);
        if (chk1 == 1)
        {
            var username = (from a in dc.Users
                           where a.UserId == Convert.ToInt32(Session["AdminUserID"])
                           select a.Username).Single();
            Order_To_Medicine_Company obms = new Order_To_Medicine_Company
            {
                MedicineCompanyID = MedicineCompanyID,
                Due_Date = Convert.ToDateTime(txtDueDate.Text),
                Order_Date = DateTime.Now,
                Placed_By = Convert.ToString(username),
                Status = "Pending"
            };
            dc.Order_To_Medicine_Companies.InsertOnSubmit(obms);
            dc.SubmitChanges();
        }
        var s = dc.Order_To_Medicine_Companies
                 .OrderByDescending(m => m.OrderIDToMC)
                 .FirstOrDefault();
        Order_To_Medicine_Company_Per_Medicine obmsm = new Order_To_Medicine_Company_Per_Medicine
        {
            MedicineID = MedicineID,
            Amount = Convert.ToInt32(quantity),
            OrderIDToMC = Convert.ToDecimal(s.OrderIDToMC)
        };
        dc.Order_To_Medicine_Company_Per_Medicines.InsertOnSubmit(obmsm);
        dc.SubmitChanges();
       
    }
    protected void ddlMedicineCompany_DataBound(object sender, EventArgs e)
    {
        ddlMedicineCompany.Items.Insert(0, new ListItem("All", "0"));
    }
    protected void ddlMedicineCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGridDataOrders();
        BindGridDataMedicinesToOrder();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        bool requiredcheck = false;
        bool numbercheck = false;
        if (ddlMedicineCompany.SelectedValue != "0" && ddlMedicineCompany.SelectedValue != string.Empty)
        {
            foreach (GridViewRow row in gvPlaceOrder.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chk = (row.Cells[0].FindControl("chkOrder") as CheckBox);
                    if (chk.Checked)
                    {
                        string quantity = ((TextBox)(row.Cells[4].FindControl("txtQuantity"))).Text;
                        if (string.IsNullOrWhiteSpace(quantity))
                        {
                            requiredcheck = true;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequired"))).Visible = true;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequired"))).Text = "Required";
                        }
                        else
                        {
                            ((Label)(row.Cells[4].FindControl("lbltxtRequired"))).Visible = false;
                        }
                        int parsedValue;
                        if (!int.TryParse(((TextBox)(row.Cells[4].FindControl("txtQuantity"))).Text, out parsedValue))
                        {
                            numbercheck = true;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequired"))).Visible = true;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequired"))).Text = "This is Number field";
                            // MessageBox.Show("This is a number only field");
                            //return;
                        }
                        else
                        {
                            ((Label)(row.Cells[4].FindControl("lbltxtRequired"))).Visible = false;
                        }
                        string name = row.Cells[1].Text;
                        //string price = row.Cells[2].Text;
                        //string company = row.Cells[3].Text;
                        //string quantity = ((TextBox)(row.Cells[4].FindControl("txtQuantity"))).Text;
                        chk1++;
                        if (quantity.ToString() != string.Empty && requiredcheck==false && numbercheck==false)
                        {
                            placeOrder(name, quantity);
                            lblmustselect.Text = "---------------------------------------------------------------------------------Order Placed--------------------------------------------------------------------------------------------------";
                            lblmustselect.ForeColor = Color.Green;
                            //string message = "Order Placed";
                            //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                        }
                        else
                        {
                            lblmustselect.Visible = false;
                            string message = "not yet";
                            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                        }



                        //data = data + name + " , " + price +" , "+company+quantity+ "<br>";
                    }
                }
                //foreach (Control ctrl in form1.Controls) 
                //{
                //    if (ctrl.GetType() == typeof(TextBox)) 
                //    {
                //        ((TextBox)(ctrl)).Text = string.Empty;
                //    }
                //}
                BindGridDataOrders();
            }
            //lbltest.Text = "executed";
            //var s = dc.Order_By_Medical_Stores
            //		 .OrderByDescending(m => m.OrderIDByMS)
            //		 .FirstOrDefault();
            //lblerr.Text = data;

            //test = s.ToString();
            //lbltest.Text = Convert.ToString(s.OrderIDByMS);
            CheckState(false);
            ClearGridText();
        }
        else 
        {
            lblmustselect.Text = "           You Must select Company Name";
        }
    }
    private void CheckState(bool p)
    {
        foreach (GridViewRow row in gvPlaceOrder.Rows)
        {
            CheckBox chkcheck = (CheckBox)row.FindControl("chkOrder");
            chkcheck.Checked = p;
        }
    }
    private void ClearGridText()
    {
        foreach (GridViewRow row in gvPlaceOrder.Rows)
        {
            TextBox txt = (TextBox)row.FindControl("txtQuantity");
            txt.Text = string.Empty;
        }
    }
    protected void lnkView_Click(object sender, EventArgs e)
    {
        LinkButton lnkview = (LinkButton)sender;
        var s = from obmp in dc.Order_To_Medicine_Company_Per_Medicines
                join m in dc.Medicine_In_Stocks on obmp.MedicineID equals m.MedicineID
                where obmp.OrderIDToMC == Convert.ToInt32(lnkview.CommandArgument)
                select new
                {
                    //obmp.OrderIDMSPerMedicine,
                    m.MedicineName,
                    obmp.Amount
                };
        gvViewOrderDetails.DataSource = s;
        gvViewOrderDetails.DataBind();
        mp1.Show();
    }
    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;

            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }

        return newSortDirection;
    }
    protected void gvOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOrders.PageIndex = e.NewPageIndex;
        gvOrders.DataBind();
        BindGridDataOrders();
    }
    //TextBox txt
    protected void lnkDeliver_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        
        var gvrow = (GridViewRow)lnk.NamingContainer;
        //if (gvrow != null)
        //{
        //    txtReturn = (gvrow.FindControl("txtAddReturn") as TextBox);
        //}
        //var s = from a in dc.Order_By_Medical_Stores
        var o = from or in dc.Order_To_Medicine_Companies
                where or.OrderIDToMC == Convert.ToInt32(lnk.CommandArgument)
                select or;
        var gvBatchentry = from a in dc.Order_To_Medicine_Company_Per_Medicines
                join ordertocompany in dc.Order_To_Medicine_Companies on a.OrderIDToMC equals ordertocompany.OrderIDToMC
                join medi in dc.Medicine_In_Stocks on a.MedicineID equals medi.MedicineID
                where a.OrderIDToMC == Convert.ToInt32(lnk.CommandArgument)
                select new 
                {
                   a.OrderIDToMC,
                   medi.MedicineName,
                   a.Amount
                };
        this.gvAddBatchNumber.Columns[0].Visible = false;
        gvAddBatchNumber.DataSource = gvBatchentry;
        gvAddBatchNumber.DataBind();

        //foreach (Order_To_Medicine_Company om in o)
        //{
        //    om.Status = "Delivered";
        //}
        //try
        //{
        //    dc.SubmitChanges();
        //}
        //catch (Exception ex)
        //{
        //    lblch.Text = ex.ToString();
        //}
        //Purchase s = new Purchase
        //{
        //    Date = DateTime.Now,
        //    OrderIDToMC = Convert.ToInt32(lnk.CommandArgument)
        //};
        //dc.Purchases.InsertOnSubmit(s);
        //dc.SubmitChanges();
        //BindGridDataOrders();
        ModalPopupExtender1.Show();
        //if()
    }
    protected void gvPlaceOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPlaceOrder.PageIndex = e.NewPageIndex;
        gvPlaceOrder.DataBind();
        BindGridDataMedicinesToOrder();
    }
    
    protected void btnSearchMedicine_ServerClick(object sender, EventArgs e)
    {
        string search = txtSearchMedicine.Text;
        var s = from a in dc.Medicine_In_Stocks
                join medicompany in dc.Medicine_Companies on a.MedicineCompanyID equals medicompany.MedicineCompanyID
                where a.MedicineName.Contains(search)
                select new
                {
                    //a.MedicineID,
                    a.MedicineName,
                    a.Price,
                    //a.ManufactureDate,
                    //a.ExpiryDate,
                    medicompany.MedicineCompanyName
                    //a.Amount,
                    //medicat.MedicineCategoryName
                };
        //this.gvMed//.Columns[0].Visible = false;
        gvPlaceOrder.DataSource = s;
        gvPlaceOrder.DataBind();
    }
    Label lblOrderIDToMC;
    Label lblmediname;
    Label lblAmount;
    TextBox txtPrice;
    protected void btnSaveMedicine_Click(object sender, EventArgs e)
    {

        Page.Validate();
        //if (Page.IsValid)
        //{
            if (customIsValid)
            {
                int? medicineid = 0;
                // int? newMedicineID=0;
                // bool flag = false;
                //  Button lnk = (Button)sender;
                // var gvrow = (GridViewRow)lnk.NamingContainer;
                foreach (GridViewRow gvrow in gvAddBatchNumber.Rows)
                {
                    lblOrderIDToMC = ((Label)gvrow.Cells[0].FindControl("lblOrderIDToMC"));
                    lblmediname = ((Label)gvrow.Cells[1].FindControl("lblMedicineName"));
                    lblAmount = ((Label)gvrow.Cells[2].FindControl("lblMedicineQuantity"));
                    TextBox txtBatch = ((TextBox)gvrow.Cells[4].FindControl("txtBatchNumber"));
                    TextBox txtManufactureDate = ((TextBox)gvrow.Cells[5].FindControl("AddtxtManufactureDate"));
                    TextBox txtExpiryDate = ((TextBox)gvrow.Cells[6].FindControl("AddtxtExpiryDate"));
                    TextBox txtPackSize = ((TextBox)gvrow.Cells[7].FindControl("txtPackSize"));
                    txtPrice = ((TextBox)gvrow.Cells[3].FindControl("txtPrice"));
                    // dc.GetMaxMedicineID(lblmediname.Text,ref medicineid);
                    var getCompany = (from a in dc.Medicine_In_Stocks
                                      where a.MedicineName == lblmediname.Text
                                      select a).First();
                    //var getmediInfo = from a in dc.Medicine_In_Stocks
                    //                  where a.MedicineName == lblmediname.Text
                    //                  select a;
                    //foreach (Medicine_In_Stock item in  getmediInfo)
                    //{
                    //    item.Price =Convert.ToDecimal( txtPrice.Text);
                    //}
                    //try
                    //{
                    //    dc.SubmitChanges();
                    //}
                    //catch (Exception ex)
                    //{

                    //    lblch.Text = ex.ToString();
                    //}
                    if (gvrow.RowType == DataControlRowType.DataRow)
                    {
                        Medicine_In_Stock ms = new Medicine_In_Stock
                        {
                            MedicineName = lblmediname.Text,

                            Amount = Convert.ToInt32(lblAmount.Text),
                            BatchNo = txtBatch.Text,
                            ManufactureDate = Convert.ToDateTime(txtManufactureDate.Text),
                            ExpiryDate = Convert.ToDateTime(txtExpiryDate.Text),
                            PackSize = txtPackSize.Text,
                            Price = Convert.ToDecimal(txtPrice.Text),
                            MedicineCategoryID = getCompany.MedicineCategoryID,
                            MedicineCompanyID = getCompany.MedicineCompanyID,
                            Image = getCompany.Image,
                            Description = getCompany.Description

                        };
                        dc.Medicine_In_Stocks.InsertOnSubmit(ms);
                        dc.SubmitChanges();
                        dc.GetMaxMedicineID(lblmediname.Text, ref medicineid);
                        // Label lb = (gvrow.Cells[0].FindControl("lblOrderIDtoMC") as Label);
                        //var s = (from a in dc.Order_To_Medicine_Company_Per_Medicines
                        //        join medi in dc.Medicine_In_Stocks on a.MedicineID equals medi.MedicineID
                        //        where a.OrderIDToMC == Convert.ToInt32(lb.Text) && medi.MedicineName==Convert.ToString ((Label)gvrow.Cells[1].FindControl("lblMedicineName"))
                        //        select medi.BatchNo).Single();
                        // if (s == Convert.ToString((Label)gvrow.Cells[2].FindControl("txtBatchNumber")))
                        // {
                        //var sub = dc.Medicine_In_Stocks
                        //          .Where(m => m.MedicineName == Convert.ToString((Label)gvrow.Cells[1].FindControl("lblMedicineName")) && m.BatchNo == Convert.ToString((Label)gvrow.Cells[2].FindControl("txtBatchNumber")))
                        //          .FirstOrDefault();
                        //int q = Convert.ToInt32(sub.Amount);
                        // int q = Convert.ToInt32((Label)gvrow.Cells[2].FindControl("lblMedicineQuantity"));
                        //// int.TryParse(quantity, out q);
                        //var mediInStock = from m in dc.Medicine_In_Stocks
                        //           where m.MedicineName == Convert.ToString((Label)gvrow.Cells[1].FindControl("lblMedicineName")) && m.BatchNo == Convert.ToString((Label)gvrow.Cells[2].FindControl("txtBatchNumber"))
                        //           select m;
                        //foreach (Medicine_In_Stock mis in mediInStock)
                        //{
                        //    mis.Amount = q;


                        //};
                        //try
                        //{
                        //    dc.SubmitChanges();
                        //}
                        //catch (Exception ex)
                        //{
                        //    lblerr.Text = ex.ToString();
                        //}
                        //if (flag == false)
                        //{

                        //}
                        //}

                    }
                }

                var o = from or in dc.Order_To_Medicine_Companies
                        where or.OrderIDToMC == Convert.ToInt32(lblOrderIDToMC.Text)
                        select or;
                foreach (Order_To_Medicine_Company om in o)
                {
                    om.Status = "Delivered";

                }
                try
                {
                    dc.SubmitChanges();
                }
                catch (Exception ex)
                {
                    lblch.Text = ex.ToString();
                }
                decimal id = 0;
                var ordermedi = from or in dc.Order_To_Medicine_Company_Per_Medicines
                                //join ord in dc.Order_To_Medicine_Company_Per_Medicines on or.OrderIDToMC equals ord.OrderIDToMC
                                //join mediname in dc.Medicine_In_Stocks on ord.MedicineID equals mediname.MedicineID
                                where or.OrderIDToMC == Convert.ToInt32(lblOrderIDToMC.Text)
                                select or;
                foreach (Order_To_Medicine_Company_Per_Medicine item in ordermedi)
                {
                    var a = (from s in dc.Medicine_In_Stocks
                             where s.MedicineID == item.MedicineID //&& s.MedicineName == lblmediname.Text
                             select s.MedicineID).First();
                    if (a > 0)
                    {
                        id = a;
                        break;
                    }
                }
                var orderidmedi = from or in dc.Order_To_Medicine_Company_Per_Medicines
                                  // join ord in dc.Order_To_Medicine_Company_Per_Medicines on or.OrderIDToMC equals ord.OrderIDToMC
                                  //join mediname in dc.Medicine_In_Stocks on ord.MedicineID equals mediname.MedicineID
                                  where or.OrderIDToMC == Convert.ToInt32(lblOrderIDToMC.Text) && or.MedicineID == id
                                  select or;
                foreach (Order_To_Medicine_Company_Per_Medicine item in orderidmedi)
                {
                    item.MedicineID = medicineid;
                    item.NetAmount = (Convert.ToInt32(lblAmount.Text) * Convert.ToDecimal(txtPrice.Text));
                }
                try
                {
                    dc.SubmitChanges();
                }
                catch (Exception ex)
                {

                    lblerr.Text = ex.ToString();
                }
                Purchase sp = new Purchase
                {
                    Date = DateTime.Now,
                    OrderIDToMC = Convert.ToInt32(lblOrderIDToMC.Text)
                };
                // flag = true;
                dc.Purchases.InsertOnSubmit(sp);
                dc.SubmitChanges();
                var sname = (from a in dc.Order_To_Medicine_Companies
                             join medi in dc.Medicine_Companies on a.MedicineCompanyID equals medi.MedicineCompanyID
                             where a.OrderIDToMC == Convert.ToInt32(lblOrderIDToMC.Text)
                             select medi.MedicineCompanyName).First();
                Transaction tc = new Transaction
                {
                    Order_ = Convert.ToInt32(lblOrderIDToMC.Text),
                    Date = DateTime.Now.Date,
                    Time = Convert.ToDateTime(DateTime.Now),
                    Type = "Purchase from Company",
                    Client_Supplier = sname
                };
                dc.Transactions.InsertOnSubmit(tc);
                dc.SubmitChanges();
                BindGridDataOrders();
//}
        }
    }
    protected void btnSaveDetail_Click(object sender, EventArgs e)
    {

    }
    TextBox txtAmount;
    //protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    //{
    //    CustomValidator btn = (CustomValidator)source;
    //    var gvrow = (GridViewRow)btn.NamingContainer;
    //    if (gvrow != null)
    //    {
    //        txtAmount = (gvrow.FindControl("txtQuantity") as TextBox);
    //    }
    //    System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("^[0-9]+$");
    //    args.IsValid = r.IsMatch(txtAmount.Text);
    //}
    //protected void btntest_Click(object sender, EventArgs e)
    //{
    //    string message = "Order Placed";
    //    ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
    //}
    public bool customIsValid
    {

        get;
        set;

    }
    TextBox edittxtManufactureDate;
    TextBox edittxtExpiryDate;
    protected void cvExpiryDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator cv = (CustomValidator)source;
        // txtaddManufactureDate = (TextBox)cv.FindControl("addtxtManufactureDate");
        //txtaddExpDate = (TextBox)cv.FindControl("addtxtExpiryDate");
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            edittxtManufactureDate = (gvrow.FindControl("AddtxtManufactureDate") as TextBox);
            edittxtExpiryDate = (gvrow.FindControl("AddtxtExpiryDate") as TextBox);
        }
        if (Convert.ToDateTime(edittxtExpiryDate.Text).Date <= Convert.ToDateTime(edittxtManufactureDate.Text).Date)
        {
            //.Text = "Invalid expiryDate";
            args.IsValid = false;
            customIsValid = false;
        }
        else
        {
            customIsValid = true;
        }

    }
    TextBox txteditPrice;
    protected void Unnamed_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            txteditPrice = (gvrow.FindControl("txtPrice") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"^[0-9]{0,6}(\.[0-9]{1,2})?$");
        args.IsValid = r.IsMatch(txteditPrice.Text);
    }
}