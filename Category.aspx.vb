Public Class Category
    Inherits System.Web.UI.Page
    Protected WithEvents AdsGrid As System.Web.UI.WebControls.DataGrid
    Protected WithEvents HomeLink As System.Web.UI.WebControls.HyperLink

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not IsPostBack Then
            Dim Connect As MsmDataProvider.MsmConnection = New MsmDataProvider.MsmConnection()
            Dim Adaptor As MsmDataProvider.MsmDataAdapter
            Dim ds As DataSet = New DataSet()
            Dim MCode As String
            Dim Category As String

            Category = Trim(Request.QueryString("Category"))

            If Category <> "" Then
                MCode = "D CAT^ASP(""" & Category & """)"
            Else
                MCode = "D ADS^ASP"
            End If

            Connect.ConnectionString = "Server=127.0.0.1;Port=1972;Uci=PAU;Volume="
            Connect.Open()
            Adaptor = New MsmDataProvider.MsmDataAdapter(MCode, Connect)
            Adaptor.Fill(ds)

            AdsGrid.DataSource = ds
            Page.DataBind()

            Connect.Close()
            Adaptor.Dispose()
        End If
    End Sub

End Class
