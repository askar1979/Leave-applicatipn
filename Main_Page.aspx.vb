Partial Public Class _Main_Page

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim check As New CheckSession()
        If check.IsSessionExist(Session.Contents("User")) = False Then
            Response.Redirect("error_Page.aspx")
        End If

        lblWelcome.Text = Resources.ResourceAR.Hello & Session.Contents("User").ToString()

    End Sub

    Protected Sub btnExit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnExit.Click
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub
End Class