﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="PurchaseReport.aspx.cs" Inherits="admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function PrintDivContent(divId) {
            var printContent = document.getElementById(divId);
            var WinPrint = window.open('', '', 'left=0,top=0,toolbar=0,sta­tus=0');
            WinPrint.document.write(printContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
        }
    </script>
     <script type="text/javascript">
         function divexpandcollapse(divname) {
             var div = document.getElementById(divname);
             var img = document.getElementById('img' + divname);
             if (div.style.display == "none") {
                 div.style.display = "inline";
                 img.src = "Images/minus.jpg";
             } else {
                 div.style.display = "none";
                 img.src = "Images/plus.jpg";
             }
         }
         function divexpandcollapse2(divname) {
             var div2 = document.getElementById(divname);
             var img = document.getElementById('img' + divname);
             if (div2.style.display == "none") {
                 div2.style.display = "inline";
                 img.src = "Images/minus.jpg";
             } else {
                 div2.style.display = "none";
                 img.src = "Images/plus.jpg";
             }
         }
         function divexpandcollapseChild(divname) {
             var div3 = document.getElementById(divname);
             var img = document.getElementById('img' + divname);
             if (div3.style.display == "none") {
                 div3.style.display = "inline";
                 img.src = "../Images/minus.jpg";
             } else {
                 div3.style.display = "none";
                 img.src = "../Images/plus.jpg";

             }
         }
         function divexpandcollapseChild(divname) {
             var div1 = document.getElementById(divname);
             var img = document.getElementById('img' + divname);
             if (div1.style.display == "none") {
                 div1.style.display = "inline";
                 img.src = "../Images/minus.jpg";
             } else {
                 div1.style.display = "none";
                 img.src = "../Images/plus.jpg";

             }
         }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<form id="f1" runat="server">--%>
        <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <h1 class="page-header">
                            Purchase Reports
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> Purchase Report
                            </li>
                        </ol>
                    </div>
                </div>
        <div class="row">
           <div class="col-lg-12 col-md-12 col-sm-12">
               
               
               <asp:Panel ID="panel1" runat="server">
                   <div id="divToPrint">
                        
                        <h3 style="text-align:left"> Company Name: Debis Pharma</h3>
                        <table style="width:1000px">
                           <tr>
                               <th style="text-align:left">
                                   Commercial Market, Rawalpindi
                               </th>
                               <th style="text-align:right">
                                   Date: 22 April,2015
                               </th>
                           </tr>
                           <tr>
                               <td style="text-align:left">
                                   Phone NO: +92-334-105-1020
                               </td>
                               
                           </tr>
                           <tr>
                               <td  style="text-align:left">
                                   E-mail: WWW.debispharma.com
                               </td>
                               
                           </tr>
                       </table>
                       <br />
        <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvReport_RowDataBound"  CssClass="table table-bordered table-hover table-striped" HorizontalAlign="Center">
            <Columns>
                 <asp:TemplateField ItemStyle-Width="20px">
            <ItemTemplate>
                <a href="JavaScript:divexpandcollapse('div<%# Eval("Year") %>');">
                    <img id='imgdiv<%# Eval("Year") %>'  style="width:9px" border="0" 
                                                                 src="Images/plus.jpg" alt=""/></a> 
                <%--<asp:Image ID="img1" runat="server" ImageUrl="~/sb-admin/Images/plus.jpg" />--%>                      
            </ItemTemplate>
            <ItemStyle Width="20px" VerticalAlign="Middle"></ItemStyle>
        </asp:TemplateField>

                <%--<asp:BoundField HeaderText="Year" DataField="Year" />--%>
                <asp:TemplateField HeaderText="Year" HeaderStyle-ForeColor="Black">
                    <ItemTemplate>
                        <asp:Label ID="lblYear" runat="server" Text='<%#Eval("Year") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Total Purchases" DataField="TotalPurchases" HeaderStyle-ForeColor="Black"/>
                <asp:BoundField HeaderText="Total Quantity" DataField="TotalQuantity" HeaderStyle-ForeColor="Black" />
                <asp:BoundField HeaderText="Total Price" DataField="TotalPrice" HeaderStyle-ForeColor="Black" />
                <asp:TemplateField>
            <ItemTemplate>
            <tr>
            <td  colspan="100">
            <div id='div<%# Eval("Year") %>'  style="overflow:auto; display:none;
                                    position: relative; left: 15px; overflow: auto">
            <asp:GridView ID="gv_Child" runat="server" Width="95%"
                                    AutoGenerateColumns="false" OnRowDataBound="gv_Child_RowDataBound" CssClass="table table-bordered table-hover table-striped">
                <Columns>
               <asp:TemplateField ItemStyle-Width="20px">
            <ItemTemplate>
            <a href="JavaScript:divexpandcollapse('div1<%#Eval("Month") %>');">
            <img id='imgdiv1<%#Eval("Month") %>' width="9px" border="0" src="Images/plus.jpg"
                        alt="" /></a>    
                <%--<asp:Image ID="img2" runat="server"  ImageUrl="~/sb-admin/Images/plus.jpg"/>--%>                   
            </ItemTemplate>
            <ItemStyle Width="20px" VerticalAlign="Middle"></ItemStyle>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Month" HeaderStyle-ForeColor="Black">
                <ItemTemplate>
                    <asp:Label ID="lblMonth" runat="server" Text='<%#String.Format("{0:MMMM}",Eval("Month")) %>'></asp:Label>
                    <asp:Label ID="lblmonthnum" runat="server" Text='<%#Eval("Month") %>' Visible="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:BoundField DataField='<%#String.Format("{MMMM}",Eval("Month")) %>' HeaderText="Month"/>--%>
                   
            <asp:BoundField HeaderText="Total Purchase" DataField="TotalPurchases" HeaderStyle-ForeColor="Black" />
                <asp:BoundField HeaderText="Total Quantity" DataField="TotalQuantity" HeaderStyle-ForeColor="Black" />
                <asp:BoundField HeaderText="Total Price" DataField="TotalPrice" HeaderStyle-ForeColor="Black" />    
                    <asp:TemplateField>
                <ItemTemplate>
                <tr>
                    <td colspan="100">
                <div id='div1<%# Eval("Month") %>'  style="overflow:auto; display:none;
                                                   position: relative; left: 15px; overflow: auto">
                        <asp:GridView ID="gv_NestedChild" runat="server" Width="95%"
                                                                AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped">
                                        
                        <Columns>
                        <asp:BoundField DataField="PurchaseInvoice" HeaderText="Purchase Invoice" HeaderStyle-ForeColor="Black" />
                                                                                                                     
                        <asp:BoundField DataField="PurchaseInvoiceDate" HeaderText="Purchase Invoice Date" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="MedicineCompanyName" HeaderText="Medicine Company Name" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="PharmaEmployee" HeaderText="Pharma Employee" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="Price" HeaderText="Price" HeaderStyle-ForeColor="Black"/>
                        </Columns>
                         <HeaderStyle BackColor="White" ForeColor="#95B4CA"/>
                        </asp:GridView>
                        </div>
                    </td>
                </tr>
                </ItemTemplate>
            </asp:TemplateField>     
            </Columns>
                       <HeaderStyle BackColor="White" ForeColor="#95B4CA" />
                        </asp:GridView>
                        </div>
                    </td>
                </tr>
                </ItemTemplate>
            </asp:TemplateField>
            </Columns>  <%--Sale Report Ending--%>
            <HeaderStyle BackColor="White" ForeColor="#95B4CA" />
            </asp:GridView> 
                        <br /> 
                       <table style="width:1000px">
                           <tr>
                               <td style="text-align:left">
                                  <b> Signed By:_____________________</b>
                               </td>
                               <td style="text-align:right">
                                  <b> Submitted By:_____________________</b>
                               </td>
                           </tr>
                       </table> 
                       </div>
                   </asp:Panel>  
               <%--<asp:Button ID="btnexport" runat="server" Text="Export" OnClick="btnexport_Click"  />--%>
               <div style="text-align:center">
               <asp:Button ID="btn1" runat="server" OnClientClick="javascript:PrintDivContent('divToPrint');" Text="Print" CssClass="btn btn-danger btn-lg"/>
               </div>
               </div>
            <%--<div class="col-lg-6">
                <%--<div id="divToPrint">
               kjdhkdj
                   </div>--%>
               

                 <%--<asp:GridView ID="gvtest"  runat="server"></asp:GridView>--%>
           
               <%--<div class="col-lg-6">
                   <h2>Purchase Return Report</h2>
                   <div id="divToPrintSaleReturn">
                        <asp:GridView ID="gvSaleReturnReport" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvSaleReturnReport_RowDataBound">
            <Columns>
                 <asp:TemplateField ItemStyle-Width="20px">
            <ItemTemplate>
                <a href="JavaScript:divexpandcollapse2('div2<%# Eval("pYear") %>');">
                    <img id='imgdiv2<%# Eval("pYear") %>' width="9px" border="0" 
                                                                 src="Images/plus.jpg" alt="" /></a>                       
            </ItemTemplate>
            <ItemStyle Width="20px" VerticalAlign="Middle"></ItemStyle>
        </asp:TemplateField>--%>

                <%--<asp:BoundField HeaderText="Year" DataField="Sale" />--%>
                <%--<asp:TemplateField HeaderText="Year">
                    <ItemTemplate>
                        <asp:Label ID="slblYear" runat="server" Text='<%#Eval("pYear") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Total Purchases Return" DataField="pTotalPurchasesReturn" />
                <asp:BoundField HeaderText="Total Quantity" DataField="pTotalQuantity" />
                <asp:BoundField HeaderText="Total Price" DataField="pTotalPrice" />
                <asp:TemplateField>
            <ItemTemplate>
            <tr>
            <td colspan="100%">
            <div id='div2<%# Eval("pYear") %>'  style="overflow:auto; display:none;
                                    position: relative; left: 15px; overflow: auto">
            <asp:GridView ID="gvSaleReturnChild" runat="server" Width="95%"
                                    AutoGenerateColumns="false" OnRowDataBound="gvSaleReturnChild_RowDataBound">
                <Columns>
               <asp:TemplateField ItemStyle-Width="20px">
            <ItemTemplate>
            <a href="JavaScript:divexpandcollapse('div3<%#Eval("pMonth") %>');">
            <img id='imgdiv3<%#Eval("pMonth") %>' width="9px" border="0" src="Images/plus.jpg"
                        alt="" /></a>                       
            </ItemTemplate>
            <ItemStyle Width="20px" VerticalAlign="Middle"></ItemStyle>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Month">
                <ItemTemplate>
                    <asp:Label ID="lblMonth" runat="server" Text='<%#String.Format("{0:MMMM}",Eval("pMonth")) %>'></asp:Label>
                    <asp:Label ID="lblmonthnumReturn" runat="server" Text='<%#Eval("pMonth") %>' Visible="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
            <%--<asp:BoundField DataField='<%#String.Format("{MMMM}",Eval("sMonth")) %>' HeaderText="Month"/>--%>
           <%-- <asp:BoundField HeaderText="Total Purchases Return" DataField="pTotalPurchasesReturn" />
                <asp:BoundField HeaderText="Total Quantity" DataField="pTotalQuantity" />
                <asp:BoundField HeaderText="Total Price" DataField="pTotalPrice" />  
                    <asp:TemplateField>
                <ItemTemplate>
                <tr>
                    <td colspan="100">
                <div id='div3<%# Eval("pMonth") %>'  style="overflow:auto; display:none;
                                                   position: relative; left: 15px; overflow: auto">
                        <asp:GridView ID="gv_NestedChildReturn" runat="server" Width="95%"
                                                                AutoGenerateColumns="false">
                                        
                        <Columns>
                        <asp:BoundField DataField="PurchaseReturnInvoice" HeaderText="Purchase Invoice" />
                                                                                                                     
                        <asp:BoundField DataField="PurchaseReturnInvoiceDate" HeaderText="Purchase Return Invoice Date"/>
                            <asp:BoundField DataField="MedicineCompanyName" HeaderText="Medicine Company Name"/>
                            <asp:BoundField DataField="PharmaEmployee" HeaderText="Pharma Employee"/>
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity"/>
                            <asp:BoundField DataField="Price" HeaderText="Price"/>
                        </Columns>
                        <HeaderStyle BackColor="#95B4CA" ForeColor="White" />
                        </asp:GridView>
                        </div>
                    </td>
                </tr>
                </ItemTemplate>
            </asp:TemplateField>       
            </Columns>
                        <HeaderStyle BackColor="#95B4CA" ForeColor="White" />
                        </asp:GridView>
                        </div>
                    </td>
                </tr>
                </ItemTemplate>
            </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#4D92C1" ForeColor="White" />
            </asp:GridView>
                       </div>
                   <asp:Button ID="Button1" runat="server" OnClientClick="javascript:PrintDivContent('divToPrintSaleReturn');" Text="click me" />
                    </div>--%>
            </div>
            
    <%--</form>--%>
</asp:Content>

