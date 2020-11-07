<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="lblerr" runat="server"></asp:Label>
      <table>
          <tr>
              <td>Current Password </td>
              <td><asp:TextBox runat="server" ID="txtCurrentPassword"></asp:TextBox><asp:Label ID="lblInCorrectPassword" runat="server"></asp:Label></td>
              <td><asp:RequiredFieldValidator ID="rqCurrentPassword" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="*" ></asp:RequiredFieldValidator>  </td>
          </tr>
          <tr>
              <td>New Password</td>
              <td><asp:TextBox ID="txtNewPassword" runat="server"></asp:TextBox></td>
              <td><asp:RequiredFieldValidator ID="rqNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="*"></asp:RequiredFieldValidator></td>
          </tr>
          <tr>
              <td>Confirm New Password </td>
              <td><asp:TextBox ID="txtConfirmNewPassword" runat="server"></asp:TextBox></td>
              <td><asp:CompareValidator ID="CompareValidator1" ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtNewPassword"
                ControlToValidate="txtConfirmNewPassword" runat="server" /></td>
          </tr>
          <tr>
              <td> </td>
              <td>
                  <asp:Button ID="btnConfirm" runat="server" Text="Confirm"  OnClick="btnConfirm_Click"/>
              </td>
          </tr>
      </table>
    </div>
    </form>
</body>
</html>
