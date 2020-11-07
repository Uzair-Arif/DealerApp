using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default3 : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var s = from a in dc.Medical_Stores
                    select a;
            gvtest.DataSource = s;
            gvtest.DataBind();
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
//protected void btntest_Click(object sender, EventArgs e)
//{
//    gvtest.PagerSettings.Visible = false;
//    gvtest.DataBind();
//    StringWriter sw = new StringWriter();
//    HtmlTextWriter hw = new HtmlTextWriter(sw);
//    gvtest.RenderControl(hw);
//    string gridHTML = sw.ToString().Replace("\"", "'")
//        .Replace(System.Environment.NewLine, "");
//    StringBuilder sb = new StringBuilder();
//    sb.Append("<script type = 'text/javascript'>");
//    sb.Append("window.onload = new function(){");
//    sb.Append("var printWin = window.open('', '', 'left=0");
//    sb.Append(",top=0,width=1000,height=600,status=0');");
//    sb.Append("printWin.document.write(\"");
//    sb.Append(gridHTML);
//    sb.Append("\");");
//    sb.Append("printWin.document.close();");
//    sb.Append("printWin.focus();");
//    sb.Append("printWin.print();");
//    sb.Append("printWin.close();};");
//    sb.Append("</script>");
//    ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());
//    gvtest.PagerSettings.Visible = true;
//    gvtest.DataBind();
//}
    protected void btn1_Click(object sender, EventArgs e)
    {
        string popupScript = "";
        popupScript = "<script language='javascript'>" +
"showSuccessToast();" +
"</script>";
        Page.ClientScript.RegisterStartupScript(typeof(Page), "popupScript", popupScript);
        //ScriptManager.RegisterClientScriptBlock(typeof(Page), "popupScript", popupScript);
    }
    protected void btnfile_Click(object sender, EventArgs e)
    {
        string name = fileupload1.PostedFile.FileName;
    }
    TextBox txteditPrice;
    protected void cvNumber_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //CustomValidator btn = (CustomValidator)source;
        
        //var gvrow = (GridViewRow)btn.NamingContainer;
        //if (gvrow != null)
        //{
        //    txteditPrice = (gvrow.FindControl("txtNumber") as TextBox);
        //}
        System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex(@"^[0-9]{0,6}(\.[0-9]{1,2})?$");
        args.IsValid = r.IsMatch(txtNumber.Text);
    }
}