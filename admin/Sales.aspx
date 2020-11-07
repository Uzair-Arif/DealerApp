<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Sales.aspx.cs" Inherits="admin_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register TagPrefix="cc1" Namespace="ControlFreak" Assembly="ExportPanel" %>
<asp:Content ID="c1" runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript">
        function pageLoad() {
            $('.bs-pagination td table').each(function (index, obj) {
                convertToPagination(obj)
            });
        }
    </script>
    <script type="text/javascript">
        //function Getrowindex() {
        //    $("table tr").click(function () {
                
        //        return this.rowIndex - 1;
        //    })
        //};
        function validateForm(btn) {
            $("#ContentPlaceHolder1_gvSalesDetail tr").click(function () {
                // alert(this.rowIndex-1);
                //var row = btn.parentNode.parentNode;
                var indx=this.rowIndex-1;
                //var indx = this.rowIndex+1 ;
                //alert(indx);
                    var name = document.forms["f5"]["ContentPlaceHolder1_gvSalesDetail_txtAddReturn_" +indx ].value;
                    if (name == null || name == "") {
                        // alert(indx);
                        alert("Return must be filled out");
                       // return false;
                    }
                    else
                    {
                        if (isNaN(name) == true) {
                            alert("Return must be a number.");
                            //return false;
                            //name.focus();
                            //name.select();
                        }
                        else
                        {
                            alert("Return Added");
                        }
                    }
                })
            }
       
        //Getrowindex();
            //alert(Getrowindex());
            //var name = document.forms["f5"]["ContentPlaceHolder1_gvSalesDetail_txtAddReturn_" + ].value;
            //if (name == null || name == "") {
            //    alert("Name must be filled out");
            //    return false;
            //}
        //};
           // var $row = $(this).closest('tr').index(this);
            //alert($row);
            //var x = document.getElementById("ContentPlaceHolder1_gvSalesDetail").rows.index;
            //alert(x);
            //alert("amhsjh");
           // document.ge
            //var gettable = document.forms["f5"]["ContentPlaceHolder1_gvSalesDetail"];
            //var getrow=gettable.
           // var x = document.getElementsByTagName("tr");
           // alert(gettable.rowindex);
            //var name = document.forms["f5"]["ContentPlaceHolder1_gvSalesDetail_txtAddReturn_"+x.rowindex].value;
            //if (name == null || name == "") {
            //    alert("Name must be filled out");
            //    return false;
            //}
        
    </script>
    <%--<script src="jQueryToast/src/test/javascript/lib/jquery-1.5.min.js"></script>--%>
    <%--<script src="../assets/js/jquery-1.8.2.min.js"></script>--%>
    <script src="js/jquery-1.11.0.js"></script>
    <link href="jQueryToast/src/main/resources/css/jquery.toastmessage.css" rel="stylesheet" />
    <%--<link href="../assets/jQueryToast/src/main/resources/css/jquery.toastmessage.css" rel="stylesheet" />--%>
    <script src="jQueryToast/src/main/javascript/jquery.toastmessage.js"></script>
    <%--<script src="../assets/jQueryToast/src/test/javascript/jquery.toastmessage.tests.js"></script>--%>
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<form id="form2" runat="server">--%>
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="row">
            <div class="col-md-12 col-lg-6">
                <%--<h1 class="page-header">
                            Sales
                        </h1>--%>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i><a href="Dashboard.aspx">Dashboard</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-table"></i>Sales
                    </li>
                </ol>
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h2 class="panel-title"><i class="fa fa-money fa-fw"></i><b>Sales By Order Information</b></h2>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="up1" runat="server">
                            <ContentTemplate>
                                <asp:LinqDataSource ID="lnqDataSourceMedicalStoreName" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicalStoreName)" TableName="Medical_Stores"></asp:LinqDataSource>
                                <asp:DropDownList runat="server" ID="ddlMedicalStore" AutoPostBack="true" DataSourceID="lnqDataSourceMedicalStoreName" DataTextField="MedicalStoreName" DataValueField="MedicalStoreName"  OnDataBound="ddlMedicalStore_DataBound" CssClass="form-control" Width="30%" OnSelectedIndexChanged="ddlMedicalStore_SelectedIndexChanged">
                                    
                                </asp:DropDownList>
                                </br>
                                <div class="table-responsive">
                                    <asp:GridView ID="gvSales" runat="server" ShowFooter="true" AutoGenerateColumns="false" PageSize="5" CssClass="table table-bordered table-hover table-striped" AllowPaging="true" OnPageIndexChanging="gvSales_PageIndexChanging">
                                        <PagerStyle CssClass="bs-pagination" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundField HeaderText="Sale Number" DataField="SaleID" />
                                            <asp:BoundField  HeaderText="Medical Store Name" DataField="MedicalStoreName"/>
                                            <asp:TemplateField HeaderText="Date of Order">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate" runat="server" Text='<%#String.Format("{0:M/d/yyyy}",Eval("Date")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Order Number" DataField="OrderIDByMS" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:UpdatePanel ID="up3" runat="server" UpdateMode="Conditional">

                                                        <ContentTemplate>
                                                            <asp:LinkButton ID="lnkViewDetails" runat="server" Text="View Details/ Add Return" OnClick="lnkViewDetails_Click" ForeColor="Red" CommandArgument='<%#Eval("OrderIDByMS") %>'></asp:LinkButton>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="lnkViewDetails" EventName="Click" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkGenerateInvoice" runat="server" Text="Generate Invoice" ForeColor="Green" OnClick="lnkGenerateInvoice_Click" CommandArgument='<%#Eval("SaleID") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="gvSales" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <br />

                        <br />
                        <%--<asp:ToolkitScriptManager ID="tk1" runat="server"></asp:ToolkitScriptManager>--%>


                        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClose"
                            CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                            <%--<asp:TextBox runat="server" ID="txtTest" />--%>
                            <asp:UpdatePanel ID="up4" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvSalesDetail" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped">

                                        <Columns>

                                            <asp:TemplateField HeaderText="OrderID">

                                                <ItemTemplate>
                                                    <asp:Label ID="lblOrderID" runat="server" Text='<%#Eval("OrderIDByMS") %>'></asp:Label>
                                                    <%--<asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>' Width="90"></asp:Label>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Medical Store Name">

                                                <ItemTemplate>
                                                    <asp:Label ID="lblMedicalStoreName" runat="server" Text='<%#Eval("MedicalStoreName") %>'></asp:Label>
                                                    <%--<asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>' Width="90"></asp:Label>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="MedicineName">

                                                <ItemTemplate>
                                                    <asp:Label ID="lblMedicineName" runat="server" Text='<%#Eval("MedicineName") %>'></asp:Label>
                                                    <%--<asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>' Width="90"></asp:Label>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action" >

                                                <ItemTemplate >
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:TextBox ID="txtAddReturn" runat="server" placeholder="Add Return Quantity"></asp:TextBox>
                                                            <%--<asp:RequiredFieldValidator ID="rvReturn" ErrorMessage="Please enter Value" ControlToValidate="txtAddReturn" runat="server" ForeColor="Red" ValidationGroup='<%# "Group_" + Container.UniqueID %>' />
                                                            <asp:CustomValidator ErrorMessage="Please Enter Correct Amount" ControlToValidate="txtAddReturn" runat="server" ID="cvReturnAmount" ForeColor="Red" OnServerValidate="cvReturnAmount_ServerValidate" />--%>

                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="txtAddReturn" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:UpdatePanel ID="up2" runat="server">
                                                        <ContentTemplate>
                                                            <%--<script type="text/javascript">
                                     Sys.Application.add_load(showSuccessToast);
                               </script>--%>
                                                            <asp:Button ID="btn1" runat="server" Text="Return" CommandArgument='<%#Eval("MedicineName") %>' OnClick="btn1_Click" CssClass="btn btn-success" OnClientClick="return validateForm(this)" />

                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="btn1" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>

                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>

                                    <asp:PostBackTrigger ControlID="gvSalesDetail" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" CssClass="btn btn-danger" />
                            <asp:Label ID="lblReturnMessage" runat="server" />
                        </asp:Panel>

                        <asp:Label runat="server" ID="lblerr"></asp:Label>
                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel2" TargetControlID="btnCloseInvoice"
                            CancelControlID="btnCloseInvoice" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <%--<cc1:exportpanel id="ExportPanel1" runat="server" Height="207px" Width="688px" BorderWidth="1px"
                                                            BorderStyle="Dotted" ScrollBars="Both">--%>
                        <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup" align="center" Style="display: none">

                            <table>
                                <tr style="border-bottom: 1px solid black">
                                    <th style="text-align: center">
                                        <b>Debis Pharma </b>
                                    </th>
                                    <th style="text-align: center">
                                        <b>Adress: Comercial Market, Rawalpindi </b>
                                    </th>
                                </tr>
                                <tr style="border-bottom: 1px solid black">
                                    <td style="text-align: left">Email: debispharma@gmail.com
                                    </td>

                                    <td style="text-align: right">call: +92-334-1051020
                                    </td>
                                </tr>
                                <tr style="border-bottom: 1px solid black">
                                    <th style="text-align: center">
                                        <b>Client Information:D.Watson<asp:Label ID="lblStoreName" runat="server"></asp:Label>
                                        </b>
                                    </th>
                                    <th style="text-align: center">
                                        <b>Payment Details </b>
                                    </th>
                                </tr>
                                <tr>
                                    <td style="text-align: left">Address:D/123/Rawalpindi<asp:Label ID="lblAddress" runat="server"></asp:Label>
                                    </td>
                                    <td style="text-align: right">Bill Amount:<asp:Label ID="lblAmount" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left">Call:03345876532<asp:Label ID="lblPhone" runat="server"></asp:Label>
                                    </td>
                                    <td style="text-align: right">Bill Date:6/8/2015<asp:Label ID="lblDate" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left">Email:dwatson@gmail.com<asp:Label ID="lblemail" runat="server"></asp:Label>
                                    </td>
                                    <td style="text-align: right">Payment Status: Paid
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:GridView runat="server" ID="gvInvoice" ShowFooter="true" OnRowDataBound="gvInvoice_RowDataBound" AutoGenerateColumns="false" CssClass="table table-striped">
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

                                            <asp:TemplateField HeaderText="Qty">
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
                                    <td>This is an Electronic Generated Device so doesn't require any signatures
                                    </td>
                                </tr>
                            </table>

                            <asp:Button ID="btnCloseInvoice" runat="server" Text="Close" CssClass="btn btn-danger btn-lg" />
                            <asp:Button ID="btnExportDC" runat="server" Text="Export to PDF" CssClass="btn btn-primary btn-lg" OnClick="btnExportDC_Click" />
                        </asp:Panel>
                        <%--</cc1:exportpanel>--%>
                        <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" PopupControlID="Panel3" TargetControlID="btnCloseInvoiceWithoutDc"
                            CancelControlID="btnCloseInvoiceWithoutdc" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Panel3" runat="server" CssClass="modalPopup" align="center" Style="display: none">



                            <table>
                                <tr style="border-bottom: 1px solid black">
                                    <th style="text-align: center">
                                        <b>Debis Pharma </b>
                                    </th>
                                    <th style="text-align: center">
                                        <b>Adress: Comercial Market, Rawalpindi </b>
                                    </th>
                                </tr>
                                <tr style="border-bottom: 1px solid black">
                                    <td style="text-align: left">Email: debispharma@gmail.com
                                    </td>

                                    <td style="text-align: right">call: +92-334-1051020
                                    </td>
                                </tr>
                                <tr style="border-bottom: 1px solid black">
                                    <th style="text-align: center">
                                        <b>Client Information:D.Watson<asp:Label ID="lblStoreNamewdc" runat="server"></asp:Label>
                                        </b>
                                    </th>
                                    <th style="text-align: center">
                                        <b>Payment Details </b>
                                    </th>
                                </tr>
                                <tr>
                                    <td style="text-align: left">Address:D/123/Rawalpindi<asp:Label ID="lblStoreAddresswdc" runat="server"></asp:Label>
                                    </td>
                                    <td style="text-align: right">Bill Amount:<asp:Label ID="lblAmountwdc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left">Call:0334876082<asp:Label ID="lblPhonewdc" runat="server"></asp:Label>
                                    </td>
                                    <td style="text-align: right">Bill Date:6/8/2015<asp:Label ID="lblDatewdc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left">Email:dwatson@gmail.com<asp:Label ID="lblEmailwdc" runat="server"></asp:Label>
                                    </td>
                                    <td style="text-align: right">Payment Status: Paid
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>

                                    <asp:GridView runat="server" ID="gvWithoutdc" ShowFooter="true" CssClass="table table-striped" OnRowDataBound="gvWithoutdc_RowDataBound" AutoGenerateColumns="false">
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

                                            <asp:TemplateField HeaderText="Net Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNetAmount" runat="server" Text='<%#Eval("NetAmount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>

                                    <asp:PostBackTrigger ControlID="gvWithoutdc" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <table>
                                <tr>
                                    <td>
                                        <b>Important:</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>This is an Electronic Generated Device so doesn't require any signatures
                                    </td>
                                </tr>
                            </table>
                            <asp:Button ID="btnExport" runat="server" Text="Export to PDF" CssClass="btn btn-primary btn-lg" OnClick="btnExport_Click" />
                            &nbsp;&nbsp;&nbsp;
                       <asp:Button ID="btnCloseInvoiceWithoutdc" runat="server" Text="Close" CssClass="btn btn-danger btn-lg" />

                            <%-- <hr/>--%>
                        </asp:Panel>
                        <%--</div>--%>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <%--</form>--%>
</asp:Content>

