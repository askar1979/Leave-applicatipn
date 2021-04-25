Imports System.Data
Imports System.Data.SqlClient
Partial Public Class InsertNewEmployee
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection
    Dim mycommand As New System.Data.SqlClient.SqlCommand

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub SDSInsertNewEmployee_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SDSInsertNewEmployee.Inserted
        Dim myscript As String
        myscript = "alert('تم اضافة الموظف');"
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
    End Sub

    Private Sub DetailsViewInsertNewEmployee_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles DetailsViewInsertNewEmployee.ItemInserting
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
      
        Dim batchNumber As Integer

        batchNumber = CType(e.Values(1), Integer)
        mycommand.CommandType = CommandType.StoredProcedure
        mycommand.CommandText = "check_Batch_Number"
        mycommand.Parameters.AddWithValue("@BatchNumber", batchNumber)

        Dim Batchout As SqlParameter

        Batchout = New SqlParameter("@Batchout", SqlDbType.Int)
        Batchout.Direction = ParameterDirection.Output
        mycommand.Parameters.Add(Batchout)
        'Try
        myconnection.Open()
        mycommand.ExecuteScalar()

        'if batchnumber entered, is already exist in the database
        If Batchout.Value.Equals(DBNull.Value) <> True Then
            e.Cancel = True
            Response.Redirect("DuplicateBadgeNumber.aspx")
        End If
        'Catch ex As Exception
        '    e.Cancel = True
        '    Response.Write(":حدث خطأ" & ex.ToString())

        '    Response.Redirect("error_Page.aspx")
        'Finally
        '    myconnection.Close()
        'End Try
        myconnection.Close()
    End Sub

End Class