<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="startbootstrap_modern_business_1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Debis Pharma|Main</title>
    <script src="../assets/js/jquery-1.8.2.min.js"></script>
     <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet"/>

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        $(document).ready(function () {
            //Handles menu drop down
            $('.dropdown-menu').find('form').click(function (e) {
                e.stopPropagation();
            });
        });
        </script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css"
    rel="stylesheet" type="text/css" />
<script type="text/javascript">
    function ShowPopup(message) {
        $(function () {
            $("#dialog").html(message);
            $("#dialog").dialog({
                title: "Alert",
                buttons: {
                    Close: function () {
                        $(this).dialog('close');
                    }
                },
                modal: true
            });
        });
    };
</script>
    <style type="text/css">
        .ui-dialog > .ui-widget-header {background:#BAA378;}
    .modalBackground
    {
        background-color: Black;
        filter: alpha(opacity=90);
        opacity: 0.8;
    }
    .modalPopup
    {
        background-color: #FFFFFF;
        border-width: 3px;
        border-style: solid;
        border-color: black;
        padding-top: 10px;
        padding-left: 10px;
        padding-right: 10px;
        width: auto;
        height: auto;
    }
        .right {
            position: absolute;
            right: 0px;
            width: 300px;
            /*background-color: #b0e0e6;*/
        }
</style>
</head>
<body>
         
    <div>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color:#2151A2">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                
                <a class="navbar-brand" style="color:white;padding-top:0px;">
                    <img src="images/logo.jpg" />  
                </a>
                <div class="navbar-text"> <span style="font-weight:bold;color:#ffffff;" > DEBIS PHARMA </span> </div>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a class="page-scroll" href="#about" style="color:white">About</a>
                    </li>
                    <!--<li>
                        <a href="services.html">Services</a>
                    </li>-->
                    <li>
                        <a class="page-scroll" href="#contact" style="color:white">Contact</a>
                    </li>
                    <li >
                        <a class="page-scroll" href="#products" style="color:white"> Products </a>
                    </li>
                   
                    <li class="dropdown">
                        <!--<a class="myloginclass" href="Login.aspx">Login</a>-->
                        <a class="myloginclass" href="../admin/Dashboard.aspx"" data-toggle="dropdown" style="color:white"> Sign In <strong class="caret"></strong></a>
						<div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
							<form id="form1" runat="server">
                                <asp:ToolkitScriptManager ID="tk1" runat="server"></asp:ToolkitScriptManager>
                                <asp:TextBox ID="Username" runat="server" placeholder="Username" CssClass="form-control"></asp:TextBox>
								<%--<input style="margin-bottom: 15px;" type="text" placeholder="Username" id="username" name="username"/>--%>
								<%--<input style="margin-bottom: 15px;" type="password" placeholder="Password" id="password" name="password"/>--%>
                               <asp:TextBox ID="Password" runat="server" placeholder="Password" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                  <%--<asp:TextBox ID="Username" style="margin-bottom: 15px;" runat="server" placeholder="Username" CssClass="username"></asp:TextBox>
                <asp:TextBox ID="Password" runat="server" placeholder="Password" CssClass="password" TextMode="Password"></asp:TextBox>--%>
								<%--<input style="float: left; margin-right: 10px;" type="checkbox" name="remember-me" id="remember-me" value="1"/>
								<label class="string optional" for="user_remember_me"> Remember me</label>--%>
								<%--<input class="btn btn-primary btn-block" type="submit" id="sign-in"  value="Sign In"/>--%>
                                <asp:UpdatePanel runat="server" ID="updatepanelLogin">
                                    <ContentTemplate>
                                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"  class="btn btn-primary btn-block" />
                                 <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger  ControlID="btnLogin" EventName="Click"/>
                                    </Triggers>
                                    
                                </asp:UpdatePanel>
                                <asp:HyperLink NavigateUrl="~/startbootstrap/ForgetPassword.aspx" runat="server" Text="Forget Password?" />
                                 <div class="error"><span></span></div>
							</form>
                            <br />
						</div>
                        
                    </li>
                   
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
        <%--<br />--%>
        <%--<br />
        <br />
        <br />
         <br />
        <br />
        <br />
        <br />--%>
    <!-- Header Carousel -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            
            <div class="item active">
    <!--<img src="images/meds.jpg" />-->
                <div class="fill" style="background-image: url('images/meds.jpg');"></div>
                <div class="carousel-caption">
                    <h2>Welcome To Debees Pharma</h2>
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image: url('images/meds.jpg');"></div>
                <div class="carousel-caption">
                    <h2>Call: +92-334-1051020</h2>
                </div>
            </div>
            
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
    </header>

    <!-- Page Content -->
    <div class="container">
        <div id="dialog" style="display: none">
</div>     
        <!-- Marketing Icons Section -->
        <div class="row">
           <!-- <div class="col-lg-12">
                <h1 class="page-header">
                    Welcome to Modern Business
                </h1>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-check"></i> Bootstrap v3.2.0</h4>
                    </div>
                    <div class="panel-body">
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
                        <a href="#" class="btn btn-default">Learn More</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-gift"></i> Free &amp; Open Source</h4>
                    </div>
                    <div class="panel-body">
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
                        <a href="#" class="btn btn-default">Learn More</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-compass"></i> Easy to Use</h4>
                    </div>
                    <div class="panel-body">
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
                        <a href="#" class="btn btn-default">Learn More</a>
                    </div>
                </div>
            </div>-->
        </div>
        <!-- /.row -->

        <!-- Portfolio Section -->
        <section id="products">
        <div class="row">
            <div class="col-lg-12">
                <br />
                <h2 class="page-header" style="text-align:center">Products</h2>
            </div>
            <div class="col-md-4 col-sm-6">
                <a href="Capsules.aspx">
                    <img class="img-responsive img-portfolio img-hover" src="../img/tablets1.jpg" alt=""/>
                    <div class="carousel-caption">
                    <h2 style="color:white">Capsules</h2>
                </div>
                </a>
            </div>
            <div class="col-md-4 col-sm-6">
                <a href="Tablets.aspx">
                    <img class="img-responsive img-portfolio img-hover" src="../img/blue.jpg" alt=""/>
                     <div class="carousel-caption">
                    <h2 style="color:white">Tablets</h2>
                </div>
                </a>
            </div>
            <div class="col-md-4 col-sm-6">
                <a href="Syrups.aspx">
                    <img class="img-responsive img-portfolio img-hover" src="../img/syrup1.jpg" alt=""/>
                     <div class="carousel-caption">
                    <h2 style="color:white">Syrup</h2>
                </div>
                </a>
            </div>
            <div class="col-md-4 col-sm-6">
                <a href="Gel.aspx">
                    <img class="img-responsive img-portfolio img-hover" src="../img/gel1.jpg" alt=""/>
                     <div class="carousel-caption">
                    <h2 style="color:white">Gel</h2>
                </div>
                </a>
            </div>
            <div class="col-md-4 col-sm-6">
                <a href="Spray.aspx">
                    <img class="img-responsive img-portfolio img-hover" src="../img/nosal.jpg" alt=""/>
                    <div class="carousel-caption">
                    <h2 style="color:white">Spray</h2>
                </div>
                </a>
            </div>
            <div class="col-md-4 col-sm-6">
                <a href="Tube.aspx">
                    <img class="img-responsive img-portfolio img-hover" src="../img/cream.jpg" alt=""/>
                     <div class="carousel-caption">
                    <h2 style="color:white">Cream</h2>
                </div>
                </a>
            </div>
        </div>
            </section>
        <!-- /.row -->
        <hr />
 <section id="about" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h2>About Debees Pharma</h2>
                <p>Debees Pharma is playing a vital role to provide complete & substantiate range of Local & Imported Allopathic Medicines, Drugs, Herbal Products, Optical Products,etc.
                    Debees Pharma's Group mission is to supply cheaper products to everybody who has access to the internet. Through harnessing the power of the internet and supplying you directly, this website will save up to 50% off the cost of many well known products found in your local chemist. <a href="http://debispharma.tk/">Debees Pharma</a></p>
                
            </div>
        </div>
    </section>
          <hr/>
        <section id="contact" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h2>Contact Debis Pharma</h2>
                <p>Feel free to email us to provide some feedback on our Products, give us suggestions for new medicines, or to just say hello!</p>
                <p><a href="mailto:debispharma@gmail.com"><asp:Label  runat="server" ID="lblmailAddress" /></a>
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
        <!-- Features Section -->
        <!--<div class="row">
            <div class="col-lg-12">
                <h2 class="page-header">Modern Business Features</h2>
            </div>
            <div class="col-md-6">
                <p>The Modern Business template by Start Bootstrap includes:</p>
                <ul>
                    <li><strong>Bootstrap v3.2.0</strong>
                    </li>
                    <li>jQuery v1.11.0</li>
                    <li>Font Awesome v4.1.0</li>
                    <li>Working PHP contact form with validation</li>
                    <li>Unstyled page elements for easy customization</li>
                    <li>17 HTML pages</li>
                </ul>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis, omnis doloremque non cum id reprehenderit, quisquam totam aspernatur tempora minima unde aliquid ea culpa sunt. Reiciendis quia dolorum ducimus unde.</p>
            </div>
            <div class="col-md-6">
                <img class="img-responsive" src="http://placehold.it/700x450" alt="">
            </div>
        </div>-->
        <!-- /.row -->

        <hr/>

        <!-- Call to Action Section -->
        <!--<div class="well">
            <div class="row">
                <div class="col-md-8">
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Molestias, expedita, saepe, vero rerum deleniti beatae veniam harum neque nemo praesentium cum alias asperiores commodi.</p>
                </div>
                <div class="col-md-4">
                    <a class="btn btn-lg btn-default btn-block" href="#">Call to Action</a>
                </div>
            </div>
        </div>

        <hr>-->

        <!-- Footer -->
        <footer>
            <div class="row" style="text-align:center">
                <div class="col-lg-12">
                    <p>Copyright &copy; Debees Pharma 2015</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Script to Activate the Carousel -->
    <script>
        $('.carousel').carousel({
            interval: 5000 //changes the speed
        })
         </script>
    </div>
    
</body>
</html>
