<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <asp:GridView runat="server" ID="gvMedicineCategory" OnRowCommand="gvTest_RowCommand" AutoGenerateColumns="false" OnRowEditing="gvTest_RowEditing" OnRowCancelingEdit="gvTest_RowCancelingEdit">
           <Columns>
               <asp:TemplateField HeaderText="medicineCategory">
                   <ItemTemplate>
                       <asp:Label ID="lblcat" runat="server" Text='<%#Eval("MedicineCategoryName") %>'></asp:Label>
                   </ItemTemplate>
                   <EditItemTemplate>
                       <asp:TextBox ID="txtcat" runat="server" Text='<%#Eval("MedicineCategoryName") %>'></asp:TextBox>
                   </EditItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField>
                   <ItemTemplate>
                       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandArgument='<%#Eval("MedicineCategoryName") %>' CommandName="UpdateCategory"></asp:LinkButton>
                   </ItemTemplate>
               </asp:TemplateField>
           </Columns>
       </asp:GridView>
    </div>
        
        
    </form>
</body>
</html>
