<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login - SoleStyle</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --text-color: #333;
            --error-color: #e74c3c;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', Arial, sans-serif;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            background: #fff;
            padding: 2.5rem;
            border-radius: 15px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
            font-size: 1.8rem;
            font-weight: 600;
        }

        .error-message {
            color: var(--error-color);
            font-size: 0.9rem;
            text-align: center;
            margin-bottom: 1rem;
            background: #ffe6e6;
            padding: 0.5rem;
            border-radius: 5px;
        }

        .login-field {
            margin-bottom: 1.2rem;
            position: relative;
        }

        .login-field input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .login-field input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }

        .login-field label {
            display: block;
            margin-bottom: 0.4rem;
            color: var(--text-color);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .login-button {
            width: 100%;
            padding: 0.8rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .login-button:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 0.9rem;
            color: var(--text-color);
        }

        .links {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
        }

        .links a {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .links a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 1.5rem;
                max-width: 100%;
            }

            .login-container h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>Welcome Back</h2>
            <asp:Login ID="LoginControl" runat="server" 
                OnAuthenticate="LoginControl_Authenticate" 
                FailureText="Invalid username or password."
                DisplayRememberMe="true"
                LoginButtonText="Sign In">
                <LayoutTemplate>
                    <asp:Label ID="FailureText" runat="server" CssClass="error-message" EnableViewState="false"></asp:Label>
                    <div class="login-field">
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                        <asp:TextBox ID="UserName" runat="server" CssClass="login-input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                            ControlToValidate="UserName" ErrorMessage="Username is required." 
                            ToolTip="Username is required." ValidationGroup="LoginControl">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="login-field">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="login-input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                            ControlToValidate="Password" ErrorMessage="Password is required." 
                            ToolTip="Password is required." ValidationGroup="LoginControl">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="remember-me">
                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me" />
                    </div>
                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Sign In" 
                        ValidationGroup="LoginControl" CssClass="login-button" />
                </LayoutTemplate>
            </asp:Login>
            <div class="links">
                <a href="ForgotPassword.aspx">Forgot Password?</a><br />
                Don't have an account? <a href="Signup.aspx">Sign Up</a>
            </div>
        </div>
    </form>
</body>
</html>