<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Purchase.aspx.cs" Inherits="admin_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="chead" runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript">
        function pageLoad() {
            $('.bs-pagination td table').each(function (index, obj) {
                convertToPagination(obj)
            });
        }
   </script>
    <script type="text/javascript">
        function validateForm(btn) {
            $("#ContentPlaceHolder1_gvPurchasesDetail tr").click(function () {
                // alert(this.rowIndex-1);
                //var row = btn.parentNode.parentNode;
                var indx = this.rowIndex - 1;
                //var indx = this.rowIndex+1 ;
                //alert(indx);
                var name = document.forms["f5"]["ContentPlaceHolder1_gvPurchasesDetail_txtAddReturn_" + indx].value;
                if (name == null || name == "") {
                    // alert(indx);
                    alert("Return must be filled out");
                    // return false;
                }
                else {
                    if (isNaN(name) == true) {
                        alert("Return must be a number.");
                        //return false;
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
        function showSuccessToast() {
            $().toastmessage('showSuccessToast', "Value added");
        }
        function showNoticeToast() {
            $().toastmessage('showNoticeToast', "Notice Dialog");
        }
        function showWarningToast() {
            $().toastmessage('showWarningToast', "OK but value should be at least 8 char");
        }
        function showErrorToast() {
            $().toastmessage('showErrorToast', "Insert a value");
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<form id="form2" runat="server">--%>
        <div class="container-fluid" >
         <!-- Page Heading -->
                <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <%--<h1 class="page-header">
                           Distributor's Purchases
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> Purchase
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                    <h2 class="panel-title"><i class="fa fa-money fa-fw"></i><b>Purchases</b></h2>
                            </div>
                        <div class="panel-body">
                    <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <asp:LinqDataSource ID="lnqDataSourceMedicineCompany" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicineCompanyName)" TableName="Medicine_Companies"></asp:LinqDataSource>
                <asp:DropDownList runat="server" ID="ddlMedicineCompanyName" DataTextField="MedicineCompanyName" DataValueField="MedicineCompanyName" DataSourceID="lnqDataSourceMedicineCompany" AutoPostBack="true" CssClass="form-control" Width="30%" OnDataBound="ddlMedicineCompanyName_DataBound" OnSelectedIndexChanged="ddlMedicineCompanyName_SelectedIndexChanged">
                    
                </asp:DropDownList> 
                </br>   
                <div class="table-responsive">
                        <asp:GridView ID="gvPurchases" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" PageSize="5" AllowPaging="true" OnPageIndexChanging="gvPurchases_PageIndexChanging">
                            <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>
                            <Columns>
                                <asp:BoundField  HeaderText="Purchase Number" DataField="PurchaseID"/>
                                <asp:BoundField  HeaderText="Medicine Company" DataField="MedicineCompanyName"/>
                                <asp:BoundField HeaderText="Order Number" DataField="OrderIDToMC" />
                                <asp:TemplateField HeaderText="Date of Purchase">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDate" runat="server" Text='<%#String.Format("{0:M/d/yyyy}",Eval("Date")) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Details" >
                                    <ItemTemplate>
                                        <asp:UpdatePanel ID="up3" runat="server" UpdateMode="Conditional" >
                        
                        <ContentTemplate>
                                        <asp:LinkButton ID="lnkViewDetails" runat="server" Text="View Details/Add Return" ForeColor="Green" OnClick="lnkViewDetails_Click" CommandArgument='<%#Eval("OrderIDToMC") %>'></asp:LinkButton>
                            </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="lnkViewDetails" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>        
                            </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Invoice" >
                                    <ItemTemplate>
                                        <%--<asp:LinkButton ID="lnkViewDetails" runat="server" Text="View Details" OnClick="lnkViewDetails_Click" CommandArgument='<%#Eval("OrderIDToMC") %>'></asp:LinkButton>--%>
                                        <asp:LinkButton ID="lnkGenrateInvoice" runat="server" Text="Generate Invoice"  ForeColor="Red" OnClick="lnkGenrateInvoice_Click" CommandArgument='<%#Eval("PurchaseID") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
         <Triggers>
            
             <asp:AsyncPostBackTrigger ControlID="gvPurchases" />
         </Triggers>
         </asp:UpdatePanel>
                            </div>
                        </div>
                    <br />
                    
                    <br />
                    <%--<asp:ToolkitScriptManager ID="tk1" runat="server"></asp:ToolkitScriptManager>--%>
        <asp:Button ID="btnShow" runat="server" Text="Show Modal Popup" Visible="false" />
        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClose"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
             <asp:UpdatePanel ID="up4" runat="server">
                     <ContentTemplate>
     <asp:GridView ID="gvPurchasesDetail" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped">
                        <Columns>
                
                             <asp:TemplateField HeaderText="OrderID" >
 
                <ItemTemplate>
                <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("OrderIDToMC") %>' ></asp:Label>
                    <%--<asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>' Width="90"></asp:Label>--%> 
               </ItemTemplate> 
                    </asp:TemplateField>
                            <asp:TemplateField HeaderText="Medicine Company Name" >
 
                <ItemTemplate>
                <asp:Label ID="lblMedicineCompanyName" runat="server" Text='<%#Eval("MedicineCompanyName") %>' ></asp:Label>
                    <%--<asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>' Width="90"></asp:Label>--%> 
               </ItemTemplate> 
                    </asp:TemplateField>
                <asp:TemplateField HeaderText="MedicineName" >
 
                <ItemTemplate>
                <asp:Label ID="lblMedicineName" runat="server" Text='<%#Eval("MedicineName") %>' ></asp:Label>
                    <%--<asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>' Width="90"></asp:Label>--%> 
               </ItemTemplate> 
                    </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                    <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>'></asp:Label> 
                    </ItemTemplate>
                    </asp:TemplateField>
                 <asp:TemplateField HeaderText="Action">
                     <ItemTemplate>
                         <asp:TextBox ID="txtAddReturn" runat="server" placeholder="Add Return Quantity" ></asp:TextBox>
                         <%--<asp:RequiredFieldValidator   ID="rvReturn" ControlToValidate ="txtAddReturn" runat="server" ForeColor="Red" />
                         <asp:CustomValidator ErrorMessage="Please Enter Number Only" ControlToValidate="txtAddReturn" runat="server" ID="cvReturnAmount" OnServerValidate="cvReturnAmount_ServerValidate" />--%>
                     </ItemTemplate>
                 </asp:TemplateField>
                             <asp:TemplateField HeaderText="Action">
                     <ItemTemplate>
                          <asp:UpdatePanel ID="up2" runat="server" UpdateMode="Conditional">
                             <ContentTemplate>
                                 <%--<script type="text/javascript">
                                     Sys.Application.add_load(showSuccessToast);
                               </script>--%>
                         <asp:Button ID="btn1" runat="server" Text="Return" CommandArgument='<%#Eval("MedicineName") %>'  OnClick="btn1_Click" CssClass="btn btn-success" OnClientClick="return validateForm(this)" />
                    </ContentTemplate>
                             <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="btn1"/>
                             </Triggers>
                                 </asp:UpdatePanel>
                                  </ItemTemplate>
                 </asp:TemplateField>
                    
            </Columns>
            
                    </asp:GridView>
        </ContentTemplate>
         <Triggers>
            
             <asp:PostBackTrigger ControlID="gvPurchasesDetail" />
         </Triggers>
         </asp:UpdatePanel>
    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-danger" />
            <asp:Label ID="lblReturnMessage"  runat="server" />
</asp:Panel> 
                    <asp:Label runat="server" ID="lblerr"></asp:Label>
                     <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel2" TargetControlID="btnCloseInvoice"
    CancelControlID="btnCloseInvoice" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
                    <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
                          <table>
                            <tr style="border-bottom:1px solid black">
                                <th style="text-align:center">
                                  <b>  Debis Pharma </b>
                                </th>
                                <th style="text-align:center">
                                   <b> Adress: Comercial Market, Rawalpindi </b>
                                </th>
                            </tr>
                            <tr style="border-bottom:1px solid black">
                                <td style="text-align:left">
                                    Email: debispharma@gmail.com
                                </td>
                                
                                <td style="text-align:right">
                                    call: +92-334-1051020
                                </td>
                            </tr>
                            <tr style="border-bottom:1px solid black">
                                <th style="text-align:center">
                                   <b> Supplier Information:Abbot Pakistan<asp:Label ID="lblStoreName" runat="server"></asp:Label> </b>
                                </th>
                                <th style="text-align:center">
                                   <b> Payment Details </b>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    Address:D/123/Rawalpindi<asp:Label ID="lblAddress" runat="server"></asp:Label>
                                </td>
                                <td style="text-align:right">
                                    Bill Amount:<asp:Label ID="lblAmount" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    Call:0334876082<asp:Label ID="lblPhone" runat="server"></asp:Label>
                                </td>
                                <td style="text-align:right">
                                    Bill Date:6/8/2015<asp:Label ID="lblDate" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    Email:abbot@gmail.com<asp:Label ID="lblemail" runat="server"></asp:Label>
                                </td>
                                <td style="text-align:right">
                                    Payment Status: Paid
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                     <ContentTemplate> 
                    <asp:GridView runat="server" ID="gvInvoice" ShowFooter="true" OnRowDataBound="gvInvoice_RowDataBound" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped">
                         <Columns>
               <asp:TemplateField HeaderText="Product code">
                   <ItemTemplate>
                       <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("MedicineID") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                   <ItemTemplate>
                       <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("MedicineName") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Pack Size">
                   <ItemTemplate>
                       <asp:Label ID="lblPackSize" runat="server" Text='<%#Eval("PackSize") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Batch No">
                   <ItemTemplate>
                       <asp:Label ID="lblBatchNo" runat="server" Text='<%#Eval("BatchNo") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="DOE">
                   <ItemTemplate>
                       <asp:Label ID="lblDOE" runat="server" Text='<%# String.Format("{0:M/d/yyyy}",Eval("ExpiryDate")) %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="RATE">
                   <ItemTemplate>
                       <asp:Label ID="lblRate" runat="server" Text='<%#Eval("Price") %>'></asp:Label>
                   </ItemTemplate>
                   <FooterTemplate>
                       <asp:Label ID="AddlblRate" runat="server"></asp:Label>
                   </FooterTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Quantity">
                   <ItemTemplate>
                       <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
              <%-- <asp:TemplateField HeaderText="Discount Percentage(%)">
                   <ItemTemplate>
                       <asp:Label ID="lblDiscount" runat="server" Text='<%#Eval("Discount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>--%>
              <%-- <asp:TemplateField HeaderText="Discount Amount">
                   <ItemTemplate>
                       <asp:Label ID="lblDiscountAmount" runat="server" Text='<%#Eval("DiscountAmount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>--%>
               <asp:TemplateField HeaderText="Net Amount">
                   <ItemTemplate>
                       <asp:Label ID="lblNetAmount" runat="server" Text='<%#Eval("NetAmount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               
           </Columns>
                    </asp:GridView>
                          </ContentTemplate>
         <Triggers>
            
             <asp:PostBackTrigger ControlID="gvInvoice" />
         </Triggers>
         </asp:UpdatePanel>
 <table>
                            <tr>
                                <td>
                                  <b>Important:</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    This is an Electronic Generated Device so doesn't require any signatures
                                </td>
                            </tr>
                        </table>
                    
                        <asp:Button ID="btnCloseInvoice" runat="server" Text="Close" CssClass="btn btn-danger btn-lg"/>
                        <asp:Button  ID="btnExport" runat="server" Text="Export to PDF" CssClass="btn btn-primary btn-lg" OnClick="btnExport_Click"/>
                        
                        </asp:Panel>
                </div>
            </div>
            </div>
         <%--</form>--%>
</asp:Content>

