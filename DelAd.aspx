<%@ Page Explicit="True" Language="VB" Debug="True" %>
<%@ Register TagPrefix="ASPFD" TagName="Header" Src="header.ascx" %>
<%@ Register TagPrefix="ASPFD" TagName="ClassyAd" Src="classyad.ascx" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    Dim AdNumSent As Integer
    
    Sub Page_Load(Sender As Object, E As EventArgs)
    
    If Not IsPostBack Then
    
        If Trim(Request.QueryString("AdNum")) = "" Then
           Response.Redirect("default.aspx")
        End If
    
        Header.AddPageName("Delete Ad Verification")
        AdNumSent = Trim(Request.QueryString("AdNum"))
        ClassyAd.GetAd(AdNumSent)
        ViewState("AdNumSent") = AdNumSent
    
    End If
    End Sub
    
    Sub Verify_Click(Sender As Object, E As EventArgs)
    
    If VerifyText.Text <> "DELETE" Then
        Message.Text = "You didn't type DELETE. Click Home " & _
           "to cancel."
        Exit Sub
    End If
    
    AdNumSent = ViewState("AdNumSent")
    
    ClassyAd.GetAd(AdNumSent)
    
    ClassyAd.DeleteAd
    
    If ClassyAd.HasErrors Then
        Message.Text = "There was an error placing your ad. " & _
           ClassyAd.RowError
    Else
        Message.Text = "Ad Deleted"
    End If
    Verify.Enabled=False
    VerifyText.Enabled=False
    End Sub

</script>
<html>
<head>
</head>
<body vlink="red">
    <form runat="server">
        <aspfd:header id="Header" runat="server"></aspfd:header>
        <aspfd:classyad id="ClassyAd" runat="server"></aspfd:classyad>
        <p>
            If you are sure you want to delete this record, type the word DELETE in the edit below
            and click the Delete Ad button to confirm.
        </p>
        <table>
            <tbody>
                <tr>
                    <td>
                        Type DELETE:</td>
                    <td>
                        <asp:textbox id="VerifyText" runat="server" columns="15"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:button id="Verify" onclick="Verify_Click" runat="server" text="Delete Ad"></asp:button>
                    </td>
                    <td align="middle">
                        <asp:Label id="Message" runat="server" forecolor="red" backcolor="yellow" font-size="16 pt" font-italic="true" font-bold="true"></asp:Label></td>
                </tr>
            </tbody>
        </table>
        <br />
        <center>
            <asp:hyperlink id="HomeLink" runat="server" font-size="12 pt" font-bold="true" font-name="Arial" navigateurl="default.aspx">
[ Home ]</asp:hyperlink>
        </center>
    </form>
</body>
</html>
