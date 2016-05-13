<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DocumentRelationsDataType.ascx.cs" Inherits="Vizioz.Relationships.UserControls.DocumentRelationsDataType" %>
<%@ Register Assembly="controls" Namespace="umbraco.uicontrols.TreePicker" TagPrefix="cc1" %>

<span class="relationshipPicker">
<cc1:SimpleContentPicker Visible="true" ID="RelationshipPicker" runat="server">

</cc1:SimpleContentPicker>
</span>
<%= this.GetRelatedDocuments() %>
