<%@ Page Explicit="True" Language="VB" Debug="True" %>
<%@ Register TagPrefix="ASPFD" TagName="Header" Src="header.ascx" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    Sub Page_Load(Sender As Object, E As EventArgs)
    Header.AddPageName("Search")
    End Sub
    
    Sub Search_Click(Sender As Object, E As EventArgs)
        
    Dim WhereClause As String
    
        Dim Connect As MsmDataProvider.MsmConnection = New MsmDataProvider.MsmConnection()
        Dim Adaptor As MsmDataProvider.MsmDataAdapter
        Dim ds As DataSet = New DataSet()
        Dim MCode As String
               
    Message.Text = ""
    
    ' If they only entered a category, go to the category page
    If TitleText.Text = "" And DescriptionText.Text = "" And _
        StateText.Text = "" And PriceFromText.Text = "" And _
        PriceToText.Text = "" Then
        If CategoryDropDown.SelectedItem.Value = "" Then
           Message.Text = "You didn't enter any search " & _
              "parameters. Try again."
           Exit Sub
        Else
           Response.Redirect("category.aspx?Category=" & _
              CategoryDropDown.SelectedItem.Value)
        End If
    End If
    
        WhereClause = TitleText.Text & "~" & DescriptionText.Text & "~" & CategoryDropDown.SelectedItem.Value & "~" & StateText.Text & "~" & PriceFromText.Text & "~" & PriceToText.Text
        
        MCode = "D SEARCH^ASP(""" + WhereClause + """)"
    
        Connect.ConnectionString = "Server=127.0.0.1;Port=1972;Uci=PAU;Volume=PAU"
        Connect.Open()
        Adaptor = New MsmDataProvider.MsmDataAdapter(MCode, Connect)
        Adaptor.Fill(ds)
        AdsGrid.DataSource = ds.Tables("Ads")
        Page.DataBind()
        Connect.Close()
        Adaptor.Dispose()
    
    End Sub

</script>
<html>
<head>
</head>
<body vlink="red">
    <form runat="server">
        <aspfd:header id="Header" runat="server"></aspfd:header>
        <table>
            <tbody>
                <tr>
                    <td>
                        Title:</td>
                    <td>
                        <asp:textbox id="TitleText" runat="server" columns="30"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description:</td>
                    <td>
                        <asp:textbox id="DescriptionText" runat="server" columns="30"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category:</td>
                    <td>
                        <asp:dropdownlist id="CategoryDropDown" runat="server">
                            <asp:listitem value="">* Any Category *</asp:listitem>
                            <asp:listitem value="VEHICLES">Vehicles</asp:listitem>
                            <asp:listitem value="COMPUTERS">Computers</asp:listitem>
                            <asp:listitem value="REALESTATE">Real Estate</asp:listitem>
                            <asp:listitem value="COLLECTIBLES">Collectibles</asp:listitem>
                            <asp:listitem value="GENERAL">General Merchandise</asp:listitem>
                        </asp:dropdownlist>
                    </td>
                </tr>
                <tr>
                    <td>
                        State:</td>
                    <td>
                        <asp:textbox id="StateText" runat="server" columns="2"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Price:</td>
                    <td>
                        From: 
                        <asp:textbox id="PriceFromText" runat="server" columns="10"></asp:textbox>
                        To: 
                        <asp:textbox id="PriceToText" runat="server" columns="10"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:button id="Search" onclick="Search_Click" runat="server" text="Search"></asp:button>
                    </td>
                </tr>
            </tbody>
        </table>
        <br />
        <asp:Label id="Message" runat="server"></asp:Label>
        <br />
        <asp:datagrid id="AdsGrid" runat="server" cellpadding="5" cellspacing="0" bordercolor="Black" width="100%" backcolor="yellow" border="1" autogeneratecolumns="false">
            <headerstyle font-bold="true" />
            <columns>
                <asp:hyperlinkcolumn headertext="Title" datanavigateurlfield="AdNum" datanavigateurlformatstring="detail.aspx?AdNum={0}" datatextfield="Title" />
                <asp:boundcolumn headertext="Price" datafield="Price"></asp:boundcolumn>
                <asp:boundcolumn headertext="State" datafield="State"></asp:boundcolumn>
            </columns>
        </asp:datagrid>
    </form>
</body>
</html>
