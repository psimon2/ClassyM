<%@ Control Explicit="True" Language="VB" Debug="True" %>
<script runat="server">

    Sub AddPageName(Name As String)
    Dim HTMLForHeader As String
    HTMLForHeader = "<br><p><table border=2 bgcolor=yellow width=100% " & _
        "bordercolor=Black cellspacing=0 cellpadding=5 >" & _
        "<td><font size=5 face='Arial' color='blue'><b>" & Name & "</b></font>" & _
        "</td></table></p>"
    PageName.Visible = true
    PageName.Text = HTMLForHeader
    End Sub

</script>
<table bordercolor="black" cellspacing="0" cellpadding="5" width="100%" bgcolor="yellow" border="2">
    <tbody>
        <tr>
            <td rowspan="2">
                <asp:Label id="HeaderLabel" text="MUMPS Classifieds" font-italic="true" font-bold="true" font-name="Arial" font-size="32 pt" forecolor="Red" runat="server"></asp:Label></td>
            <td valign="center" align="middle">
                <asp:hyperlink id="HomeLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="default.aspx">
Home</asp:hyperlink>
            </td>
            <td valign="center" align="middle">
                <asp:hyperlink id="VehiclesLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="category.aspx?Category=VEHICLES">
Vehicles</asp:hyperlink>
            </td>
            <td valign="center" align="middle">
                <asp:hyperlink id="ComputersLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="category.aspx?Category=COMPUTERS">
Computers</asp:hyperlink>
            </td>
            <td valign="center" align="middle">
                <asp:hyperlink id="RealEstateLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="category.aspx?Category=REALESTATE">
Real Estate</asp:hyperlink>
            </td>
        </tr>
        <tr>
            <td valign="center" align="middle">
                <asp:hyperlink id="CollectiblesLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="category.aspx?Category=COLLECTIBLES">
Collectibles</asp:hyperlink>
            </td>
            <td valign="center" align="middle">
                <asp:hyperlink id="GeneralLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="category.aspx?Category=GENERAL">
General</asp:hyperlink>
            </td>
            <td valign="center" align="middle">
                <asp:hyperlink id="PlaceAdLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="editad.aspx">
Place A<br />New Ad</asp:hyperlink>
            </td>
            <td valign="center" align="middle">
                <asp:hyperlink id="SearchLink" font-bold="true" font-name="Arial" font-size="10 pt" runat="server" navigateurl="search.aspx">
Search</asp:hyperlink>
            </td>
        </tr>
    </tbody>
</table>
<asp:Label id="PageName" runat="server" visible="false"></asp:Label>