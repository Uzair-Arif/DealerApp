<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Admin_Orders" MasterPageFile="~/admin/MasterPage.master"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="c1" runat="server" ContentPlaceHolderID="head">
     <script type="text/javascript">
         function pageLoad() {
             $('.bs-pagination td table').each(function (index, obj) {
                 convertToPagination(obj)
             });
         }
   </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<form id="form2" runat="server">--%>
        <div class="container-fluid" >
         <!-- Page Heading -->
                <div class="row">
                    <div class="col-md-12 col-lg-6">
                       <%-- <h1 class="page-header">
                            Orders From Medical Stores
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-book"></i> Orders
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
<%--<div class="row">
                    <div class="col-md-12 col-lg-12">
                        <h2>Medical Store</h2>--%>
                        <%--<div class="table-responsive">--%>
        <%-- Gridview for Medicine Categories --%>
           
        <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>--%>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                         <div class="panel-heading">
                    <h2 class="panel-title"> <i class="fa fa-ambulance fa-fw"></i><b>List of Orders</b></h2>
                        </div>
                                        <div class="panel-body">
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
    
<asp:LinqDataSource ID="LinqDataSourceMedicalStoreName" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicalStoreName)" TableName="Medical_Stores"></asp:LinqDataSource>
        <asp:DropDownList ID="ddlMedicalStore" runat="server" AutoPostBack="true" DataSourceID="LinqDataSourceMedicalStoreName" DataTextField="MedicalStoreName" DataValueField="MedicalStoreName" OnDataBound="ddlMedicalStore_DataBound" OnSelectedIndexChanged="ddlMedicalStore_SelectedIndexChanged" CssClass="form-control" Width="30%"></asp:DropDownList> 
        <br />
    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false"  CssClass="table table-bordered table-hover table-striped" HorizontalAlign="Center" AllowPaging="true"  PageSize="5" OnPageIndexChanging="gvOrders_PageIndexChanging"  CellSpacing="0" OnRowDataBound="gvOrders_RowDataBound">
<PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>
        <Columns>
           
            <asp:TemplateField HeaderText="OrderID">
                <ItemTemplate>
                    <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("OrderIDByMS") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Due Date">
                 <ItemTemplate>
                     <asp:Label ID="lblDate" runat="server" Text='<%#String.Format("{0:M/d/yyyy}",Eval("Due_Date")) %>'></asp:Label>
                 </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Status") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Medical Store Name">
                <ItemTemplate>
                    <asp:Label ID="lblMedicalStoreName" runat="server" Text='<%#Eval("MedicalStoreName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:UpdatePanel ID="up3" runat="server" UpdateMode="Conditional" >
                        
                        <ContentTemplate>
                    <asp:LinkButton ID="lnkView" runat="server" Text="View Order Detail" ForeColor="Green" CommandArgument='<%#Eval("OrderIDByMS") %>' OnClick="lnkView_Click"></asp:LinkButton>
                 </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lnkView" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                            </ItemTemplate>
                
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkApprove" runat="server" Text="Add To Sale" ForeColor="Red" OnClick="lnkApprove_Click" CommandArgument='<%#Eval("OrderIDByMS") %>' Visible='<%#Convert.ToString(Eval("Status"))=="Pending"?true:false %>' OnClientClick="return alert('Sale Added for Invoice');"></asp:LinkButton>
                    <asp:Label ID="lblDeliver" runat="server" Text="Sale Added" ForeColor="Green" Visible='<%#Convert.ToString(Eval("Status"))=="Delivery Pending"?true:false %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDeliver" runat="server" Text="Delivere" Visible='<%#Convert.ToString(Eval("Status"))=="Approved"?true:false %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>--%>
        </Columns>
    </asp:GridView>
                </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvOrders" />
        </Triggers>
        </asp:UpdatePanel>
                                            </div>
                                        </div>
                                    </div>
                                </div>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    <%--</div>--%>
    <%--</div>
    </div>--%>
      <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClose"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
             <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
         <asp:UpdatePanel ID="up4" runat="server">
                     <ContentTemplate>            
      <asp:Label ID="lblch" runat="server"></asp:Label>

        <asp:GridView ID="gvViewOrderDetails" runat="server" CssClass="table table-striped" >
        </asp:GridView>
                   </ContentTemplate>
         <Triggers>
            
             <asp:PostBackTrigger ControlID="gvViewOrderDetails" />
         </Triggers>
         </asp:UpdatePanel>
                  <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-danger"/>
                 </asp:Panel>
            </div>
     
          
              
        <%--</form>--%>
    </asp:Content>

