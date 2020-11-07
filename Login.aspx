<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login"  %>

<html>
    <head>
        <meta charset="utf-8">
        <title>Fullscreen Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- CSS -->
        <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'>
        <link rel="stylesheet" href="assets/css/reset.css">
        <link rel="stylesheet" href="assets/css/supersized.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/bs.pagination.js"></script>
        <script src="js/jquery-1.11.0.js"></script>
    <script src="js/bs.pagination.js"></script>
    <!-- Custom CSS -->
     <link href="css/sb-admin.css" rel="stylesheet"/> 

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet"/>

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    </head>
    <body>

    <form id="form1" runat="server">
    <div>
    <asp:TextBox ID="Username" runat="server" placeholder="Username" CssClass="username"></asp:TextBox>
                <asp:TextBox ID="Password" runat="server" placeholder="Password" CssClass="password" TextMode="Password"></asp:TextBox>
        
        <%--<button type="submit">Sign me in</button>--%>
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"  CssClass="btn btn-default" BackColor="YellowGreen" />
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
        <div class="error"><span>+</span></div>
        <div class="connect">
                <p>Or connect with:</p>
                <p>
                    <a class="facebook" href=""></a>
                    <a class="twitter" href=""></a>
                </p>
            </div>
        </div>

        <!-- Javascript -->
        <script src="assets/js/jquery-1.8.2.min.js"></script>
        <script src="assets/js/supersized.3.2.7.min.js"></script>
        <script src="assets/js/supersized-init.js"></script>
        <script src="assets/js/scripts.js"></script>
    </div>
    </form>
        </body>
    </html>