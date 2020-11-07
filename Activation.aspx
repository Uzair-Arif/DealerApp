<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Activation.aspx.cs" Inherits="Activation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1><asp:Literal ID="ltMessage" runat="server" /><asp:LinkButton ID="lnkLoginHere" runat="server" PostBackUrl="~/Login.aspx" Text="Click Here to Login"></asp:LinkButton></h1>
    </div>
    </form>
</body>
</html>
