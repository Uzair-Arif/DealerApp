<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row">
         <div class="col-md-4 col-md-offset-4">
             <div class="panel panel-default">
                 <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-user fa-fw"></i>Change Password?</h3>
                            </div>
                <div class="panel-body">
                    <div class="form-group">
                        <div>
        <asp:Label ID="lblerr" runat="server"></asp:Label>
      
         
              Current Password 
              <asp:TextBox runat="server" ID="txtCurrentPassword" class="form-control" required="" TextMode="Password"></asp:TextBox><asp:Label ID="lblInCorrectPassword" runat="server"></asp:Label>
              <asp:RequiredFieldValidator ID="rqCurrentPassword" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="*" ></asp:RequiredFieldValidator>  
          
          
              New Password
              <asp:TextBox ID="txtNewPassword" runat="server" class="form-control" required="" TextMode="Password"></asp:TextBox>
              <asp:RequiredFieldValidator ID="rqNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="*"></asp:RequiredFieldValidator>
          
          
              Confirm New Password 
              <asp:TextBox ID="txtConfirmNewPassword" runat="server" class="form-control" required="" TextMode="Password"></asp:TextBox>
              <asp:CompareValidator ID="CompareValidator1" ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtNewPassword"
                ControlToValidate="txtConfirmNewPassword" runat="server" />
          
          
          
                  <asp:Button ID="btnConfirm" runat="server" Text="Confirm" CssClass="btn btn-lg btn-primary btn-block" OnClick="btnConfirm_Click"/>
             
          </div>
                            
                        </div>
                     </div>
                 </div>
           </div>
    </div>
   
</asp:Content>

