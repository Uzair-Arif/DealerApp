<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="SaleReport.aspx.cs" Inherits="admin_Default" %>

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
                        <%--<h1 class="page-header">
                            Sale Reports
                        </h1>--%>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> Sale Report
                            </li>
                        </ol>
                    </div>
                </div>
        <div class="row">
           <div class="col-lg-12 col-md-12 col-sm-12">
               
               
               <asp:Panel ID="panel1" runat="server">
                   <div id="divToPrint">
                      <%-- <h2>Sale Report</h2>--%>
                        
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
        <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvReport_RowDataBound" CssClass="table table-bordered table-hover table-striped" HorizontalAlign="Center">
            <Columns>
                 <asp:TemplateField ItemStyle-Width="20px">
            <ItemTemplate>
                <a href="JavaScript:divexpandcollapse('div<%# Eval("Year") %>');">
                    <img id='imgdiv<%# Eval("Year") %>'  style="width:9px" border="0" 
                                                                 src="Images/plus.jpg" alt="" /></a> 
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
                <asp:BoundField HeaderText="Total Sales" DataField="TotalSales" HeaderStyle-ForeColor="Black" />
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
                   
            <asp:BoundField HeaderText="Total Sales" DataField="TotalSales" HeaderStyle-ForeColor="Black" />
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
                        <asp:BoundField DataField="SaleInvoice" HeaderText="Sale Invoice"  HeaderStyle-ForeColor="Black"/>
                                                                                                                     
                        <asp:BoundField DataField="SaleInvoiceDate" HeaderText="Sale Invoice Date" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="MedicalStoreName" HeaderText="Medical Store Name" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="StoreEmployee" HeaderText="Store Employee" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-ForeColor="Black"/>
                            <asp:BoundField DataField="Price" HeaderText="Price" HeaderStyle-ForeColor="Black"/>
                        </Columns>
                        <HeaderStyle BackColor="White" ForeColor="#95B4CA" />
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
                <div style="text-align:center">
               <%--<asp:Button ID="btnexport" runat="server" Text="Export" OnClick="btnexport_Click" CssClass="btn btn-success btn-lg" />--%>
               <asp:Button ID="btn1" runat="server" OnClientClick="javascript:PrintDivContent('divToPrint');" Text="Print" CssClass="btn btn-danger btn-lg" />
                    </div>
               </div>
            <%--<div class="col-lg-6">
                <%--<div id="divToPrint">
               kjdhkdj
                   </div>--%>
               

                 <%--<asp:GridView ID="gvtest"  runat="server"></asp:GridView>--%>
           
               
            </div>
            

    <%--</form>--%>
</asp:Content>

