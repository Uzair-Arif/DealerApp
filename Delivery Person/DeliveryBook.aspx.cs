using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Delivery_Person_DeliveryBook : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["DeliveryUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataOrders();
                BindDataOrdersDelivered();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
    void BindGridDataOrders()
    {

        if (ddlMedicalStore.SelectedValue == "0" || ddlMedicalStore.SelectedValue == string.Empty)
        {
            var s = from obm in dc.Order_By_Medical_Stores
                    join m in dc.Medical_Stores on obm.MedicalStoreID equals m.MedicalStoreID
                    where obm.Status=="Delivery Pending"
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
                    where m.MedicalStoreName == ddlMedicalStore.SelectedValue && obm.Status == "Delivery Pending"
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
    void BindDataOrdersDelivered() 
    {
        if (ddlMedicalStore.SelectedValue == "0" || ddlMedicalStore.SelectedValue == string.Empty)
        {
            var s = from obm in dc.Order_By_Medical_Stores
                    join m in dc.Medical_Stores on obm.MedicalStoreID equals m.MedicalStoreID
                    where obm.Status == "Delivered"
                    orderby obm.OrderIDByMS descending

                    select new
                    {
                        obm.OrderIDByMS,
                        obm.Delivered_Date,
                        obm.Status,
                        m.MedicalStoreName,
                        obm.Order_Date,
                        obm.Placed_By
                    };
            gvOrderHistory.DataSource = s;
            gvOrderHistory.DataBind();
            //gvViewOrderDetails.DataSource = s;
            //gvViewOrderDetails.DataBind();
        }
        else
        {
            var s = from obm in dc.Order_By_Medical_Stores
                    join m in dc.Medical_Stores on obm.MedicalStoreID equals m.MedicalStoreID
                    where m.MedicalStoreName == ddlMedicalStore.SelectedValue && obm.Status == "Delivered"
                    orderby obm.OrderIDByMS descending
                    select new
                    {
                        obm.OrderIDByMS,
                        obm.Delivered_Date,
                        obm.Status,
                        m.MedicalStoreName,
                        obm.Order_Date,
                        obm.Placed_By
                    };
            gvOrderHistory.DataSource = s;
            gvOrderHistory.DataBind();
        }
    }
    protected void ddlMedicalStore_DataBound(object sender, EventArgs e)
    {
        ddlMedicalStore.Items.Insert(0, new ListItem("All", "0"));
    }
    protected void ddlMedicalStore_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGridDataOrders();
    }

    protected void lnkView_Click(object sender, EventArgs e)
    {
        LinkButton lnkview = (LinkButton)sender;

        var s = from obmp in dc.Order_by_Medical_Store_Per_Medicines
                join m in dc.Medicine_In_Stocks on obmp.MedicineID equals m.MedicineID
                where obmp.OrderIDByMS == Convert.ToInt32(lnkview.CommandArgument)
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
    protected void lnkApprove_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        //var s = from a in dc.Order_By_Medical_Stores
        var o = from or in dc.Order_By_Medical_Stores
                where or.OrderIDByMS == Convert.ToInt32(lnk.CommandArgument)
                select or;
        foreach (Order_By_Medical_Store om in o)
        {
            om.Status = "Delivered";
            om.Delivered_Date = DateTime.Now.Date;
            om.Recieved_By = txtReceiverName.Text;
        }
        try
        {
            dc.SubmitChanges();
        }
        catch (Exception ex)
        {
            lblch.Text = ex.ToString();
        }
        var ord=(from a in dc.Order_By_Medical_Stores
                join medi in dc.Medical_Stores on a.MedicalStoreID equals medi.MedicalStoreID 
                where a.OrderIDByMS==Convert.ToInt32(lnk.CommandArgument)
                select medi.MedicalStoreName).First();
        Notification nf = new Notification
        {
            UserID = Convert.ToInt32(Session["DeliveryUserID"]),
            Message = "Order Delivered to " + ord,
            Type = "Order Delivered",
            Status = "Unseen",
            OrderNumber = Convert.ToInt32(lnk.CommandArgument)
        };
        dc.Notifications.InsertOnSubmit(nf);
        dc.SubmitChanges();
        try
        {
            dc.SubmitChanges();
        }
        catch (Exception ex)
        {
            lblch.Visible = false;
            lblch.Text = ex.ToString();
        }
        BindGridDataOrders();
        lblConfirm.Text = "-----------------------------Delivery Added-------------------------------------------";
        lblConfirm.ForeColor = Color.Green;
    }
    protected void gvOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOrders.PageIndex = e.NewPageIndex;
        gvOrders.DataBind();
        BindGridDataOrders();
    }
    protected void gvOrderHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOrderHistory.PageIndex = e.NewPageIndex;
        gvOrderHistory.DataBind();
        BindDataOrdersDelivered();
    }
    protected void lnkView_Click1(object sender, EventArgs e)
    {
        LinkButton lnkview = (LinkButton)sender;
        var s = from obmp in dc.Order_by_Medical_Store_Per_Medicines
                join m in dc.Medicine_In_Stocks on obmp.MedicineID equals m.MedicineID
                where obmp.OrderIDByMS == Convert.ToInt32(lnkview.CommandArgument)
                select new
                {
                    //obmp.OrderIDMSPerMedicine,
                    m.MedicineName,
                    obmp.Amount
                };
        gvOrderDetails.DataSource = s;
        gvOrderDetails.DataBind();
        //lblch.Text = "done";
        ModalPopupExtender1.Show();
    }
}