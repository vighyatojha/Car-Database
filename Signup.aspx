<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Signup.aspx.vb" Inherits="Signup" %>

<!DOCTYPE html>
<head id="Head1" runat="server">
    <title>Sign Up - SoleStyle</title>
</head>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .signup-container {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 650px;   /* ✅ wider form */
        }

        .logo {
            text-align: center;
            margin-bottom: 2rem;
            color: #667eea;
            font-size: 2rem;
            font-weight: bold;
        }

        .form-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #333;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #555;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 16px;
            transition: border-color 0.3s;
            background: #f8f9fa;
        }

        .form-control:focus {
            border-color: #667eea;
            outline: none;
            background: white;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102,126,234,0.3);
        }

        .login-link {
            text-align: center;
            margin-top: 2rem;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .input-icon .form-control {
            padding-left: 40px;
        }

        @media (max-width: 576px) {
            .signup-container {
                padding: 1.5rem;
                margin: 10px;
            }
        }
    </style>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <div class="logo">
                <i class="fas fa-shoe-prints"></i> SoleStyle
            </div>
            
            <h2 class="form-title">Create Your Account</h2>
            
            <div class="form-group">
                <label for="txtFullName">Full Name</label>
                <div class="input-icon">
                    <i class="fas fa-user"></i>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                    ControlToValidate="txtFullName" 
                    ErrorMessage="Full name is required" 
                    CssClass="error-message" 
                    Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtUsername">Username</label>
                <div class="input-icon">
                    <i class="fas fa-user-circle"></i>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a username"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Username is required" 
                    CssClass="error-message" 
                    Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtEmail">Email Address</label>
                <div class="input-icon">
                    <i class="fas fa-envelope"></i>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
             TextMode="SingleLine" placeholder="Enter your email"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required" 
                    CssClass="error-message" 
                    Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                    ControlToValidate="txtEmail" 
                    ErrorMessage="Please enter a valid email address" 
                    CssClass="error-message" 
                    Display="Dynamic"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <label for="txtPassword">Password</label>
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a password"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" 
                    CssClass="error-message" 
                    Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtPhone">Phone Number</label>
                <div class="input-icon">
                    <i class="fas fa-phone"></i>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label for="txtAddress">Address</label>
                <div class="input-icon">
                    <i class="fas fa-home"></i>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter your address"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Button ID="btnSignup" runat="server" Text="Create Account" CssClass="btn btn-primary" OnClick="btnSignup_Click" />
            </div>

            <div class="login-link">
                Already have an account? <a href="Login.aspx">Login here</a>
            </div>
        </div>
    </form>
</body>
</html>
