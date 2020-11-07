<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <%--<link href="css/jquery.toastmessage.css" rel="stylesheet" />--%>
    <script type="text/javascript" src="js/bs.pagination.js"></script>
        <script src="js/jquery-1.11.0.js"></script>
    <%--<script src="js/jquery.toastmessage.js"></script>--%>
    <script src="js/bs.pagination.js"></script>
    <!-- Custom CSS -->
     <link href="css/sb-admin.css" rel="stylesheet"/> 

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet"/>
    
    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
   
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body style="background-color:white">
    <form id="form1" runat="server">
     <div>
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#2151A2">
        <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            <a class="navbar-brand" style="color:white;padding-top:0px;">
                    <img src="../startbootstrap/images/logo.jpg" />  
                </a>
                <a class="navbar-brand" href="OrderBook.aspx" style="color:white">DEBIS PHARMA</a>
            </div>
        
         <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                   
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:white"><i class="fa fa-user"></i> <asp:Label ID="lblUserName"  runat="server">Talal</asp:Label> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        
                        <li>
                            <a href="ChangePassword.aspx"><i class="fa fa-fw fa-gear"></i> Change Password</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="../main.aspx"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
             </ul>
                </nav>
        </div>
     <div class="row" style="padding-top:6%">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-lock fa-fw"></i>Change Password??</h3>
                            </div>
                <div class="panel-body">
                    <div class="form-group">
        <asp:Label ID="lblerr" runat="server"></asp:Label>
      
              Current Password 
              <asp:TextBox runat="server" class="form-control" ID="txtCurrentPassword" TextMode="Password"></asp:TextBox><asp:Label ID="lblInCorrectPassword" runat="server"></asp:Label>
              <asp:RequiredFieldValidator ID="rqCurrentPassword" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="*" ></asp:RequiredFieldValidator> 
         
              New Password
              <asp:TextBox ID="txtNewPassword" class="form-control" runat="server" TextMode="Password"></asp:TextBox>
              <asp:RequiredFieldValidator ID="rqNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="*"></asp:RequiredFieldValidator>
          
              Confirm New Password 
              <asp:TextBox ID="txtConfirmNewPassword" class="form-control" runat="server" TextMode="Password"></asp:TextBox>
              <asp:CompareValidator ID="CompareValidator1" ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtNewPassword"
                ControlToValidate="txtConfirmNewPassword" runat="server" />
         
                  <asp:Button ID="btnConfirm" runat="server" Text="Confirm" CssClass="btn btn-lg btn-success btn-block" OnClick="btnConfirm_Click"/>
                   <%--<asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-lg btn-primary btn-block" OnClick="OrderBook.aspx"/>--%>    
              
    </div>
                    </div>
                </div>
            </div>
    </div>
         <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>
    </form>
</body>
</html>
