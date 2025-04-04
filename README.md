<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Fnf_Main.aspx.cs" Inherits="CLMS.App.Input.Fnf_Main" MaintainScrollPositionOnPostback="true" %>
<%@ Register assembly="CustomControls" namespace="GridViewasContainer" tagprefix="cc1" %>
<%@ Register src="~/Control/MyMsgBox.ascx" tagname="MyMsgBox" tagprefix="uc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.2.js"></script>
<script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
<script type="text/javascript">


</script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h1>Hello</h1>


</asp:Content>
Parser Error
Description: An error occurred during the parsing of a resource required to service this request. Please review the following specific parse error details and modify your source file appropriately.

Parser Error Message: Could not load type 'CLMS.App.Input.Fnf_Main'.

Source Error:


Line 1:  <%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Fnf_Main.aspx.cs" Inherits="CLMS.App.Input.Fnf_Main" MaintainScrollPositionOnPostback="true" %>
Line 2:  <%@ Register assembly="CustomControls" namespace="GridViewasContainer" tagprefix="cc1" %>
Line 3:  <%@ Register src="~/Control/MyMsgBox.ascx" tagname="MyMsgBox" tagprefix="uc1" %>
