<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderBook.aspx.cs" Inherits="sb_admin_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Sales Representatvie</title>
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
    <script type="text/javascript">
        function Search(ctrl) {
            if ($(ctrl).val() != null)
                $(".SeachClick").click();
            $(ctrl).focus();
        }
    </script>
    <script type="text/javascript">
        function SearchCompany(ctrl) {
            if ($(ctrl).val() != null)
                $(".SeachCompanyClick").click();
            $(ctrl).focus();
        }
        
        function validateForm(btn) {
            $("#gvPlaceOrder tr").click(function () {
                // alert(this.rowIndex-1);
                //var row = btn.parentNode.parentNode;
                var indx = this.rowIndex - 1;
                //var indx = this.rowIndex+1 ;
                //alert(indx);
                var name = document.forms["form1"]["gvPlaceOrder_txtQuantity_" + indx].value;
                if (name == null || name == "") {
                    // alert(indx);
                    alert("Return must be filled out");
                     //return false;
                }
                else {
                    if (isNaN(name) == true) {
                        alert("Return must be a number.");
                       // return false;
                        //name.focus();
                        //name.select();
                    }
                    else {
                        alert("Return Added");
                    }
                }
            })
        }
    </script>
    <script type="text/javascript">
        function validateddl(){
            if ($("#ddlMedicalStore option:selected").text() == "All")
                alert("Wrong");
        }
        //var test = "aslam";
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
        border-width: 3px;
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
    <script type="text/javascript">
        function CheckBoxCheck(chk) {
            var chks = $('[id*=gvPlaceOrder]').find('input');
            var row = $(chk).parent().find('tr');
            for (var i = 0; i < chks.length; i++) {
                if (chks[i].type == "checkbox") {
                    if (chks[i].checked && chks[i] != rb) {
                        chks[i].checked = false;
                        break;
                    }
                }
            }
        }
</script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('[id*=btnSave]').click(function () {
                $('[id*= gvPlaceOrder] tr td:nth-child(1)').each(function () {
                    var rb = $(this).find('[id*=chkOrder]');
                    if (rb.is(':checked')) {
                        if ($.trim($(('[id*= txtQuantity]'), $(rb).closest('tr')).val()) == "") {
                            alert('Please Enter Quantity');
                        }

                    }
                });
            });
        });

</script>
<script type="text/javascript">
    function ValidateText(val) {
        var intValue = parseInt(val.value, 10);

        if (isNaN(intValue)) {
            alert("please enter only number");
        }
    }

