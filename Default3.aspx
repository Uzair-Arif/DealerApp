<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3"  EnableEventValidation="false"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Print DIV Content using javaScript</title>
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
        function validateForm() {
            var x = document.forms["form1"]["txt1"].value;
            if (x == null || x == "") {
                alert("Name must be filled out");
                return false;
            }
        }
            </script>
    
     

</head>
<body>
    <form id="form1" runat="server">
    
       <div>   
           <%--<script src="assets/js/jquery-1.8.2.min.js"></script>--%>
    <link href="assets/jQueryToast/src/main/resources/css/jquery.toastmessage.css" rel="stylesheet" />
    <script src="assets/jQueryToast/src/main/javascript/jquery.toastmessage.js"></script>
   
<script type="text/javascript">
    function showSuccessToast() {
        $().toastmessage('showSuccessToast', "Value added");
    }
    function showNoticeToast() {
        $().toastmessage('showNoticeToast', "Notice Dialog");
    }
    function showWarningToast() {
        $().toastmessage('showWarningToast', "OK but value should be at least 8 char");
    }
    function showErrorToast() {
        $().toastmessage('showErrorToast', "Insert a value");
    }
</script>
    <div id="divToPrint">
   <asp:GridView runat="server" ID="gvtest"> </asp:GridView>
    </div>
    <br />   
    <div id="divNotToPrint">
    This is a sample content not to print<br />
    This is a sample content not to print<br />
    This is a sample content not to print<br />
    This is a sample content not to print
    </div>
    <br />   
           <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <%--<asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Print_button.png" OnClientClick="javascript:PrintDivContent('divToPrint');" />--%>
  <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
      <ContentTemplate>
          
      <script type="text/javascript">
          Sys.Application.add_load(showSuccessToast);
            </script>
            <asp:Button ID="btn1" runat="server"   OnClick="btn1_Click" Text="click me" />
       </ContentTemplate>
      <Triggers>
          <asp:AsyncPostBackTrigger ControlID="btn1" />
      </Triggers>
  </asp:UpdatePanel>
               </div>
        <asp:FileUpload ID="fileupload1" runat="server" />
        <asp:Button ID="btnfile" runat="server" Text="Upload File" OnClick="btnfile_Click" />
        <asp:TextBox runat="server" ID="txtNumber"  />
        <asp:Button Text="Submit" runat="server" OnClientClick="validateForm()" />
        
        <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="txtNumber" runat="server" />
        <asp:CustomValidator ErrorMessage="Please Enter numbers" ControlToValidate="txtNumber" runat="server" ID="cvNumber" OnServerValidate="cvNumber_ServerValidate" />
        <asp:Button ID="btn2" Text="text" runat="server" />
        <asp:Panel runat="server" ID="Panelhello">
            <asp:TextBox runat="server" Text="hello" ID="txtReturn" />
        </asp:Panel>
    </form>
   
       
</body>
</html>
