using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.IO;
using System.Data;
using System.Reflection;
using System.Data.SqlClient;
public partial class Medicine : System.Web.UI.Page
{
	DataClassesDataContext dc = new DataClassesDataContext();
	string name = "";
	protected void Page_Load(object sender, EventArgs e)
	{
        if (Session["AdminUserID"] != null)
        {
           // lblsession.Text = "Session was created" + Session["UserID"];

            if (!IsPostBack)
            {
               
                BindGridDataMedicine();

            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
        
	}
	
	void BindGridDataMedicine()
	{
        var s = from a in dc.Medicine_In_Stocks
                join mcat in dc.Medicine_Categories on a.MedicineCategoryID equals mcat.MedicineCategoryID
                join mc in dc.Medicine_Companies on a.MedicineCompanyID equals mc.MedicineCompanyID
                select new 
                {
                    
                    a.MedicineID,
                    a.Image,
                    a.BatchNo,
                    a.MedicineName,
                    a.Amount,
                    a.Price,
                    a.ManufactureDate,
                    a.ExpiryDate,
                    mc.MedicineCompanyName,
                    mcat.MedicineCategoryName
                };
        //var data = from a in dc.Medicine_In_Stocks
        //           join mcat in dc.Medicine_Categories on a.MedicineCategoryID equals mcat.MedicineCategoryID
        //           join mc in dc.Medicine_Companies on a.MedicineCompanyID equals mc.MedicineCompanyID
        //           select a.Data;
        //foreach (Medicine_In_Stock item in s)
        //{
        //    //byte[] bytes = (byte[])LINQToDataTable(s).Columns[11]["Data"];
        //    byte[] bytes = item.Data.ToArray();
        //    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
        //    //(Image)gvMedicine.FindControl("imgMedi").//.ImageUrl = "data:image/png;base64," + base64String;
        //}
        this.gvMedicine.Columns[0].Visible = false;

        gvMedicine.DataSource = s;
		gvMedicine.DataBind();
	}
	
	


	
	protected void cancelEditMedicine(object sender, GridViewCancelEditEventArgs e)
	{
        this.gvMedicine.Columns[1].Visible = true;
		gvMedicine.EditIndex = -1;
		BindGridDataMedicine();
	}
	protected void editMedicine(object sender, GridViewEditEventArgs e)
	{
        this.gvMedicine.Columns[1].Visible = false;
		gvMedicine.EditIndex = e.NewEditIndex;
		BindGridDataMedicine();
	}
	protected void updateMedicine(object sender, GridViewUpdateEventArgs e)
	{
        this.gvMedicine.Columns[1].Visible =true;
        int? MedicineCatID = 0;
		int? MedicineCompanyID = 0;
		string MedicineID = ((Label)gvMedicine.Rows[e.RowIndex].FindControl("editlblMedicineID")).Text;
		string MedicineName = ((TextBox)gvMedicine.Rows[e.RowIndex].FindControl("edittxtMedicineName")).Text;
		string Price = ((TextBox)gvMedicine.Rows[e.RowIndex].FindControl("edittxtPrice")).Text;
		string MedicineCatName = ((DropDownList)gvMedicine.Rows[e.RowIndex].FindControl("editMedicineCategoryName")).Text;
		//dc.GetMedcineCategoryID(MedicineCatName, ref MedicineCatID);
		dc.GetMedicineCategoryID(MedicineCatName, ref MedicineCatID);
		string MedicineCompanyName = ((DropDownList)gvMedicine.Rows[e.RowIndex].FindControl("editMedicineCompanyName")).Text;
		dc.GetMedicineCompanyID(MedicineCompanyName, ref MedicineCompanyID);

		string ManufactureDate = ((TextBox)gvMedicine.Rows[e.RowIndex].FindControl("edittxtManufactureDate")).Text;
		string ExpiryDate = ((TextBox)gvMedicine.Rows[e.RowIndex].FindControl("edittxtExpiryDate")).Text;
		string Amount = ((TextBox)gvMedicine.Rows[e.RowIndex].FindControl("edittxtAmount")).Text;
		var q = from medi in dc.Medicine_In_Stocks
				where medi.MedicineID == Convert.ToInt32(MedicineID)
				select medi;
		foreach (Medicine_In_Stock mis in q) 
		{
			mis.MedicineName = MedicineName;
			mis.Price =Convert.ToDecimal (Price);
			mis.MedicineCategoryID = MedicineCatID;
			mis.MedicineCompanyID = MedicineCompanyID;
			mis.ManufactureDate = Convert.ToDateTime (ManufactureDate);
			mis.ExpiryDate = Convert.ToDateTime(ExpiryDate);
			mis.Amount =Convert.ToDecimal(Amount);
		}
		try 
		{
			dc.SubmitChanges();
		}
		catch(Exception ex)
		{
			lblerr.Text = ex.ToString();
		}
		gvMedicine.EditIndex = -1;
		BindGridDataMedicine();
	}
	protected void deleteMedicine(object sender, EventArgs e) 
	{
		LinkButton lnkrmv = (LinkButton)sender;
		var todel = from d in dc.Medicine_In_Stocks
					where d.MedicineID == Convert.ToInt32(lnkrmv.CommandArgument)
					select d;
		foreach (var ex in todel)
		{
			dc.Medicine_In_Stocks.DeleteOnSubmit(ex);
		}
		try
		{
			dc.SubmitChanges();
		}
		catch (Exception exe)
		{
			lblerr.Text = exe.ToString();
		}
		BindGridDataMedicine();

	}
	protected void AddNewMedicine(object sender, EventArgs e) 
	{
		int? MedicineCatid = 0;
		int? MedicineCompanyID = 0;
		string MedicineName = ((TextBox)gvMedicine.FooterRow.FindControl("addtxtMedicineName")).Text;
		string MedicineCategoryName = ((DropDownList)gvMedicine.FooterRow.FindControl("addMedicineCategoryName")).SelectedItem.ToString();
		dc.GetMedicineCategoryID(MedicineCategoryName, ref MedicineCatid);
		//errlbl.Text = prodid.ToString();
		string MedicineCompanyName = ((DropDownList)gvMedicine.FooterRow.FindControl("addMedicineCompanyName")).SelectedItem.ToString();
		dc.GetMedicineCompanyID(MedicineCompanyName, ref MedicineCompanyID);
		string Price = ((TextBox)gvMedicine.FooterRow.FindControl("addtxtprice")).Text;
		string ManufactureDate = ((TextBox)gvMedicine.FooterRow.FindControl("addtxtManufactureDate")).Text;
		string ExpiryDate = ((TextBox)gvMedicine.FooterRow.FindControl("addtxtExpiryDate")).Text;
		string Amount = ((TextBox)gvMedicine.FooterRow.FindControl("addtxtAmount")).Text;
		Medicine_In_Stock mis = new Medicine_In_Stock
		{
            
			MedicineName = MedicineName,
			Price = Convert.ToDecimal(Price),
			ManufactureDate = Convert.ToDateTime(ManufactureDate),
			//ArrivalDate = DateTime.ParseExact(ArrivalDateAjax,"MM/dd/yyyy hh:mm:ss tt", System.Globalization.CultureInfo.InvariantCulture),
			ExpiryDate=Convert.ToDateTime(ExpiryDate),
			MedicineCategoryID=MedicineCatid,
			MedicineCompanyID=MedicineCompanyID,
			Amount=Convert.ToDecimal(Amount)
			

		};
		dc.Medicine_In_Stocks.InsertOnSubmit(mis);
		dc.SubmitChanges();
		BindGridDataMedicine();
	}
   
    public bool IsValid
    {

        get;
        set;

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (fileupload1.PostedFile != null)
        //{
        //    string FileName = Path.GetFileName(fileupload1.PostedFile.FileName);

        //    //Save files to disk
        //    fileupload1.SaveAs(Server.MapPath("../ProductImages/" + FileName));


        //    Medicine_In_Stock mis = new Medicine_In_Stock
        //    {
        //        Image = "../ProductImages/" + FileName
        //    };
        //    dc.Medicine_In_Stocks.InsertOnSubmit(mis);
        //    dc.SubmitChanges();
        //    //BindGridDataMedicine();

        //}
        //else
        //{
        //    //lblMessage.ForeColor = System.Drawing.Color.Red;
        //    lblerr.Text = "File format not recognised." + " Upload Image/Word/PDF/Excel formats";
        //}
        if (IsValid)
        {
            int? MedicineCatid = 0;
            int? MedicineCompanyID = 0;
            string MedicineName = txtMedicineName.Text; //((TextBox)gvMedicine.FooterRow.FindControl("addtxtMedicineName")).Text;
            string MedicineCategoryName = addMedicineCategoryName.SelectedItem.ToString();//((DropDownList)gvMedicine.FooterRow.FindControl("addMedicineCategoryName")).SelectedItem.ToString();
            dc.GetMedicineCategoryID(MedicineCategoryName, ref MedicineCatid);
            //errlbl.Text = prodid.ToString();
            string MedicineCompanyName = addMedicineCompanyName.SelectedItem.ToString(); //((DropDownList)gvMedicine.FooterRow.FindControl("addMedicineCompanyName")).SelectedItem.ToString();
            dc.GetMedicineCompanyID(MedicineCompanyName, ref MedicineCompanyID);
            string Price = txtMedicinePrice.Text; //((TextBox)gvMedicine.FooterRow.FindControl("addtxtprice")).Text;
            string ManufactureDate = addtxtManufactureDate.Text;//((TextBox)gvMedicine.FooterRow.FindControl("addtxtManufactureDate")).Text;
            string ExpiryDate = addtxtExpiryDate.Text;//((TextBox)gvMedicine.FooterRow.FindControl("addtxtExpiryDate")).Text;
            string Amount = addtxtAmount.Text;//((TextBox)gvMedicine.FooterRow.FindControl("addtxtAmount")).Text;
            string Description = txtDescription.Text;

            var mediup = (from a in dc.Medicine_In_Stocks
                          select a.MedicineID).Max();
            var maxmedi = from a in dc.Medicine_In_Stocks
                          where a.MedicineID == mediup
                          select a;
            foreach (Medicine_In_Stock item in maxmedi)
            {
                item.MedicineName = MedicineName;
                item.Price = Convert.ToDecimal(Price);
                item.ManufactureDate = Convert.ToDateTime(ManufactureDate);
                //ArrivalDate = DateTime.ParseExact(ArrivalDateAjax,"MM/dd/yyyy hh:mm:ss tt", System.Globalization.CultureInfo.InvariantCulture),
                item.ExpiryDate = Convert.ToDateTime(ExpiryDate);
                item.MedicineCategoryID = MedicineCatid;
                item.MedicineCompanyID = MedicineCompanyID;
                item.Amount = Convert.ToDecimal(Amount);
                item.Description = Description;
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
        
        }
    protected void btnAddMedicine_Click(object sender, EventArgs e)
    {
        mp1.Show();
    }
    
     public SortDirection dir
    {
        get
        {
            if (ViewState["dirState"] == null)
            {
                ViewState["dirState"] = SortDirection.Ascending;
            }
            return (SortDirection)ViewState["dirState"];
        } 
        set
        {
            ViewState["dirState"] = value;
        }
 
    }

    protected void gvMedicine_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMedicine.PageIndex = e.NewPageIndex;
        if (Session["SortedView"] != null)
        {
            gvMedicine.DataSource = Session["SortedView"];
            gvMedicine.DataBind();
        }
        else
        {
            //gvMedicine.DataSource = dc.GetMedicine();
            //gvMedicine.DataBind();
            BindGridDataMedicine();
        }
    }
    public DataTable LINQToDataTable<T>(IEnumerable<T> varlist)
    {
        DataTable dtReturn = new DataTable();

        // column names 
        PropertyInfo[] oProps = null;

        if (varlist == null) return dtReturn;

        foreach (T rec in varlist)
        {
            // Use reflection to get property names, to create table, Only first time, others 
            // will follow 
            if (oProps == null)
            {
                oProps = ((Type)rec.GetType()).GetProperties();
                foreach (PropertyInfo pi in oProps)
                {
                    Type colType = pi.PropertyType;

                    if ((colType.IsGenericType) && (colType.GetGenericTypeDefinition()
                    == typeof(Nullable<>)))
                    {
                        colType = colType.GetGenericArguments()[0];
                    }

                    dtReturn.Columns.Add(new DataColumn(pi.Name, colType));
                }
            }

            DataRow dr = dtReturn.NewRow();

            foreach (PropertyInfo pi in oProps)
            {
                dr[pi.Name] = pi.GetValue(rec, null) == null ? DBNull.Value : pi.GetValue
                (rec, null);
            }

            dtReturn.Rows.Add(dr);
        }
        return dtReturn;
    }
    protected void btnSearch_ServerClick(object sender, EventArgs e)
    {
        string search = txtSearch.Text;
        var s = from a in dc.Medicine_In_Stocks
                join medicompany in dc.Medicine_Companies on a.MedicineCompanyID equals medicompany.MedicineCompanyID
                join medicat in dc.Medicine_Categories on a.MedicineCategoryID equals medicat.MedicineCategoryID
                where a.MedicineName.Contains(search)
                select new
                {
                    a.MedicineID,
                    a.Image,
                    a.MedicineName,
                    a.BatchNo,
                    a.Price,
                    a.ManufactureDate,
                    a.ExpiryDate,
                    medicompany.MedicineCompanyName,
                    a.Amount,
                    medicat.MedicineCategoryName
                };
        this.gvMedicine.Columns[0].Visible = false;
        gvMedicine.DataSource = s;
        gvMedicine.DataBind();
    }

    protected void btnSearchCompany_ServerClick(object sender, EventArgs e)
    {
        string search = txtSearchByCompany.Text;
        var s = from a in dc.Medicine_In_Stocks
                join medicompany in dc.Medicine_Companies on a.MedicineCompanyID equals medicompany.MedicineCompanyID
                join medicat in dc.Medicine_Categories on a.MedicineCategoryID equals medicat.MedicineCategoryID
                where medicompany.MedicineCompanyName.Contains(search)
                select new
                {

                    a.MedicineID,
                    a.Image,
                    a.MedicineName,
                    a.BatchNo,
                    a.Price,
                    a.ManufactureDate,
                    a.ExpiryDate,
                    medicompany.MedicineCompanyName,
                    a.Amount,
                    medicat.MedicineCategoryName
                };
        this.gvMedicine.Columns[0].Visible = false;
        gvMedicine.DataSource = s;
        gvMedicine.DataBind();
    }
    TextBox txteditMedicine;
    TextBox txteditPrice;
    TextBox txteditAmount;
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
         CustomValidator btn=(CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null) 
        {
           txteditMedicine = ( gvrow.FindControl("edittxtMedicineName") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"^[A-Za-z\s,.]*$");
        args.IsValid = r.IsMatch(txteditMedicine.Text);
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
           txteditPrice  = (gvrow.FindControl("edittxtPrice") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"^[1-9]{0,6}(\.[0-9]{1,2})?$");
        args.IsValid = r.IsMatch(txteditPrice.Text);
    }
    protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            txteditAmount = (gvrow.FindControl("edittxtAmount") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("^[0-9]+$");
        args.IsValid = r.IsMatch(txteditAmount.Text);
    }
    protected void gvMedicine_Sorting(object sender, GridViewSortEventArgs e)
    {
        BindGridDataMedicine();
        DataTable dt = LINQToDataTable(dc.GetMedicine());
       // dt = ds.Tables[0];
        string SortDir = string.Empty;
            if (dir == SortDirection.Ascending)
            {
                dir = SortDirection.Descending;
                SortDir = "Desc";
            }
            else
            {
                dir = SortDirection.Ascending;
                SortDir = "Asc";
            }
            DataView sortedView = new DataView(dt);
            sortedView.Sort = e.SortExpression + " " + SortDir;
            gvMedicine.DataSource = sortedView;
            gvMedicine.DataBind();
    }
    
    //protected void lnkUpload_Click(object sender, EventArgs e)
    //{
    //    //if (fileupload1.PostedFile != null)
    //    //{
    //    //    string FileName = Path.GetFileName(fileupload1.PostedFile.FileName);

    //    //    //Save files to disk
    //    //    fileupload1.SaveAs(Server.MapPath("../ProductImages/" + FileName));


    //    //    Medicine_In_Stock mis = new Medicine_In_Stock
    //    //    {
    //    //        Image = "../ProductImages/" + FileName
    //    //    };
    //    //    dc.Medicine_In_Stocks.InsertOnSubmit(mis);
    //    //    dc.SubmitChanges();
    //    //    //BindGridDataMedicine();

    //    //}
    //    //else
    //    //{
    //    //    //lblMessage.ForeColor = System.Drawing.Color.Red;
    //    //    lblerr.Text = "File format not recognised." + " Upload Image/Word/PDF/Excel formats";
    //    //}
    //}
    protected void AsyncFileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        string filename = System.IO.Path.GetFileName(AsyncFileUpload1.FileName);
        AsyncFileUpload1.SaveAs(Server.MapPath("../ProductImages/") + filename);
        Medicine_In_Stock mis = new Medicine_In_Stock
        {
            Image = "../ProductImages/" + filename
        };
        dc.Medicine_In_Stocks.InsertOnSubmit(mis);
        dc.SubmitChanges();
    }
    TextBox txtaddManufactureDate;
    TextBox txtaddExpDate;
    protected void cvExpiryDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator cv = (CustomValidator)source;
        txtaddManufactureDate = (TextBox)cv.FindControl("addtxtManufactureDate");
        txtaddExpDate = (TextBox)cv.FindControl("addtxtExpiryDate");
        //CustomValidator btn = (CustomValidator)source;
        //var gvrow = (GridViewRow)btn.NamingContainer;
        //if (gvrow != null)
        //{
        //    txtaddExpDate = (gvrow.FindControl("addtxtExpiryDate") as TextBox);
        //    txtaddManufactureDate = (gvrow.FindControl("addtxtManufactureDate") as TextBox);
        //}
        if (Convert.ToDateTime(txtaddExpDate.Text).Date <= Convert.ToDateTime(txtaddManufactureDate.Text).Date)
        {
            //.Text = "Invalid expiryDate";
            args.IsValid = false;
            IsValid = false;
        }
        else
        {
            IsValid = true;
        }

    }
    TextBox edittxtManufactureDate;
    TextBox edittxtExpiryDate;
    protected void cvEditExpiryDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator cv = (CustomValidator)source;
        // txtaddManufactureDate = (TextBox)cv.FindControl("addtxtManufactureDate");
        //txtaddExpDate = (TextBox)cv.FindControl("addtxtExpiryDate");
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            edittxtManufactureDate = (gvrow.FindControl("edittxtManufactureDate") as TextBox);
            edittxtExpiryDate = (gvrow.FindControl("edittxtExpiryDate") as TextBox);
        }
        if (Convert.ToDateTime(edittxtExpiryDate.Text).Date <= Convert.ToDateTime(edittxtManufactureDate.Text).Date)
        {
            //.Text = "Invalid expiryDate";
            args.IsValid = false;
            IsValid = false;
        }
        else
        {
            IsValid = true;
        }

    }
}