<%@ Control Explicit="True" Language="VB" Debug="True" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<%@ import Namespace="System.Globalization" %>

<script runat="server">
    Dim Row As DataRow
    Dim AdNumSent As String
    Dim CatListIndex As Integer
    Dim Connect As MsmDataProvider.MsmConnection = New MsmDataProvider.MsmConnection()
    Dim Adaptor As MsmDataProvider.MsmDataAdapter
    Dim MCode As String
    
    Public AdNum As Integer
    Public Title As String
    Public Description As String
    Public Category As String
    Public Price As String
    Public Phone As String
    Public Email As String
    Public State As String
    Public Posted As Date
    Public Password As String
    
    Public HasErrors As Boolean
    Public RowError As String
    
    Sub GetAd(AdNumSent As String)
        Dim ClassyDS As DataSet = New DataSet()
    
        if AdNumSent = "0" Then Exit Sub
    
        MCode = "D ROW^ASP(" & AdNumSent & ")"
        Connect.ConnectionString = "Server=127.0.0.1;Port=1972;Uci=PAU;Volume="
        Connect.Open()
        Adaptor = New MsmDataProvider.MsmDataAdapter(MCode, Connect)
        Adaptor.Fill(ClassyDS)
        Connect.Close()
        Adaptor.Dispose()
    
        If ClassyDS.Tables("Ads").Rows.Count > 0 Then
           Row = ClassyDS.Tables("Ads").Rows(0)
    
           AdNum = Row.Item("AdNum")
           Title = Row.Item("Title")
           Description = Row.Item("Description")
           Category = Row.Item("Category")
           Price = Row.Item("Price")
           Phone = Row.Item("Phone")
           Email = Row.Item("Email")
           State = Row.Item("State")
           Posted = Row.Item("Posted")
           Password = Row.Item("Password")
    
           TitleLabel.Text = Title
           DescriptionLabel.Text = Description
           PriceLabel.Text = Price
           PhoneLabel.Text = Phone
           EmailLink.Text = Email
           EmailLink.NavigateURL = "mailto:" & Email
           StateLabel.Text = State
           PostedLabel.Text = Posted
        End If
    
        PostErrors
    End Sub
    
    Sub PlaceAd
        Dim ClassyDS As DataSet = New DataSet()
        Dim Q As String
        Dim provider As CultureInfo = CultureInfo.InvariantCulture
        Dim dateString As String
    
        Q = """"
    
        Title = Q & Replace(Title, """", """""") & Q
        Description = Q & Replace(Description, """", """""") & Q
        Category = Q & Replace(Category, """", """""") & Q
        Price = Q & Replace(Price, """", """""") & Q
        Phone =Q &  Replace(Phone, """", """""") & Q
        Email = Q & Replace(Email, """", """""") & Q
        State = Q & Replace(State, """", """""") & Q
        Password = Q & Replace(Password, """", """""") & Q

        dateString = Now
        
        Dim dtm As System.DateTime = CDate(Now)
    
        MCode = "D ADD^ASP(" & Title & "," & Description & "," & Category & "," & Price & _
           "," & Phone & "," & Email & "," & State & "," & Password & "," & Q & "NA" & Q & ")"
    
        'Response.Write("<B>" + MCode + "</B>")
    
        Connect.ConnectionString = "Server=127.0.0.1;Port=1972;Uci=PAU;Volume="
    
        Connect.Open()
        Adaptor = New MsmDataProvider.MsmDataAdapter(MCode, Connect)
    
        Adaptor.Fill(ClassyDS)
    
        Connect.Close()
        Adaptor.Dispose()
    End Sub
    
    Sub EditAd    
        Dim params As String
        Dim ClassyDS As DataSet = New DataSet()
    
        CopyToDS
    
        AdNumSent = Request.QueryString("AdNum")
    
        params = AdNumSent & "¥" & Title & "¥" & _
          Category & "¥" & _
          Description & "¥" & _
          Price & "¥" & _
          Phone & "¥" & _
          Email & "¥" & _
          State
    
        MCode = "D UPDATE^ASP(""" + Replace(params, """", """""") + """)"
    
        Connect.ConnectionString = "Server=127.0.0.1;Port=1972;Uci=PAU;Volume="
        Connect.Open()
        Adaptor = New MsmDataProvider.MsmDataAdapter(MCode, Connect)
    
        Adaptor.Fill(ClassyDS)
    
        Connect.Close()
        Adaptor.Dispose()
    End Sub
    
    Sub DeleteAd

        Dim ClassyDS As DataSet = New DataSet()
        AdNumSent = Request.QueryString("AdNum")
    
        MCode = "D DELETE^ASP(" + AdNumSent + ")"
    
        Connect.ConnectionString = "Server=127.0.0.1;Port=1972;Uci=PAU;Volume="
        Connect.Open()
        Adaptor = New MsmDataProvider.MsmDataAdapter(MCode, Connect)
    
        Adaptor.Fill(ClassyDS)
    
        Connect.Close()
        Adaptor.Dispose()
    End Sub
    
    
    ' Copy the values in the properties of this
    ' control in the ClassyDS
    Private Sub CopyToDS
        Row.Item("Title") = Title
        Row.Item("Description") = Description
        Row.Item("Category") = Category
        Row.Item("Price") = CSng(Price)
        Row.Item("Phone") = Phone
        Row.Item("Email") = Email
        Row.Item("State") = State
        Row.Item("Password") = Password
    End Sub
    
    Private Sub PostErrors
        'HasErrors = ClassyDS.HasErrors
        'If HasErrors Then
           'RowError = ClassyDS.Tables("Ads").Rows(0).RowError
        'End If
    End Sub

</script>
<table bordercolor="black" cellspacing="0" cellpadding="2" width="100%" bgcolor="lime" border="1">
    <tbody>
        <tr>
            <td bgcolor="yellow" colspan="2">
                <asp:Label id="TitleLabel" runat="server" font-size="12 pt" font-bold="true"></asp:Label></td>
        </tr>
        <tr>
            <td valign="top" width="25%">
                Description:</td>
            <td>
                <asp:Label id="DescriptionLabel" runat="server" font-size="12 pt" font-bold="true"></asp:Label></td>
        </tr>
        <tr>
            <td width="25%">
                Price:</td>
            <td>
                $<asp:Label id="PriceLabel" runat="server" font-size="12 pt" font-bold="true"></asp:Label> 
            </td>
        </tr>
        <tr>
            <td width="25%">
                Phone:</td>
            <td>
                <asp:Label id="PhoneLabel" runat="server" font-size="12 pt" font-bold="true"></asp:Label></td>
        </tr>
        <tr>
            <td width="25%">
                Email:</td>
            <td>
                <asp:hyperlink id="EmailLink" runat="server" font-size="12 pt" font-bold="true"></asp:hyperlink>
            </td>
        </tr>
        <tr>
            <td width="25%">
                Location:</td>
            <td>
                <asp:Label id="StateLabel" runat="server" font-size="12 pt" font-bold="true"></asp:Label></td>
        </tr>
        <tr>
            <td width="25%">
                Posted Date:</td>
            <td>
                <asp:Label id="PostedLabel" runat="server" font-size="12 pt" font-bold="true"></asp:Label></td>
        </tr>
    </tbody>
</table>