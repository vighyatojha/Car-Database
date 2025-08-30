Imports System.Data.SqlClient
Imports System.Data

Partial Class Login
    Inherits System.Web.UI.Page

    ' ✅ Keep your original connection string
    Dim cn As New SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=D:\ASP Practical\Shoes_User.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True")

    Protected Sub LoginControl_Authenticate(ByVal sender As Object, ByVal e As AuthenticateEventArgs) Handles LoginControl.Authenticate
        Dim username As String = LoginControl.UserName.Trim()
        Dim password As String = LoginControl.Password

        Try
            ' ✅ Use your cn object
            Dim cmd As New SqlCommand("SELECT COUNT(*) FROM Users WHERE (Username=@user OR Email=@user) AND Password=@pass", cn)
            cmd.Parameters.AddWithValue("@user", username)
            cmd.Parameters.AddWithValue("@pass", password) ' ⚠️ In real projects, store hashed passwords

            cn.Open()
            Dim count As Integer = Convert.ToInt32(cmd.ExecuteScalar())
            cn.Close()

            If count > 0 Then
                e.Authenticated = True
                Response.Redirect("Shoes.aspx")
            Else
                e.Authenticated = False
            End If

        Catch ex As Exception
            ' In case of error, make sure connection is closed
            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If
            e.Authenticated = False
            ' Optional: Show error message
            ' Response.Write("Error: " & ex.Message)
        End Try

    End Sub
End Class