</script>
    <script type = "text/javascript">
        function CheckBoxCheck(chkB) {
            var IsChecked = chkB.checked;
            if (IsChecked) {
                chkB.parentElement.parentElement.style.backgroundColor = '#F0FFFF'; //'#A3FFA3';  
                chkB.parentElement.parentElement.style.color = 'black';
            }
            else {
                chkB.parentElement.parentElement.style.backgroundColor = 'white';
                chkB.parentElement.parentElement.style.color = 'black';
            }
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
                
                <a class="navbar-brand" href="../startbootstrap/main.aspx" style="color:white">DEBIS PHARMA</a>
            </div>
        
         <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:white"><i class="fa fa-user"></i> <asp:Label ID="lblUserName"  runat="server"></asp:Label> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        
                        <li>
                            <a href="ChangePassword.aspx"><i class="fa fa-fw fa-gear"></i> Settings</a>
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
       <%-- <div style="background-color:#C0A172">--%>
    <div role="tabpanel" style="background-color: #E5E4E2">
        

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" style="margin-left:40%" id="myTab">
    <li class="active"><a href="#OrderBook" >Order Book</a></li>
    <li><a href="#ViewOrder">View Order</a></li>
    
  </ul>
   </div>

  <!-- Tab panes -->
      <%--<div style="background-color:#E5E4E2">  --%>   
  <div class="tab-content">
    <div class="tab-pane fade in active" id="OrderBook" style="text-align:center">
        <br />
       
            
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
        <asp:LinqDataSource ID="linqsourceMedicalStore" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicalStoreName)" TableName="Medical_Stores"></asp:LinqDataSource>
         <div class="form-inline">    
        <div class="form-group">
            <asp:Label ID="lblMedicalStore" runat="server" Text="<b>Medical Store</b>"></asp:Label>
           
             <asp:DropDownList ID="ddlMedicalStore" runat="server" AutoPostBack="true" DataSourceID="linqsourceMedicalStore" DataTextField="MedicalStoreName" DataValueField="MedicalStoreName"  OnDataBound="ddlMedicalStore_DataBound" CssClass="form-control" Width="60%" OnSelectedIndexChanged="ddlMedicalStore_SelectedIndexChanged"></asp:DropDownList>
         
                    <br />
            <div id="err_ddlStore" class="text-danger"></div>
            <%--<asp:Label ID="lblerr" runat="server" ForeColor="Red"></asp:Label>--%>        
        </div>
               
               <div class="form-group"> 
         <asp:Label ID="lblDueDate" runat="server" Text="<b>Due Date:</b>"></asp:Label>
        <asp:TextBox ID="txtDueDate" runat="server" placeholder="Select Date" CssClass="form-control" Width="72%" required="required"></asp:TextBox>
                    <div id="err_due_date" class="text-danger"></div>
                         </div>
                  
        <asp:RequiredFieldValidator ID="rqDate" runat="server" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtDueDate"></asp:RequiredFieldValidator>
        <asp:CalendarExtender ID="CalendarExtenderED2" runat="server" TargetControlID="txtDueDate" PopupButtonID="addtxtExpiryDate" Format="MM/dd/yyyy"></asp:CalendarExtender>
                   
          <button id="btnSearch" type="button" runat="server" class="SeachClick" onserverclick="btnSearch_ServerClick"
            style="display: none;">
        </button>
              <div class="form-group">
        <asp:Label runat="server" ID="lblSearchMedi" Text="<b>Search Medicine:</b>"></asp:Label> <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server"  onkeyup="Search(this);" ClientIDMode="Static" placeholder="Type Medicne Name"></asp:TextBox>
                </div>
              <button id="btnSearchCompany" type="button" runat="server" class="SeachCompanyClick" onserverclick="btnSearchCompany_ServerClick"
            style="display: none;">
        </button>
        <div class="form-group">
        <asp:Label runat="server" ID="lblCompanyName" Text="<b>Search Medicine By Company:</b>"></asp:Label> <asp:TextBox ID="txtSearchByCompany" CssClass="form-control" runat="server" onkeyup="SearchCompany(this);" ClientIDMode="Static" placeholder="Type Company Name"></asp:TextBox>
            </div>
              <br />
        <br /> &nbsp;&nbsp;&nbsp;&nbsp;
        <div class="form-group"> 
          <asp:Label ID="lblName" runat="server" Text="<b>Placed By:</b>"></asp:Label>    
          <asp:TextBox ID="txtName" runat="server" placeholder="Enter Name" CssClass="form-control" Width="67%"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtName"></asp:RequiredFieldValidator>        
       </div>
           
         
       
       </div>                
            <br />
            <br />
                <br />
      <%-- <div class="col-lg-3" style="background-color:#E5E4E2">

       </div>--%>
      
      <div class="col-lg-12 col-sm-12 col-md-12" style="background-color:#E5E4E2">
                        <h2>MEDICINES LIST</h2>
                        <div class="table-responsive" style="background-color: #E5E4E2">
                            <%--<table class="table table-bordered table-hover table-striped">--%>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="serverclick" />
            </Triggers>
                                 <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearchCompany" EventName="serverclick" />
            </Triggers>
                                
            <ContentTemplate>
            <asp:Label ID="lbltest" runat="server" ></asp:Label> 
          <div>            
           <asp:GridView ID="gvPlaceOrder" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" CellSpacing="0" style="background-color: #E5E4E2" AllowPaging="true" PageSize="10" OnPageIndexChanging="gvPlaceOrder_PageIndexChanging">
        <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>
               <Columns>
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                  
                    <asp:CheckBox ID="chkOrder" runat="server" onclick="CheckBoxCheck(this);"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MedicineName" HeaderText="Name"/>
            <%--<asp:BoundField DataField="Amount"  HeaderText="Amount"/>--%>
            <asp:BoundField  DataField="Price" HeaderText="Price"/>
            <asp:BoundField  DataField="MedicineCompanyName" HeaderText="Company"/>
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:TextBox ID="txtQuantity" runat="server" placeholder="Enter Quantity" onkeyup="ValidateText(this)" CssClass="form-control"></asp:TextBox>
                    <br />
                    <asp:Label ID="lbltxtRequried" runat="server" ForeColor="Red"></asp:Label>
                    <%--<asp:CompareValidator ID="cmpValidator" runat="server" ControlToValidate="txtQuantity" Operator="DataTypeCheck" Type="Integer" Display="Dynamic" ErrorMessage="Value must be a whole number"></asp:CompareValidator>
                   <%--<asp:RangeValidator ID="rngValidator" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Only Positive Number" Display="Dynamic" MinimumValue="1" MaximumValue="500"></asp:RangeValidator>--%>
                  <%--<asp:RegularExpressionValidator ID="rng1" runat="server" ControlToValidate="txtQuantity" Display="Dynamic" ValidationExpression="\d+" ErrorMessage="Only positive Numbers Allowed" ForeColor="Red"></asp:RegularExpressionValidator>--%>
                    <%--<asp:CustomValidator ErrorMessage="Quantity" ControlToValidate="txtQuantity" runat="server" ID="cvQuantity" OnServerValidate="cvQuantity_ServerValidate" />--%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount(%)">
                <ItemTemplate>
                    <asp:TextBox ID="txtDiscount" runat="server" placeholder="Enter Discount" CssClass="form-control" onkeyup="ValidateText(this)"></asp:TextBox>
                    <%--<asp:CompareValidator ID="cmp1Validator" runat="server" ControlToValidate="txtDiscount" Operator="DataTypeCheck" Type="Integer" Display="Dynamic" ErrorMessage="Value must be a whole number"></asp:CompareValidator>--%>
                   <%--<asp:RangeValidator ID="rngValidator" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Only Positive Number" Display="Dynamic" MinimumValue="1" MaximumValue="500"></asp:RangeValidator>--%>
                  <%--<asp:RegularExpressionValidator ID="rng2" runat="server" ControlToValidate="txtDiscount" Display="Dynamic" ValidationExpression="\d+" ErrorMessage="Only positive Numbers Allowed" ForeColor="Red"></asp:RegularExpressionValidator>--%>
                    <asp:Label ID="lbldscRequried" runat="server" ForeColor="Red"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
              </div>
                </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvPlaceOrder" />
        </Triggers>
        </asp:UpdatePanel>
             <%-- </table>--%>
              
       </div>
               <div id="dialog" style="display: none">
