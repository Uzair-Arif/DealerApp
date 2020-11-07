<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Medicines.aspx.cs" Inherits="Medicine" MasterPageFile="~/admin/MasterPage.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="c1" runat="server" ContentPlaceHolderID="head">
     <script type="text/javascript">
         function pageLoad() {
             $('.bs-pagination td table').each(function (index, obj) {
                 convertToPagination(obj)
             });
         }
   </script>
    <script type="text/javascript">
        function Search(ctrl) {

            if ($(ctrl).val() != null)
                $(".SeachClick").click();
            $(ctrl).focus();
        }
    </script>
    <script type="text/javascript">
        function SearchCompany(ctrl) {
            if ($(ctrl).val() != null)
                $(".SeachCompanyClick").click();
            $(ctrl).focus();
        }
    </script>
    <script type="text/javascript">
        function ValidateText(val) {
            var intValue = parseInt(val.value, 10);

            if (isNaN(intValue)) {
                alert("please enter only number");
            }
        }

</script>
   <script type="text/javascript">
       function allLetter(inputtxt) {
           var letters = /^[A-Za-z]*$/;
           if (inputtxt.value.match(letters)) {
               return true;
           }
           else {
               alert("Enter Letter only");
               return false;
           }
       }


   </script>

    <script type="text/javascript">
        function validateForm() {
            var flag = 0;
            var name = document.forms["f5"]["ContentPlaceHolder1_txtMedicineName"].value;
            if (name == null || name == "") {
                flag = 1;
                alert("Name must be filled out");
                return false;
            }
            var phone = document.forms["f5"]["ContentPlaceHolder1_fileupload1"].value;
            if (phone == null || phone == "") {
                flag = 1;
                alert("Upload Picture");
                return false;
            }
            var address = document.forms["f5"]["ContentPlaceHolder1_txtDescription"].value;
            if (address == null || address == "") {
                flag = 1;
                alert("Description must be filled out");
                return false;
            }
            var email = document.forms["f5"]["ContentPlaceHolder1_addtxtEmail"].value;
            if (email == null || email == "") {
                flag = 1;
                alert("Email must be filled out");
                return false;
            }
            var price = document.forms["f5"]["ContentPlaceHolder1_txtMedicinePrice"].value;
            if (price == null || price == "") {
                flag = 1;
                alert("Enter Price");
                return false;
            }
            if (!flag)
            {
                alert("Medicine Added");
            }
        }
            </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<form id="form1" runat="server">--%>

    <div class="container-fluid" >
        <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>--%>
         <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <%--<h1 class="page-header">
                            Medicine's Inventory
                            <asp:Label ID="lblsession" runat="server"></asp:Label>
                        </h1>--%>
                       <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.aspx">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-th-list"></i> Medicine Stock
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
          <div class="row" style="margin-right:3px;">
                      
                  
              <asp:UpdatePanel ID="upMedicine" runat="server">
                  <ContentTemplate>
              
               <asp:Button ID="btnAddMedicine" runat="server" OnClick="btnAddMedicine_Click" Text="+Add Medicine" CssClass="pull-right btn btn-lg btn-success"/>
                
            </ContentTemplate>
                  <Triggers>
                      <asp:AsyncPostBackTrigger  ControlID="btnAddMedicine" EventName="Click"/>
                  </Triggers>
              </asp:UpdatePanel>
              
              
        <asp:Panel ID="PanelAddMedicine" runat="server" CssClass="modalPopup"  align="center" style = "display:none">
            <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="PanelAddMedicine" TargetControlID="btnCancel"
    CancelControlID="btnCancel" BackgroundCssClass="modalBackground" >
