<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgetPassword.aspx.cs" Inherits="startbootstrap_ForgetPassword" %>

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
<body>
    <form id="form1" runat="server">
        <br />
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-lock fa-fw"></i>Forgot Password?</h3>
                            </div>
                <div class="panel-body">
                    <div class="form-group">
                        <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
<asp:TextBox ID="txtEmail" runat="server" class="form-control" AutoCompleteType="Email" placeholder="email address" required="" Height="40px"/>
<br />

                            </div>
                        </div>
   <asp:Label ID="lblMessage" runat="server" />
<br />                         
                    <div class="form-group">
<asp:Button  Text="Send" runat="server" OnClick="SendEmail" CssClass="btn btn-lg btn-primary btn-block"/>
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
