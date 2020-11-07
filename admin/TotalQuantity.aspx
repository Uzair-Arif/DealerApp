<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="TotalQuantity.aspx.cs" Inherits="admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <%--<h1 class="page-header">
                           Medicine's Quantity In Stock
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-th-list"></i> Stock Quantity
                            </li>
                        </ol>
                    </div>
                </div>
    <div class="row">
        <div class="col-md-12 col-lg-12 col-sm-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                     <h2 class="panel-title"><i class="fa fa-money fa-fw"></i><b>Total Medicines In Stock</b></h2>
                </div>
                <div class="panel-body">
    <asp:GridView ID="gvTotalQuantity" runat="server" CssClass="table table-bordered table-hover table-striped">

    </asp:GridView>
                    </div>
                </div>
            </div>
    </div>
</asp:Content>

