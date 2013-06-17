<%@ Page Explicit="True" Language="VB" Debug="True" %>
<%@ Register TagPrefix="ASPFD" TagName="Header" Src="header.ascx" %>
<%@ Register TagPrefix="ASPFD" TagName="ClassyAd" Src="classyad.ascx" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    Dim AdNumSent As Integer
    Dim Operation As String
    
    Sub Page_Load(Sender As Object, E As EventArgs)
    
    If Not IsPostBack Then
    
        Header.AddPageName("Confirmation")
    
        If Trim(Request.QueryString("AdNum")) = "" Or _
           Trim(Request.QueryString("Operation")) = "" Then
              Response.Redirect("default.aspx")
        End If
    
        AdNumSent = Trim(Request.QueryString("AdNum"))
        Operation = Trim(Request.QueryString("Operation"))
        ViewState("AdNumSent") = AdNumSent
        ViewState("Operation") = Operation
    
    End If
    
    End Sub
    
    
    Sub EnterPassword_Click(Sender As Object, E As EventArgs)
    
    AdNumSent = ViewState("AdNumSent")
    Operation = ViewState("Operation")
    
    ClassyAd.GetAd(AdNumSent)
    
    'If ClassyAd.Password = PasswordText.Text Then
     If Operation = "EDIT" Then
           Response.Redirect("editad.aspx?AdNum=" & AdNumSent)
     ElseIf Operation = "DEL" Then
          Response.Redirect("delad.aspx?AdNum=" & AdNumSent)
        Else
           Message.Text = "Internal Error - No Valid Operation Sent."
     End If
    
     'Else
        'Message.Text = "Invalid Password - Try Again"
    'End If
    '
    Response.Redirect("editad.aspx?AdNum=" & AdNumSent)
    End Sub

</script>
<html>
<head>
</head>
<body vlink="red">
    <form runat="server">
        <aspfd:header id="Header" runat="server"></aspfd:header>
        <aspfd:classyad id="ClassyAd" runat="server" visible="false"></aspfd:classyad>
        <p>
            Please enter the password you used when you created your ad. 
        </p>
        <table>
            <tbody>
                <tr>
                    <td>
                        Password:</td>
                    <td>
                        <asp:textbox id="PasswordText" runat="server" textmode="password" columns="50"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:button id="EnterPassword" onclick="EnterPassword_Click" runat="server" text="Enter Password"></asp:button>
                    </td>
                </tr>
            </tbody>
        </table>
        <br />
        <asp:Label id="Message" runat="server"></asp:Label>
        <br />
        <center>
            <asp:hyperlink id="HomeLink" runat="server" navigateurl="default.aspx" font-bold="true" font-name="Arial" font-size="12 pt">
[ Home ]</asp:hyperlink>
        </center>
    </form>
</body>
</html>
