<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="MedicineCategory.aspx.cs" Inherits="admin_Default" %>
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
  <script type="text/javascript">
      function validateForm() {
          var name = document.forms["f5"]["ContentPlaceHolder1_txtCategoryName"].value;
          if (name == null || name == "") {
              alert("Category Name must be filled out");
              return false;
          }
          
          //else
          //{
          //    alert("New Category Added");
          //}
      }
      </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<form id="form1" runat="server">--%>
        <div class="container-fluid" >
         <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <%--<h1 class="page-header">
                            Medicine Category
                            <asp:Label ID="lblsession" runat="server"></asp:Label>
                        </h1>--%>
                       <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-copy"></i> Medicine's Categories
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                
        
   <%--<div class="row">
                    <div class="col-lg-12 col-md-6">--%>
                        <%--<h2>Medicine Category</h2>--%>
                        
                            <asp:Button ID="btnAddCat" runat="server" OnClick="btnAddCat_Click" Text="+ Add Category" CssClass="btn btn-success btn btn-lg pull-right"  />
        <%-- Gridview for Medicine Categories --%>
           <asp:Label ID="test" runat="server"></asp:Label>
        <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>--%>
                            <br />
            <br />
            <br />
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                    <h2 class="panel-title"> <i class="fa fa-plus fa-fw"></i><b>List of Medicines</b></h2>
                        </div>
                                        <div class="panel-body">
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <br />
                
      <asp:GridView ID="gvMedicineCategory" runat="server"  Width="80%" Font-Size="11pt" CellSpacing="0" CssClass="table table-bordered table-hover table-striped" HorizontalAlign="Center" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvMedicineCategory_PageIndexChanging"  PagerStyle-CssClass="bs-pagination"  AutoGenerateColumns="False" OnRowCancelingEdit="gvMedicineCategory_RowCancelingEdit" OnRowEditing="gvMedicineCategory_RowEditing" OnRowUpdating="gvMedicineCategory_RowUpdating" >
          <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>   
          <Columns>
                 <asp:TemplateField HeaderText="ID" HeaderStyle-CssClass="hidden-sm" ItemStyle-CssClass="hidden-sm">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineCategoryID" runat="server" Text='<%# Eval("MedicineCategoryID") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:Label ID="editlblMedicineCategoryID" runat="server" Text='<%# Eval("MedicineCategoryID") %>'></asp:Label>
                        
                </EditItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Category Name">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineCategoryName" runat="server" Text='<%# Eval("MedicineCategoryName") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtMedicineCategoryName" runat="server" pattern="[A-Za-z\s]*" Text='<%# Eval("MedicineCategoryName") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="edittxtMedicineCategoryName" runat="server" />
                    <asp:CustomValidator ErrorMessage="Must Be letters"  ForeColor="Red" ControlToValidate="edittxtMedicineCategoryName" runat="server" ID="cveditMedicineCatgeory" OnServerValidate="cveditMedicineCatgeory_ServerValidate"/>   
                </EditItemTemplate>
                     
                 </asp:TemplateField>
                 <asp:TemplateField>
                 <ItemTemplate>
        <asp:LinkButton ID="lnkRemove" runat="server"
            CommandArgument = '<%# Eval("MedicineCategoryID")%>'
         OnClientClick = "return confirm('Do you want to delete?')"
        Text = "Delete" OnClick="lnkRemove_Click" ForeColor="Red"></asp:LinkButton>
    </ItemTemplate>
   
                     
                 </asp:TemplateField>

         <asp:CommandField  ShowEditButton="True" ControlStyle-ForeColor="Green" />
             </Columns>

          
      </asp:GridView>
                                       
                    
            </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvMedicineCategory" />
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
         <asp:Label ID="lblCategoryName" runat="server" Text="<b>Enter Category:</b>"></asp:Label>
                           </td>
                       <td>
         <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Medicine Catgory Name" pattern="[A-Za-z\s]*" Title="Only Letters" Width="300px"></asp:TextBox>
        </td>
                           </tr>
        
       </table>
     <asp:UpdatePanel ID="up2" runat="server" UpdateMode="Conditional">
           <ContentTemplate>
                <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnClear"
    CancelControlID="btnClear" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
        <asp:Button ID="btnSave" runat="server" Class="btn btn-success" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateForm();"/>
           <asp:Button ID="btnClear" runat="server" Class="btn btn-danger" Text="Close" />
   
           </ContentTemplate>
           
               </asp:UpdatePanel> 
        <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClientClick="Alert()" />--%>
        
           </asp:Panel>
    
         <%--</div>
       </div>--%>
            
    </div>
    <%--</form>--%>
</asp:Content>

