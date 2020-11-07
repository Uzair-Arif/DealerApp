using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sb_admin_Default : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    int chk1 = 0;
   // private static int _clickedCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SaleUserID"] != null)
        {
            var s = (from a in dc.Users
                    where a.UserId == Convert.ToInt32(Session["SaleUserID"])
                     select a.Username).First();
            lblUserName.Text = s.ToString();
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
       // this.RegisterPostBackControl();
    }
    //private void RegisterPostBackControl()
    //{
    //    foreach (GridViewRow row in gvOrders.Rows)
    //    {
    //        LinkButton lnkFull = row.FindControl("lnkView") as LinkButton;
    //        ScriptManager.GetCurrent(this).RegisterPostBackControl(lnkFull);
    //    }
    //}
    void BindGridDataOrders()
    {
        if (ddlMedicalStore.SelectedValue == "0" || ddlMedicalStore.SelectedValue == string.Empty)
        {
            var s = from obm in dc.Order_By_Medical_Stores
                    join m in dc.Medical_Stores on obm.MedicalStoreID equals m.MedicalStoreID
                    orderby obm.OrderIDByMS descending
                    select new
                    {
                        obm.OrderIDByMS,
                        obm.Due_Date,
                        obm.Status,
                        m.MedicalStoreName,
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
            var s = from obm in dc.Order_By_Medical_Stores
                    join m in dc.Medical_Stores on obm.MedicalStoreID equals m.MedicalStoreID
                    where m.MedicalStoreName == ddlMedicalStore.SelectedValue
                    orderby obm.OrderIDByMS descending
                    select new
                    {
                        obm.OrderIDByMS,
                        obm.Due_Date,
                        obm.Status,
                        m.MedicalStoreName,
                        obm.Order_Date,
                        obm.Placed_By
                    };
            gvOrders.DataSource = s;
            gvOrders.DataBind();
        }
    }
    void BindGridDataMedicinesToOrder()
    {
        //int medicompanyid=0;
        var s = from mis in dc.Medicine_In_Stocks

                group mis by mis.MedicineName into g
                join mc in dc.Medicine_Companies on g.First().MedicineCompanyID equals mc.MedicineCompanyID
                //select g.OrderBy(p => p.MedicineName).First()
                select new 
                {
                   MedicineName = (g.OrderBy(p => p.MedicineName).FirstOrDefault()).MedicineName,
                   Price=g.First().Price,
                   MedicineCompanyName=mc.MedicineCompanyName
                };
       
                 //select new
                 //{
                 //    MedicineName=g.First(),
                 //    //mis.Amount,
                 //    Price=g.First(),
                 //   // mc.MedicineCompanyName
                 //});
        //var t = dc.Medicine_In_Stocks
        //      .Join(dc.Medicine_Companies,
        //      mis => mis.MedicineCompanyID,
        //      mc => mc.MedicineCompanyID,
        //      (mis, mc) => new { mis.MedicineName, mis.Price, mc.MedicineCompanyName })
        //      .GroupBy(mis => mis.MedicineName);
              
        gvPlaceOrder.DataSource =s ;
        gvPlaceOrder.DataBind();
    }
    void placeOrder(string name, string quantity,string discount)
    {
        //List<int> dlist = new List<int>();
        Dictionary<int, decimal> ddictionary = new Dictionary<int, decimal>();
        int? MedicalStoreID = 0;
        bool requiredMedicineAvailable = false;
        
        string MedicalStoreName = ddlMedicalStore.SelectedItem.Text;
        var samename=from a in dc.Medicine_In_Stocks
                     where a.MedicineName==name
                     select a;
        foreach (Medicine_In_Stock mediamount in samename)
        {
            if (mediamount.Amount - Convert.ToDecimal(quantity) >= 0) 
            {
               decimal df=Convert.ToDecimal( (mediamount.Amount - Convert.ToDecimal(quantity)));
                ddictionary.Add(Convert.ToInt32 (mediamount.MedicineID),df);
                requiredMedicineAvailable = true;
            }
            
        }
        if (requiredMedicineAvailable == true)   // Stock Available for to be delivered
        {
           var getleastkey = (from a in ddictionary
                               orderby a.Value
                               select a.Key).First();
            var getleastvalue = (from a in ddictionary
                                 orderby a.Value
                                 select a.Value).First();
            //var getBatch = (from a in dc.Medicine_In_Stocks
            //                   where a.MedicineID==getleastkey
            //                   orderby a.ExpiryDate

            //                   select a.BatchNo).First();
            // int? MedicineID = 0;
            // dc.GetMedicineID(name, ref MedicineID);
            // dc.GetMedicineIDByBatch(getBatch, ref MedicineID);
            dc.GetMedicalStoreID(MedicalStoreName, ref MedicalStoreID);
            if (chk1 == 1)
            {
                Order_By_Medical_Store obms = new Order_By_Medical_Store
                {
                    MedicalStoreID = MedicalStoreID,
                    Due_Date = Convert.ToDateTime(txtDueDate.Text),
                    Order_Date = DateTime.Now,
                    Placed_By = txtName.Text,
                    Status = "Pending"
                };
                dc.Order_By_Medical_Stores.InsertOnSubmit(obms);
                dc.SubmitChanges();
            }
            var s = dc.Order_By_Medical_Stores
                     .OrderByDescending(m => m.OrderIDByMS)
                     .FirstOrDefault();

            Order_by_Medical_Store_Per_Medicine obmsm = new Order_by_Medical_Store_Per_Medicine
            {
                MedicineID = getleastkey,
                Amount = Convert.ToInt32(quantity),
                Discount = Convert.ToInt32(discount),
                // DiscountAmount=(price*Convert.ToInt32 (discount))/100,
                //NetAmount=price-((price*Convert.ToInt32 (discount))/100),         
                OrderIDByMS = Convert.ToDecimal(s.OrderIDByMS)
            };
            dc.Order_by_Medical_Store_Per_Medicines.InsertOnSubmit(obmsm);
            dc.SubmitChanges();


            var price = (from a in dc.Medicine_In_Stocks
                         join b in dc.Order_by_Medical_Store_Per_Medicines on a.MedicineID equals b.MedicineID
                         where b.OrderIDByMS == s.OrderIDByMS && a.MedicineID == Convert.ToInt32(getleastkey)
                         select a.Price).Single();
            var orpm = from a in dc.Order_by_Medical_Store_Per_Medicines
                       where a.OrderIDByMS == Convert.ToDecimal(s.OrderIDByMS) && a.MedicineID == Convert.ToInt32(getleastkey)
                       select a;
            foreach (Order_by_Medical_Store_Per_Medicine orp in orpm)
            {
                orp.DiscountAmount = ((price * orp.Amount) * Convert.ToInt32(discount)) / 100;
                orp.NetAmount = (price * orp.Amount) - (((price * orp.Amount) * Convert.ToInt32(discount)) / 100);
            };
            try
            {
                dc.SubmitChanges();
            }
            catch (Exception ex)
            {
               // lblerr.Text = ex.ToString();
            }
            var sub = dc.Medicine_In_Stocks
                      .Where(m => m.MedicineID == getleastkey)
                      .FirstOrDefault();
            int q = Convert.ToInt32(sub.Amount);
            q = q - Convert.ToInt32(quantity);
            // int.TryParse(quantity, out q);
            var medi = from m in dc.Medicine_In_Stocks
                       where m.MedicineID == getleastkey
                       select m;
            foreach (Medicine_In_Stock mis in medi)
            {
                
                    if (q < 20)
                    {
                        Notification nf = new Notification
                        {
                            UserID = Convert.ToInt32(Session["SaleUserID"]),
                            Message = "New Order You have less of: " + mis.MedicineName + "having Batch#  " + mis.BatchNo,
                            Type = "Warning",
                            Status="Unseen",
                            OrderNumber = s.OrderIDByMS
                        };
                        dc.Notifications.InsertOnSubmit(nf);
                        dc.SubmitChanges();
                    }
                    else
                    {
                        Notification nf = new Notification
                        {
                            UserID = Convert.ToInt32(Session["SaleUserID"]),
                            Message = "You have new Order",
                            Type = "Order Placed",
                            Status = "Unseen",
                            OrderNumber = s.OrderIDByMS
                        };
                        dc.Notifications.InsertOnSubmit(nf);
                        dc.SubmitChanges();
                    }
                    mis.Amount = q;
                
                try
                {
                    dc.SubmitChanges();
                }
                catch (Exception ex)
                {
                   // lblerr.Visible = false;
                    //lblerr.Text = ex.ToString();
                }
            };
        }
        else
        {
             int? MedicineID = 0;
             dc.GetMedicineID(name, ref MedicineID);
             
             var medi = from m in dc.Medicine_In_Stocks
                       where m.MedicineID == MedicineID
                       select m;
             dc.GetMedicalStoreID(MedicalStoreName, ref MedicalStoreID);
             if (chk1 == 1)
             {
                 Order_By_Medical_Store obms = new Order_By_Medical_Store
                 {
                     MedicalStoreID = MedicalStoreID,
                     Due_Date = Convert.ToDateTime(txtDueDate.Text),
                     Order_Date = DateTime.Now,
                     Placed_By = txtName.Text,
                     Status = "Pending"
                 };
                 dc.Order_By_Medical_Stores.InsertOnSubmit(obms);
                 dc.SubmitChanges();
             }
             var s = dc.Order_By_Medical_Stores
                      .OrderByDescending(m => m.OrderIDByMS)
                      .FirstOrDefault();

             Order_by_Medical_Store_Per_Medicine obmsm = new Order_by_Medical_Store_Per_Medicine
             {
                 MedicineID = MedicineID,
                 Amount = Convert.ToInt32(quantity),
                 Discount = Convert.ToInt32(discount),
                 // DiscountAmount=(price*Convert.ToInt32 (discount))/100,
                 //NetAmount=price-((price*Convert.ToInt32 (discount))/100),         
                 OrderIDByMS = Convert.ToDecimal(s.OrderIDByMS)
             };
             dc.Order_by_Medical_Store_Per_Medicines.InsertOnSubmit(obmsm);
             dc.SubmitChanges();


             var price = (from a in dc.Medicine_In_Stocks
                          join b in dc.Order_by_Medical_Store_Per_Medicines on a.MedicineID equals b.MedicineID
                          where b.OrderIDByMS == s.OrderIDByMS && a.MedicineID == Convert.ToInt32(MedicineID)
                          select a.Price).Single();
             var orpm = from a in dc.Order_by_Medical_Store_Per_Medicines
                        where a.OrderIDByMS == Convert.ToDecimal(s.OrderIDByMS) && a.MedicineID == Convert.ToInt32(MedicineID)
                        select a;
             foreach (Order_by_Medical_Store_Per_Medicine orp in orpm)
             {
                 orp.DiscountAmount = ((price * orp.Amount) * Convert.ToInt32(discount)) / 100;
                 orp.NetAmount = (price * orp.Amount) - (((price * orp.Amount) * Convert.ToInt32(discount)) / 100);
             };
             try
             {
                 dc.SubmitChanges();
             }
             catch (Exception ex)
             {
                // lblerr.Text = ex.ToString();
             }
            foreach (Medicine_In_Stock mis in medi)
            {
           // mis.Amount = 0;
            Notification nf = new Notification
            {
                UserID = Convert.ToInt32(Session["SaleUserID"]),
                Message = "Medicine finished " + mis.MedicineName,
                Type = "Stock Ended",
                Status="Unseen",
                OrderNumber = s.OrderIDByMS
            };
            dc.Notifications.InsertOnSubmit(nf);
            dc.SubmitChanges();
            try
            {
                dc.SubmitChanges();
            }
            catch (Exception ex)
            {
               // lblerr.Visible = false;
                //lblerr.Text = ex.ToString();
            }
            };
           
        }

        
        
    }
    void placeOrder(string name, string quantity)
    {
        Dictionary<int, decimal> ddictionary = new Dictionary<int, decimal>();
        bool requiredMedicineAvailable = false;
        int? MedicalStoreID = 0;
        string MedicalStoreName = ddlMedicalStore.SelectedItem.Text;
       // int? MedicineID = 0;
        var samename = from a in dc.Medicine_In_Stocks
                       where a.MedicineName == name
                       select a;
        foreach (Medicine_In_Stock mediamount in samename)
        {
            if (mediamount.Amount - Convert.ToDecimal(quantity) >= 0)
            {
                decimal df = Convert.ToDecimal((mediamount.Amount - Convert.ToDecimal(quantity)));
                ddictionary.Add(Convert.ToInt32(mediamount.MedicineID), df);//first agr ID,second arg amount after subtraction
                requiredMedicineAvailable = true;
            }

        }
         if (requiredMedicineAvailable == true)   // Stock Available for to be delivered
        {
           var getleastkey = (from a in ddictionary
                               orderby a.Value
                               select a.Key).First();
            var getleastvalue = (from a in ddictionary
                                 orderby a.Value
                                 select a.Value).First();
            //var getBatch = (from a in dc.Medicine_In_Stocks
            //                   where a.MedicineID==getleastkey
            //                   orderby a.ExpiryDate

            //                   select a.BatchNo).First();
            // int? MedicineID = 0;
            // dc.GetMedicineID(name, ref MedicineID);
            // dc.GetMedicineIDByBatch(getBatch, ref MedicineID);
           // dc.GetMedicalStoreID(MedicalStoreName, ref MedicalStoreID);
        //dc.GetMedicineID(name, ref MedicineID);
        dc.GetMedicalStoreID(MedicalStoreName, ref MedicalStoreID);
        if (chk1 == 1)
        {
            Order_By_Medical_Store obms = new Order_By_Medical_Store
            {
                MedicalStoreID = MedicalStoreID,
                Due_Date = Convert.ToDateTime(txtDueDate.Text),
                Order_Date = DateTime.Now,
                Placed_By = txtName.Text,
                Status = "Pending"
            };
            dc.Order_By_Medical_Stores.InsertOnSubmit(obms);
            dc.SubmitChanges();
        }
        var s = dc.Order_By_Medical_Stores
                 .OrderByDescending(m => m.OrderIDByMS)
                 .FirstOrDefault();
        Order_by_Medical_Store_Per_Medicine obmsm = new Order_by_Medical_Store_Per_Medicine
        {
            MedicineID = getleastkey,
            Amount = Convert.ToInt32(quantity),
            Discount=0,
            OrderIDByMS = Convert.ToDecimal(s.OrderIDByMS)
        };
        dc.Order_by_Medical_Store_Per_Medicines.InsertOnSubmit(obmsm);
        dc.SubmitChanges();
        var price = (from a in dc.Medicine_In_Stocks
                     join b in dc.Order_by_Medical_Store_Per_Medicines on a.MedicineID equals b.MedicineID
                     where b.OrderIDByMS == s.OrderIDByMS && a.MedicineID == Convert.ToInt32(getleastkey)
                     select a.Price).Single();
        var orpm = from a in dc.Order_by_Medical_Store_Per_Medicines
                   where a.OrderIDByMS == Convert.ToDecimal(s.OrderIDByMS) && a.MedicineID == Convert.ToInt32(getleastkey)
                   select a;
        foreach (Order_by_Medical_Store_Per_Medicine orp in orpm)
        {
           // orp.DiscountAmount = ((price * orp.Amount) * Convert.ToInt32(discount)) / 100;
            orp.NetAmount = (price * orp.Amount);
        };
        try
        {
            dc.SubmitChanges();
        }
        catch (Exception ex)
        {
           // lblerr.Text = ex.ToString();
        }
        var sub = dc.Medicine_In_Stocks
                  .Where(m => m.MedicineID == getleastkey)
                  .FirstOrDefault();
        int q = Convert.ToInt32(sub.Amount);
        q = q - Convert.ToInt32(quantity);
        // int.TryParse(quantity, out q);
        var medi = from m in dc.Medicine_In_Stocks
                   where m.MedicineID == getleastkey
                   select m;
        foreach (Medicine_In_Stock mis in medi)
        {
            
                if (q < 20)
                {
                    Notification nf = new Notification
                    {
                            UserID = Convert.ToInt32(Session["SaleUserID"]),
                            Message = "New Order You have less of: " + mis.MedicineName + "having Batch#  " + mis.BatchNo,
                            Type = "Warning",
                            Status="Unseen",
                            OrderNumber = s.OrderIDByMS
                    };
                    dc.Notifications.InsertOnSubmit(nf);
                    dc.SubmitChanges();
                }
                else 
                {
                    Notification nf = new Notification
                    {
                        UserID = Convert.ToInt32(Session["SaleUserID"]),
                        Message = "You have new Order",
                        Type = "Order Placed",
                        Status = "Unseen",
                        OrderNumber=s.OrderIDByMS
                    };
                    dc.Notifications.InsertOnSubmit(nf);
                    dc.SubmitChanges();
                }
                mis.Amount = q;
                try
                {
                    dc.SubmitChanges();
                }
                catch (Exception ex)
                {
                   // lblerr.Visible = false;
                   // lblerr.Text = ex.ToString();
                }
        };
         }
         else
         {
             int? MedicineID = 0;
             dc.GetMedicineID(name, ref MedicineID);
             dc.GetMedicalStoreID(MedicalStoreName, ref MedicalStoreID);
             if (chk1 == 1)
             {
                 Order_By_Medical_Store obms = new Order_By_Medical_Store
                 {
                     MedicalStoreID = MedicalStoreID,
                     Due_Date = Convert.ToDateTime(txtDueDate.Text),
                     Order_Date = DateTime.Now,
                     Placed_By = txtName.Text,
                     Status = "Pending"
                 };
                 dc.Order_By_Medical_Stores.InsertOnSubmit(obms);
                 dc.SubmitChanges();
             }
             var s = dc.Order_By_Medical_Stores
                      .OrderByDescending(m => m.OrderIDByMS)
                      .FirstOrDefault();
             Order_by_Medical_Store_Per_Medicine obmsm = new Order_by_Medical_Store_Per_Medicine
             {
                 MedicineID = MedicineID,
                 Amount = Convert.ToInt32(quantity),
                 Discount = 0,
                 OrderIDByMS = Convert.ToDecimal(s.OrderIDByMS)
             };
             dc.Order_by_Medical_Store_Per_Medicines.InsertOnSubmit(obmsm);
             dc.SubmitChanges();
             var price = (from a in dc.Medicine_In_Stocks
                          join b in dc.Order_by_Medical_Store_Per_Medicines on a.MedicineID equals b.MedicineID
                          where b.OrderIDByMS == s.OrderIDByMS && a.MedicineID == Convert.ToInt32(MedicineID)
                          select a.Price).Single();
             var orpm = from a in dc.Order_by_Medical_Store_Per_Medicines
                        where a.OrderIDByMS == Convert.ToDecimal(s.OrderIDByMS) && a.MedicineID == Convert.ToInt32(MedicineID)
                        select a;
             foreach (Order_by_Medical_Store_Per_Medicine orp in orpm)
             {
                 // orp.DiscountAmount = ((price * orp.Amount) * Convert.ToInt32(discount)) / 100;
                 orp.NetAmount = (price * orp.Amount);
             };
             try
             {
                 dc.SubmitChanges();
             }
             catch (Exception ex)
             {
                // lblerr.Text = ex.ToString();
             }
             
             var medi = from m in dc.Medicine_In_Stocks
                        where m.MedicineID == MedicineID
                        select m;
             foreach (Medicine_In_Stock mis in medi)
             {
                 //mis.Amount = 0;
                 Notification nf = new Notification
                 {
                     UserID = Convert.ToInt32(Session["SaleUserID"]),
                     Message = "Medicine finished " + mis.MedicineName,
                     Type = "Stock Ended",
                     Status = "Unseen",
                     OrderNumber=s.OrderIDByMS
                 };
                 dc.Notifications.InsertOnSubmit(nf);
                 dc.SubmitChanges();
                 try
                 {
                     dc.SubmitChanges();
                 }
                 catch (Exception ex)
                 {
                  //   lblerr.Visible = false;
                    // lblerr.Text = ex.ToString();
                 }
             };

         }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        bool requiredcheck = false;
        bool numbercheck = false;
        bool checkddl = false;
        bool dsccheck = false;
        if (ddlMedicalStore.SelectedValue == "0" || ddlMedicalStore.SelectedValue == string.Empty)
        {
            checkddl = true;
           // lblerr.Text = "You Must Select Medical Store Name";
        }
        else 
        {
            //lblerr.Visible = false;
        }
        bool mecheck = false;
        if (!checkddl)
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
                            ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Visible = false;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequried"))).Visible = true;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequried"))).Text="Required";
                        }
                        else
                        {
                            ((Label)(row.Cells[4].FindControl("lbltxtRequried"))).Visible = false;
                            ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Visible = false;
                        }
                        int parsedValue;
                        if (!int.TryParse(((TextBox)(row.Cells[4].FindControl("txtQuantity"))).Text, out parsedValue))
                        {
                            numbercheck = true;
                            ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Visible = false;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequried"))).Visible = true;
                            ((Label)(row.Cells[4].FindControl("lbltxtRequried"))).Text = "This is Number field";
                           // MessageBox.Show("This is a number only field");
                            //return;
                        }
                        else
                        {
                            ((Label)(row.Cells[4].FindControl("lbltxtRequried"))).Visible = false;
                            ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Visible = false;
                        }
                        string name = row.Cells[1].Text;
                        //string price = row.Cells[2].Text;
                        //string company = row.Cells[3].Text;
                        //string quantity = ((TextBox)(row.Cells[4].FindControl("txtQuantity"))).Text;
                        string discount = ((TextBox)(row.Cells[5].FindControl("txtDiscount"))).Text;
                        chk1++;
                        int parsedValuedsc;
                        ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Visible = false;
                        if (!int.TryParse(((TextBox)(row.Cells[4].FindControl("txtDiscount"))).Text, out parsedValuedsc))
                        {
                            dsccheck = true;
                            ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Visible = true;
                            ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Text = "This is Number field";
                            // MessageBox.Show("This is a number only field");
                            //return;
                        }
                        else
                        {
                            ((Label)(row.Cells[5].FindControl("lbltxtRequried"))).Visible = false;
                        }
                        if (discount.ToString() != string.Empty && quantity.ToString() != string.Empty &&requiredcheck==false&&numbercheck==false&&dsccheck==false)
                        {
                            
                            placeOrder(name, quantity, discount);
                            Chart ch = new Chart
                            {
                                Date = DateTime.Now,
                                MedicalStoreName = ddlMedicalStore.SelectedValue,
                                Sum = Convert.ToDecimal(quantity)
                            };
                            dc.Charts.InsertOnSubmit(ch);
                            dc.SubmitChanges();
                            string message = "Order Placed";
                            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                            //lbltest.Text = "Order Placed";
                            mecheck = true;
                        }
                        if (quantity.ToString() != string.Empty && discount.ToString() == string.Empty && requiredcheck == false && numbercheck == false)
                        {
                            ((Label)(row.Cells[5].FindControl("lbldscRequried"))).Visible = false;
                            placeOrder(name, quantity);
                            Chart ch = new Chart
                            {
                                Date = DateTime.Now,
                                MedicalStoreName = ddlMedicalStore.SelectedValue,
                                Sum = Convert.ToDecimal(quantity),
                                Month=DateTime.Now.ToString("MMMM"),
                                Year=DateTime.Now.Year
                            };
                            dc.Charts.InsertOnSubmit(ch);
                            dc.SubmitChanges();

                            string message = "Order Placed";
                            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                            // lbltest.Text = "Order Placed";
                            mecheck = true;
                        }
                        else if (!mecheck)
                        {
                            string message = "Order Not Placed PLEASE Verify your Information";
                            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + message + "');", true);
                            //lbltest.Text = "not yet";
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

            }
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
        BindGridDataOrders();
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
            TextBox txt1 = (TextBox)row.FindControl("txtDiscount");
            txt1.Text = string.Empty;
        }
    }
    protected void lnkView_Click(object sender, EventArgs e)
    {
        //++_clickedCount;
        //var suffix = _clickedCount <= 1 ? "time" : "times";
        //lnkView.Text = string.Format("Clicked {0} {1}", _clickedCount, suffix);

        LinkButton lnkview = (LinkButton)sender;
        var s = from obmp in dc.Order_by_Medical_Store_Per_Medicines
                join m in dc.Medicine_In_Stocks on obmp.MedicineID equals m.MedicineID
                where obmp.OrderIDByMS == Convert.ToInt32( lnkview.CommandArgument)
                select new
                {
                    //obmp.OrderIDMSPerMedicine,
                    m.MedicineName,
                    obmp.Amount
                };
        gvViewOrderDetails.DataSource = s;
        gvViewOrderDetails.DataBind();
        //lblch.Text = "done";
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
    //protected void chkOrder_CheckedChanged(object sender, EventArgs e)
    //{
    //    CheckBox chk = (CheckBox)sender;
    //    if (chk.Checked) 
    //    {
    //        GridViewRow gvr = (GridViewRow)chk.NamingContainer;
    //        Int32 rowIndex = gvr.RowIndex;

    //        TextBox t = (TextBox)gvPlaceOrder.Rows[rowIndex].FindControl("txtQuantity");
    //        if (t.Text.Trim()=="") 
    //        {
    //            cvQuantity.ErrorMessage = "No blank things";
    //            cvQuantity.IsValid = false;
    //        }
    //    }
    //}
    //protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    //{
    //    GridViewRow row = (GridViewRow)((Control)source).NamingContainer;
    //    TextBox txtAmountReceived = (TextBox)row.FindControl("txtQuantity");
    //    CheckBox cb = (CheckBox)row.FindControl("chkOrder");


    //    if (cb.Checked == false)
    //        args.IsValid = true;
    //    else
    //        if (txtAmountReceived==null)
    //            args.IsValid = false;
    //        else
    //            args.IsValid = true;
    //}
    protected void ddlMedicalStore_DataBound(object sender, EventArgs e)
    {
        ddlMedicalStore.Items.Insert(0, new ListItem("All", "0"));
    }
    protected void ddlMedicalStore_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGridDataOrders();
    }
    protected void gvPlaceOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPlaceOrder.PageIndex = e.NewPageIndex;
        gvPlaceOrder.DataBind();
        BindGridDataMedicinesToOrder();
    }
    protected void btnSearch_ServerClick(object sender, EventArgs e)
    {
        string search = txtSearch.Text;
        var s = from mis in dc.Medicine_In_Stocks

                group mis by mis.MedicineName into g
                join mc in dc.Medicine_Companies on g.First().MedicineCompanyID equals mc.MedicineCompanyID
                where g.First().MedicineName.Contains(search)
                //select g.OrderBy(p => p.MedicineName).First()
                select new
                {
                    MedicineName = (g.OrderBy(p => p.MedicineName).FirstOrDefault()).MedicineName,
                    Price = g.First().Price,
                    MedicineCompanyName = mc.MedicineCompanyName
                };
        //var s = from a in dc.Medicine_In_Stocks
        //        join medicompany in dc.Medicine_Companies on a.MedicineCompanyID equals medicompany.MedicineCompanyID
        //        join medicat in dc.Medicine_Categories on a.MedicineCategoryID equals medicat.MedicineCategoryID
        //        where a.MedicineName.Contains(search)
        //        select new
        //        {
        //            a.MedicineID,
        //            a.Image,
        //            a.MedicineName,
        //            a.BatchNo,
        //            a.Price,
        //            a.ManufactureDate,
        //            a.ExpiryDate,
        //            medicompany.MedicineCompanyName,
        //            a.Amount,
        //            medicat.MedicineCategoryName
        //        };
        ////this.gvPlaceOrder.Columns[0].Visible = false;
        gvPlaceOrder.DataSource = s;
        gvPlaceOrder.DataBind();
    }
    protected void btnSearchCompany_ServerClick(object sender, EventArgs e)
    {
        string search = txtSearchByCompany.Text;
        var s = from mis in dc.Medicine_In_Stocks

                group mis by mis.MedicineName into g
                join mc in dc.Medicine_Companies on g.First().MedicineCompanyID equals mc.MedicineCompanyID
                where mc.MedicineCompanyName.Contains(search)
                //select g.OrderBy(p => p.MedicineName).First()
                select new
                {
                    MedicineName = (g.OrderBy(p => p.MedicineName).FirstOrDefault()).MedicineName,
                    Price = g.First().Price,
                    MedicineCompanyName = mc.MedicineCompanyName
                };
        gvPlaceOrder.DataSource = s;
        gvPlaceOrder.DataBind();

    }
    //TextBox txteditAmount;
    //protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    //{
    //    CustomValidator btn = (CustomValidator)source;
    //    var gvrow = (GridViewRow)btn.NamingContainer;
    //    if (gvrow != null)
    //    {
    //        txteditAmount = (gvrow.FindControl("txtQuanity") as TextBox);
    //    }
    //    System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("^[0-9]+$");
    //    args.IsValid = r.IsMatch(txteditAmount.Text);
    //}
}