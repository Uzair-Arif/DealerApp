<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="admin_Dashboard" MasterPageFile="~/admin/MasterPage.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            $('.bs-pagination td table').each(function (index, obj) {
                convertToPagination(obj)
            });
        }
   </script>
    </asp:Content>
<asp:Content ID="c1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <%--<form id="form1" runat="server">--%>
    <div class="container-fluid">
        <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            DashBoard
                        </h1>
                        <%--<ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                           
                        </ol>--%>
                    </div>
                </div>
                <!-- /.row -->
         
    <div class="row">
                    <%--<cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
</cc1:ToolkitScriptManager>--%>
                    <div class="col-lg-6 col-md-6">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-shopping-cart fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge"><asp:Label ID="lblOrderTotal" runat="server"></asp:Label></div>
                                        <div>Pharma Orders!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="PurchaseBook.aspx">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-plus-square fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge"><asp:Label ID="lblTotal" runat="server"></asp:Label></div>
                                        <div>Total Medicines Quantity</div>
                                    </div>
                                </div>
                            </div>
                            <a href="TotalQuantity.aspx">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
               
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i> Area Chart</h3>
                               
                                        
                                    
                                <asp:LinqDataSource ID="lnqMedicalStore" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicalStoreName)" TableName="Medical_Stores"></asp:LinqDataSource>
                                <asp:DropDownList ID="ddlQuantity" runat="server" AutoPostBack="true" DataSourceID="lnqMedicalStore" DataTextField="MedicalStoreName" DataValueField="MedicalStoreName" OnDataBound="ddlQuantity_DataBound" OnSelectedIndexChanged="ddlQuantity_SelectedIndexChanged" CssClass="form-control" Width="30%"></asp:DropDownList>
                                <asp:Label Text="*All Shows Current Month Report" runat="server" />
                                <br />
                                <asp:Label Text="*Individual Store shows Year Report  " runat="server" />
                             </div>
                            <asp:Label ID="lblxxis" runat="server" BackColor="SteelBlue">

                                </asp:Label>
                            <div class="panel-body">
                                
                                <cc1:BarChart ID="BarChart1" runat="server" ChartHeight="300" ChartWidth = "850"
    ChartType="Column" ChartTitleColor="#0E426C"
    CategoryAxisLineColor="#D08AD9" ValueAxisLineColor="#D08AD9" BaseLineColor="#A156AB">
</cc1:BarChart>  
                                <asp:Label id="lblMonth" runat="server" />
                                <br />
                                <asp:Label id="lblMedicalStore" runat="server" />
                                <br />
                                <asp:Label id="lblQuantity" runat="server" /> 
                            </div>
                        </div>
                    </div>
                </div>
				<div class="row">
				<div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-money fa-fw"></i> Transactions Panel</h3>
                            </div>
                            <div class="panel-body">
                                
                                        
                                    <asp:UpdatePanel ID="updateTransaction" runat="server">
                                    <ContentTemplate>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        
                                        <asp:GridView ID="gvTransaction" runat="server" CssClass="table table-bordered table-hover table-striped" AutoGenerateColumns="false" AllowPaging="true" PagerStyle-CssClass="bs-pagination" PageSize="8" OnPageIndexChanging="gvTransaction_PageIndexChanging">
                                           <PagerStyle CssClass="bs-pagination" HorizontalAlign="Center" />
                                             <Columns>
                                                 <asp:TemplateField HeaderText="Order#">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOrderNumber" runat="server" Text='<%#Eval("Order_") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblType" runat="server" Text='<%#Eval("Type") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField HeaderText="Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" runat="server" Text='<%#String.Format("{0:M/d/yyyy}",Eval("Date")) %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTime" runat="server" Text='<%#String.Format("{0:T}",Eval("Time")) %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Client/Supplier">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblClientSupplier" runat="server" Text='<%#Eval("Client_Supplier") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                         
                                    </table>
                                    </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="gvTransaction" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                </div>
                                
                               
                            
                        </div>
                    </div>
				</div>

    </div>
    <%--</form>--%>
    </asp:Content>