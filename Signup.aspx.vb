Imports System.Data
Imports System.Data.SqlClient

Partial Class Signup
    Inherits System.Web.UI.Page

    ' Database connection string
    Dim cn As New SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=D:\ASP Practical\Shoes_User.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True")

    Protected Sub btnSignup_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSignup.Click
        Try
            cn.Open()

            ' ✅ Added CreatedDate
            Dim query As String = "INSERT INTO Users (Username, Password, Email, FullName, Address, Phone, CreatedDate) " &
                                  "VALUES (@Username, @Password, @Email, @FullName, @Address, @Phone, @CreatedDate)"

            Dim cmd As New SqlCommand(query, cn)
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text)
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text) ' ⚠️ In production, hash this
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text)
            cmd.Parameters.AddWithValue("@FullName", txtFullName.Text)
            cmd.Parameters.AddWithValue("@Address", txtAddress.Text)
            cmd.Parameters.AddWithValue("@Phone", txtPhone.Text)
            cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now) ' ✅ Fix NULL issue

            cmd.ExecuteNonQuery()
            MsgBox("✅ Account created successfully!")
        Catch ex As Exception
            MsgBox("❌ Error creating account: " & ex.Message)
        Finally
            cn.Close()
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtEmail.Attributes("type") = "email"
        End If
    End Sub
End Class
