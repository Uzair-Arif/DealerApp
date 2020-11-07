<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Syrups.aspx.cs" Inherits="Syrups" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Products</title>
     <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript" src="js/bs.pagination.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bs.pagination.js"></script>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet"/>
    <link href="css/salesstyle.css" rel="stylesheet"/>

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#003366">
        <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html" style="color:white">DEBIS PHARMA</a>
            </div>
        
        <div class="collapse navbar-collapse navbar-right navbar-main-collapse">
                <ul class="nav navbar-nav">
                    <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="main.aspx#products" style="color:white">Products</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="main.aspx#about" style="color:white">About</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="main.aspx#contact" style="color:white">Contact</a>
                    </li>
                    
                </ul>
            </div>
                </nav>
        </div>
        <br />
        <br />
        <br />
        <div class="container-fluid">
        <div class="col-lg-12">
       <asp:GridView runat="server" ID="gvSyrup" CssClass="table table-striped" AutoGenerateColumns="false">
         <Columns>
           <asp:ImageField DataImageUrlField="Image" ControlStyle-Width="100"
        ControlStyle-Height = "100" HeaderText = "Preview Image"/>
            <asp:TemplateField HeaderText="Medicine Name">
                <ItemTemplate>
                    <asp:Label ID="lblMedicineName" Text='<%#Eval("MedicineName") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description">
                <ItemTemplate>
                    <asp:Label ID="lblMedicineDescription" Text='<%#Eval("Description") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pack Size">
                <ItemTemplate>
                    <asp:Label ID="lblMedicinePackSize" Text='<%#Eval("PackSize") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Medicine Category Name">
                <ItemTemplate>
                    <asp:Label ID="lblMedicineCategoryName" Text='<%#Eval("MedicineCategoryName") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
           </div>
            
    </form>
</body>
</html>
