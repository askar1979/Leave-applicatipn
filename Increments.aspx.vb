Imports System.Data
Imports System.Data.SqlClient

Partial Public Class Increments
    Inherits System.Web.UI.Page
    Dim myconnection As New System.Data.SqlClient.SqlConnection
    Dim mycommand As New System.Data.SqlClient.SqlCommand
    'get last date
    Protected Sub GetLastNormal()
      
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"

        mycommand.Connection = Me.myconnection

        '  Dim lastUpdate As DateTime
        Dim outparam As SqlParameter
        'get last normal update
        myconnection.Open()
        mycommand.Parameters.Clear()
        mycommand.CommandType = CommandType.StoredProcedure
        mycommand.CommandText = "Last_NormalIncrement_Date"
        outparam = New SqlParameter("@LastUpdate", SqlDbType.VarChar, 150)
        outparam.Direction = ParameterDirection.Output
        mycommand.Parameters.Add(outparam)
        mycommand.ExecuteNonQuery()
        ' lastUpdate = CType(outparam.Value, String)
        lblNormalIncrementDate.Text = "  تم اخر تحديث في  " & outparam.Value.ToString()
        myconnection.Close()

    End Sub
    'get last date
    Protected Sub GetLastSick()
        myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        mycommand.Connection = Me.myconnection

        '  Dim lastUpdate As DateTime
        Dim outparam As SqlParameter
        myconnection.Open()
        ' get last sick update
        mycommand.Parameters.Clear()
        mycommand.CommandType = CommandType.StoredProcedure
        mycommand.CommandText = "Last_SickIncrement_Date"
        outparam = New SqlParameter("@LastUpdate", SqlDbType.VarChar, 150)
        outparam.Direction = ParameterDirection.Output
        mycommand.Parameters.Add(outparam)
        mycommand.ExecuteNonQuery()
        ' lastUpdate = CType(outparam.Value, String)
        lblSickIncrementsDate.Text = ("  تم اخر تحديث في  " & outparam.Value.ToString())
        myconnection.Close()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'myconnection.ConnectionString = "Data Source=SEZER-PC;Initial Catalog=Leave_DB;User ID=sa;Password=sezer"
        'mycommand.Connection = Me.myconnection

        'Dim lastUpdate As DateTime
        'Dim outparam As SqlParameter
        ''get last normal update
        'myconnection.Open()
        'mycommand.CommandType = CommandType.StoredProcedure
        'mycommand.CommandText = "Last_NormalIncrement_Date"
        'outparam = New SqlParameter("@LastUpdate", SqlDbType.VarChar, 50)
        'outparam.Direction = ParameterDirection.Output
        'mycommand.Parameters.Add(outparam)
        'mycommand.ExecuteNonQuery()
        'lastUpdate = CType(outparam.Value, String)
        'lblNormalIncrementDate.Text = ("  تم اخر تحديث في  " & lastUpdate)
        '' get last sick update
        'mycommand.Parameters.Clear()
        'mycommand.CommandType = CommandType.StoredProcedure
        'mycommand.CommandText = "Last_SickIncrement_Date"
        'outparam = New SqlParameter("@LastUpdate", SqlDbType.VarChar, 50)
        'outparam.Direction = ParameterDirection.Output
        'mycommand.Parameters.Add(outparam)
        'mycommand.ExecuteNonQuery()
        'lastUpdate = CType(outparam.Value, String)
        'lblSickIncrementsDate.Text = ("  تم اخر تحديث في  " & lastUpdate)
        'myconnection.Close()

        '---------------------------------------------
        'get last update date
        GetLastNormal()
        GetLastSick()

    End Sub

    Protected Sub normalIncrement_Click(ByVal sender As Object, ByVal e As EventArgs) Handles normalIncrement.Click
        SDSIncrementNormalLeaves.Update()
        'SDSIncrementNormalLeaves.DataBind()
        GetLastNormal()
    End Sub

    Protected Sub sickIncrements_Click(ByVal sender As Object, ByVal e As EventArgs) Handles sickIncrements.Click
        SDSIncrementSickLeaves.Update()
        'SDSIncrementSickLeaves.DataBind()
        GetLastSick()
    End Sub
End Class