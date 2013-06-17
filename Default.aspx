<%@ Page Explicit="True" Language="VB" Debug="True" %>
<%@ Register TagPrefix="ASPFD" TagName="Header" Src="header.ascx" %>
<script runat="server">

    Sub Page_Load(Sender As Object, E As EventArgs)
    Header.AddPageName("Home")
    End Sub
    
    Sub Header_Load(sender As Object, e As EventArgs)
    
    End Sub

</script>
<html>
<head>
</head>
<body vlink="red">
    <aspfd:header id="Header" OnLoad="Header_Load" runat="server"></aspfd:header>
    Welcome to Classy Classifieds. We make it easy to turn your stuff into cash and to
    get other people's stuff cheap. 
    <p>
        <asp:Label id="Label1" runat="server" text="The Categories:" font-bold="true" font-name="Arial" font-size="18 pt"></asp:Label>
        <br />
        <br />
        <table cellpadding="10" width="100%">
            <tbody>
                <tr>
                    <td>
                        <asp:hyperlink id="VehiclesLink" runat="server" font-name="Arial" font-size="16" navigateurl="category.aspx?Category=VEHICLES">
Vehicles</asp:hyperlink>
                    </td>
                    <td>
                        <asp:hyperlink id="ComputersLink" runat="server" font-name="Arial" font-size="16 pt" navigateurl="category.aspx?Category=COMPUTERS">
Computers and Software</asp:hyperlink>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:hyperlink id="RealEstateLink" runat="server" font-name="Arial" font-size="16 pt" navigateurl="category.aspx?Category=REALESTATE">
Real Estate</asp:hyperlink>
                    </td>
                    <td>
                        <asp:hyperlink id="CollectiblesLink" runat="server" font-name="Arial" font-size="16 pt" navigateurl="category.aspx?Category=COLLECTIBLES">
Collectibles</asp:hyperlink>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:hyperlink id="GeneralLink" runat="server" font-name="Arial" font-size="16 pt" navigateurl="category.aspx?Category=GENERAL">
General Merchandise</asp:hyperlink>
                    </td>
                    <td>
                        <asp:hyperlink id="SearchLink" runat="server" font-name="Arial" font-size="16 pt" navigateurl="search.aspx">
Search</asp:hyperlink>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:hyperlink id="PlaceAdLink" runat="server" font-name="Arial" font-size="16 pt" navigateurl="editad.aspx">
Place A New Ad</asp:hyperlink>
                    </td>
                </tr>
            </tbody>
        </table>
    </p>
</body>
</html>
