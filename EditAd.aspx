<%@ Page Explicit="True" Language="VB" Debug="True" %>
<%@ Register TagPrefix="ASPFD" TagName="Header" Src="header.ascx" %>
<%@ Register TagPrefix="ASPFD" TagName="ClassyAd" Src="classyad.ascx" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    Dim AdNumSent As Integer
    Dim Operation As String
    Dim CatListIndex As Integer
    
    Sub Page_Load(Sender As Object, E As EventArgs)
    
    If Not IsPostBack Then
    
        If Trim(Request.QueryString("AdNum")) = "" Then
           Operation = "PLACE"
           Header.AddPageName("Place Ad")
           Submit.Text = "Place Ad"
    
           AdNumSent = 0
        Else
           Operation = "EDIT"
           Header.AddPageName("Edit Ad")
           Submit.Text = "Make Changes"
    
           ' If you make a control invisible
           ' you MUST also make the validation
           ' control(s) that refer to it
           ' invisible, too (not just disabled)
           PasswordRequired.Visible = False
           PasswordText.Visible = False
           PasswordLabel.Visible = False
    
           AdNumSent = Request.QueryString("AdNum")
    
           ClassyAd.GetAd(AdNumSent)
    
           TitleText.Text = ClassyAd.Title
           DescriptionText.Text = ClassyAd.Description
           For CatListIndex=0 To CategoryDropDown.Items.Count -1
              If CategoryDropDown.Items(CatListIndex).Value = ClassyAd.Category Then
                 CategoryDropDown.Items(CatListIndex).Selected = True
              End If
           Next
           PriceText.Text = ClassyAd.Price
           PhoneText.Text = ClassyAd.Phone
           EmailText.Text = ClassyAd.Email
           StateText.Text = ClassyAd.State
    
        End If
    
        ViewState("Operation")=Operation
        ViewState("AdNumSent")=AdNumSent
    End If
    
    End Sub
    
    
    Sub Submit_Click(Sender As Object, E As EventArgs)
    
    Operation=ViewState("Operation")
    AdNumSent = ViewState("AdNumSent")
    
    ClassyAd.GetAd(AdNumSent)
    
    ClassyAd.Title = TitleText.Text
    ClassyAd.Description = DescriptionText.Text
    ClassyAd.Category = CategoryDropDown.SelectedItem.Value
    ClassyAd.Price = PriceText.Text
    ClassyAd.Phone = PhoneText.Text
    ClassyAd.Email = EmailText.Text
    ClassyAd.State = StateText.Text
    
    If Operation="PLACE" Then
        ClassyAd.Password = PasswordText.Text
        ClassyAd.Posted = Today
        ClassyAd.PlaceAd
    Else
        ClassyAd.EditAd
    End If
    
    If ClassyAd.HasErrors Then
        Message.Text = "There was a database error: " & _
           ClassyAd.RowError
    Else
        If Operation="PLACE"
           Message.Text = "Your classified ad has been placed"
        Else
           Message.Text = "Your classified ad changes have been made"
        End If
        TitleText.Enabled=False
        DescriptionText.Enabled=False
        CategoryDropDown.Enabled=False
        PriceText.Enabled=False
        PhoneText.Enabled=False
        EmailText.Enabled=False
        StateText.Enabled=False
        PasswordText.Enabled=False
        Submit.Enabled=False
    End If
    End Sub

</script>
<html>
<head>
</head>
<body vlink="red">
    <form runat="server">
        <aspfd:header id="Header" runat="server"></aspfd:header>
        <aspfd:classyad id="ClassyAd" runat="server" visible="false"></aspfd:classyad>
        <% If Operation="PLACE" Then %> 
        <p>
            Please fill in <i>all</i> of these textboxes below. Be careful when entering a Password
            and be sure to remember what you type. You may be required to enter the password later
            to identify yourself if you need to edit or delete this ad. 
        </p>
        <p>
            When you are finished, click the Place Ad button. 
        </p>
        <% Else %> 
        <p>
            Edit any of the information you like. Make sure each textbox has a valid value before
            you click the Make Changes button. 
        </p>
        <% End If %> 
        <table>
            <tbody>
                <tr>
                    <td>
                        Title:</td>
                    <td>
                        <asp:requiredfieldvalidator id="TitleRequired" runat="server" controltovalidate="TitleText" errormessage="*"></asp:requiredfieldvalidator>
                        <asp:textbox id="TitleText" runat="server" columns="50"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        Description:</td>
                    <td>
                        <asp:requiredfieldvalidator id="DescriptionRequired" runat="server" controltovalidate="DescriptionText" errormessage="*"></asp:requiredfieldvalidator>
                        <asp:textbox id="DescriptionText" runat="server" columns="40" textmode="multiline" rows="3"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Category:</td>
                    <td>
                        <asp:requiredfieldvalidator id="CategoryRequired" runat="server" controltovalidate="CategoryDropDown" errormessage="*" initialvalue="* Pick a Category *"></asp:requiredfieldvalidator>
                        <asp:dropdownlist id="CategoryDropDown" runat="server">
                            <asp:listitem >* Pick a Category *</asp:listitem>
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
                        Price:</td>
                    <td>
                        <asp:requiredfieldvalidator id="PriceRequired" runat="server" controltovalidate="PriceText" errormessage="*"></asp:requiredfieldvalidator>
                        $ 
                        <asp:textbox id="PriceText" runat="server" columns="10"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone</td>
                    <td>
                        <asp:requiredfieldvalidator id="PhoneRequired" runat="server" controltovalidate="PhoneText" errormessage="*"></asp:requiredfieldvalidator>
                        <asp:textbox id="PhoneText" runat="server" columns="15"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Email:</td>
                    <td>
                        <asp:requiredfieldvalidator id="EmailRequired" runat="server" controltovalidate="EmailText" errormessage="*"></asp:requiredfieldvalidator>
                        <asp:textbox id="EmailText" runat="server" columns="50"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        State:</td>
                    <td>
                        <asp:requiredfieldvalidator id="StateRequired" runat="server" controltovalidate="StateText" errormessage="*"></asp:requiredfieldvalidator>
                        <asp:textbox id="StateText" runat="server" columns="2"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label id="PasswordLabel" runat="server" text="Password:"></asp:Label></td>
                    <td>
                        <asp:requiredfieldvalidator id="PasswordRequired" runat="server" controltovalidate="PasswordText" errormessage="*"></asp:requiredfieldvalidator>
                        <asp:textbox id="PasswordText" runat="server" columns="15" textmode="password"></asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:button id="Submit" onclick="Submit_Click" runat="server"></asp:button>
                    </td>
                    <td align="middle">
                        <asp:Label id="Message" runat="server" font-bold="true" font-italic="true" font-size="16 pt" backcolor="yellow" forecolor="red"></asp:Label></td>
                </tr>
            </tbody>
        </table>
        <br />
        <center>
            <asp:hyperlink id="HomeLink" runat="server" font-bold="true" font-size="12 pt" navigateurl="default.aspx" font-name="Arial">
[ Home ]</asp:hyperlink>
        </center>
    </form>
</body>
</html>