</div>                     
              
                <%--<asp:CustomValidator ID="cvQuantity" runat="server" Display="None" OnServerValidate="cvQuantity_ServerValidate" ErrorMessage="no blanks"></asp:CustomValidator>--%>
        <br />
        <div  style="text-align:center">  
            
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success btn-lg"  OnClientClick="return validateForm(this)" />
          
        </div>
         </div>
      
       <%-- <div class="col-lg-3" style="background-color:#E5E4E2">

        </div>--%>
       
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
     
<asp:LinqDataSource ID="LinqDataSourceMedicalStoreName" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicalStoreName)" TableName="Medical_Stores"></asp:LinqDataSource>
         
    
    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" AllowPaging="true" HorizontalAlign="Center"  PageSize="5" OnPageIndexChanging="gvOrders_PageIndexChanging" CssClass="table table-bordered table-hover table-striped" PagerStyle-CssClass="bs-pagination">
       <%--<PagerSettings  Mode="NextPrevious" FirstPageText="First" PreviousPageText="Previous"  NextPageText="Next" LastPageText="Last" />--%>
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
                    <asp:LinkButton ID="lnkView" runat="server" Text="View Order Detail" ForeColor="Green"  CausesValidation="false" CommandArgument='<%#Eval("OrderIDByMS") %>' OnClick="lnkView_Click" ></asp:LinkButton>
                       
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lnkView" EventName="Click" />
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
                <asp:AsyncPostBackTrigger ControlID="gvOrders"/>
        </Triggers>

        </asp:UpdatePanel>
                            
     <asp:UpdatePanel ID="up4" runat="server">
                     <ContentTemplate>
      <asp:Label ID="lblch" runat="server"></asp:Label>
                          <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" Visible="false" />
        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClose"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
        <asp:GridView ID="gvViewOrderDetails" runat="server" HorizontalAlign="Center" CssClass="table table-bordered table-hover table-striped" >
        </asp:GridView>
             <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-danger" />
        </asp:Panel>
                         </ContentTemplate>
         <Triggers>
             <asp:PostBackTrigger ControlID="gvViewOrderDetails" />
         </Triggers>
           
  
         </asp:UpdatePanel>
    </div>
    
  </div>
           <%--<div class="col-lg-3" style="background-color:#E5E4E2">
           </div>--%>
</div>
</div>
       
    </form>
    <script>
        $("#form1").submit(function () {
            if (!(new Date() <= new Date($("#txtDueDate").val()))) {
                $("#err_due_date").html('Due date must be greater than current date');
                return false;
            } else {
                $("#err_due_date").html('');
            }
            if ($("#ddlMedicalStore option:selected").text() == "All") {
                $("#err_ddlStore").html('Please Select');
                return false;
            }
           // if ($("#gvPlaceOrder_txtQuantity_1").val() {
                var value = $("#gvPlaceOrder_txtQuantity_1").val();
                if (NaN(value)) {
                    alert("Not a Number")
                    return false;
                }
            //}


            
        });
        //if ($("#gvPlaceOrder_txtQuantity_1").focusin(function ()
        //{
        //    var value = $("#gvPlaceOrder_txtQuantity_1").val();
        //    if (NaN(value))
        //{
        //       alert("Not a Number")
        //       return false;
        //}

        
        //}));
        
    </script>
</body>
</html>

