using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gvTest_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    void BindGridDataMedicineCategory()
    {
        gvMedicineCategory.DataSource = dc.GetMedicineCategory();
        gvMedicineCategory.DataBind();
    }
    protected void gvTest_RowEditing(object sender, GridViewEditEventArgs e)
    {
        // Label tb = (Label)gvMedicineCategory.Rows[e.NewEditIndex].Cells[2].FindControl("lblMedicineCategoryName");
        gvMedicineCategory.EditIndex = e.NewEditIndex;
        //name = lbl.Text;
        //medicineCatName  = tb.Text;

        BindGridDataMedicineCategory();
    }
    protected void gvTest_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvMedicineCategory.EditIndex = -1;
        BindGridDataMedicineCategory();
    }
}