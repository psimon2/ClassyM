<%@ Page Explicit="True" Language="VB" Debug="True" %>
<%@ Register TagPrefix="ASPFD" TagName="Header" Src="header.ascx" %>
<%@ Register TagPrefix="ASPFD" TagName="ClassyAd" Src="classyad.ascx" %>
<script runat="server">

    Sub Page_Load(Sender As Object, E As EventArgs)
    If Not IsPostBack Then
        Dim AdNumSent As Integer
    
        If Trim(Request.QueryString("AdNum")) = "" Then
           Response.Redirect("default.aspx")
        End If
    
        Header.AddPageName("Ad Detail")
    
        AdNumSent = Trim(Request.QueryString("AdNum"))
        ClassyAd.GetAd(AdNumSent)
    
        EditLink.NavigateURL = "confirm.aspx?AdNum=" & AdNumSent & "&Operation=EDIT"
        DelLink.NavigateURL = "confirm.aspx?AdNum=" & AdNumSent & "&Operation=DEL"
    
    End If
    
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
            <i>To respond to this ad, just click on the email address above and send a message.</i> 
        </p>
        If you created this ad, you can...<br />
        <asp:hyperlink id="EditLink" runat="server">
Edit it</asp:hyperlink>
        or<br />
        <asp:hyperlink id="DelLink" runat="server">
Delete it</asp:hyperlink>
    </form>
</body>
</html>
