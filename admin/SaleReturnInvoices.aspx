<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="SaleReturnInvoices.aspx.cs" Inherits="admin_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            $('.bs-pagination td table').each(function (index, obj) {
                convertToPagination(obj)
            });
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
                            Sale Return Invoices
                        </h1>--%>
                       <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> Sale Return Invoices
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="panel panel-default">
                    <div class="panel-heading">
                    <h2 class="panel-title"> <i class="fa fa-money fa-fw"></i><b>List of Sale Return Invoices</b></h2>
                        </div>
                        <div class="panel-body">
                    
                    <div class="table-responsive">
                        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                        <asp:GridView ID="gvSaleReturnInvoices" runat="server" AutoGenerateColumns="false" PageSize="5" AllowPaging="true" OnPageIndexChanging="gvSaleReturnInvoices_PageIndexChanging" CssClass="table table-bordered table-hover table-striped">
                           <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>
                             <Columns>
                                <asp:TemplateField HeaderText="ID">
                                   <ItemTemplate>
                                       <asp:Label ID="lblID" runat="server" Text='<%#Eval("srInvoice") %>'></asp:Label>
                                   </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sale Return Invoice Date">
                                   <ItemTemplate>
                                       <asp:Label ID="lblSaleReturnDate" runat="server" Text='<%#Eval("srInvoiceDate") %>'></asp:Label>
                                   </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Quantity">
                                   <ItemTemplate>
                                       <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity") %>'></asp:Label>
                                   </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Price">
                                   <ItemTemplate>
                                       <asp:Label ID="lblPrice" runat="server" Text='<%#Eval("Price") %>'></asp:Label>
                                   </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sale Return Number">
                                   <ItemTemplate>
                                       <asp:Label ID="lblSaleID" runat="server" Text='<%#Eval("SaleReturnID") %>'></asp:Label>
                                   </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkSaleReturnInvoiceDetail" runat="server" ForeColor="Green" CommandArgument='<%#Eval("SaleReturnID") %>' Text="SaleReturnInvoiceDetails" OnClick="lnkSaleReturnInvoiceDetail_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                         </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvSaleReturnInvoices" />
        </Triggers>
        </asp:UpdatePanel>
                        <br />
                        <%--<asp:ToolkitScriptManager ID="tk1" runat="server"></asp:ToolkitScriptManager>--%>
                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel2" TargetControlID="btnCloseInvoice"
    CancelControlID="btnCloseInvoice" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
                    <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup"  align="center" style = "display:none; margin-right:15px">
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
                                   <b> Client Information:D.Watson<asp:Label ID="lblStoreNamewdc" runat="server"></asp:Label> </b>
                                </th>
                                <th style="text-align:center">
                                   <b> Payment Details </b>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    Address: D/123/Rawalpindi<asp:Label ID="lblStoreAddresswdc" runat="server"></asp:Label>
                                </td>
                                <td style="text-align:right">
                                    Bill Amount:<asp:Label ID="lblAmountwdc" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    Call:0334876082<asp:Label ID="lblPhonewdc" runat="server"></asp:Label>
                                </td>
                                <td style="text-align:right">
                                    Bill Date:6/8/2015<asp:Label ID="lblDatewdc" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    Email:dwatson@gmail.com<asp:Label ID="lblEmailwdc" runat="server"></asp:Label>
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
               <asp:TemplateField HeaderText="Return Quantity">
                   <ItemTemplate>
                       <asp:Label ID="lblReturnQuantity" runat="server" Text='<%#Eval("ReturnAmount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Remaining Quantity">
                   <ItemTemplate>
                       <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Discount Percentage(%)">
                   <ItemTemplate>
                       <asp:Label ID="lblDiscount" runat="server" Text='<%#Eval("Discount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Discount Amount">
                   <ItemTemplate>
                       <asp:Label ID="lblDiscountAmount" runat="server" Text='<%#Eval("DiscountAmount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Net Amount">
                   <ItemTemplate>
                       <asp:Label ID="lblNetAmount" runat="server" Text='<%#Eval("NetAmount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
                <asp:TemplateField HeaderText=" Return Net Amount">
                   <ItemTemplate>
                       <asp:Label ID="lblReturnNetAmount" runat="server" Text='<%#Eval("ReturnNetAmount") %>'></asp:Label>
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
                         <asp:Button ID="btnExport" runat="server" Text="Export to PDF" CssClass="btn btn-primary btn-lg" OnClick="btnExport_Click" />
             &nbsp;&nbsp;&nbsp;
                       <asp:Button ID="btnCloseInvoice" runat="server" Text="Close" CssClass="btn btn-danger btn-lg" />
                        <%--<asp:Button  ID="btnExport" runat="server" Text="Export to PDF" OnClick="btnExport_Click"/>--%>
                        </asp:Panel>
                        
                    </div>
                   <%-- </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvSaleReturnInvoices" />
        </Triggers>
        </asp:UpdatePanel>--%>
            </div>
                        </div>
                        </div>
                </div>
            
    
         <%--</form>--%>
</asp:Content>

