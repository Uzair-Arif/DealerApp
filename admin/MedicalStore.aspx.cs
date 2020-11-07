using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_MedicalStore : System.Web.UI.Page
{
	DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataMedicalStore();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
	void BindGridDataMedicalStore() 
	{
		var m = from c in dc.Medical_Stores
				select c;
        this.gvMedicalStore.Columns[0].Visible = false;
		gvMedicalStore.DataSource = m;
		gvMedicalStore.DataBind();
	}
	protected void lnkDelete_Click(object sender, EventArgs e)
	{
		LinkButton lnkrmv=(LinkButton)sender;
		var d = from a in dc.Medical_Stores
				where a.MedicalStoreID == Convert.ToInt32(lnkrmv.CommandArgument)
				select a;
		foreach(var x in d)
		{
			dc.Medical_Stores.DeleteOnSubmit(x);
		}
		try
		{
			dc.SubmitChanges();
		}
		catch(Exception ex) 
		{
			lblerr.Text = ex.ToString();
		}
		BindGridDataMedicalStore();
	}
	protected void gvMedicalStore_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
	{
		gvMedicalStore.EditIndex = -1;
		BindGridDataMedicalStore();
	}
	protected void gvMedicalStore_RowEditing(object sender, GridViewEditEventArgs e)
	{

		gvMedicalStore.EditIndex = e.NewEditIndex;
		BindGridDataMedicalStore();
	}
	protected void gvMedicalStore_RowUpdating(object sender, GridViewUpdateEventArgs e)
	{
		string MedicalStoreID = ((Label)gvMedicalStore.Rows[e.RowIndex].FindControl("editlblMedicalStoreID")).Text;
		string MedicalStoreName = ((TextBox)gvMedicalStore.Rows[e.RowIndex].FindControl("edittxtMedicalStoreName")).Text;
		string Phone=((TextBox)gvMedicalStore.Rows[e.RowIndex].FindControl("edittxtPhone")).Text;
		string Address=((TextBox)gvMedicalStore.Rows[e.RowIndex].FindControl("edittxtAddress")).Text;
	    string Email=((TextBox)gvMedicalStore.Rows[e.RowIndex].FindControl("edittxtEmail")).Text;
	    string AlternativeEmail=((TextBox)gvMedicalStore.Rows[e.RowIndex].FindControl("edittxtAlternativeEmail")).Text;
		string AlternativePhone=((TextBox)gvMedicalStore.Rows[e.RowIndex].FindControl("edittxtAlternativePhone")).Text;
		string Fax=((TextBox)gvMedicalStore.Rows[e.RowIndex].FindControl("edittxtFax")).Text;
		var s = from c in dc.Medical_Stores
				where c.MedicalStoreID == Convert.ToInt32(MedicalStoreID)
				select c;
		foreach(Medical_Store ms in s)
		{
			ms.MedicalStoreName = MedicalStoreName;
			ms.Phone =Convert.ToString(Phone);
			ms.Address = Address;
			ms.Email = Email;
			ms.Alternative_Email = AlternativeEmail;
			ms.Alternative_Phone = AlternativePhone;
			ms.Fax = Fax;
		}
		try 
		{
			dc.SubmitChanges();
		}
		catch(Exception ex)
		{
			lblerr.Text = ex.ToString();
		}
        gvMedicalStore.EditIndex = -1;
		BindGridDataMedicalStore();
	}
    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    string MedicalStoreName = ((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtMedicalStoreName")).Text;
    //    string Phone = ((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtPhone")).Text;
    //    string Address = ((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtAddress")).Text;
    //    string Email = ((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtEmail")).Text;
    //    string AlternativeEmail = ((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtAlternativeEmail")).Text;
    //    string AlternativePhone = ((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtAlternativePhone")).Text;
    //    string Fax = ((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtFax")).Text;
    //    Medical_Store ms=new Medical_Store
    //    {
    //        MedicalStoreName = MedicalStoreName,
    //        Phone = Convert.ToDecimal(Phone),
    //        Address = Address,
    //        Email = Email,
    //        Alternative_Email = AlternativeEmail,
    //        Alternative_Phone = AlternativePhone,
    //        Fax = Fax
    //    };
    //    dc.Medical_Stores.InsertOnSubmit(ms);
    //    dc.SubmitChanges();
    //    BindGridDataMedicalStore();
    //}
    protected void btnAddMedicalStore_Click(object sender, EventArgs e)
    {
        mp1.Show();
    }
    protected void gvMedicalStore_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMedicalStore.PageIndex = e.NewPageIndex;
        gvMedicalStore.DataBind();
        BindGridDataMedicalStore();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string MedicalStoreName = addtxtMedicalStoreName.Text; //((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtMedicalStoreName")).Text;
        string Phone = addtxtPhone.Text;//((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtPhone")).Text;
        string Address = addtxtAddress.Text; //((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtAddress")).Text;
        string Email = addtxtEmail.Text;//((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtEmail")).Text;
        string AlternativeEmail = txtAddAlternativeEmail.Text;//((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtAlternativeEmail")).Text;
        string AlternativePhone = txtAddAlternativePhone.Text;//((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtAlternativePhone")).Text;
        string Fax = txtAddFax.Text;//((TextBox)gvMedicalStore.FooterRow.FindControl("addtxtFax")).Text;
        Medical_Store ms = new Medical_Store
        {
            MedicalStoreName = MedicalStoreName,
            Phone = Convert.ToString(Phone),
            Address = Address,
            Email = Email,
            Alternative_Email = AlternativeEmail,
            Alternative_Phone = AlternativePhone,
            Fax = Fax
        };
        dc.Medical_Stores.InsertOnSubmit(ms);
        dc.SubmitChanges();
        BindGridDataMedicalStore();
    }
    protected void btnSearch_ServerClick(object sender, EventArgs e)
    {
        string search = txtSearch.Text;
        var s = from a in dc.Medical_Stores
                where a.MedicalStoreName.Contains(search)
                select new
                {
                    a.MedicalStoreID,
                    a.MedicalStoreName,
                    a.Phone,
                    a.Address,
                    a.Email,
                    //medicompany.MedicineCompanyName,
                    a.Alternative_Email,
                    a.Alternative_Phone,
                    a.Fax
                };
        this.gvMedicalStore.Columns[0].Visible = false;
        gvMedicalStore.DataSource = s;
        gvMedicalStore.DataBind();
    }
    TextBox txteditMedicalStore;
    TextBox txteditPhone;
    TextBox txteditEmail;
    protected void rqtxtMedicalStoreName_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            txteditMedicalStore = (gvrow.FindControl("edittxtMedicalStoreName") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"^[A-Za-z\s,.]*$");
        args.IsValid = r.IsMatch(txteditMedicalStore.Text);
    }

    protected void cvPhone_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            txteditPhone = (gvrow.FindControl("edittxtPhone") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"\(?\d{3}\)?-? *\d{3}-? *-?\d{4}");
        args.IsValid = r.IsMatch(txteditPhone.Text);
        
    }

    protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
    {
        
            CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            txteditEmail = (gvrow.FindControl("edittxtEmail") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
        args.IsValid = r.IsMatch(txteditEmail.Text);
    }
}