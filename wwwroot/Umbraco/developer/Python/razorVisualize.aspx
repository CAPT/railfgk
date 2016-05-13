<%@ Page Language="C#" MasterPageFile="../../masterpages/umbracoDialog.Master" AutoEventWireup="true"
    CodeFile="razorVisualize.aspx.cs" ValidateRequest="false" Inherits="umbraco_developer_Python_razorVisualize" %>
<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="cc2" Namespace="umbraco.controls" Assembly="umbraco" %>

<asp:Content runat="server" ContentPlaceHolderID="head">

    <script type="text/javascript">

        jQuery(document).ready(function () {

            var xsltSelection = jQuery("#<%=xsltSelection.ClientID %>");
            
            if (xsltSelection.val() == '') {
                xsltSelection.val(UmbClientMgr.snippet);

                /*UmbClientMgr.contentFrame().xsltSnippet
                // automatically submit if page is chosen
                var picker = Umbraco.Controls.TreePicker.GetPickerById('<%=contentPicker.ClientID%>');
                if (picker.GetValue() != '') {
                jQuery("#<%=visualizeDo.ClientID %>").click();
                }*/
            }

        });

        function encodeDecodeResult(isChecked) {
            var html = jQuery("#result").html();
            if (isChecked) {
                jQuery("#result").html(
                    html.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\n/g,"<br/>").replace(/\r/g,""));
            } else {
            jQuery("#result").html(
                    html.replace(/<BR>/g, "\n").replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>'));
        }
        }

    </script>

</asp:Content>
<asp:Content ContentPlaceHolderID="body" runat="server">

<cc1:Pane ID="Pane1" runat="server" Text="Visualize saved Razor file">
  <cc1:PropertyPanel ID="PropertyPanel1" runat="server">
    <input type="hidden" runat="server" id="xsltSelection" />
    @Model=<cc2:ContentPicker ID="contentPicker" runat="server" /><br/>
    @Parameter.VisualizeOption=<asp:TextBox ID="visualizeOption" runat="server" Text="" width="350px"></asp:TextBox>    
    <asp:Button ID="visualizeDo" runat="server" Text="Visualize Razor (executing the actual code)" OnClick="visualizeDo_Click" />
</cc1:PropertyPanel>
</cc1:Pane>
<cc1:Pane ID="visualizeContainer" runat="server" Text="Generated Result" Visible="false">
<p style="float: right">
    <!--<input type="checkbox" id="encodeDecode" onclick="encodeDecodeResult(this.checked)" />
    <label for="encodeDecode">Encode/Decode result</label></p>-->
<cc1:PropertyPanel ID="visualizePanel" runat="server">
    <asp:Literal ID="visualizeArea" runat="server"></asp:Literal>
</cc1:PropertyPanel>
    </cc1:Pane>

</asp:Content>
