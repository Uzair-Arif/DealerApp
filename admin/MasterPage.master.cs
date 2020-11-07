using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_MasterPage : System.Web.UI.MasterPage
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack)
        //{
            if (Session["AdminUserID"] != null)
            {
                var name = (from a in dc.Users
                            where a.UserId == Convert.ToInt32(Session["AdminUserID"])
                            select a.Username).First();
                username.Text = name.ToString();
                    var notify = (from a in dc.Notifications
                                  where a.Status=="Unseen"
                                  select a.NotificationId).Count();
                    if (notify>0)
                    {
                        lblNotifyNumber.Text = notify.ToString();
                        var notifywarning = (from a in dc.Notifications
                                            join u in dc.Users on a.UserID equals u.UserId
                                            where a.Type == "Warning" && a.Status=="Unseen"
                                            select new 
                                            {
                                               a.Message,
                                               u.Username
                                            }).Count();
                        if (notifywarning > 0)
                        {
                            lblWarning.Text = notifywarning.ToString();
                            string popupScript = "";
                            popupScript = "<script language='javascript'>" +
                    "showErrorToast();" +
                    "</script>";
                            Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
                        }
                        else 
                        {
                            lblWarning.Visible = false;
                        }
                        var notifysuccess = (from a in dc.Notifications
                                             join u in dc.Users on a.UserID equals u.UserId
                                             where a.Type == "Order Placed" && a.Status=="Unseen"
                                             select new
                                             {
                                                 a.Message,
                                                 u.Username
                                             }).Count();
                        if (notifysuccess > 0)
                        {
                            lblOrdersPlaced.Text = notifysuccess.ToString();
                            string popupScript = "";
                            popupScript = "<script language='javascript'>" +
                    "showSuccessToast();" +
                    "</script>";
                            Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
                        }
                        else
                        {
                            lblOrdersPlaced.Visible = false;
                        }
                        var notifyStockEnded = (from a in dc.Notifications
                                             join u in dc.Users on a.UserID equals u.UserId
                                             where a.Type == "Stock Ended" && a.Status=="Unseen"
                                             select new
                                             {
                                                 a.Message,
                                                 u.Username
                                             }).Count();
                        if (notifyStockEnded > 0)
                        {
                            lblStockEnded.Text = notifyStockEnded.ToString();
                            string popupScript = "";
                            popupScript = "<script language='javascript'>" +
                    "showErrorToast();" +
                    "</script>";
                            Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
                        }
                        else
                        {
                            lblStockEnded.Visible = false;
                        }
                        var notifyOrderDelivered = (from a in dc.Notifications
                                                join u in dc.Users on a.UserID equals u.UserId
                                                where a.Type == "Order Delivered" && a.Status=="Unseen"
                                                select new
                                                {
                                                    a.Message,
                                                    u.Username
                                                }).Count();
                        if (notifyOrderDelivered > 0)
                        {
                            lblOrderDelivered.Text = notifyOrderDelivered.ToString();
                        }
                        else
                        {
                            lblOrderDelivered.Visible = false;
                        }
                    }
                    else 
                    {
                        lblNotifyNumber.Visible = false;
                    }

                }

            }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            var name = (from a in dc.Users
                        where a.UserId == Convert.ToInt32(Session["AdminUserID"])
                        select a.Username).First();
            username.Text = name.ToString();
            var notify = (from a in dc.Notifications
                          where a.Status == "Unseen"
                          select a.NotificationId).Count();
            if (notify > 0)
            {
                lblNotifyNumber.Text = notify.ToString();
                var notifywarning = (from a in dc.Notifications
                                     join u in dc.Users on a.UserID equals u.UserId
                                     where a.Type == "Warning" && a.Status == "Unseen"
                                     select new
                                     {
                                         a.Message,
                                         u.Username
                                     }).Count();
                if (notifywarning > 0)
                {
                    lblWarning.Text = notifywarning.ToString();
                    string popupScript = "";
                    popupScript = "<script language='javascript'>" +
            "showErrorToast();" +
            "</script>";
                    Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
                }
                else
                {
                    lblWarning.Visible = false;
                }
                var notifysuccess = (from a in dc.Notifications
                                     join u in dc.Users on a.UserID equals u.UserId
                                     where a.Type == "Order Placed" && a.Status == "Unseen"
                                     select new
                                     {
                                         a.Message,
                                         u.Username
                                     }).Count();
                if (notifysuccess > 0)
                {
                    lblOrdersPlaced.Text = notifysuccess.ToString();
                    string popupScript = "";
                    popupScript = "<script language='javascript'>" +
            "showSuccessToast();" +
            "</script>";
                    Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
                }
                else
                {
                    lblOrdersPlaced.Visible = false;
                }
                var notifyStockEnded = (from a in dc.Notifications
                                        join u in dc.Users on a.UserID equals u.UserId
                                        where a.Type == "Stock Ended" && a.Status == "Unseen"
                                        select new
                                        {
                                            a.Message,
                                            u.Username
                                        }).Count();
                if (notifyStockEnded > 0)
                {
                    lblStockEnded.Text = notifyStockEnded.ToString();
                    string popupScript = "";
                    popupScript = "<script language='javascript'>" +
            "showErrorToast();" +
            "</script>";
                    Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
                }
                else
                {
                    lblStockEnded.Visible = false;
                }
                var notifyOrderDelivered = (from a in dc.Notifications
                                            join u in dc.Users on a.UserID equals u.UserId
                                            where a.Type == "Order Delivered" && a.Status == "Unseen"
                                            select new
                                            {
                                                a.Message,
                                                u.Username
                                            }).Count();
                if (notifyOrderDelivered > 0)
                {
                    lblOrderDelivered.Text = notifyOrderDelivered.ToString();
                }
                else
                {
                    lblOrderDelivered.Visible = false;
                }
            }
            else
            {
                lblNotifyNumber.Visible = false;
            }

        }

    }
}
    //}

    
    

