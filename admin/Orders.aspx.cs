using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class Admin_Orders : System.Web.UI.Page
{
	DataClassesDataContext dc = new DataClassesDataContext();
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataOrders();
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
					where m.MedicalStoreName==ddlMedicalStore.SelectedValue
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
	protected void ddlMedicalStore_DataBound(object sender, EventArgs e)
	{
		ddlMedicalStore.Items.Insert(0, new ListItem("All", "0"));
	}
	protected void ddlMedicalStore_SelectedIndexChanged(object sender, EventArgs e)
	{
		BindGridDataOrders();
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
	protected void lnkApprove_Click(object sender, EventArgs e)
	{
		LinkButton lnk = (LinkButton)sender;
		//var s = from a in dc.Order_By_Medical_Stores
		var o = from or in dc.Order_By_Medical_Stores
				where or.OrderIDByMS == Convert.ToInt32(lnk.CommandArgument)
				select or;
		foreach (Order_By_Medical_Store om in o) 
		{
			om.Status = "Delivery Pending";
		}
		try
		{
			dc.SubmitChanges();
		}
		catch (Exception ex)
		{
			lblch.Text = ex.ToString();
		}
        
		Sale s = new Sale 
		{
		  Date=DateTime.Now,
		  OrderIDByMS=Convert.ToInt32(lnk.CommandArgument)
		};
		dc.Sales.InsertOnSubmit(s);
		dc.SubmitChanges();
        var sname=(from a in dc.Order_By_Medical_Stores
                  join medi in dc.Medical_Stores on a.MedicalStoreID equals medi.MedicalStoreID
                  where a.OrderIDByMS==Convert.ToInt32(lnk.CommandArgument)
                  select medi.MedicalStoreName).First();
        Transaction tc = new Transaction 
        {
           Order_=Convert.ToInt32(lnk.CommandArgument),
           Date=DateTime.Now,
           Time=Convert.ToDateTime( DateTime.Now),
           Type="Sale to Store",
           Client_Supplier=sname
        };
        dc.Transactions.InsertOnSubmit(tc);
        dc.SubmitChanges();
		BindGridDataOrders();

	}
	protected void gvOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
	{
		gvOrders.PageIndex = e.NewPageIndex;
		gvOrders.DataBind();
		BindGridDataOrders();
	}
	//protected void gvOrders_Sorting(object sender, GridViewSortEventArgs e)
	//{
	//	DataTable dataTable = gvOrders.DataSource as DataTable;

	//	if (dataTable != null)
	//	{
	//		DataView dataView = new DataView(dataTable);
	//		dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

	//		gvOrders.DataSource = dataView;
	//		gvOrders.DataBind();
	//	}
	//}
    protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow) 
        {
            //int a = Convert.ToInt32 (e.Row.Cells[1].Text);
            if (e.Row.Cells[1].Text ==Convert.ToString( Request.QueryString["OrderNumber"])) 
            {
                e.Row.BackColor = Color.Red;
            }
        }
    }
}