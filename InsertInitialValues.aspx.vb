Imports System.Data
Imports System.Data.SqlClient
Partial Public Class InsertInitialValues
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection
    Dim mycommand As New System.Data.SqlClient.SqlCommand
    Dim sqltrans As System.Data.SqlClient.SqlTransaction


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        DtlViewEmployeeInfo.DataBind()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        DtlViewEmployeeInfo.Visible = True

        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        'check if employee exist or not
        Dim count As Integer
        Dim outparam As SqlParameter
        Try
            myconnection.Open()
            'send BatchNumber to stored procedure
            mycommand.Parameters.Clear()
            mycommand.CommandType = CommandType.StoredProcedure
            mycommand.CommandText = "IS_Employee_Exist"
            mycommand.Parameters.AddWithValue("@BatchNumber", TextBoxBatch.Text)
            'recieve count value from stored procedure
            outparam = New SqlParameter("@count", SqlDbType.Int)
            outparam.Direction = ParameterDirection.Output
            mycommand.Parameters.Add(outparam)
            mycommand.ExecuteNonQuery()
            myconnection.Close()
            count = CType(outparam.Value, Integer)
            'if employee is not exist
            If count = 0 Then
                DetailsViewInsertInitialValues.Enabled = False
                Response.Redirect("EmployeeNotExist.aspx")
            End If
        Catch ex As Exception
            Response.Redirect("error_Page.aspx")
        End Try

    End Sub
    Protected Sub Checked_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Checked.Click

        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        Dim EmployeeID As Integer
        Try
            myconnection.Open()
            'get EmployeeID according to BatchNumber
            mycommand.CommandText = "select EmployeeID=e.ID from Employee as e inner join LeaveBalance as L on L.EmployeeID=e.ID where e.BatchNumber =" & TextBoxBatch.Text
            mycommand.CommandType = CommandType.Text
            EmployeeID = CType(mycommand.ExecuteScalar(), Integer)

            If CheckBox1.Checked Then
                lblCheck.BackColor = Drawing.Color.AliceBlue
                'update WithoutSalary
                mycommand.CommandText = "update LeaveBalance set WithoutSalary=1 where EmployeeID=" & EmployeeID
                mycommand.CommandType = CommandType.Text
                mycommand.ExecuteNonQuery()
            End If
            If Not CheckBox1.Checked Then
                lblCheck.BackColor = Drawing.Color.White
                'update WithoutSalary
                mycommand.CommandText = "update LeaveBalance set WithoutSalary=0 where EmployeeID=" & EmployeeID
                mycommand.CommandType = CommandType.Text
                mycommand.ExecuteNonQuery()
            End If

        Catch ex As Exception
            Response.Redirect("error_Page.aspx")
        Finally
            myconnection.Close()
        End Try
    End Sub

    Private Sub DetailsViewInsertInitialValues_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertedEventArgs) Handles DetailsViewInsertInitialValues.ItemInserted
        'في حالة تم ادخال قيمة ابتدائية للموظف مسبقأ
        If e.Exception Is Nothing = False Then
            e.ExceptionHandled = True
            Response.Redirect("DuplicateInitialValue.aspx")
        End If
        'اذا الموظف ماعندة قيمة ابتدائية
        If Not e.ExceptionHandled Then
            Dim myscript As String
            myscript = "alert('تم اضافة القيمة الابتدائية');"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
        End If
    End Sub

    Private Sub DetailsViewInsertInitialValues_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles DetailsViewInsertInitialValues.ItemInserting
        'في حالة تم ادخال قيمة ابتدائية للموظف مسبقأ
        'If e.Exception Is Nothing = False Then
        '    e.ExceptionHandled = True
        '    Response.Redirect("DuplicateInitialValue.aspx")
        'End If
     
    End Sub
End Class