<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContentMaintenanceDashboard.ascx.cs"
    Inherits="ContentMaintenanceDashboard.ContentMaintenanceDashboard" %>
<%@ Register Assembly="ContentMaintenanceDashboard" Namespace="ContentMaintenanceDashboard.Classes"
    TagPrefix="Dashboard" %>
<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<umbraco:Feedback ID="MessageFeedback" runat="server" Visible="false" />
<asp:ValidationSummary ID="valSum" runat="server" CssClass="Error" />
<umbraco:Pane ID="FilterPane" runat="server">
    <umbraco:PropertyPanel ID="NameProperty" runat="server" Text="Name">
        <asp:TextBox ID="SearchFilterTextBox" CssClass="umbEditorTextField" runat="server" /></umbraco:PropertyPanel>
    <umbraco:PropertyPanel ID="DocumentTypeProperty" runat="server" Text="Document type">
        <asp:DropDownList ID="DocumentTypeDropdown" runat="server" />
    </umbraco:PropertyPanel>
    <umbraco:PropertyPanel ID="TemplateProperty" runat="server" Text="Template">
        <asp:DropDownList ID="TemplateDropdown" runat="server" />
    </umbraco:PropertyPanel>
    <umbraco:PropertyPanel ID="StateProperty" runat="server" Text="Publish state">
        <asp:DropDownList ID="StateDropdown" runat="server" />
    </umbraco:PropertyPanel>
    
    <umbraco:PropertyPanel ID="RecordPerPageProperty" runat="server" Text="Record per page">
        <asp:DropDownList ID="RecordPerPageDropdown" runat="server">
            <asp:ListItem Value="10" Text="10" />
            <asp:ListItem Value="50" Text="50" />
            <asp:ListItem Value="100" Text="100" Selected="True" />
        </asp:DropDownList>
    </umbraco:PropertyPanel>
    <umbraco:PropertyPanel ID="SearchInContentProperty" runat="server" Text="Search in Content (Slower)">
        <asp:CheckBox ID="SearchInContentCheckBox" runat="server" Checked="true" /></umbraco:PropertyPanel>
    <umbraco:PropertyPanel ID="SearchProperty" runat="server" Text="">
     <umbraco:PropertyPanel ID="ParentProperty" runat="server" Text="Parent">
        <asp:PlaceHolder ID="ParentPropertyPlaceHolder" runat="server" />
    </umbraco:PropertyPanel><br /><br />
        <asp:Button ID="SearchButton" runat="server" Text="Search" OnClick="SearchButton_Click" /></umbraco:PropertyPanel>
</umbraco:Pane>
<umbraco:Pane ID="NoresultPane" runat="server">
    No Result</umbraco:Pane>
<umbraco:Pane ID="ResultPane" runat="server">
   <umbraco:PropertyPanel ID="ResultPanel" runat="server" Text="">
        <asp:Placeholder ID="MassOptionButtons" runat="server">
        <asp:Button ID="PublishAllButton" runat="server" Text="Publish Selected" OnClick="PublishAllButton_Click" />&nbsp;&nbsp;<asp:Button
            ID="UnPublishAllButton" runat="server" Text="UnPublish Selected" OnClick="UnPublishAllButton_Click" />&nbsp;&nbsp;<asp:Button
                ID="DeleteAllButton" runat="server" Text="Delete Selected" OnClick="DeleteAllButton_Click" />&nbsp;&nbsp;<asp:button
                id="MoveAllButtonSelect" Text="Move Selected" runat="server" OnClick="MoveAllButton_Click"/>&nbsp;&nbsp;<asp:LinkButton
                    ID="SelectAllButton" runat="server" Text="Select All" OnClick="SelectAllButton_Click" />&nbsp;&nbsp;<asp:LinkButton
                        ID="DeSelectAllButton" runat="server" Text="Deselect All" OnClick="DeSelectAllButton_Click" /><br /><br />
                        </asp:Placeholder>
        <asp:Placeholder id="MassMoveOptionsPlaceholder" runat="server" visible="false">Move selected items to: <asp:PlaceHolder ID="NewParentPickerPlaceHolder" runat="server" />&nbsp;&nbsp;&nbsp;<asp:Button
                ID="Button1" runat="server" Text="Move" OnClick="DoMoveAllButton_Click" ValidationGroup="DoMove" /><asp:CustomValidator ID="ParentReqVal" ErrorMessage="Specify a parent" Text="Specify a parent" OnServerValidate="ParentValidate" ValidationGroup="DoMove" runat="server" Display="Dynamic"  />&nbsp;&nbsp;<asp:Button ID="CancelMove" runat="server" Text="Cancel move" OnClick="CancelMove_Click" />    </asp:Placeholder>
        <asp:GridView ID="OverviewGrid" runat="server" OnPageIndexChanging="OverviewGrid_PageIndexChanging"
            OnSorting="OverviewGrid_Sorting" AutoGenerateColumns="false" AllowPaging="True"
            AllowSorting="True">
            <Columns>
                <asp:TemplateField HeaderText="Name" SortExpression="Text">
                    <ItemTemplate>
                        <Dashboard:ValueCheckBox ID="SelectCheckbox" Value='<%# Eval("Id")%>' runat="server" />&nbsp;<asp:HyperLink ID="ContentLink" runat="server" NavigateUrl='<%#String.Format("/umbraco/editContent.aspx?id={0}", Eval("Id"))%>'><%# Eval("Text")%></asp:HyperLink></ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Document type" SortExpression="nodeTypeName">
                    <ItemTemplate>
                        <%# Eval("nodeTypeName")%></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="State" SortExpression="Published">
                    <ItemTemplate>
                        <%# (bool)Eval("published") ? "Published" : "Unpublished"%></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="publishButton" CommandArgument='<%# Eval("Id")%>' OnCommand="PublisButton_Command"
                            runat="server" Text="Publish" />&nbsp;<asp:Button ID="UnPublishButton" runat="server"
                                Text="UnPublish" CommandArgument='<%# Eval("Id")%>' OnCommand="UnpublishButton_Command" />&nbsp;<asp:Button
                                    ID="DeleteButton" runat="server" Text="Delete" CommandArgument='<%# Eval("Id")%>'
                                    OnCommand="DeleteButton_Command" /></ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </umbraco:PropertyPanel>
</umbraco:Pane>
