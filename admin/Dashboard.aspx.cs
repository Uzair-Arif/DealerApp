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
using System.Configuration;
public partial class admin_Dashboard : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminUserID"] != null)
        {
            if (!IsPostBack)
            {
                BindGridDataTransaction();
                if (ddlQuantity.SelectedValue == "0" || ddlQuantity.SelectedValue == string.Empty)
                {
                    
                    var s = (from a in dc.Charts
                             where Convert.ToDateTime(a.Date).Month == DateTime.Now.Month
                             group a by a.MedicalStoreName into medi
                             orderby medi.Select(x => x.Sum).Sum() descending
                             select new
                             {
                                 MedicalStoreName = medi.First().MedicalStoreName,
                                 Quantity = medi.Select(x => x.Sum).Sum()
                             }).Take(5);

                    DataTable dt = LINQToDataTable(s);
                    string[] xa = new string[dt.Rows.Count];
                    decimal[] y = new decimal[dt.Rows.Count];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        xa[i] = dt.Rows[i][0].ToString();
                        y[i] = Convert.ToInt32(dt.Rows[i][1]);
                    }
                    BarChart1.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = y });
                    BarChart1.CategoriesAxis = string.Join(",", xa);
                   // BarChart1.ChartTitle = string.Format("{0} Order Distribution", ddlQuantity.SelectedItem.Value);
                    if (xa.Length > 3)
                    {
                        BarChart1.ChartWidth = (xa.Length * 250).ToString();
                    }
                    lblMonth.Visible = false;
                    lblMedicalStore.Visible = true;
                    lblMedicalStore.Text = "*x-axis Medical Store";
                    lblQuantity.Text = "*y-axis Medicine Quantity";
                  //  BindGridDataTransaction();
                }
                else
                {
                    var s = (from a in dc.Charts
                             where Convert.ToDateTime(a.Date).Year == DateTime.Now.Year && a.MedicalStoreName==ddlQuantity.SelectedValue
                             group a by a.MedicalStoreName into medi
                             //orderby medi.Select(x => x.Sum).Sum() descending
                             select new
                             {
                                // MedicalStoreName = medi.First().MedicalStoreName,
                                 Month = Convert.ToDateTime(medi.First().Date).Month.ToString(),
                                 Quantity = medi.Select(x => x.Sum).Sum()
                             });
                    
                    DataTable dt = LINQToDataTable(s);
                    string[] xa = new string[dt.Rows.Count];
                    decimal[] y = new decimal[dt.Rows.Count];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        xa[i] = dt.Rows[i][0].ToString();
                        y[i] = Convert.ToInt32(dt.Rows[i][1]);
                    }
                    BarChart1.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = y });
                    BarChart1.CategoriesAxis = string.Join(",", xa);
                    // BarChart1.ChartTitle = string.Format("{0} Order Distribution", ddlCountries.SelectedItem.Value);
                    if (xa.Length > 3)
                    {
                        BarChart1.ChartWidth = (xa.Length * 250).ToString();
                    }
                    lblMonth.Visible = true;
                    lblMedicalStore.Visible = false;
                    lblMonth.Text = "*x-axis Month";
                    lblQuantity.Text = "*y-axis Medicine Quantity";
                }
                //BarChart1.Visible = ddlCountries.SelectedItem.Value != "";
                
                var total=(from a in dc.Medicine_In_Stocks
                          select a.Amount).Sum();
                lblTotal.Text =Convert.ToString( total);
                var ordertotal=(from a in dc.Order_To_Medicine_Companies
                               where a.Status=="Pending"
                               select a.OrderIDToMC).Count();
                lblOrderTotal.Text = Convert.ToString(ordertotal);
            }
        }
        else
        {
            Response.Redirect("../startbootstrap/main.aspx");
        }
    }
    void BindGridDataTransaction() 
    {
        var trans = from a in dc.Transactions
                    orderby a.Id descending
                    select new
                    {
                        a.Order_,
                        a.Type,
                        a.Date,
                        a.Time,
                        a.Client_Supplier
                    };
        gvTransaction.DataSource = trans;
        gvTransaction.DataBind();
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
        protected void ddlQuantity_DataBound(object sender, EventArgs e)
        {
            ddlQuantity.Items.Insert(0, new ListItem("All", "0"));
        }
        private static DataTable GetData(string query)
        {
            DataTable dt = new DataTable();
            string constr = ConfigurationManager.ConnectionStrings["Debis_Pharma_DBConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                    }
                }
                return dt;
            }
        }
        protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlQuantity.SelectedValue == "0" || ddlQuantity.SelectedValue == string.Empty)
            {
                var s = (from a in dc.Charts
                         where Convert.ToDateTime(a.Date).Month == DateTime.Now.Month
                         group a by a.MedicalStoreName into medi
                         orderby medi.Select(x => x.Sum).Sum() descending
                         select new
                         {
                             MedicalStoreName = medi.First().MedicalStoreName,
                             Quantity = medi.Select(x => x.Sum).Sum()
                         }).Take(5);

                DataTable dt = LINQToDataTable(s);
                string[] xa = new string[dt.Rows.Count];
                decimal[] y = new decimal[dt.Rows.Count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    xa[i] = dt.Rows[i][0].ToString();
                    y[i] = Convert.ToInt32(dt.Rows[i][1]);
                }
                BarChart1.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = y });
                BarChart1.CategoriesAxis = string.Join(",", xa);
                // BarChart1.ChartTitle = string.Format("{0} Order Distribution", ddlQuantity.SelectedItem.Value);
                if (xa.Length > 3)
                {
                    BarChart1.ChartWidth = (xa.Length * 250).ToString();
                }
                lblMonth.Visible = false;
                lblMedicalStore.Visible = true;
                lblMedicalStore.Text = "*x-axis Medical Store";
                lblQuantity.Text = "*y-axis Medicine Quantity";
            }
            else
            {
                string query = string.Format("select Month,  sum(Sum) from Chart where MedicalStoreName = '{0}' and Year={1} group by Month" ,ddlQuantity.SelectedItem.Value,DateTime.Now.Year);
    DataTable dt = GetData(query);
 
    string[] x = new string[dt.Rows.Count];
    decimal[] y = new decimal[dt.Rows.Count];
    for (int i = 0; i < dt.Rows.Count; i++)
    {
        x[i] =  (dt.Rows[i][0].ToString());
        y[i] = Convert.ToInt32(dt.Rows[i][1]);
    }
    BarChart1.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = y });
    BarChart1.CategoriesAxis = string.Join(",", x);
    BarChart1.ChartTitle = string.Format("{0} Order Distribution", ddlQuantity.SelectedItem.Value);
    if (x.Length > 3)
    {
        BarChart1.ChartWidth = (x.Length * 100).ToString();
    }
    lblMonth.Visible = true;
    lblMedicalStore.Visible = false;
    lblMonth.Text = "*x-axis Month";
    lblQuantity.Text = "*y-axis Medicine Quantity";
    //BarChart1.Visible = ddlCountries.SelectedItem.Value != "";
}
            //    var s = (from a in dc.Charts
            //             where Convert.ToDateTime(a.Date).Year == DateTime.Now.Year && a.MedicalStoreName == ddlQuantity.SelectedValue
            //             group a by a.MedicalStoreName into medi
            //             orderby Convert.ToDateTime( medi.Select(x=>x.Date)).Month descending
            //             select new
            //             {
            //                 Month = Convert.ToDateTime( medi.First().Date).ToString("MMMM"),
            //                 Quantity = medi.Select(x => x.Sum).Sum()
            //             });

              
                
            //    DataTable dt = LINQToDataTable(s);
            //    string[] xa = new string[dt.Rows.Count];
            //    decimal[] y = new decimal[dt.Rows.Count];
            //    for (int i = 0; i < dt.Rows.Count; i++)
            //    {
            //        xa[i] = dt.Rows[i][0].ToString();
            //        y[i] = Convert.ToInt32(dt.Rows[i][1]);
            //    }
            //    BarChart1.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = y });
            //    BarChart1.CategoriesAxis = string.Join(",", xa);
            //    // BarChart1.ChartTitle = string.Format("{0} Order Distribution", ddlCountries.SelectedItem.Value);
            //    if (xa.Length > 3)
            //    {
            //        BarChart1.ChartWidth = (xa.Length * 250).ToString();
            //    }
            }
        

        protected void gvTransaction_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTransaction.PageIndex = e.NewPageIndex;
            gvTransaction.DataBind();
            BindGridDataTransaction();
        }
}
