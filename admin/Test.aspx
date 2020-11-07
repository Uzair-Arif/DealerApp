<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Test" %>



<asp:Content ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    
    <form id="form1" runat="server">
   
        <%--<div role="tabpanel">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Settings</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home"><asp:TextBox ID="txt1" runat="server" placeholder="great"></asp:TextBox></div>
    <div role="tabpanel" class="tab-pane" id="profile"><asp:Label ID="lbl1" runat="server" Text="I am here"></asp:Label></div>
    <div role="tabpanel" class="tab-pane" id="messages"><asp:Button ID="bt1" runat="server"  Text="press me"/></div>
    <div role="tabpanel" class="tab-pane" id="settings"><asp:HyperLink ID="hp1" runat="server" Text="click me"></asp:HyperLink></div>
  </div>

</div>--%>
    <%--<asp:GridView ID="gvTest" runat="server">
        <Columns>
            <asp:TemplateField HeaderText="rollno">
                <ItemTemplate>
                    <asp:Label ID="lbl" runat="server" Text="label"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>--%>
    <asp:Label ID="lbl1" runat="server" Text="786"></asp:Label>
   
        </form>
        
</asp:Content>