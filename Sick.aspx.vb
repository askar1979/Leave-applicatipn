Imports System.Data
Imports System.Data.SqlClient
Partial Public Class Sick
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection
    Dim mycommand As New System.Data.SqlClient.SqlCommand
    Dim sqltrans As System.Data.SqlClient.SqlTransaction
    Protected Function checkInitialvalue() As Boolean
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        mycommand.Connection = Me.myconnection
        ' Dim count As SqlParameter
        Try
            myconnection.Open()
            sqltrans = myconnection.BeginTransaction()
            mycommand.Parameters.Clear()
            mycommand.CommandType = CommandType.StoredProcedure
            mycommand.CommandText = "usp_Check_InitialValue"
            mycommand.Parameters.AddWithValue("@BatchNumber", TextBoxBatch.Text)
            mycommand.Transaction = sqltrans

            Dim outParam As SqlParameter

            outParam = New SqlParameter("@count", SqlDbType.TinyInt)
            outParam.Direction = ParameterDirection.Output
            mycommand.Parameters.Add(outParam)
            mycommand.ExecuteScalar()
            'count = CType(outParam.Value, Integer)
            myconnection.Close()
            If outParam.Value.Equals(DBNull.Value) Then
                Return False
            Else
                Return True
            End If
        Catch ex As System.Data.SqlClient.SqlException
            Response.Redirect("error_Page.aspx")
        End Try


    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' TextBoxBatch.Focus()
        If Not Page.IsPostBack Then

            myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
            mycommand.Connection = Me.myconnection
            'if the session has a value from search by name page then do the code
            If Not Session.Contents("BatchNumber") Is Nothing Then
                'get value from session
                TextBoxBatch.Text = Session.Contents("BatchNumber")
                Session.Contents("BatchNumber") = Nothing
                'hide search panel if it is search by name
                Panel1.Visible = False

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
                        DetailsViewInsert.Visible = False
                        GVPanel.Visible = False
                        Response.Redirect("EmployeeNotExist.aspx")

                    Else

                        DetailsViewInsert.Visible = True
                        GVPanel.Visible = True
                    End If

                Catch ex As System.Data.SqlClient.SqlException
                    Response.Redirect("error_Page.aspx")
                End Try
            End If
        End If
    End Sub


    Private Sub DetailsViewInsert_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles DetailsViewInsert.ItemInserting


        'if employee has no initial value
        If checkInitialvalue() = False Then
            e.Cancel = True
            Dim myscript As String
            myscript = "alert('الموظف ليس لديه قيم ابتدائية');"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
        End If


        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        Dim Duration As Integer

        Try
            myconnection.Open()
            sqltrans = myconnection.BeginTransaction()
            Try

                mycommand.Transaction = sqltrans
                Duration = CType(e.Values(1), Integer)
                mycommand.CommandType = CommandType.StoredProcedure
                mycommand.CommandText = "[sick_full_Salary_Decrement]"
                mycommand.Parameters.Clear()
                mycommand.Parameters.AddWithValue("@BatchNumber", TextBoxBatch.Text)
                mycommand.Parameters.AddWithValue("@Duration", Duration)
                mycommand.ExecuteNonQuery()

                sqltrans.Commit()
            Catch ex As System.Data.SqlClient.SqlException
                sqltrans.Rollback()
                e.Cancel = True
                Response.Redirect("error_Page.aspx")

            End Try
        Catch ex As Exception
            e.Cancel = True
            Response.Redirect("error.Page.aspx")
        Finally

            myconnection.Close()

        End Try

        DetailsViewBalance.DataBind()

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        'check if employee exist or not first
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
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
                DetailsViewInsert.Visible = False
                GVPanel.Visible = False
                Response.Redirect("EmployeeNotExist.aspx")

            Else

                DetailsViewInsert.Visible = True
                GVPanel.Visible = True
            End If
        Catch ex As System.Data.SqlClient.SqlException
            Response.Redirect("error_Page.aspx")
        End Try
        Panel1.Visible = False
    End Sub

    Private Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        'في حالة الغاء الاجازة
        Dim Duration, EmployeeID, ActualLeaves, RemainingLeaves As Integer


        Duration = 0
        ActualLeaves = 0
        RemainingLeaves = 0
        Try
            myconnection.Open()
            sqltrans = myconnection.BeginTransaction()

            'select EmployeeID according to BadgeNumber
            mycommand.CommandText = "select ID from Employee where BatchNumber =" & TextBoxBatch.Text
            mycommand.CommandType = CommandType.Text
            mycommand.Transaction = sqltrans
            EmployeeID = CType(mycommand.ExecuteScalar(), Integer)

            mycommand.CommandText = "select ActualLeaves from LeaveBalance where LeaveTypeID=3 and EmployeeID=" & EmployeeID
            mycommand.CommandType = CommandType.Text
            ActualLeaves = CType(mycommand.ExecuteScalar(), Integer)

            mycommand.CommandText = "select RemainingLeaves from LeaveBalance where LeaveTypeID=3 and EmployeeID=" & EmployeeID
            mycommand.CommandType = CommandType.Text
            RemainingLeaves = CType(mycommand.ExecuteScalar(), Integer)


            'read values from controls and assign them to variables
            Duration = CType(e.Values(0), Integer)

            'assign new values
            ActualLeaves = ActualLeaves - Duration
            RemainingLeaves = RemainingLeaves + Duration


            'update LeaveBalance
            mycommand.CommandText = "update LeaveBalance set ActualLeaves=" & ActualLeaves & " where LeaveTypeID=3 and EmployeeID=" & EmployeeID
            mycommand.CommandType = CommandType.Text
            mycommand.ExecuteNonQuery()

            mycommand.CommandText = "update LeaveBalance set RemainingLeaves=" & RemainingLeaves & " where LeaveTypeID=3 and EmployeeID=" & EmployeeID
            mycommand.CommandType = CommandType.Text
            mycommand.ExecuteNonQuery()


            sqltrans.Commit()
        Catch ex As System.Data.SqlClient.SqlException
            sqltrans.Rollback()
            Response.Redirect("error_Page.aspx")
        Finally
            myconnection.Close()
        End Try
        DetailsViewBalance.DataBind()
    End Sub

    
End Class