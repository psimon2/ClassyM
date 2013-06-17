<%@ Page Explicit="True" Language="VB" Debug="True" %>
<%@ Register TagPrefix="ASPFD" TagName="Header" Src="header.ascx" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    Sub Page_Load(Sender As Object, E As EventArgs)
    If Not IsPostBack Then
      Dim Connect As MsmDataProvider.MsmConnection = New MsmDataProvider.MsmConnection()
      Dim Adaptor As MsmDataProvider.MsmDataAdapter
      Dim ds As DataSet = New DataSet()
      Dim MCode As String
      Dim Category As String
    
      Category = Trim(Request.QueryString("Category"))
    
      If Category <> "" Then
         Header.AddPageName("Category Listing: " & Category)
         MCode = "D CAT^ASP(""" & Category & """)"
      Else
         Header.AddPageName("Ad Listing")
         MCode = "D ADS^ASP"
      End If
    
      Connect.ConnectionString = "Server=127.0.0.1;Port=1972;Uci=PAU;Volume=PAU"
      Connect.Open()
      Adaptor = New MsmDataProvider.MsmDataAdapter(MCode, Connect)
      Adaptor.Fill(ds)
    
      AdsGrid.DataSource = ds
      Page.DataBind()
    
      Connect.Close()
      Adaptor.Dispose()
    End If
    End Sub
    
    Sub AdsGrid_SelectedIndexChanged(sender As Object, e As EventArgs)
    
    End Sub

</script>
<html>
<head>
</head>
<body vlink="red">
    <aspfd:header id="Header" runat="server"></aspfd:header>
    <asp:datagrid id="AdsGrid" runat="server" autogeneratecolumns="false" border="1" backcolor="yellow" width="100%" bordercolor="Black" cellspacing="0" cellpadding="5" OnSelectedIndexChanged="AdsGrid_SelectedIndexChanged">
        <headerstyle font-bold="true" />
        <columns>
            <asp:hyperlinkcolumn headertext="Title" datanavigateurlfield="AdNum" datanavigateurlformatstring="detail.aspx?AdNum={0}" datatextfield="Title" />
            <asp:boundcolumn headertext="Price" datafield="Price"></asp:boundcolumn>
            <asp:boundcolumn headertext="State" datafield="State"></asp:boundcolumn>
        </columns>
    </asp:datagrid>
    <br />
    <center>
        <asp:hyperlink id="HomeLink" runat="server" navigateurl="default.aspx" font-bold="true" font-name="Arial" font-size="12 pt">
[ Home ]</asp:hyperlink>
    </center>
</body>
</html>
