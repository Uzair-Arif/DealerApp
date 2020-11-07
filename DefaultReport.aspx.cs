using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
//using ServiceReference1;
using Microsoft.Reporting.WebForms;
using System.Globalization;
using System.Configuration;
using System.Data.SqlClient;
using System.Reflection;
public partial class _Default : System.Web.UI.Page
{

	//Service1Client obj = new Service1Client();
	  // obj = new Service1Client();
	//ServiceReference1.Service1Client ob=new ServiceReference1.Service1Client();
    DataClassesDataContext dc = new DataClassesDataContext();
    dsMedicine dsmedi=new dsMedicine();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
            for (int i = 1; i <= 12; i++)
            {
                DateTime date = new DateTime(1900, i, 1);
                ddlMonthName.Items.Add(new ListItem(date.ToString("MMMM"), i.ToString()));
            }
            ddlMonthName.SelectedValue = DateTime.Today.Month.ToString();
            for (int year = 2000; year <= DateTime.Today.Year;year++ ) 
            {
                ddlYear.Items.Add(year.ToString());
            }
           // DataSet.DataTable1DataTable dt = new DataSet.DataTable1DataTable();
            //ReportViewer1.ProcessingMode = ProcessingMode.Local;
            //ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Report.rdlc");
            // dsmedi = GetData();

            //ReportDataSource datasource = new ReportDataSource("dsMedicine",dsmedi.Tables[0]);
            //ReportViewer1.LocalReport.DataSources.Clear();
            //ReportViewer1.LocalReport.DataSources.Add(datasource);
         
        }
        
		
    }
    private dsMedicine GetData()
    {
       var q = (from a in dc.GetMedicineCategory().AsEnumerable()
                                
                                 select a);
        
       DataTable dt = LINQToDataTable(q);
       
       
       dsmedi.Tables.Remove("dtMedicineCategory");
       dsmedi.Tables.Add(dt);
       
       
       return dsmedi;
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
                    ==typeof(Nullable<>)))
                     {
                         colType = colType.GetGenericArguments()[0];
                     }

                    dtReturn.Columns.Add(new DataColumn(pi.Name, colType));
               }
          }

          DataRow dr = dtReturn.NewRow();

          foreach (PropertyInfo pi in oProps)
          {
               dr[pi.Name] = pi.GetValue(rec, null) == null ?DBNull.Value :pi.GetValue
               (rec,null);
          }

          dtReturn.Rows.Add(dr);
     }
     return dtReturn;
}
	protected void btn1_Click(object sender, EventArgs e)
	{
		//int a = Convert.ToInt32(txt1.Text);
		//int b = Convert.ToInt32(txt2.Text);
		//txt1.Text = ob.add(a, b).ToString();
	}
    protected void btnGenerateReport_Click(object sender, EventArgs e)
    {
        int year = Convert.ToInt32( ddlYear.SelectedValue);
       int month = DateTime.ParseExact(ddlMonthName.SelectedItem.ToString(), "MMMM", CultureInfo.CurrentCulture).Month;
        txtYear.Text = year.ToString();
        txtMonth.Text = month.ToString();
        var s = from a in dc.Sales
                where a.Date.ToString().Contains(year.ToString()) && a.Date.ToString().Contains(month.ToString())
                select a;
        gvSales.DataSource = s;
        gvSales.DataBind();
    }
}