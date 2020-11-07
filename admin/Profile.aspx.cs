using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
	DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDetails();
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }


    public void BindGridDetails() 
    {
        var getName = (from a in dc.Distributors
                       select a.Name).First();
        txtName.Text = getName;
        var getAddress = (from a in dc.Distributors
                          select a.Address).First();
        txtAddress.Text = getAddress;
        var getPhone = (from a in dc.Distributors
                        select a.Phone).First();
        txtPhone.Text = getPhone;
        var getMobile = (from a in dc.Distributors
                         select a.Mobile).First();
        txtMobile.Text = getMobile;
        var getEmail = (from a in dc.Distributors
                        select a.Email).First();
        txtEmail.Text = getEmail;
        var getEmail2 = (from a in dc.Distributors
                         select a.Alternative_Email).First();
        txtEmail2.Text = getEmail2;
        var getMobile2 = (from a in dc.Distributors
                          select a.Alternative_Mobile).First();
        txtMobile2.Text = getMobile2;
        var getFax = (from a in dc.Distributors
                      select a.Fax).First();
        txtFax.Text = getFax;
    }
	protected void btnSave_Click(object sender, EventArgs e)
	{
		var save = from s in dc.Distributors
				   //where s.Id == 1
				   select s;
		foreach (Distributor d in save) 
		{
			d.Name = txtName.Text;
			d.Address = txtAddress.Text;
			d.Phone = txtPhone.Text;
			d.Mobile = txtMobile.Text;
			d.Email = txtEmail.Text;
			d.Alternative_Mobile = txtMobile2.Text;
			d.Alternative_Email = txtEmail2.Text;
			d.Fax = txtFax.Text;
		}
		try 
		{
			dc.SubmitChanges();
		}
		catch(Exception ex)
		{
			lblerror.Text = ex.ToString();
		}
	}
	protected void btnClear_Click(object sender, EventArgs e)
	{
		txtName.Text = string.Empty;
		txtAddress.Text = string.Empty;
		txtPhone.Text = string.Empty;
		txtMobile.Text = string.Empty;
		txtEmail.Text = string.Empty;
		txtFax.Text = string.Empty;
		txtEmail2.Text = string.Empty;
		txtMobile2.Text = string.Empty;
	}
}