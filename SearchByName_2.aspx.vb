Imports System.Data
Imports System.Data.SqlClient
Partial Public Class SearchByName_2
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection
    Dim mycommand As New System.Data.SqlClient.SqlCommand
    Dim sqltrans As System.Data.SqlClient.SqlTransaction
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
    Protected Sub checkInitialvalue()
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection
        mycommand.Connection = Me.myconnection
        Dim count As Integer
        Try
            myconnection.Open()
            sqltrans = myconnection.BeginTransaction()
            mycommand.Parameters.Clear()
            mycommand.CommandType = CommandType.StoredProcedure
            mycommand.CommandText = "usp_Check_InitialValue"
            mycommand.Parameters.AddWithValue("@BatchNumber", Session.Contents("send"))
            mycommand.Transaction = sqltrans
            Session.Contents("send") = Nothing
            Dim outParam As SqlParameter

            outParam = New SqlParameter("@count", SqlDbType.TinyInt)
            outParam.Direction = ParameterDirection.Output
            mycommand.Parameters.Add(outParam)
            mycommand.ExecuteScalar()
            myconnection.Close()
            count = CType(outParam.Value, Integer)
            'if employee doesnt have normal,sick,halfsick initial values
            If count <> 3 Then
                Response.Redirect("No_Initial_Value.aspx")
            End If

        Catch ex As System.Data.SqlClient.SqlException
            Response.Redirect("error_Page.aspx")
        End Try
     

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
        If DDLAction.SelectedValue.Equals("6") Then
            Response.Redirect("All_Leaves_Report.aspx")
        End If

    End Sub
    Protected Sub getSimilarNames()
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection

        Dim dt As DataTable = New DataTable()

        mycommand.CommandType = CommandType.StoredProcedure
        mycommand.CommandText = "find_Name_Like"
        mycommand.Parameters.Clear()
        mycommand.Parameters.AddWithValue("@name", textboxName.Text)
    
        Try
            myconnection.Open()

            Dim ad As SqlDataAdapter = New SqlDataAdapter(mycommand)

            ad.Fill(dt)

            If dt.Rows.Count.Equals(0) Then
                Dim myscript As String
                myscript = "alert('لم يتم العثور على الموظف');"
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
            Else
                PanelGV_Name.Visible = True
                GVEmpName.Visible = True
                GVEmpName.DataSource = dt
                GVEmpName.DataBind()
            End If

        Catch ex As System.Data.SqlClient.SqlException
            Response.Redirect("error_Page.aspx")
        Finally
            myconnection.Close()
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            passValue.Enabled = False
        End If

    End Sub
    Protected Sub SearchName_Click(ByVal sender As Object, ByVal e As EventArgs) Handles SearchName.Click
        getSimilarNames()
       
    End Sub

    Protected Sub GVEmpName_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GVEmpName.RowCommand

        If e.CommandName = "Select" Then

            Dim badge As Integer
            badge = Convert.ToInt32(GVEmpName.Rows(Convert.ToInt32(e.CommandArgument)).Cells(0).Text)
            Session.Contents("BatchNumber") = badge
            Session.Contents("send") = badge
            passValue.Enabled = True
        End If
    End Sub

    Protected Sub passValue_Click(ByVal sender As Object, ByVal e As EventArgs) Handles passValue.Click
        checkInitialvalue()
        DDLActionSelect()
    End Sub
    Protected Sub textboxName_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles textboxName.TextChanged

        PanelGV_Name.Visible = False
        GVEmpName.Visible = False

    End Sub
End Class