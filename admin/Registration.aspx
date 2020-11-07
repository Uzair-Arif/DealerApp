<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container-fluid" >

         <!-- Page Heading -->
                <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <%--<h1 class="page-header">
                            Orders To Medicine Company
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-copy"></i> Registration
                            </li>
                        </ol>
                    </div>
                </div>
    
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                 <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-user fa-fw"></i>Register New User</h3>
                            </div>
                <div class="panel-body">
                    <div class="form-group">
        <asp:Label ID="lblerr" runat="server"></asp:Label>
        <asp:LinqDataSource ID="linqDataSourceRole" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (RoleName)" TableName="Roles"></asp:LinqDataSource>
       
                Username
                <asp:TextBox runat="server"  ID="txtUsername" CssClass="form-control" pattern="[A-Za-z\s]*"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtUsername"
                runat="server" />
            
           
                Password
                <asp:TextBox ID="txtPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtPassword"
                runat="server" />
            
            
                Confirm Password
                <asp:TextBox ID="txtConfirmPassword" runat="server"  class="form-control" TextMode="Password" />
                <asp:CompareValidator ID="CompareValidator1" ErrorMessage="*" ForeColor="Red" ControlToCompare="txtPassword"
                ControlToValidate="txtConfirmPassword" runat="server" />
            
                Email
                 <asp:TextBox ID="txtEmail" class="form-control" runat="server" AutoCompleteType="Email" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="*" Display="Dynamic" ForeColor="Red"
                ControlToValidate="txtEmail" runat="server" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." />
            
            
                Select Role
                <asp:DropDownList ID="ddlRole" runat="server" class="form-control"  DataSourceID="linqDataSourceRole" DataTextField="RoleName" DataValueField="RoleName"></asp:DropDownList>
            <br/>
            <asp:Button ID="Button1" Text="Submit" runat="server" OnClick="RegisterUser" CssClass="btn btn-lg btn-success btn-block" />
        
        <asp:GridView ID="gvtest" runat="server"></asp:GridView>
               </div>
    </div>
                 </div>
            </div>
        
         </div>
</asp:Content>

