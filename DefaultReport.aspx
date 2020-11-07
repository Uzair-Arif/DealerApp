<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DefaultReport.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="lblYear" runat="server" Text="Select Year"></asp:Label>
        <asp:DropDownList ID="ddlYear" runat="server"></asp:DropDownList>
        <br />
        <asp:Label ID="lblMonth" runat="server" Text="Select Month"></asp:Label>
     <asp:DropDownList ID="ddlMonthName" runat="server"></asp:DropDownList>
        <br />
        <asp:Button ID="btnGenerateReport" runat="server"  Text="Generate Report" OnClick="btnGenerateReport_Click"/>
        <asp:TextBox ID="txtYear" runat="server"></asp:TextBox>
        <asp:TextBox ID="txtMonth" runat="server"></asp:TextBox>
        <br />
        <asp:GridView ID="gvSales" runat="server"></asp:GridView>
       <%-- <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="668px" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" >
            <LocalReport ReportPath="Report.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="DataSetTableAdapters."></asp:ObjectDataSource>--%>
        <%--<asp:TextBox ID="txt1" runat="server"></asp:TextBox>
    <asp:TextBox ID="txt2" runat="server"></asp:TextBox>
        <asp:Button ID="btn1" runat="server" Text="test" OnClick="btn1_Click" />    --%>
    </div>
    </form>
</body>
</html>
