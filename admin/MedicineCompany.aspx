<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MedicineCompany.aspx.cs" Inherits="Admin_MedicineCompany" MasterPageFile="~/admin/MasterPage.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript">
         function pageLoad() {
             $('.bs-pagination td table').each(function (index, obj) {
                 convertToPagination(obj)
             });
         }
   </script>
    <script type="text/javascript">
        function validateForm() {
            var name = document.forms["f5"]["ContentPlaceHolder1_addtxtMedicineCompanyName"].value;
            if (name == null || name == "") {
                alert("Name must be filled out");
                return false;
            }
            var phone = document.forms["f5"]["ContentPlaceHolder1_addtxtPhone"].value;
            if (phone == null || phone == "") {
                alert("Phone must be filled out");
                return false;
            }
            var address = document.forms["f5"]["ContentPlaceHolder1_addtxtAddress"].value;
            if (address == null || address == "") {
                alert("Address must be filled out");
                return false;
            }
            var email = document.forms["f5"]["ContentPlaceHolder1_addtxtEmail"].value;
            if (email == null || email == "") {
                alert("Email must be filled out");
                return false;
            }
        }
            </script>
  <script type="text/javascript">
      function Search(ctrl) {
          if ($(ctrl).val() != null)
              $(".SeachClick").click();
          $(ctrl).focus();
      }
    </script>
    </asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<form id="form1" runat="server">--%>
        <div class="container-fluid" >
         <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <%--<h1 class="page-header">
                            Medicine Company
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-copy"></i> Medicine Company
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
    <div class="row" style="margin-left:3px;">
                <button id="btnSearch" type="button" runat="server" class="SeachClick" onserverclick="btnSearch_ServerClick"
            style="display: none;">
        </button>
        <asp:Label runat="server" ID="lblSearchMedi" Text="<b>Search Company Name </b>"></asp:Label> <asp:TextBox ID="txtSearch" runat="server" pattern="[a-zA-Z\s]+" onkeyup="Search(this);" ClientIDMode="Static" placeholder="Type Company Name" CssClass="form-control" Width="30%"></asp:TextBox>

            </div>
    <div class="row">
                    <div class="col-lg-12 col-sm-6">
                       
                        <div class="table-responsive">
        <%-- Gridview for Medicine Categories --%>
           <asp:Button ID="btnAddMedicineCompany" runat="server" OnClick="btnAddMedicineCompany_Click" Text="+ Add Medicine Company" CssClass="btn btn-success btn-lg pull-right"  />
        <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>--%>
                            <br />
                            <br />
                            <br />
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                    <h2 class="panel-title"> <i class="fa fa-money fa-fw"></i><b>List of Sale Return Invoices</b></h2>
                        </div>
                                        <div class="panel-body">
        <asp:UpdatePanel ID="up1" runat="server">
             <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="serverclick" />
            </Triggers>
            <ContentTemplate>
                
             <div style="overflow-x:auto;width:100%;">   
    <asp:GridView ID="gvMedicineCompany" runat="server"   CssClass="table table-bordered table-hover table-striped" CellSpacing="0" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvMedicineCompany_PageIndexChanging" AutoGenerateColumns="False" OnRowCancelingEdit="gvMedicineCompany_RowCancelingEdit" OnRowEditing="gvMedicineCompany_RowEditing" Width="100%" OnRowUpdating="gvMedicineCompany_RowUpdating" >
       <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>
         <Columns>
            <asp:TemplateField HeaderText="MedicalCompanyID" ItemStyle-CssClass="hidden-phone" HeaderStyle-CssClass="hidden-phone">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineCompanyID" runat="server" Text='<%# Eval("MedicineCompanyID") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:Label ID="editlblMedicineCompanyID" runat="server" Text='<%# Eval("MedicineCompanyID") %>'></asp:Label>
                        
                </EditItemTemplate>


                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Medicine Company Name">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineCompanyName" runat="server" Text='<%# Eval("MedicineCompanyName") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtMedicineCompanyName" runat="server" Text='<%# Eval("MedicineCompanyName") %>' pattern="[a-zA-Z,.]+"></asp:TextBox>
                    <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="edittxtMedicineCompanyName" runat="server" ForeColor="Red" />
                    <asp:CustomValidator ErrorMessage="Please Enter Letters Only" ControlToValidate="edittxtMedicineCompanyName" runat="server" ID="rqtxtMedicineCompanyName" OnServerValidate="rqtxtMedicineCompanyName_ServerValidate" ForeColor="Red"  />
                </EditItemTemplate>
                     
                 </asp:TemplateField>
              <asp:TemplateField HeaderText="Phone">
                     <ItemTemplate>
                            <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtPhone" runat="server" Text='<%# Eval("Phone") %>' pattern="^\d{4}-\d{3}-\d{4}$"></asp:TextBox>
                    <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="edittxtPhone" runat="server" ForeColor="Red" />
                    <asp:CustomValidator ErrorMessage="Please Enter Number Only" ControlToValidate="edittxtPhone" runat="server"  ForeColor="Red" ID="cvPhone" OnServerValidate="cvPhone_ServerValidate"/>   
                </EditItemTemplate>
             
                 </asp:TemplateField>
             <asp:TemplateField HeaderText="Address">
                     <ItemTemplate>
                            <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtAddress" runat="server" Text='<%# Eval("Address") %>' pattern="[a-zA-Z0-9 /\\@#$%&]+"></asp:TextBox>
                    
                </EditItemTemplate>
                     
                 </asp:TemplateField>
              <asp:TemplateField HeaderText="Email">
                     <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtEmail" runat="server" Text='<%# Eval("Email") %>' pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"></asp:TextBox>
                    <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="edittxtEmail" runat="server" ForeColor="Red" />   
                    <asp:CustomValidator ErrorMessage="Please Enter Correct Mail" ControlToValidate="edittxtEmail" runat="server" ID="cvEmail" ForeColor="Red" OnServerValidate="cvEmail_ServerValidate" />
                </EditItemTemplate>

              </asp:TemplateField>
              <asp:TemplateField HeaderText="Alternative Email">
                     <ItemTemplate>
                            <asp:Label ID="lblAlternativeEmail" runat="server" Text='<%# Eval("AlternativeEmail") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtAlternativeEmail" runat="server" Text='<%#Eval("AlternativeEmail") %>' pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"></asp:TextBox>
                        
                </EditItemTemplate>
                     
                 </asp:TemplateField>
          <asp:TemplateField HeaderText="Alternative Phone">
                     <ItemTemplate>
                            <asp:Label ID="lblAlternativePhone" runat="server" Text='<%# Eval("AlternativePhone") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtAlternativePhone" runat="server" Text='<%#Eval("AlternativePhone") %>' pattern="^\d{4}-\d{3}-\d{4}$"></asp:TextBox>
                        
                </EditItemTemplate>
                     
                 </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fax">
                     <ItemTemplate>
                            <asp:Label ID="lblFax" runat="server" Text='<%# Eval("Fax") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtFax" runat="server" Text='<%#Eval("Fax") %>' pattern="^\d{4}-\d{3}-\d{4}$"></asp:TextBox>
                        
                </EditItemTemplate>
                     
                 </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("MedicineCompanyID") %>' Text="Delete" OnClientClick="return confirm('Do you want to delete?')" OnClick="lnkDelete_Click" ForeColor="Red"></asp:LinkButton>
                        </ItemTemplate>
                     
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="true" ControlStyle-ForeColor="Green" />
        </Columns>
    </asp:GridView>
                 </div>
                    
   </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvMedicineCompany" />
        </Triggers>
        </asp:UpdatePanel>
                                            </div>
                                        </div>
                                    </div>
                                </div>
        <asp:Label ID="lblerr" runat="server"></asp:Label>
                            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
    
   
               <table>
                   <tr>
                       <td>
         <asp:Label ID="lblMedicineCompanyName" runat="server" Text="Medicine Company Name"></asp:Label>
                           </td>
                       <td>
         <asp:TextBox ID="addtxtMedicineCompanyName" runat="server" Width="100%" CssClass="form-control" pattern="[A-Za-z\s]*" placeholder="Enter Company Name"></asp:TextBox>
        </td>
                           </tr>
                   <tr>
                       <td>
                           <asp:Label ID="lblPhone" runat="server" Text="Phone"></asp:Label>
                       </td>
                       <td>
                           <asp:TextBox ID="addtxtPhone" runat="server" Width="100%" CssClass="form-control" pattern="(?:\(\d{3}\)|\d{4})[- ]?\d{3}[- ]?\d{4}" placeholder="Enter Phone Number"></asp:TextBox>
                       </td>
                   </tr>
                   <tr>
                       <td>
                           <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
                       </td>
                       <td>
                           <asp:TextBox ID="addtxtAddress" runat="server" Width="100%" CssClass="form-control" pattern="[a-zA-Z0-9 /\\@#$%&]+"  placeholder="Enter Store Address"></asp:TextBox>
                       </td>
                   </tr>
                   <tr>
                       <td>
                           <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                       </td>
                       <td>
                           <asp:TextBox ID="addtxtEmail" runat="server" Width="100%" CssClass="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}" placeholder="Enter Email"></asp:TextBox>
                       </td>
                   </tr>
                   <tr>
                       <td>
                           <asp:Label ID="lblAlternativeEmail" runat="server" Text="Alternative Email"></asp:Label>

                       </td>
                       <td>
                           <asp:TextBox ID="txtAddAlternativeEmail" runat="server" Width="100%" CssClass="form-control"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}" placeholder="Enter Alternate Email"></asp:TextBox>
                       </td>
                   </tr>
                   <tr>
                       <td>
                           <asp:Label ID="lblAlternativePhone" runat="server" Text="Alternative Phone"></asp:Label>
                       </td>
                       <td>
                           <asp:TextBox ID="txtAddAlternativePhone" runat="server" Width="100%" CssClass="form-control" pattern="(?:\(\d{3}\)|\d{4})[- ]?\d{3}[- ]?\d{4}" placeholder="Enter Alternate Phone#"></asp:TextBox>
                       </td>
                   </tr>
                   <tr>
                       <td>
                           <asp:Label ID="lblFax" runat="server" Text="Fax"></asp:Label>
                       </td>
                       <td>
                           <asp:TextBox ID="txtAddFax" runat="server" Width="100%" CssClass="form-control" pattern="(?:\(\d{3}\)|\d{4})[- ]?\d{3}[- ]?\d{4}" placeholder="Enter Fax #"></asp:TextBox>
                       </td>
                   </tr>
        
       </table>
     <asp:UpdatePanel ID="up2" runat="server" UpdateMode="Conditional">
           <ContentTemplate>
                <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClear"
    CancelControlID="btnClear" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateForm();"/>
           <asp:Button ID="btnClear" runat="server" CssClass="btn btn-danger" Text="Close" />
   
           </ContentTemplate>
           
               </asp:UpdatePanel> 
        <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClientClick="Alert()" />--%>
        
           </asp:Panel>
 

    </div>
         </div>
       </div>
            </div>
    <%--</form>--%>
</asp:Content>