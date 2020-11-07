<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="PurchaseBook.aspx.cs" Inherits="admin_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="c1" ContentPlaceHolderID="head" Runat="Server">
    <%--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>--%>
      <script type="text/javascript">
          $(document).ready(function () {
              $("#myTab a").click(function (e) {
                  e.preventDefault();
                  $(this).tab('show');
              });
          });
</script>
   <script type="text/javascript">
       function pageLoad() {
           $('.bs-pagination td table').each(function (index, obj) {
               convertToPagination(obj)
           });
       }
   </script>
    <%--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css"
    rel="stylesheet" type="text/css" />
     <script type="text/javascript">
         $("[id*=btnPopup]").live("click", function () {
             $("#dialog").dialog({
                 title: "jQuery Dialog Popup",
                 buttons: {
                     Close: function () {
                         $(this).dialog('close');
                     }
                 }
             });
             return false;
         });
</script> --%>
    
    <script type="text/javascript">
        function SearchMedicine(ctrl) {
            if ($(ctrl).val() != null)
                $(".SearchClick").click();
            $(ctrl).focus();
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
    <script type = "text/javascript">
        function CheckBoxCheck(chkB) {
            var IsChecked = chkB.checked;
            if (IsChecked) {
                chkB.parentElement.parentElement.style.backgroundColor = '#F0FFFF';
                chkB.parentElement.parentElement.style.color = 'black';
            }
            else {
                chkB.parentElement.parentElement.style.backgroundColor = 'white';
                chkB.parentElement.parentElement.style.color = 'black';
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
<%--<script type="text/javascript">
    function ValidateText(val) {
        var intValue = parseInt(val.value, 10);

        if (isNaN(intValue)) {
            alert("please enter only number");
        }
    }

</script>--%>
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid" >

         <!-- Page Heading -->
                <div class="row">
                    <div class="col-md-12 col-lg-6">
                       <%-- <h1 class="page-header">
                            Orders To Medicine Company
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-book"></i> Purchase Book
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
    <%--<form id="PurchaseBookform" runat="server">--%>
        <%--<asp:Button ID="btnPopup" runat="server"  Text="button popup"/>--%>
       <%-- <div id="dialog" style="display: none">
    
</div>--%>
    <div role="tabpanel">
        

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" style="margin-left:0%" id="myTab">
    <li class="active"><a href="#OrderBook" >Order Book</a></li>
    <li ><a href="#ViewOrder">View Order</a></li>
    
  </ul>
   </div>

  <!-- Tab panes -->
         
  <div class="tab-content">
    <div class="tab-pane fade in active" id="OrderBook" style="text-align:center">
        <br />
        <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>--%>
        <asp:LinqDataSource ID="linqdatasourceMedicineCompany" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicineCompanyName)" TableName="Medicine_Companies"></asp:LinqDataSource>
        <div class="row">  
            <div class="form-inline"> 
                <div class="form-group">   
         <asp:Label ID="lblMedicineComapany" runat="server" Text="Medicine Company"></asp:Label>
                <asp:DropDownList ID="ddlMedicineCompany" runat="server" AutoPostBack="true" CssClass="form-control" DataSourceID="linqdatasourceMedicineCompany" DataTextField="MedicineCompanyName" DataValueField="MedicineCompanyName" OnDataBound="ddlMedicineCompany_DataBound" OnSelectedIndexChanged="ddlMedicineCompany_SelectedIndexChanged"></asp:DropDownList>
       
                </div>
                
                <div class="form-group">
         <asp:Label ID="lblDueDate" runat="server" Text="Due Date:"></asp:Label>
        <asp:TextBox ID="txtDueDate" runat="server" placeholder="Select Date" CssClass="form-control"   ValidationGroup="Date"></asp:TextBox>
                    <div id="err_due_date" class="text-danger"></div>
                    </div>
                
        <asp:RequiredFieldValidator ID="rqDate" runat="server" ErrorMessage="*" ControlToValidate="txtDueDate"></asp:RequiredFieldValidator>
        <asp:CalendarExtender ID="CalendarExtenderED2" runat="server" TargetControlID="txtDueDate" PopupButtonID="addtxtExpiryDate" Format="MM/dd/yyyy"></asp:CalendarExtender>
           
        
          <%--<asp:Label ID="lblName" runat="server" Text="Placed By"></asp:Label>    
          <asp:TextBox ID="txtName" runat="server" placeholder="Enter Name"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtName"></asp:RequiredFieldValidator>--%>        
        
       
           
           <button id="btnSearchMedicine" type="button" runat="server" class="SearchClick" onserverclick="btnSearchMedicine_ServerClick"
            style="display: none;">
        </button>
                <div class="form-group">
        <asp:Label runat="server" ID="lblSearchMedicine" Text="Search Medicine"></asp:Label> 
           <asp:TextBox ID="txtSearchMedicine" runat="server" onkeyup="SearchMedicine(this);" ClientIDMode="Static" CssClass="form-control" placeholder="Type Medicne Name" CausesValidation="false"></asp:TextBox>
                    </div>
                </div>
       </div>
      <div class="row pull-left" id="error">
          <asp:Label ID="lblmustselect" runat="server" ForeColor="Red" Font-Size="Larger"></asp:Label>
      </div>
      <div class="row">
          <div class="col-lg-12 col-sm-6">
                        <h2>MEDICINES LIST</h2>
              
                        <div class="table-responsive">
                            <%--<table class="table table-bordered table-hover table-striped">--%>
            <asp:Label ID="lbltest" runat="server" ></asp:Label> 
          <div>            
              <asp:UpdatePanel ID="upPlaceOrder" runat="server">
                 
                  <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearchMedicine" EventName="serverclick" />
            </Triggers>
                  <ContentTemplate>
           <asp:GridView ID="gvPlaceOrder" runat="server" AutoGenerateColumns="false" AllowPaging="true" PagerStyle-CssClass="bs-pagination" CssClass="table table-bordered table-hover table-striped" CellSpacing="0" OnPageIndexChanging="gvPlaceOrder_PageIndexChanging" PageSize="5">
        <PagerStyle CssClass="bs-pagination" HorizontalAlign="Center" />
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
                    <%--<asp:CompareValidator ID="cmpValidator" runat="server" ControlToValidate="txtQuantity" Operator="DataTypeCheck" Type="Integer" Display="Dynamic" ErrorMessage="Value must be a whole number"></asp:CompareValidator>--%>
                   <%--<asp:RangeValidator ID="rngValidator" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Only Positive Number" Display="Dynamic" MinimumValue="1" MaximumValue="500"></asp:RangeValidator>--%>
                  <%--<asp:RegularExpressionValidator ID="rng1" runat="server" ControlToValidate="txtQuantity" Display="Dynamic" ValidationExpression="\d+" ErrorMessage="Only positive Numbers Allowed" ForeColor="Red"></asp:RegularExpressionValidator>--%>
                  <%--<asp:CustomValidator ID="cvQuantity" ForeColor="Red" runat="server" OnServerValidate="cvQuantity_ServerValidate" ControlToValidate="txtQuantity" ErrorMessage="Enter number only"></asp:CustomValidator>--%>
                    <asp:Label ID="lbltxtRequired" ForeColor="Red" runat="server" />
                     </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
                      </ContentTemplate>
                  </asp:UpdatePanel>
              </div>
             <%-- </table>--%>
              
       </div>
                            
              
                <%--<asp:CustomValidator ID="cvQuantity" runat="server" Display="None" OnServerValidate="cvQuantity_ServerValidate" ErrorMessage="no blanks"></asp:CustomValidator>--%>
        <br />
        <div  style="text-align:center">    
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success btn-lg" />
        <asp:Label ID="lblerr" runat="server"></asp:Label>
        </div>
         </div>
          </div>
        <div class="col-lg-3">

        </div>
       
          </div>

      
      
    
  
    <div class="tab-pane fade" id="ViewOrder" style="text-align:center">
       <div class="row">
           
                   
                        <h2>Orders</h2>
           <div class="col-lg-12">
                        <div class="table-responsive">
                            
        <%-- Gridview for Medicine Categories --%>
           
       <%-- <asp:ToolkitScriptManager ID="ToolkitScriptManager2" runat="server"></asp:ToolkitScriptManager>--%>
        <asp:UpdatePanel ID="up2" runat="server">
            <ContentTemplate>
     
<asp:LinqDataSource ID="LinqDataSourceMedicalStoreName" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicalStoreName)" TableName="Medical_Stores"></asp:LinqDataSource>
         
    
    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" AllowPaging="true"  HorizontalAlign="Center"  PageSize="5" OnPageIndexChanging="gvOrders_PageIndexChanging" CssClass="table table-bordered table-hover table-striped" PagerStyle-CssClass="bs-pagination">
       <%--<PagerSettings  Mode="NextPrevious" FirstPageText="First" PreviousPageText="Previous"  NextPageText="Next" LastPageText="Last" />--%>
        <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/> 
        <Columns>
            <asp:TemplateField HeaderText="OrderID">
                <ItemTemplate>
                    <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("OrderIDToMC") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Due Date">
                 <ItemTemplate>
                     <asp:Label ID="lblDate" runat="server" Text='<%# String.Format("{0:M/d/yyyy}",Eval("Due_Date")) %>'></asp:Label>
                 </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Status") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Medicine Company Name">
                <ItemTemplate>
                    <asp:Label ID="lblMedicineCompanyName" runat="server" Text='<%#Eval("MedicineCompanyName") %>'></asp:Label>
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
                    <asp:LinkButton ID="lnkView" runat="server" Text="View Order Detail" ForeColor="Green" CausesValidation="false" CommandArgument='<%#Eval("OrderIDToMC") %>' OnClick="lnkView_Click" ></asp:LinkButton>
                       
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lnkView" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                        </ItemTemplate>
                
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:UpdatePanel ID="upConfirmDelivery" runat="server">
                        <ContentTemplate>
                    <asp:LinkButton ID="lnkDeliver" runat="server" Text="Confirm Delivery" ForeColor="Red"  OnClick="lnkDeliver_Click" CommandArgument='<%#Eval("OrderIDToMC") %>' Visible='<%#Convert.ToString(Eval("Status"))=="Pending"?true:false %>' CausesValidation="false"></asp:LinkButton>
                    <asp:Label ID="lblDeliver" runat="server" Text="Done" ForeColor="Green" Visible='<%#Convert.ToString(Eval("Status"))=="Delivered"?true:false %>'></asp:Label>
                 </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lnkDeliver" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                            </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
                
          
                </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="gvOrders"/>
        </Triggers>

        </asp:UpdatePanel>
                            
    </div>
    </div>
     </div>
                         <%--<asp:Timer ID="t1" runat="server" Interval="1000000000"></asp:Timer>--%>
      <asp:Label ID="lblch" runat="server"></asp:Label>
               <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClose"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>          
        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
             <asp:UpdatePanel ID="up4" runat="server">
                     <ContentTemplate>
                         
        <asp:GridView ID="gvViewOrderDetails" runat="server" HorizontalAlign="Center" CssClass="table table-bordered table-hover table-striped" >
        </asp:GridView>
            

                         </ContentTemplate>
         <Triggers>
             <asp:PostBackTrigger ControlID="gvViewOrderDetails" />
         </Triggers>
         </asp:UpdatePanel>
            <asp:Button ID="btnClose" runat="server" Text="Close" class="btn btn-danger" />
                           </asp:Panel>  
           
                            
      <asp:Label ID="Label1" runat="server"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel5" TargetControlID="btnCloseBatch"
    CancelControlID="btnCloseBatch" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>      
        <asp:Panel ID="Panel5" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
            
            <asp:Button ID="btnCloseBatch" class="close" data-dismiss="modal" runat="server" Text="X"/>
                
           <asp:UpdatePanel ID="Up6" runat="server">
                     <ContentTemplate>
                         
         <asp:GridView ID="gvAddBatchNumber" runat="server"  AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped">
                <Columns>
                    <asp:TemplateField HeaderText="ID">
                        <ItemTemplate>
                           <asp:Label ID="lblOrderIDToMC" runat="server" Text='<%#Eval("OrderIDToMC") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Medicine Name">
                        <ItemTemplate>
                           <asp:Label ID="lblMedicineName" runat="server" Text='<%#Eval("MedicineName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quanity">
                        <ItemTemplate>
                           <asp:Label ID="lblMedicineQuantity" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Price">
                        <ItemTemplate>
                           <asp:TextBox ID="txtPrice" runat="server" Width="70px" ></asp:TextBox>
                            <asp:CustomValidator ErrorMessage="Must be Numbers" ForeColor="Red" ControlToValidate="txtPrice" runat="server"  OnServerValidate="Unnamed_ServerValidate"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Batch Number">
                        <ItemTemplate>
                           <asp:TextBox ID="txtBatchNumber" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mfg Date">
                     <ItemTemplate>
                             <asp:TextBox ID="AddtxtManufactureDate" runat="server" Width="90px" ></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtenderMD1" runat="server" TargetControlID="AddtxtManufactureDate" PopupButtonID="edittxtManufactureDate" Format="MM/dd/yyyy"></asp:CalendarExtender>
                     <asp:RequiredFieldValidator ID="requiredManufactureDate" runat="server" ControlToValidate="AddtxtManufactureDate" ErrorMessage="Required" ForeColor="Red" ></asp:RequiredFieldValidator>
                        </ItemTemplate>
                
                     
                 </asp:TemplateField>
              <asp:TemplateField HeaderText="Exp Date">
                     <ItemTemplate>
                            <asp:TextBox ID="AddtxtExpiryDate" runat="server" Width="90px" CausesValidation="true"></asp:TextBox>
                     <asp:CalendarExtender ID="CalendarExtenderED1" runat="server" TargetControlID="AddtxtExpiryDate" PopupButtonID="edittxtExpiryDate" Format="MM/dd/yyyy"></asp:CalendarExtender>   
                     <%--<asp:RequiredFieldValidator ID="requiredExpiryDate" runat="server" ControlToValidate="AddtxtExpiryDate" ErrorMessage="Required" ForeColor="Red" ></asp:RequiredFieldValidator>--%>
                         <asp:CustomValidator ErrorMessage="Invalid Expiry Date" ControlToValidate="AddtxtExpiryDate" ForeColor="Red" runat="server" ID="cvExpiryDate" OnServerValidate="cvExpiryDate_ServerValidate" />
                        </ItemTemplate>
               
                     
                 </asp:TemplateField>
                    <asp:TemplateField HeaderText="Pack Size">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPackSize" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
                         
                         <asp:Button ID="btnSaveMedicine" runat="server" Text="Save"  OnClick="btnSaveMedicine_Click" Class="btn btn-success btn-lg" CausesValidation="false"/>
                         </ContentTemplate>
         <Triggers>
             <asp:PostBackTrigger ControlID="gvAddBatchNumber" />
         </Triggers>
         </asp:UpdatePanel>
            
            
           </asp:Panel>
             
               
  </div>
       <%--</div>    
  
</div>--%>
</div>
        <script>
            $("#f5").submit(function () {
                if (!(new Date() <= new Date($("#ContentPlaceHolder1_txtDueDate").val()))) {
                    $("#err_due_date").html('Due date must be greater than current date');
                    return false;
                } else {
                    $("#err_due_date").html('');
                }
            });
    </script>
        </div>
<%--</form>--%>
</asp:Content>

