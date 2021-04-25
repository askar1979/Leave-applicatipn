Imports System.Data
Imports System.Data.SqlClient
Partial Public Class Login
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection()
    Dim mycommand As New System.Data.SqlClient.SqlCommand()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim Menu As Menu = Master.FindControl("navigate")
        If Menu IsNot Nothing Then
            Menu.Enabled = False
        End If

    End Sub

    Protected Sub Submit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Submit.Click

        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        myconnection.Open()
        Dim dt As DataTable = New DataTable()

        'mycommand.Parameters.Clear()
        mycommand.CommandType = CommandType.Text
        mycommand.CommandText = "Select UserName,Password from Users where UserName=N'" & txtUserName.Text.Trim() & "' and Password=N'" & txtPassword.Text.Trim() & "'"


        Dim ad As SqlDataAdapter = New SqlDataAdapter(mycommand)

        ad.Fill(dt)

        If dt.Rows.Count.Equals(0) Then
            Dim myscript As String
            myscript = "alert('ادخل اسم المستخدم و كلمة المرور');"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
            txtUserName.Text = ""
            txtPassword.Text = ""
        Else

            Session.Contents("User") = dt.Rows(0).Item(0)
            Response.Redirect("Main_Page.aspx")

        End If

    End Sub
End Class