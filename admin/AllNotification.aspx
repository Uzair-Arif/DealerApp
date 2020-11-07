<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="AllNotification.aspx.cs" Inherits="admin_Default" %>
<%@ MasterType VirtualPath="~/admin/MasterPage.master" %>   
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<form id="form1" runat="server">--%>
        <asp:Label ID="lblerr" runat="server"></asp:Label>
        <div class="col-lg-11">
        <asp:GridView ID="gvShowAllNotification" runat="server" AutoGenerateColumns="false" CssClass="table table-hover">
            <Columns>
                <asp:TemplateField HeaderText="OrderNumber">
                    <ItemTemplate>
                        <asp:Label ID="lblOrderNumber" runat="server" Text='<%#Eval("OrderNumber") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Message">
                    <ItemTemplate>
                        <asp:Label ID="lblMessage" runat="server" Text='<%#Eval("Message") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sale Person">
                    <ItemTemplate>
                        <asp:Label ID="lblSalePerson" runat="server" Text='<%#Eval("Username") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Details">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkOrderDetails" runat="server" Text="View Details" PostBackUrl='<%#Eval("OrderNumber","~/sb-admin/Orders.aspx?OrderNumber={0}") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
            </div>
    <%--</form>--%>
</asp:Content>

