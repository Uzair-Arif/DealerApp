<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="PurchasesReturn.aspx.cs" Inherits="admin_Default" %>
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<form id="form1" runat="server">--%>
        <div class="container-fluid" >
         <!-- Page Heading -->
                <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <%--<h1 class="page-header">
                            Purchase Returns
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> Purchase Return
                            </li>
                        </ol>
                    </div>
                </div>
            <div class="row">
                <div class="col-md-12 col-lg-12 col-sm-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                    <h2 class="panel-title"><i class="fa fa-money fa-fw"></i><b>Purchase Return</b></h2>
                            </div>
                        <div class="panel-body">
             <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
    <asp:GridView ID="gvPurchaseReturn" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" AllowPaging="true" OnPageIndexChanging="gvPurchaseReturn_PageIndexChanging">
        <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>
        <Columns>
            <asp:TemplateField HeaderText="Purchase Number">
                <ItemTemplate>
                    <asp:Label ID="lblPurchaseID" runat="server" Text='<%#Eval("PurchaseID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Purchase Return Date">
                <ItemTemplate>
                    <asp:Label ID="lblReturnDate" runat="server" Text='<%# String.Format("{0:M/d/yyyy}",Eval("ReturnDate")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Order Number">
                <ItemTemplate>
                    <asp:Label ID="lblOrderIDToMC" runat="server" Text='<%#Eval("OrderIDToMC") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Details">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkViewDetails" runat="server" ForeColor="Green" Text="View Details" CommandArgument='<%#Eval("OrderIDToMC") %>' OnClick="lnkViewDetails_Click"></asp:LinkButton>                

                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Invoice">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkGenerateInvoice" ForeColor="Red" runat="server" Text="Generate Invoice" CommandArgument='<%#Eval("PurchaseID") %>' OnClick="lnkGenerateInvoice_Click"></asp:LinkButton>                

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
                 </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvPurchaseReturn" />
        </Triggers>
        </asp:UpdatePanel>
        <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>--%>
       
      <asp:Label ID="lblch" runat="server"></asp:Label>
                         <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClose"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
             <asp:UpdatePanel ID="up4" runat="server">
                                <ContentTemplate>
        <asp:GridView ID="gvPurchaseReturnDetails" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped">
            <Columns>
            <asp:TemplateField HeaderText="Order Number">
                <ItemTemplate>
                    <asp:Label ID="lblOrderIDToMC" runat="server" Text='<%#Eval("OrderIDToMC") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
                <asp:TemplateField HeaderText="Medicine Name">
                <ItemTemplate>
                    <asp:Label ID="lblMedicineName" runat="server" Text='<%#Eval("MedicineName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
                <asp:TemplateField HeaderText="Return Armount">
                <ItemTemplate>
                    <asp:Label ID="lblReturnAmount" runat="server" Text='<%#Eval("ReturnAmount") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        </asp:GridView>
                                     </ContentTemplate>
                                <Triggers>

                                    <asp:PostBackTrigger ControlID="gvPurchaseReturnDetails" />
                                </Triggers>
                            </asp:UpdatePanel>
                <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-danger" />
</asp:Panel>
                        
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
                                   <b> Client Information:D.Watson<asp:Label ID="lblStoreName" runat="server"></asp:Label> </b>
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
                                    Email:watson@gmail.com<asp:Label ID="lblemail" runat="server"></asp:Label>
                                </td>
                                <td style="text-align:right">
                                    Payment Status: Paid
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
        <asp:GridView runat="server" ID="gvPurchaseReturnInvoice" AutoGenerateColumns="false" ShowFooter="true" OnRowDataBound="gvPurchaseReturnInvoice_RowDataBound" CssClass="table table-bordered table-hover table-striped">
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
                       <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("ReturnAmount") %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Remaining Quantity">
                   <ItemTemplate>
                       <asp:Label ID="lblRemainQuantity" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
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

                                    <asp:PostBackTrigger ControlID="gvPurchaseReturnInvoice" />
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
               <%-- </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvPurchaseReturn" />
        </Triggers>
        </asp:UpdatePanel>--%>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <%--</form>--%>
</asp:Content>

