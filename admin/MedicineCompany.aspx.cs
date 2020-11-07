using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_MedicineCompany : System.Web.UI.Page
{
	DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataMedicineCompany();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
	void BindGridDataMedicineCompany()
	{
		var m = from c in dc.Medicine_Companies
				select c;
        this.gvMedicineCompany.Columns[0].Visible = false;
		gvMedicineCompany.DataSource = m;
		gvMedicineCompany.DataBind();
	}
	protected void gvMedicineCompany_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
	{
		gvMedicineCompany.EditIndex = -1;
		BindGridDataMedicineCompany();
	}
	protected void gvMedicineCompany_RowEditing(object sender, GridViewEditEventArgs e)
	{
		gvMedicineCompany.EditIndex = e.NewEditIndex;
		BindGridDataMedicineCompany();
	}
	protected void gvMedicineCompany_RowUpdating(object sender, GridViewUpdateEventArgs e)
	{
		string MedicineCompanyID = ((Label)gvMedicineCompany.Rows[e.RowIndex].FindControl("editlblMedicineCompanyID")).Text;
		string MedicineCompanyName = ((TextBox)gvMedicineCompany.Rows[e.RowIndex].FindControl("edittxtMedicineCompanyName")).Text;
		string Phone = ((TextBox)gvMedicineCompany.Rows[e.RowIndex].FindControl("edittxtPhone")).Text;
		string Address = ((TextBox)gvMedicineCompany.Rows[e.RowIndex].FindControl("edittxtAddress")).Text;
		string Email = ((TextBox)gvMedicineCompany.Rows[e.RowIndex].FindControl("edittxtEmail")).Text;
		string AlternativeEmail = ((TextBox)gvMedicineCompany.Rows[e.RowIndex].FindControl("edittxtAlternativeEmail")).Text;
		string AlternativePhone = ((TextBox)gvMedicineCompany.Rows[e.RowIndex].FindControl("edittxtAlternativePhone")).Text;
		string Fax = ((TextBox)gvMedicineCompany.Rows[e.RowIndex].FindControl("edittxtFax")).Text;
		var s = from c in dc.Medicine_Companies
				where c.MedicineCompanyID == Convert.ToInt32(MedicineCompanyID)
				select c;
		foreach (Medicine_Company mc in s)
		{
			mc.MedicineCompanyName = MedicineCompanyName;
			mc.Phone = Convert.ToString(Phone);
			mc.Address = Address;
			mc.Email = Email;
			mc.AlternativeEmail = AlternativeEmail;
			mc.AlternativePhone = AlternativePhone;
			mc.Fax = Fax;
		}
		try
		{
			dc.SubmitChanges();
		}
		catch (Exception ex)
		{
			lblerr.Text = ex.ToString();
		}
        gvMedicineCompany.EditIndex = -1;
        BindGridDataMedicineCompany();
	}
	protected void lnkDelete_Click(object sender, EventArgs e)
	{
		LinkButton lnkrmv = (LinkButton)sender;
		var d = from a in dc.Medicine_Companies
				where a.MedicineCompanyID == Convert.ToInt32(lnkrmv.CommandArgument)
				select a;
		foreach (var x in d)
		{
			dc.Medicine_Companies.DeleteOnSubmit(x);
		}
		try
		{
			dc.SubmitChanges();
		}
		catch (Exception ex)
		{
			lblerr.Text = ex.ToString();
		}
		BindGridDataMedicineCompany();
	}
    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    string MedicineCompanyName = ((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtMedicineCompanyName")).Text;
    //    string Phone = ((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtPhone")).Text;
    //    string Address = ((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtAddress")).Text;
    //    string Email = ((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtEmail")).Text;
    //    string AlternativeEmail = ((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtAlternativeEmail")).Text;
    //    string AlternativePhone = ((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtAlternativePhone")).Text;
    //    string Fax = ((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtFax")).Text;
    //    Medicine_Company mc = new Medicine_Company 
    //    {
    //        MedicineCompanyName=MedicineCompanyName,
    //        Phone=Convert.ToDecimal(Phone),
    //        Address=Address,
    //        Email=Email,
    //        AlternativeEmail=AlternativeEmail,
    //        AlternativePhone=AlternativePhone,
    //        Fax=Fax
    //    };
    //    dc.Medicine_Companies.InsertOnSubmit(mc);
    //    dc.SubmitChanges();
    //    BindGridDataMedicineCompany();
    //}

    protected void btnAddMedicineCompany_Click(object sender, EventArgs e)
    {
        mp1.Show();
    }
    protected void gvMedicineCompany_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMedicineCompany.PageIndex = e.NewPageIndex;
        gvMedicineCompany.DataBind();
        BindGridDataMedicineCompany();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string MedicineCompanyName = addtxtMedicineCompanyName.Text;//((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtMedicineCompanyName")).Text;
        string Phone = addtxtPhone.Text;//((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtPhone")).Text;
        string Address = addtxtAddress.Text;//((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtAddress")).Text;
        string Email = addtxtEmail.Text;//((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtEmail")).Text;
        string AlternativeEmail = txtAddAlternativeEmail.Text;//((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtAlternativeEmail")).Text;
        string AlternativePhone = txtAddAlternativePhone.Text;//((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtAlternativePhone")).Text;
        string Fax = txtAddFax.Text;//((TextBox)gvMedicineCompany.FooterRow.FindControl("addtxtFax")).Text;
        Medicine_Company mc = new Medicine_Company
        {
            MedicineCompanyName = MedicineCompanyName,
            Phone = Convert.ToString(Phone),
            Address = Address,
            Email = Email,
            AlternativeEmail = AlternativeEmail,
            AlternativePhone = AlternativePhone,
            Fax = Fax
        };
        dc.Medicine_Companies.InsertOnSubmit(mc);
        dc.SubmitChanges();
        BindGridDataMedicineCompany();
    }
    protected void btnSearch_ServerClick(object sender, EventArgs e)
    {
        string search = txtSearch.Text;
        var s = from a in dc.Medicine_Companies
                where a.MedicineCompanyName.Contains(search)
                select new
                {
                    a.MedicineCompanyID,
                    a.MedicineCompanyName,
                    a.Phone,
                    a.Address,
                    a.Email,
                    //medicompany.MedicineCompanyName,
                    a.AlternativeEmail,
                    a.AlternativePhone,
                    a.Fax
                };
        this.gvMedicineCompany.Columns[0].Visible = false;
        gvMedicineCompany.DataSource = s;
        gvMedicineCompany.DataBind();
       
    }
    TextBox txteditMedicineCompanyName;
    TextBox txteditPhone;
    TextBox txteditEmail;
    protected void rqtxtMedicineCompanyName_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            txteditMedicineCompanyName = (gvrow.FindControl("edittxtMedicineCompanyName") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("^[A-Za-z,. ]+$");
        args.IsValid = r.IsMatch(txteditMedicineCompanyName.Text);
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