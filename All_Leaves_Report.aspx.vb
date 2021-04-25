Imports System.Data
Imports System.Data.SqlClient
Partial Public Class All_Leaves_Report
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection()
    Dim mycommand As New System.Data.SqlClient.SqlCommand()
    Protected Function IsEmployeeExist() As Boolean
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection

        'check if employee exist or not first
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
                ' PanelBetween.Visible = False
                DtlViewEmployeeInfo.Visible = False
                Response.Redirect("EmployeeNotExist.aspx")

                Return False

            Else
                ' PanelBetween.Visible = True
                DtlViewEmployeeInfo.Visible = True
                GridView1.Visible = False
                GVPanel.Visible = False
                Return True
            End If

        Catch ex As System.Data.SqlClient.SqlException
            Response.Redirect("error_Page.aspx")

        End Try

    End Function
    Protected Sub ShowReport()
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection

        Dim dt As DataTable = New DataTable()

        mycommand.CommandType = CommandType.StoredProcedure
        mycommand.CommandText = "usp_All_Leaves_Per_Employee"
        mycommand.Parameters.Clear()
        mycommand.Parameters.AddWithValue("@BatchNumber", TextBoxBatch.Text)
       

        Try
            myconnection.Open()

            Dim ad As SqlDataAdapter = New SqlDataAdapter(mycommand)

            ad.Fill(dt)

            If dt.Rows.Count.Equals(0) Then
                Dim myscript As String
                myscript = "alert('لاتوجد اجازات');"
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
            Else
                GVPanel.Visible = True
                GridView1.Visible = True
                GridView1.DataSource = dt
                GridView1.DataBind()
            End If

        Catch ex As System.Data.SqlClient.SqlException
            Response.Redirect("error_Page.aspx")
        Finally
            myconnection.Close()
        End Try


    End Sub
    Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnExcel.Click

        'clear the response
        Response.Clear()
        'set the type and file name
        Response.AddHeader("content-disposition", "attachment;filename=testsezer.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        'add the HTML from Gridview to a string writer so we can write it later
        Dim sw As System.IO.StringWriter = New System.IO.StringWriter
        Dim hw As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(sw)
        GridView1.RenderControl(hw)
        'write out the data
        Response.Write(sw.ToString)
        Response.End()
        
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As System.Web.UI.Control)
        ' MyBase.VerifyRenderingInServerForm(control)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            btnShowreport.Enabled = False
            btnExcel.Enabled = False
            myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
            mycommand.Connection = Me.myconnection

            'if the session has a value from search by name page then do the code
            If Not Session.Contents("BatchNumber") Is Nothing Then
                'get value from session
                TextBoxBatch.Text = Session.Contents("BatchNumber")
                Session.Contents("BatchNumber") = Nothing

            End If
        End If


    End Sub   
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click

        IsEmployeeExist()

        GridView1.Visible = False
        GVPanel.Visible = False

        If Page.IsPostBack Then
            btnShowreport.Enabled = True
        End If


    End Sub

    Protected Sub btnShowreport_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnShowreport.Click
        ShowReport()
        btnExcel.Enabled = True
    End Sub
    Protected Sub TextBoxBatch_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles TextBoxBatch.TextChanged
        btnExcel.Enabled = False
        btnShowreport.Enabled = False
        'if employee is not exist then 
        If Not IsEmployeeExist() Then Response.Redirect("EmployeeNotExist.aspx")
    End Sub
End Class
