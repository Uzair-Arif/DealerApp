<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="_Default" MasterPageFile="~/admin/MasterPage.master" %>



<asp:Content ID="c1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script>

        function Alert() {
            return alert("No changes made")
        }
    </script>
     <script type="text/javascript">
         function validateForm() {
             var name = document.forms["f5"]["ContentPlaceHolder1_txtName"].value;
             if (name == null || name == "") {
                 alert("Name must be filled out");
                 return false;
             }
             var phone = document.forms["f5"]["ContentPlaceHolder1_txtPhone"].value;
             if (phone == null || phone == "") {
                 alert("Phone must be filled out");
                 return false;
             }
             var address = document.forms["f5"]["ContentPlaceHolder1_txtAddress"].value;
             if (address == null || address == "") {
                 alert("Address must be filled out");
                 return false;
             }
             var email = document.forms["f5"]["ContentPlaceHolder1_txtEmail"].value;
             if (email == null || email == "") {
                 alert("Email must be filled out");
                 return false;
             }
         }
            </script>
    
    <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <%--<h1 class="page-header">
                            Debees Pharma Profile Information
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-copy"></i> Profile
                            </li>
                        </ol>
                    </div>
               

    <%--<form id="form1" runat="server">--%>
  
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-user fa-fw"></i>Update Prfoile</h3>
                            </div>
                <div class="panel-body">
                    <div class="form-group">
         <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                          
         <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="UserName" Width="300px"></asp:TextBox>
       
                          
         <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
                           
        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" Width="300px"></asp:TextBox>
       
         <asp:Label ID="lblPhone" runat="server" Text="Phone"></asp:Label>
                          
        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone" Width="300px" pattern="^\d{4}-\d{3}-\d{4}">></asp:TextBox>
        
                          
         <asp:Label ID="lblMobile1" runat="server" Text="Mobile"></asp:Label>
                           
        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Mobile" Width="300px" pattern="[0-9]*{7}"></asp:TextBox>
        
                           
         <asp:Label ID="lblMobile2" runat="server" Text="Alternative Mobile"></asp:Label>
                           
        <asp:TextBox ID="txtMobile2" runat="server" CssClass="form-control" placeholder="Alternative Mobile" Width="300px" pattern="[0-9]*{7}"></asp:TextBox>
       
                          
         <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                          
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" Width="300px" type="email"></asp:TextBox>
       
                          
         <asp:Label ID="lblEmail2" runat="server" Text="Alternative Email"></asp:Label>
                          
        <asp:TextBox ID="txtEmail2" runat="server" CssClass="form-control" placeholder="Alternative Email" Width="300px" AutoCompleteType="Email"></asp:TextBox>
       
         <asp:Label ID="lblFax" runat="server" Text="Fax"></asp:Label>
                  
        <asp:TextBox ID="txtFax" runat="server" CssClass="form-control" placeholder="Fax" Width="300px" pattern="^\d{4}-\d{3}-\d{4}"></asp:TextBox>
            
       
       </div>
  
    <div style="text-align:center">
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateForm();"/>
        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClientClick="Alert()" />
        <asp:Button ID="btnClear" runat="server" CssClass="btn btn-danger" Text="Clear All" OnClick="btnClear_Click"/>
        <asp:Label ID="lblerror" runat="server"></asp:Label>
    </div>
                    </div>
                </div>
        </div>
         </div>
    <%--</form>--%>
     

    </asp:Content>