</cc1:ModalPopupExtender>
            <asp:Button ID="btnCancel" runat="server" class="close" data-dismiss="modal" Text="X"/>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
            <table>
                   <tr>
                       <td>
         <asp:Label ID="lblMedicineName" runat="server" Text="Medicine Name"></asp:Label>
                       </td>
                       <td>
         <asp:TextBox ID="txtMedicineName" runat="server" CssClass="form-control" pattern="[A-Za-z\s]*" Title="Only Lettrs" placeholder="Enter Medicine Name" Width="300px"></asp:TextBox>
        </td>
                   </tr>
                <tr>
                    <td>
                        <asp:Label ID="MedicineImage" runat="server" Text="Medicine Image"></asp:Label>
                    </td>
                    <td>
                       <cc1:AsyncFileUpload   runat="server" ID="AsyncFileUpload1" Width="400px" UploaderStyle="Modern" CompleteBackColor = "White" OnUploadedComplete="AsyncFileUpload1_UploadedComplete"/>
                        
                    </td>
                   
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
                        
                    </td>
                </tr>
                   <tr>
                       <td>
         <asp:Label ID="lblMedicinePrice" runat="server" Text="Medcine Price"></asp:Label>
                           </td>
                       <td>
        <asp:TextBox ID="txtMedicinePrice" runat="server" CssClass="form-control" pattern="\d+(\.\d{2})?" Title="Only numbers" placeholder="Enter Medicine Price" Width="300px"></asp:TextBox>
        </td>
                           </tr>
                   <tr>
                       <td>
         <asp:Label ID="lblManufactureDate" runat="server" Text="Manufacture Date"></asp:Label>
                           </td>
                       <td>
        <asp:TextBox ID="addtxtManufactureDate" runat="server"  placeholder="Select Date" CssClass="form-control"></asp:TextBox>
                         <asp:CalendarExtender ID="CalenderExtenderMD2" runat="server" TargetControlID="addtxtManufactureDate" PopupButtonID="addtxtManufactureDate" Format="MM/dd/yyyy"></asp:CalendarExtender>
        </td>
                           </tr>
                   <tr>
                       <td>
         <asp:Label ID="lblExpiryDate" runat="server" Text="Expiry Date"></asp:Label>
                           </td>
                       <td>
        <asp:TextBox ID="addtxtExpiryDate" runat="server" placeholder="Select Date"  CssClass="form-control"></asp:TextBox>
                     <asp:CalendarExtender ID="CalendarExtenderED2" runat="server" TargetControlID="addtxtExpiryDate" PopupButtonID="addtxtExpiryDate" Format="MM/dd/yyyy"></asp:CalendarExtender>
                           <asp:CustomValidator ErrorMessage="Exp Date is Invalid" ForeColor="Red" ControlToValidate="addtxtExpiryDate" runat="server" ID="cvExpiryDate" OnServerValidate="cvExpiryDate_ServerValidate"/>
        </td>
                           </tr>
                   <tr>
                       <td>
         <asp:Label ID="lblMedicineCompanyName" runat="server" Text="Medicine Company Name"></asp:Label>
                           </td>
                       <td>
        <asp:DropDownList ID="addMedicineCompanyName" runat="server" CssClass="form-control" pattern="[A-Za-z\s]*" title="Only letters" DataSourceID="LinqDataSourceMedicineCompany" DataTextField="MedicineCompanyName" DataValueField="MedicineCompanyName"></asp:DropDownList>
        </td>
                           </tr>
                   <tr>
                       <td>
         <asp:Label ID="lblAmount" runat="server" Text="Amount"></asp:Label>
                           </td>
                       <td>
         <asp:TextBox ID="addtxtAmount" runat="server" Width="100%" CssClass="form-control" type="number" min="0" step="1" title="Only Whole Numbers" placeholder="Enter Amount"></asp:TextBox>
        </td>
                           </tr>
                   <tr>
                       <td>
         <asp:Label ID="lblMedicineCategory" runat="server" Text="Medicine Category"></asp:Label>
                           </td>
                       <td>
        <asp:DropDownList ID="addMedicineCategoryName" runat="server" CssClass="form-control" DataSourceID="LinqDataSourceMedicineCategory" DataTextField="MedicineCategoryName" DataValueField="MedicineCategoryName"></asp:DropDownList>
        </td>
                       <%-- <td>
                       
                                <asp:LinkButton ID="lnkUpload" Text="Upload Image" runat="server" OnClick="lnkUpload_Click"  />
                    
                     </td>--%>
                           </tr>
               </table>
            
                
        <%--<asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateForm();"/>--%>
                     <%--</ContentTemplate>--%>
                <%--<Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" />
                    
                </Triggers>--%>
      <%--  </asp:UpdatePanel>--%>
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success btn-lg" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateForm();"/>
           </ContentTemplate>
                     <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" />
                    
                </Triggers>
          </asp:UpdatePanel>

        
               </asp:Panel>
        </div>
               
        <asp:Label ID="lblerr" runat="server"></asp:Label>
    
              
         <%--<asp:Button ID="btnAddMedicine" runat="server" Text="Add Medicine"  />--%>
        <%--Gridview for Medicine  --%>
        <%--<div class="row">
        <div class="col-lg-12 col-sm-6">
                        <h2>Medicine </h2>--%>
        
            
              
            
                        <div class="table-responsive">
          <asp:LinqDataSource ID="LinqDataSourceMedicineCategory" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicineCategoryName)" TableName="Medicine_Categories"></asp:LinqDataSource>
           <asp:LinqDataSource ID="LinqDataSourceMedicineCompany" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" Select="new (MedicineCompanyName)" TableName="Medicine_Companies"></asp:LinqDataSource>
             <button id="btnSearch" type="button" runat="server" class="SeachClick" onserverclick="btnSearch_ServerClick" style="display: none;">
        </button>
                            <div class="form-inline">
                            <div class="form-group">
        <asp:Label runat="server" ID="lblSearchMedi" Text="<b>Search Medicine</b>"></asp:Label>
                            
                             <asp:TextBox ID="txtSearch" runat="server" onkeyup="Search(this);" pattern="[A-Za-z\s]*" ClientIDMode="Static" placeholder="Type Medicne Name" CssClass="form-control" Width="80%"></asp:TextBox>
                                </div>
        <button id="btnSearchCompany" type="button" runat="server" class="SeachCompanyClick" onserverclick="btnSearchCompany_ServerClick"
            style="display: none;">
        </button>
                            <div class="form-group">
        <asp:Label runat="server" ID="lblCompanyName" Text="<b>Search Medicine By Company</b>"></asp:Label> <asp:TextBox ID="txtSearchByCompany" runat="server" onkeyup="SearchCompany(this);" pattern="[A-Za-z\s]*" ClientIDMode="Static" placeholder="Type Company Name" CssClass="form-control" Width="80%"></asp:TextBox>
                                </div>
                                </div>
                                </div>
                            <br />
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                    <h2 class="panel-title"> <i class="fa fa-plus fa-fw"></i><b>List of Medicines</b></h2>
                        </div>
                                        <div class="panel-body">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="serverclick" />
            </Triggers>
                                 <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearchCompany" EventName="serverclick" />
            </Triggers>
                                
            <ContentTemplate>
             
                <div style="overflow-x:auto;width:100%;">
      <asp:GridView ID="gvMedicine" runat="server" CssClass="table table-bordered table-hover table-striped" AllowSorting="true" OnSorting="gvMedicine_Sorting"  PagerStyle-CssClass="bs-pagination" CellPadding="900" CellSpacing="0"  Width="100%" OnPageIndexChanging="gvMedicine_PageIndexChanging" Font-Size="11pt" AutoGenerateColumns="False" OnRowCancelingEdit="cancelEditMedicine" OnRowEditing="editMedicine" OnRowUpdating="updateMedicine" PageSize="5" AllowPaging="true">
             
          

             <PagerStyle CssClass="bs-pagination"  HorizontalAlign="Center"/>
          <Columns>
              
                 <asp:TemplateField HeaderText="ID" HeaderStyle-Width="20%">
                   
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineID" runat="server" Text='<%# Eval("MedicineID") %>'></asp:Label>
                        </ItemTemplate>
                       
                <EditItemTemplate>       
                    <asp:Label ID="editlblMedicineID" runat="server" Text='<%# Eval("MedicineID") %>'></asp:Label>
                        
                </EditItemTemplate>
                     
                 </asp:TemplateField>
              <asp:ImageField DataImageUrlField="Image" ControlStyle-Width="100"
        ControlStyle-Height = "100" HeaderText = "Preview Image"/>
             <%-- <asp:TemplateField>
                  <EditItemTemplate>
                      <asp:Image runat="server"  ID="editImageID" ImageUrl='<%#Bind("Image") %>' />
                  </EditItemTemplate>
              </asp:TemplateField>--%>
              <%--<asp:TemplateField HeaderText="Image" HeaderStyle-Width="20%">
                   
                     <ItemTemplate>
                           

                     </ItemTemplate>--%>
                       
                <%--<EditItemTemplate>       
                    <asp:Label ID="editlblMedicineID" runat="server" Text='<%# Eval("MedicineID") %>'></asp:Label>
                        
                </EditItemTemplate>--%>
                     
                 <%--</asp:TemplateField>--%>
              <asp:TemplateField HeaderText="Batch Number" SortExpression="BatchNo" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineBatch" runat="server" Text='<%# Eval("BatchNo") %>'></asp:Label>
                        </ItemTemplate>
                  </asp:TemplateField>
                 <asp:TemplateField HeaderText="Medicine Name" SortExpression="MedicineName" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineName" runat="server" Text='<%# Eval("MedicineName") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtMedicineName" runat="server" Text='<%# Eval("MedicineName") %>' Width="80%" pattern="[A-Za-z\s,.]*" title="Only Letters"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="requiredMedicineName" runat="server" ControlToValidate="edittxtMedicineName" ErrorMessage="Required" ForeColor="Red" ></asp:RequiredFieldValidator>   
                     <asp:CustomValidator ID="CustomValidator1" runat="server" ForeColor="Red" ErrorMessage="Please enter Letters Only."
    OnServerValidate="CustomValidator1_ServerValidate" ControlToValidate="edittxtMedicineName"></asp:CustomValidator>
                </EditItemTemplate>
                     
                     
                 </asp:TemplateField>
              <asp:TemplateField HeaderText="Price" SortExpression="Price" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                              <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                        </ItemTemplate>
                  
                      <EditItemTemplate>       
                    <asp:TextBox ID="edittxtPrice" runat="server" Text='<%# Eval("Price") %>' Width="55%" pattern="[1-9,.][0-9]+" Title="Only Numbers" type="number"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="requiredPrice" runat="server" ControlToValidate="edittxtPrice" ErrorMessage="Required" ForeColor="Red" ></asp:RequiredFieldValidator>    
            <asp:CustomValidator ID="CustomValidator2" runat="server" ForeColor="Red" ErrorMessage="Please enter Numbers Only."
    OnServerValidate="CustomValidator2_ServerValidate" ControlToValidate="edittxtPrice"></asp:CustomValidator>
                </EditItemTemplate>
                    
                     
                 </asp:TemplateField>
             <asp:TemplateField HeaderText="Mfg Date" SortExpression="ManudactureDate" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                            <asp:Label ID="lblManufactureDate" runat="server" Text='<%# String.Format("{0:M/d/yyyy}",Eval("ManufactureDate"))%>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtManufactureDate" runat="server" Width="70px" Text='<%# String.Format("{0:M/d/yyyy}",Eval("ManufactureDate")) %>'></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtenderMD1" runat="server" TargetControlID="edittxtManufactureDate" PopupButtonID="edittxtManufactureDate" Format="MM/dd/yyyy"></asp:CalendarExtender>
                     <asp:RequiredFieldValidator ID="requiredManufactureDate" runat="server" ControlToValidate="edittxtManufactureDate" ErrorMessage="Required" ForeColor="Red" ></asp:RequiredFieldValidator>
                </EditItemTemplate>
                     
                 </asp:TemplateField>
              <asp:TemplateField HeaderText="Exp Date" SortExpression="ExpiryDate" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                            <asp:Label ID="lblExpiryDate" runat="server" Text='<%# String.Format("{0:M/d/yyyy}",Eval("ExpiryDate")) %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtExpiryDate" runat="server" Width="70px" Text='<%# String.Format("{0:M/d/yyyy}",Eval("ExpiryDate")) %>'></asp:TextBox>
                     <asp:CalendarExtender ID="CalendarExtenderED1" runat="server" TargetControlID="edittxtExpiryDate" PopupButtonID="edittxtExpiryDate" Format="MM/dd/yyyy"></asp:CalendarExtender>   
                     <asp:RequiredFieldValidator ID="requiredExpiryDate" runat="server" ControlToValidate="edittxtExpiryDate" ErrorMessage="Required" ForeColor="Red" ></asp:RequiredFieldValidator>
                    <asp:CustomValidator ErrorMessage="Expiry Date InValid" ControlToValidate="edittxtExpiryDate" ForeColor="Red" runat="server" ID="cvEditExpiryDate" OnServerValidate="cvEditExpiryDate_ServerValidate" />
                </EditItemTemplate>
                     
                 </asp:TemplateField>
              <asp:TemplateField HeaderText="Company Name" SortExpression="MedicineCompanyName" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineCompanyName" runat="server" Text='<%# Eval("MedicineCompanyName") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:DropDownList ID="editMedicineCompanyName" runat="server"  DataSourceID="LinqDataSourceMedicineCompany" DataTextField="MedicineCompanyName" DataValueField="MedicineCompanyName" ></asp:DropDownList>
                        
                </EditItemTemplate>
                     
                 </asp:TemplateField>
           <asp:TemplateField HeaderText="Amount" SortExpression="Amount" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                            <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount") %>' onkeyup="ValidateText(this)"></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:TextBox ID="edittxtAmount" runat="server" Text='<%# Eval("Amount") %>' Width="55%" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="requiredAmount" runat="server" ControlToValidate="edittxtAmount" ErrorMessage="Required" ForeColor="Red" ></asp:RequiredFieldValidator>    
                            <asp:CustomValidator ID="CustomValidator3" runat="server" ForeColor="Red" ErrorMessage="Please enter Numbers Only."
    OnServerValidate="CustomValidator3_ServerValidate" ControlToValidate="edittxtAmount"></asp:CustomValidator>
                </EditItemTemplate>
                     
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Medicine Category" SortExpression="MedicineCategoryName" HeaderStyle-ForeColor="Black">
                     <ItemTemplate>
                            <asp:Label ID="lblMedicineCategoryName" runat="server" Text='<%# Eval("MedicineCategoryName") %>'></asp:Label>
                        </ItemTemplate>
                <EditItemTemplate>       
                    <asp:DropDownList ID="editMedicineCategoryName"  runat="server"  DataSourceID="LinqDataSourceMedicineCategory"  Width="120px" DataTextField="MedicineCategoryName" DataValueField="MedicineCategoryName"></asp:DropDownList>
                        
                </EditItemTemplate>
                     
                 </asp:TemplateField>
                 
                 <asp:TemplateField>
                    <ItemTemplate>
        <asp:LinkButton ID="lnkRemove" runat="server"
            CommandArgument = '<%# Eval("MedicineID")%>'
         OnClientClick = "return confirm('Do you want to delete?')"
        Text = "Delete" OnClick="deleteMedicine" ForeColor="Red"></asp:LinkButton>
    </ItemTemplate>
    
                     
                 </asp:TemplateField>

         <asp:CommandField  ShowEditButton="True" ControlStyle-ForeColor="Green"/>
             </Columns>

          
          

          
      </asp:GridView>
                    </div>
            </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvMedicine" />
        </Triggers>
        </asp:UpdatePanel>
                                            </div>
                                        </div>
                                    </div>
                                </div>
        </div>
        <%--</div>
       </div>--%>
        
  
        </div>
        
    <%--</form>--%>
    

    
    
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   
        
    </asp:Content>
