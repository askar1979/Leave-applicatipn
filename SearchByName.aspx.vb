Imports System.Data
Imports System.Data.SqlClient
Partial Public Class SearchByName
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection
    Dim mycommand As New System.Data.SqlClient.SqlCommand
    Protected Sub getBatchByName()
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection

        Dim BatchNumber As Integer
        Dim Name As String
        Name = Nothing
        BatchNumber = 0
        myconnection.Open()
        mycommand.CommandType = CommandType.StoredProcedure
        mycommand.CommandText = "usp_Get_BadgeNumber_BY_Name"
        mycommand.Parameters.AddWithValue("@Name", textboxName.Text)
        Dim Badge As SqlParameter
        Badge = New SqlParameter("@BatchNumber", SqlDbType.Int)
        Badge.Direction = ParameterDirection.Output
        mycommand.Parameters.Add(Badge)
        mycommand.ExecuteScalar()
        If Badge.Value.Equals(DBNull.Value) Then
            BatchNumber = 0
        Else
            BatchNumber = CType(Badge.Value, Integer)
        End If
        If BatchNumber = 0 Then

            Response.Redirect("EmployeeNotExist.aspx")
        Else
            Session.Contents("BatchNumber") = BatchNumber

        End If
        myconnection.Close()
    End Sub
    Protected Sub DDLActionSelect()
        DDLAction.Enabled = True
        DDLAction.DataBind()
        If DDLAction.SelectedValue.Equals("1") Then
            Response.Redirect("Normal.aspx")
        End If
        If DDLAction.SelectedValue.Equals("2") Then
            Response.Redirect("PartTime.aspx")
        End If
        If DDLAction.SelectedValue.Equals("3") Then
            Response.Redirect("Sick.aspx")
        End If
        If DDLAction.SelectedValue.Equals("4") Then
            Response.Redirect("SickHalfSalary.aspx")
        End If
        If DDLAction.SelectedValue.Equals("5") Then
            Response.Redirect("Reports.aspx")
        End If

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub SearchName_Click(ByVal sender As Object, ByVal e As EventArgs) Handles SearchName.Click
        'myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        'mycommand.Connection = Me.myconnection
        'Dim BatchNumber As Integer
        'Dim Name As String
        'Name = Nothing
        'BatchNumber = 0

        'Try
        '    myconnection.Open()
        '    mycommand.CommandType = CommandType.StoredProcedure
        '    mycommand.CommandText = "usp_Get_BadgeNumber_BY_Name"
        '    mycommand.Parameters.AddWithValue("@Name", textboxName.Text)
        '    Dim Badge As SqlParameter
        '    Badge = New SqlParameter("@BatchNumber", SqlDbType.Int)
        '    Badge.Direction = ParameterDirection.Output
        '    mycommand.Parameters.Add(Badge)
        '    mycommand.ExecuteScalar()

        '    If Badge.Value.Equals(DBNull.Value) Then
        '        BatchNumber = 0
        '    Else
        '        BatchNumber = CType(Badge.Value, Integer)
        '    End If
        '    If BatchNumber = 0 Then

        '        Response.Redirect("EmployeeNotExist.aspx")
        '    Else
        '        Session.Contents("BatchNumber") = BatchNumber

        '    End If
        'Catch ex As System.Data.SqlClient.SqlException

        '    Response.Redirect("error_Page.aspx")
        'Finally

        '    myconnection.Close()

        'End Try
        'myconnection.Close()
        ''  -----------------------------------------------------------
        'DDLAction.Enabled = True
        'DDLAction.DataBind()
        'If DDLAction.SelectedValue.Equals("1") Then
        '    Response.Redirect("Normal.aspx")
        'End If
        'If DDLAction.SelectedValue.Equals("2") Then
        '    Response.Redirect("PartTime.aspx")
        'End If
        'If DDLAction.SelectedValue.Equals("3") Then
        '    Response.Redirect("Sick.aspx")
        'End If
        'If DDLAction.SelectedValue.Equals("4") Then
        '    Response.Redirect("SickHalfSalary.aspx")
        'End If
        'If DDLAction.SelectedValue.Equals("5") Then
        '    Response.Redirect("Reports.aspx")
        'End If

        Try
            getBatchByName()
            DDLActionSelect()
        Catch ex As System.Data.SqlClient.SqlException

        End Try

    End Sub

    
End Class