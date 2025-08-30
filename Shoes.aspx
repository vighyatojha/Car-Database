<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Shoes.aspx.vb" Inherits="_Shoes" %>

<!DOCTYPE html>
<head id="Head1" runat="server">
    <title>SoleStyle - Premium Shoes Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f8f9fa;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            transition: background 0.3s;
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.1);
        }

        .hero {
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 50%, #fecfef 100%);
            color: #333;
            text-align: center;
            padding: 4rem 0;
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            font-weight: 300;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.8;
        }

        .products {
            padding: 4rem 0;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #333;
            font-weight: 300;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .product-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }

        .product-info {
            padding: 1.5rem;
        }

        .product-name {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .product-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 1rem;
        }

        .product-description {
            color: #666;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102,126,234,0.4);
        }

        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 2rem 0;
            margin-top: 4rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        @media (max-width: 768px) {
            .nav {
                flex-direction: column;
                gap: 1rem;
            }

            .hero h1 {
                font-size: 2rem;
            }

            .product-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
            <div class="container">
                <nav class="nav">
                    <a href="Shoes.aspx" class="logo">
                        <i class="fas fa-shoe-prints"></i> SoleStyle
                    </a>
                    <div class="nav-links">
                        <a href="Shoes.aspx">Home</a>
                        <div class="user-info">
                            <asp:Label ID="lblWelcome" runat="server" Text="" CssClass="welcome-msg"></asp:Label>
                            <asp:LinkButton ID="lnkLogin" runat="server" Text="Login" PostBackUrl="~/Login.aspx"></asp:LinkButton>
                            <asp:LinkButton ID="lnkSignup" runat="server" Text="Sign Up" PostBackUrl="~/Signup.aspx"></asp:LinkButton>
                            <asp:LinkButton ID="lnkLogout" runat="server" Text="Logout" OnClick="lnkLogout_Click" Visible="false"></asp:LinkButton>
                            <asp:LinkButton ID="lnkOrders" runat="server" Text="My Orders" PostBackUrl="~/Orders.aspx" Visible="false"></asp:LinkButton>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <section class="hero">
            <div class="container">
                <h1>Step Into Style</h1>
                <p>Discover the perfect pair from our premium collection of shoes</p>
            </div>
        </section>

        <section class="products">
            <div class="container">
                <h2 class="section-title">Featured Products</h2>
                <asp:Repeater ID="rptProducts" runat="server">
                    <HeaderTemplate>
                        <div class="product-grid">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="product-card">
                            <img src='<%# Eval("ImageURL") %>' alt='<%# Eval("ProductName") %>' class="product-image" />
                            <div class="product-info">
                                <h3 class="product-name"><%# Eval("ProductName") %></h3>
                                <div class="product-price">$<%# Eval("Price", "{0:F2}") %></div>
                                <p class="product-description"><%# Eval("Description") %></p>
                                <asp:HyperLink ID="lnkViewProduct" runat="server" 
                                    NavigateUrl='<%# "ProductDetails.aspx?id=" & Eval("ProductID") %>' 
                                    CssClass="btn btn-primary" Text="View Details"></asp:HyperLink>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </section>

        <footer class="footer">
            <div class="container">
                <p>&copy; 2025 SoleStyle. All rights reserved.</p>
            </div>
        </footer>
    </form>
</body>
</html>