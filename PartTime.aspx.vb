Imports System.Data
Imports System.Data.SqlClient
Partial Public Class PartTime
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection
    Dim mycommand As New System.Data.SqlClient.SqlCommand
    Dim mycom2 As New System.Data.SqlClient.SqlCommand
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

    Protected Sub DetailsViewInsert_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles DetailsViewInsert.ItemInserting

        'if employee has no initial value
        If checkInitialvalue() = False Then
            e.Cancel = True
            Dim myscript As String
            myscript = "alert('الموظف ليس لديه قيم ابتدائية');"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
        End If


        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        mycom2.Connection = Me.myconnection

        Dim counter, Duration, EmployeeID As Integer
        Try
            myconnection.Open()

            sqltrans = myconnection.BeginTransaction()
            Try
                '========================================================
                'get Duration from DetailsViewInsert detailsView
                Duration = CType(e.Values(1), Integer)
                '=======================================================
                'use store procedure to get column value(PTLCounter) from LeaveBalance 
                mycom2.CommandType = CommandType.StoredProcedure
                mycom2.CommandText = "usp_GetPTLCounter"
                mycom2.Parameters.AddWithValue("@BatchNumber", TextBoxBatch.Text)
                mycom2.Transaction = sqltrans
                '  mycom2.Parameters.AddWithValue("@LeaveType", 2)
                Dim outParam As SqlParameter
                ' Dim counter As Integer
                outParam = New SqlParameter("@PTLCounter", SqlDbType.TinyInt)
                outParam.Direction = ParameterDirection.Output
                mycom2.Parameters.Add(outParam)
                mycom2.ExecuteScalar()
                counter = CType(outParam.Value, Integer)
                '==================================================================
                'unneeded steps for sp input parameter
                ' Dim BatchNumber As SqlParameter
                ' BatchNumber = New SqlParameter("@BatchNumber", SqlDbType.Int)
                ' BatchNumber.Direction = ParameterDirection.Input
                ' mycom2.Parameters.Add(BatchNumber)
                '==================================================================
                'get EmployeeID according to BatchNumber
                mycommand.Transaction = sqltrans
                mycommand.CommandText = "select EmployeeID=e.ID from Employee as e inner join LeaveBalance as L on L.EmployeeID=e.ID where LeaveTypeID=2 and e.BatchNumber =" & TextBoxBatch.Text
                mycommand.CommandType = CommandType.Text
                EmployeeID = CType(mycommand.ExecuteScalar(), Integer)
                '===========================================================
                counter = counter + Duration
                If counter >= 7 Then
                    counter = counter - 7

                    'update PTLCounter as counter
                    mycommand.CommandText = "update LeaveBalance set PTLCounter=" & counter & " where LeaveTypeID=2 and EmployeeID=" & EmployeeID
                    mycommand.CommandType = CommandType.Text
                    mycommand.ExecuteNonQuery()

                    'decrement normal leave by one using sp
                    mycom2.CommandType = CommandType.StoredProcedure
                    mycom2.CommandText = "decrementOneFromNormal"
                    mycom2.Parameters.Clear()
                    mycom2.Parameters.AddWithValue("@BatchNumber", TextBoxBatch.Text)
                    mycom2.ExecuteNonQuery()
                Else

                    mycommand.CommandText = "update LeaveBalance set PTLCounter=" & counter & " where LeaveTypeID=2 and EmployeeID=" & EmployeeID
                    mycommand.CommandType = CommandType.Text
                    mycommand.ExecuteNonQuery()


                End If
                ' myconnection.Close()
                ' finally will work any how

                sqltrans.Commit()
            Catch ex As System.Data.SqlClient.SqlException
                sqltrans.Rollback()
                e.Cancel = True
                Response.Redirect("error_Page.aspx")
                'Response.Write(":حدث خطأ" & ex.ToString())

            End Try
        Catch ex As Exception
            e.Cancel = True
            Response.Redirect("error_Page.aspx")

        Finally

            myconnection.Close()


        End Try

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Try
            'check if employee exist or not first
            myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
            mycommand.Connection = Me.myconnection
            Dim count As Integer
            Dim outparam As SqlParameter
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
End Class