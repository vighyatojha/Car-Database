Imports System.Data
Imports System.Data.SqlClient

Partial Class _Shoes
    Inherits System.Web.UI.Page

    ' Database connection string
    Dim cn As New SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=D:\ASP Practical\Shoes_User.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            LoadProducts()
            CheckUserSession()
        End If
    End Sub

    Private Sub LoadProducts()
        Try
            Dim cmd As New SqlCommand("SELECT TOP 6 ProductID, ProductName, Description, Price, ImageURL FROM Products ORDER BY CreatedDate DESC", cn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)

            rptProducts.DataSource = dt
            rptProducts.DataBind()
        Catch ex As Exception
            Response.Write("<script>alert('Error loading products: " & ex.Message.Replace("'", "\'") & "');</script>")
        End Try
    End Sub

    Private Sub CheckUserSession()
        ' Check session for logged-in user
        If Session("Username") IsNot Nothing Then
            Dim userName As String = Session("UserName").ToString()
            lblWelcome.Text = "Welcome, " & userName & "!"
            lnkLogin.Visible = False
            lnkSignup.Visible = False
            lnkLogout.Visible = True
            lnkOrders.Visible = True
        Else
            ' Check for remember me cookie
            If Request.Cookies("RememberMe") IsNot Nothing Then
                Dim userID As String = Request.Cookies("RememberMe").Value
                If IsNumeric(userID) Then
                    LoadUserFromCookie(Convert.ToInt32(userID))
                End If
            End If

            lblWelcome.Text = ""
            lnkLogin.Visible = True
            lnkSignup.Visible = True
            lnkLogout.Visible = False
            lnkOrders.Visible = False
        End If
    End Sub

    Private Sub LoadUserFromCookie(ByVal userID As Integer)
        Try
            Dim cmd As New SqlCommand("SELECT Username FROM Users WHERE UserID = @UserID", cn)
            cmd.Parameters.AddWithValue("@Username", userID)

            If cn.State <> ConnectionState.Open Then cn.Open()
            Dim userName As Object = cmd.ExecuteScalar()

            If userName IsNot Nothing Then
                Session("UserName") = userName.ToString()
                CheckUserSession() ' Refresh the UI
            End If
        Catch ex As Exception
            ' Cookie might be invalid, remove it
            Dim cookie As New HttpCookie("RememberMe")
            cookie.Expires = DateTime.Now.AddDays(-1)
            Response.Cookies.Add(cookie)
        Finally
            If cn.State = ConnectionState.Open Then cn.Close()
        End Try
    End Sub

    Protected Sub lnkLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkLogout.Click
        ' Clear session
        Session.Clear()
        Session.Abandon()

        ' Remove remember me cookie
        Dim cookie As New HttpCookie("RememberMe")
        cookie.Expires = DateTime.Now.AddDays(-1)
        Response.Cookies.Add(cookie)

        Response.Redirect("Login.aspx")
    End Sub
End Class