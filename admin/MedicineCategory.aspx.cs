using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Default : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    //string medicineCatName = null;
    protected void Page_Load(object sender, EventArgs e)
    {
         if (Session["AdminUserID"] != null)
        {
         if (!IsPostBack)
            {
            BindGridDataMedicineCategory();
            }
        }
         else
         {
             Response.Redirect("../startbootstrap/main.aspx");
         }
    }
    void BindGridDataMedicineCategory()
    {
        this.gvMedicineCategory.Columns[0].Visible = false;
        gvMedicineCategory.DataSource = dc.GetMedicineCategory();
        gvMedicineCategory.DataBind();
    }
    
    protected void gvMedicineCategory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvMedicineCategory.EditIndex = -1;
        BindGridDataMedicineCategory();
    }
    protected void gvMedicineCategory_RowEditing(object sender, GridViewEditEventArgs e)
    {
       // Label tb = (Label)gvMedicineCategory.Rows[e.NewEditIndex].Cells[2].FindControl("lblMedicineCategoryName");
        gvMedicineCategory.EditIndex = e.NewEditIndex;
        //name = lbl.Text;
       //medicineCatName  = tb.Text;

        BindGridDataMedicineCategory();
    }
    protected void gvMedicineCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string ID = ((Label)gvMedicineCategory.Rows[e.RowIndex].FindControl("editlblMedicineCategoryID")).Text;
       // int? MedicineCatID = 0;
        //string medicineCategoryNamelbl = ((TextBox)gvMedicineCategory.Rows[e.RowIndex].FindControl("lblMedicineCategoryName")).Text;
        string medicineCategoryName = ((TextBox)gvMedicineCategory.Rows[e.RowIndex].FindControl("edittxtMedicineCategoryName")).Text;
       // dc.GetMedicineCategoryID(medicineCategoryName,ref ID);
        
        var toup = from t in dc.Medicine_Categories
                   where t.MedicineCategoryID == Convert.ToInt32(ID)
                   select t;
        foreach (Medicine_Category mu in toup)
        {
            mu.MedicineCategoryName = medicineCategoryName;
        }
        try
        {
            dc.SubmitChanges();
        }
        catch (Exception ex)
        {
            lblerr.Text = ex.ToString();
        }
        gvMedicineCategory.EditIndex = -1;
        BindGridDataMedicineCategory();
    }
    protected void lnkRemove_Click(object sender, EventArgs e)
    {
       // GridViewRow row = (GridViewRow)gvMedicineCategory.Rows[e.RowIndex];
        LinkButton lnk = (LinkButton)sender;
        var todel = from d in dc.Medicine_Categories
                    where d.MedicineCategoryID == Convert.ToInt32 (lnk.CommandArgument)
                    select d;
        foreach (var ex in todel)
        {
            dc.Medicine_Categories.DeleteOnSubmit(ex);
        }
        try
        {
            dc.SubmitChanges();
        }
        catch (Exception exe)
        {
            lblerr.Text = exe.ToString();
        }
        BindGridDataMedicineCategory();
    }

    protected void btnAddCat_Click(object sender, EventArgs e)
    {
        mp1.Show();
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Medicine_Category mc = new Medicine_Category 
        {
         MedicineCategoryName  =txtCategoryName.Text
        };
        dc.Medicine_Categories.InsertOnSubmit(mc);
        dc.SubmitChanges();
        BindGridDataMedicineCategory();
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
    protected void gvMedicineCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMedicineCategory.PageIndex = e.NewPageIndex;
        gvMedicineCategory.DataBind();
        BindGridDataMedicineCategory();
    }
    TextBox txteditMedicineCatName;
    protected void cveditMedicineCatgeory_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CustomValidator btn = (CustomValidator)source;
        var gvrow = (GridViewRow)btn.NamingContainer;
        if (gvrow != null)
        {
            txteditMedicineCatName = (gvrow.FindControl("edittxtMedicineCategoryName") as TextBox);
        }
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("^[A-Za-z,. ]+$");
        args.IsValid = r.IsMatch(txteditMedicineCatName.Text);
    }
}