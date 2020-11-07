<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeliveryBook.aspx.cs" Inherits="Delivery_Person_DeliveryBook" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Deliver UI</title>
     <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript" src="js/bs.pagination.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bs.pagination.js"></script>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet"/>
    <link href="css/salesstyle.css" rel="stylesheet"/>

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <!--For Changing Tabs-->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#myTab a").click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });
        });
</script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css"
    rel="stylesheet" type="text/css" />
<script type="text/javascript">
    function ShowPopup(message) {
        $(function () {
            $("#dialog").html(message);
            $("#dialog").dialog({
                title: "Alert",
                buttons: {
                    Close: function () {
                        $(this).dialog('close');
                    }
                },
                modal: true
            });
        });
    };
</script>
    <style type="text/css">
        .ui-dialog > .ui-widget-header {background:#BAA378;}
    .modalBackground
    {
        background-color: Black;
        filter: alpha(opacity=90);
        opacity: 0.8;
    }
    .modalPopup
    {
        background-color: #FFFFFF;
        border-width: 2px;
        border-style: solid;
        border-color: black;
        padding-top: 10px;
        padding-left: 10px;
        padding-right: 10px;
        width: auto;
        height: auto;
    }
        .right {
            position: absolute;
            right: 0px;
            width: 300px;
            /*background-color: #b0e0e6;*/
        }
</style>

     <script type="text/javascript">
         function pageLoad() {
             $('.bs-pagination td table').each(function (index, obj) {
                 convertToPagination(obj)
             });
         }
   </script>
     <style>
        .top-nav>li>a:hover,
.top-nav>li>a:focus,
.top-nav>.open>a,
.top-nav>.open>a:hover,
.top-nav>.open>a:focus {
    color: #fff;
    background-color: #000;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <div>
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#2151A2">
        <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            <a class="navbar-brand" style="color:white;padding-top:0px;">
                    <img src="images/logo.jpg" />  
                </a>
                <a class="navbar-brand" href="../startbootstrap/main.aspx" style="color:white">DEBIS PHARMA</a>
            </div>
        
         <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:white"><i class="fa fa-user"></i> <asp:Label ID="lblUserName"  runat="server">Afzaal</asp:Label> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        
                        <li>
                            <a href="ChangePassword.aspx"><i class="fa fa-fw fa-gear"></i> Change Password</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="../startbootstrap/main.aspx"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
             </ul>
                </nav>
        </div>
        <br />
        <br />
        <br />
        
    <div class="container-fluid" >

         <!-- Page Heading -->
               <%-- <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <h1 class="page-header">
                            Orders From Medical Stores
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a>
                            </li>
                            
                        </ol>
                    </div>
                </div>--%>
                <!-- /.row -->
         <div role="tabpanel" style="background-color: #E5E4E2">
        

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" style="margin-left:40%" id="myTab">
    <li class="active"><a href="#DeliveryBook" >Delivery Book</a></li>
    <li><a href="#ViewOrder">View Order's Delivered</a></li>
    
  </ul>
   </div>
<%--<div class="row">--%>
        <div style="background-color:#E5E4E2">
        <div class="tab-content">
    <div class="tab-pane fade in active" id="DeliveryBook" style="text-align:center">
        <br />
  
                    <div class="col-md-12  col-lg-12" style="background-color:#E5E4E2">
                        <h2>Orders</h2>
                        <div class="table-responsive" style="background-color:#E5E4E2">
        <%-- Gridview for Medicine Categories --%>
           
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <div class="row col-md-6" style="margin-left:40%">
                <div class="form-group col-lg-4" style="text-align:center">
    <asp:Label ID="lblStoreName" runat="server" Text="Select Store Name:"></asp:Label>
<asp:LinqDataSource ID="LinqDataSourceMedicalStoreName" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicalStoreName)" TableName="Medical_Stores" ></asp:LinqDataSource>
        <asp:DropDownList ID="ddlMedicalStore" runat="server" class="form-control"  AutoPostBack="true" DataSourceID="LinqDataSourceMedicalStoreName" DataTextField="MedicalStoreName" DataValueField="MedicalStoreName" OnDataBound="ddlMedicalStore_DataBound" OnSelectedIndexChanged="ddlMedicalStore_SelectedIndexChanged"></asp:DropDownList> 
        </div>
                    </div>
          <div class="row " style="margin-left:40%">
                <div class="form-group col-lg-4" style="text-align:center">         
<asp:Label ID="lblReceivedBy" runat="server" Text="Received By:"></asp:Label>
                <asp:TextBox ID="txtReceiverName"   class="form-control" runat="server" ></asp:TextBox>
                     </div>
                    </div>
                <asp:Label ID="lblConfirm" runat="server" />
    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false"  HorizontalAlign="Center" AllowPaging="true"  PageSize="5" OnPageIndexChanging="gvOrders_PageIndexChanging" CssClass="table table-bordered table-hover table-striped" CellSpacing="0">
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
                    <asp:LinkButton ID="lnkApprove" runat="server" Text="Confirm Delivery"  ForeColor="Red" OnClick="lnkApprove_Click" CommandArgument='<%#Eval("OrderIDByMS") %>' Visible='<%#Convert.ToString(Eval("Status"))=="Delivery Pending"?true:false %>'></asp:LinkButton>
                    <asp:Label ID="lblDeliver" runat="server" Text=" Order Delivered" ForeColor="Green" Visible='<%#Convert.ToString(Eval("Status"))=="Delivered"?true:false %>'></asp:Label>
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
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>
    </div>
    </div>
      <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClose"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
             <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
         <asp:UpdatePanel ID="up4" runat="server">
                     <ContentTemplate>            
      <asp:Label ID="lblch" runat="server"></asp:Label>

        <asp:GridView ID="gvViewOrderDetails" runat="server"  CssClass="table table-bordered table-hover table-striped">
        </asp:GridView>
                   </ContentTemplate>
         <Triggers>
            
             <asp:PostBackTrigger ControlID="gvViewOrderDetails" />
         </Triggers>
         </asp:UpdatePanel>
                  <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-danger btn-lg"/>
                 </asp:Panel>
           <div id="dialog" style="display: none">
</div>          
<div class="tab-pane fade" id="ViewOrder" style="text-align:center">
       <%--<div class="row">--%>
           <%--<div class="col-lg-3" style="background-color:#E5E4E2">

           </div>--%>
                    <div class="col-lg-12 col-md-12 col-sm-12" style="background-color:#E5E4E2">
                        <h2>Orders</h2>
                        <div class="table-responsive">
                            
        <%-- Gridview for Medicine Categories --%>
           
       <%-- <asp:ToolkitScriptManager ID="ToolkitScriptManager2" runat="server"></asp:ToolkitScriptManager>--%>
        
                            <asp:UpdatePanel ID="up2" runat="server">
            <ContentTemplate>
     
<asp:LinqDataSource ID="LinqDataSource1" runat="server" ></asp:LinqDataSource>
         
    
    <asp:GridView ID="gvOrderHistory" runat="server" AutoGenerateColumns="false" AllowPaging="true"  HorizontalAlign="Center"  PageSize="5" OnPageIndexChanging="gvOrderHistory_PageIndexChanging" CssClass="table table-bordered table-hover table-striped" PagerStyle-CssClass="bs-pagination">
       <%--<PagerSettings  Mode="NextPrevious" FirstPageText="First" PreviousPageText="Previous"  NextPageText="Next" LastPageText="Last" />--%>
        <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/> 
        <Columns>
            <asp:TemplateField HeaderText="OrderID">
                <ItemTemplate>
                    <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("OrderIDByMS") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delivery Date">
                 <ItemTemplate>
                     <asp:Label ID="lblDate" runat="server" Text='<%#String.Format("{0:M/d/yyyy}",Eval("Delivered_Date")) %>'></asp:Label>
                 </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Status") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="MedicalStoreName">
                <ItemTemplate>
                    <asp:Label ID="lblMedicalStoreName" runat="server" Text='<%#Eval("MedicalStoreName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Date Of Order">
                <ItemTemplate>
                    <asp:Label ID="lblOrderDate" runat="server" Text='<%#Eval("Order_Date") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Placed By">
                <ItemTemplate>
                    <asp:Label ID="lblPlacedBy" runat="server" Text='<%#Eval("Placed_By") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                 
               
                <ItemTemplate>
                    <asp:UpdatePanel ID="up3" runat="server" UpdateMode="Conditional" >
                        
                        <ContentTemplate>
                    <asp:LinkButton ID="lnkView1" runat="server" Text="View Order Detail"  ForeColor="Green" CausesValidation="false" CommandArgument='<%#Eval("OrderIDByMS") %>' OnClick="lnkView_Click1" ></asp:LinkButton>
                       
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lnkView1" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
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
                <asp:AsyncPostBackTrigger ControlID="gvOrderHistory"/>
        </Triggers>

        </asp:UpdatePanel>
                            
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                     <ContentTemplate>
      <%--<asp:Label ID="Label2" runat="server"></asp:Label>--%>
                          <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" Visible="false" />
        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel2" TargetControlID="btnClose2"
    CancelControlID="btnClose2" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
        <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
        <asp:GridView ID="gvOrderDetails" runat="server" HorizontalAlign="Center" CssClass="table table-bordered table-hover table-striped"  >
        </asp:GridView>
             <asp:Button ID="btnClose2" runat="server" Text="Close" CssClass="btn btn-danger btn-lg" />
        </asp:Panel>
                         </ContentTemplate>
         <Triggers>
             <asp:PostBackTrigger ControlID="gvOrderDetails" />
         </Triggers>
           
  
         </asp:UpdatePanel>
    </div>
    
  </div>
           <%--<div class="col-lg-3" style="background-color:#E5E4E2">
           </div>--%>
</div>
</div>
            </div>
        </div>
    </form>
</body>
</html>
