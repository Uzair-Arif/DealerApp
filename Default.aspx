<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Main_Site_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Grayscale - Start Bootstrap Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="css/grayscale.css" rel="stylesheet"/>

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css"/>
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
     <%--<style type="text/css">
    body{font-family: Arial;font-size: 10pt;}
    .main_menu{width: 100px; background-color: #fff;border: 1px solid #ccc !important; color: #000;text-align: center;height: 30px;line-height: 30px;margin-right: 5px;}
    .level_menu{width: 110px; background-color: #fff; color: #333;border: 1px solid #ccc !important;text-align: center;height: 30px;line-height: 30px;margin-top: 5px;}
    .selected{background-color: #9F9F9F;color: #fff;}
    input[type=text], input[type=password]{width: 200px;}
    table{border: 1px solid #ccc;}
    table th { background-color: #F7F7F7;color: #333;font-weight: bold;}
    table th, table td { padding: 5px; border-color: #ccc; }
</style>--%>
</head>
<body >
    <form id="form1" runat="server">
    <%--<asp:LoginView ID="LoginView" runat="server">
<LoggedInTemplate>
    <div align="right">
        Welcome <asp:LoginName ID="LoginName1" runat="server" Font-Bold="true" />
        <br /><br />
        <asp:Label ID="lblLastLoginDate" runat="server" />
        <asp:LoginStatus ID="LoginStatus1" runat="server" />
    </div>
    <hr />
</LoggedInTemplate>
</asp:LoginView>--%>
     

    <!-- Navigation -->
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation" style="background-color:#323232">
        <div class="container">
            <div class="navbar-header">
                <%--<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                    <i class="fa fa-bars"></i>
                </button>--%>
               
                <a class="navbar-brand" href="index.html" style="color:white">DEBEES PHARMA</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-right navbar-main-collapse">
                <ul class="nav navbar-nav">
                    <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#products">Products</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#about">About</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#contact">Contact</a>
                    </li>
                    <li>
                        <a class="myloginclass" href="Login.aspx">Login</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Intro Header -->
    <header class="intro">
        <div class="intro-body">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        
                        <%--<p class="intro-text">Medicine Distributors<br>Since 1990</p>
                        <a href="#about" class="btn btn-circle page-scroll">
                            <i class="fa fa-angle-double-down animated"></i>
                        </a>--%>
                    </div>
                </div>
            </div>
        </div>
    </header>
        <!-- Products Section -->
        <section id="products" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-9 col-lg-offset-2">
                <h2>OUR PRODUCTS</h2>
                <h5>Choose your DESIRED Category</h5>
                <table border="1">
                    <tr>
                        <td>Tablet</td>
                        <td>Capsule</td>
                        <td>Syrup</td>
                        <td>Drops</td>
                        <td>Spray</td>
                        <td>Gel</td>
                        <td>Tube</td>
                    </tr>
                    <tr>
                         <td headers="Tablet">
                             <asp:ImageButton ID="imgTablet" runat="server" ImageUrl="~/img/Tablet.jpg" Height="100px" Width="100px" PostBackUrl="~/Tablets.aspx"/>
                        </td>
                        <td>
                            <asp:ImageButton ID="imgCapsule" runat="server" ImageUrl="~/img/Capsule.jpg" Height="100px" Width="100px" PostBackUrl="~/Capsules.aspx" />
                        </td>
                       
                        <td>
                            <asp:ImageButton ID="imgSyrup" runat="server" ImageUrl="~/img/Syrup.jpg" Height="100px" Width="100px"  PostBackUrl="~/Syrups.aspx"/>
                        </td>
                        <td>
                            <asp:ImageButton ID="imgDrops" runat="server" ImageUrl="~/img/Drops.jpg"  Height="100px" Width="100px" PostBackUrl="~/Drops.aspx"/>
                        </td>
                        <td>
                            <asp:ImageButton ID="imgSpray" runat="server" ImageUrl="~/img/Spray.jpg" Height="100px" Width="100px" PostBackUrl="~/Spray.aspx" />
                        </td>
                        <td>
                            <asp:ImageButton ID="imgGel" runat="server" ImageUrl="~/img/Gel.jpg"  Height="100px" Width="100px" PostBackUrl="~/Gel.aspx"/>
                        </td>
                        <td>
                            <asp:ImageButton ID="imgTube" runat="server" ImageUrl="~/img/Tube.jpg" Height="100px" Width="100px" PostBackUrl="~/Tube.aspx" />
                        </td>
                    </tr>
                </table>
                <%--<p>Grayscale is a free Bootstrap 3 theme created by Start Bootstrap. It can be yours right now, simply download the template on <a href="http://startbootstrap.com/template-overviews/grayscale/">the preview page</a>. The theme is open source, and you can use it for any purpose, personal or commercial.</p>
                <p>This theme features stock photos by <a href="http://gratisography.com/">Gratisography</a> along with a custom Google Maps skin courtesy of <a href="http://snazzymaps.com/">Snazzy Maps</a>.</p>
                <p>Grayscale includes full HTML, CSS, and custom JavaScript files along with LESS files for easy customization.</p>--%>
            </div>
        </div>
    </section>
    <!-- About Section -->
    <section id="about" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h2>About Debees Pharma</h2>
                <p>Debees Pharma is playing a vital role to provide complete & substantiate range of Local & Imported Allopathic Medicines, Drugs, Herbal Products, Optical Products,etc.
                    Debees Pharma's Group mission is to supply cheaper products to everybody who has access to the internet. Through harnessing the power of the internet and supplying you directly, this website will save up to 50% off the cost of many well known products found in your local chemist. <a href="http://debispharma.tk/">Debees Pharma</a></p>
                
            </div>
        </div>
    </section>

   

    <!-- Contact Section -->
    <section id="contact" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h2>Contact Debees Pharma</h2>
                <p>Feel free to email us to provide some feedback on our Products, give us suggestions for new medicines, or to just say hello!</p>
                <p><a href="mailto:debispharma@gmail.com">debeesnutra@gmail.com</a>
                </p>
                <ul class="list-inline banner-social-buttons">
                    <li>
                        <a href="https://twitter.com/SBootstrap" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i> <span class="network-name">Twitter</span></a>
                    </li>
                    
                    <li>
                        <a href="https://plus.google.com/+Startbootstrap/posts" class="btn btn-default btn-lg"><i class="fa fa-google-plus fa-fw"></i> <span class="network-name">Google+</span></a>
                    </li>
                </ul>
            </div>
        </div>
    </section>

    <!-- Map Section -->
   <%-- <div id="map"></div>--%>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p>Copyright &copy; Your Website 2014</p>
        </div>
    </footer>

    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="js/jquery.easing.min.js"></script>

    <!-- Google Maps API Key - Use your own API key to enable the map feature. More information on the Google Maps API can be found at https://developers.google.com/maps/ -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRngKslUGJTlibkQ3FkfTxj3Xss1UlZDA&sensor=false"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/grayscale.js"></script>



    
    </form>
</body>
</html>
