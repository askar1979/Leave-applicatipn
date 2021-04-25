Public Class CheckSession

    Public Function IsSessionExist(ByVal user As String) As Boolean

        If String.IsNullOrEmpty(user) Then
            Return False
        End If

        Return True

    End Function



End Class
