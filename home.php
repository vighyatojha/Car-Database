<?php
include("connect.php");

// Handle car insertion
if (isset($_POST['btninsert'])) {
    $Carname = $_POST['txtcarname'];
    $Modelname = $_POST['txtcarmodel'];
    $Year = $_POST['selyear'];
    $Price = $_POST['txtcarprice'];
    
    $Insert = "INSERT INTO car_tbl (carname, modelname, year, price) 
               VALUES ('$Carname', '$Modelname', '$Year', '$Price')";
    
    mysqli_query($connect, $Insert) or die(mysqli_connect_error());
    header("location:home.php");
}

// Handle car update
if (isset($_POST['btnupdate'])) {
    $Carid = $_POST['txtcarid']; 
    $Carname = $_POST['txtcarname'];
    $Modelname = $_POST['txtcarmodel'];
    $Year = $_POST['selyear'];
    $Price = $_POST['txtcarprice'];
    
    $Update = "UPDATE car_tbl 
               SET carname='$Carname', modelname='$Modelname', year='$Year', price='$Price' 
               WHERE carid={$_GET['editid']}";
    
    mysqli_query($connect, $Update) or die(mysqli_connect_error());
    header("location:home.php");
}

// Handle edit data retrieval
if (isset($_GET['editid'])) {
    $Select = "SELECT * FROM car_tbl WHERE carid={$_GET['editid']}";
    $result = mysqli_query($connect, $Select);
    $row = mysqli_fetch_array($result);
}

// Handle car deletion
if (isset($_GET['delid'])) {
    $Delete = "DELETE FROM car_tbl WHERE carid={$_GET['delid']}";
    mysqli_query($connect, $Delete) or die(mysqli_connect_error());
    mysqli_query($connect, "ALTER TABLE car_tbl AUTO_INCREMENT = 1");
    header("location:home.php");
}
?>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initialscale=1">
 <title>Car Crud Operation</title>
 <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(45deg, #1e3c72, #2a5298, #7b2cbf, #c77dff);
            background-size: 400% 400%;
            animation: gradientShift 8s ease infinite;
            min-height: 100vh;
            position: relative;
            overflow-x: auto;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Floating cars animation */
        body::before {
            content: '🚗 🚙 🚕 🏎️ 🚐';
            position: fixed;
            top: -50px;
            left: -100px;
            font-size: 2rem;
            opacity: 0.1;
            animation: floatCars 25s linear infinite;
            z-index: 1;
            pointer-events: none;
        }

        @keyframes floatCars {
            0% { transform: translateX(-100px) translateY(100vh) rotate(0deg); }
            100% { transform: translateX(100vw) translateY(-100px) rotate(360deg); }
        }

        .main-container {
            position: relative;
            z-index: 10;
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.85);
            margin: 20px;
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Cpath d='M30 30c0-11.046 8.954-20 20-20s20 8.954 20 20-8.954 20-20 20-20-8.954-20-20zm0 0c0 11.046-8.954 20-20 20s-20-8.954-20-20 8.954-20 20-20 20 8.954 20 20z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            animation: patternMove 20s linear infinite;
        }

        @keyframes patternMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(60px, 60px); }
        }

        .header-section h2 {
            color: white;
            font-size: 1.8rem;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 2;
        }

        .content-wrapper {
            padding: 30px;
        }

        /* Form Styling */
        .form-container {
            background: linear-gradient(145deg, #f0f0f0, #ffffff);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 
                inset 5px 5px 10px #d1d1d1,
                inset -5px -5px 10px #ffffff,
                0 10px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .form-container:hover {
            transform: translateY(-5px);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        td {
            padding: 8px 15px;
            font-size: 0.9rem;
        }

        td:first-child {
            font-weight: 600;
            color: #2d3748;
            text-align: right;
            width: 200px;
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: linear-gradient(145deg, #ffffff, #f7fafc);
            box-shadow: inset 2px 2px 5px rgba(0, 0, 0, 0.1);
        }

        input[type="text"]:focus, input[type="number"]:focus, select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1), inset 2px 2px 5px rgba(0, 0, 0, 0.1);
            transform: scale(1.02);
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 15px rgba(79, 172, 254, 0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 25px rgba(79, 172, 254, 0.4);
        }

        input[type="submit"]:active {
            transform: translateY(-1px);
        }

        /* Table Styling */
        .data-table-container {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        .table-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 20px;
            font-size: 1rem;
            font-weight: 600;
            text-align: center;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.85rem;
        }

        .data-table th {
            background: linear-gradient(145deg, #f7fafc, #edf2f7);
            padding: 12px 10px;
            text-align: center;
            font-weight: 600;
            color: #2d3748;
            border-bottom: 2px solid #e2e8f0;
            font-size: 0.85rem;
        }

        .data-table td {
            padding: 12px 10px;
            text-align: center;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }

        .data-table tr:hover {
            background: linear-gradient(145deg, #f8fafc, #ffffff);
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .data-table tr:nth-child(even) {
            background: rgba(102, 126, 234, 0.02);
        }

        /* Action Links */
        .action-link {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 0 3px;
            display: inline-block;
        }

        .edit-link {
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            color: #8b4513;
        }

        .edit-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(252, 182, 159, 0.4);
        }

        .delete-link {
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            color: #c53030;
        }

        .delete-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(255, 154, 158, 0.4);
        }

        /* Rupee Symbol Enhancement */
        .rupee-symbol {
            font-weight: bold;
            color: #2d3748;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 10px;
                border-radius: 15px;
            }
            
            .content-wrapper {
                padding: 15px;
            }
            
            .header-section h2 {
                font-size: 1.4rem;
            }
            
            td:first-child {
                width: auto;
                text-align: left;
            }
            
            .data-table {
                font-size: 0.75rem;
            }
            
            .data-table th, .data-table td {
                padding: 8px 5px;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Car Icons */
        .car-icon {
            display: inline-block;
            margin-right: 8px;
            font-size: 1.1rem;
        }

        /* Enhanced Select Dropdown */
        select {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 12px center;
            background-repeat: no-repeat;
            background-size: 16px;
            appearance: none;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="header-section">
            <h2>🚗 Car Management System</h2>
        </div>
        
        <div class="content-wrapper">
            <div class="form-container">
                <form method="post" action="">
                    <table>
                        <tr>
                            <td>Enter Car Id : </td>
                            <td><input type="number" name="txtcarid" placeholder="Enter Car Id" value="<?php if(isset($_GET['editid'])) echo $row['carid']; ?>"></td>
                        </tr>
                        <tr>
                            <td>Enter Car Name : </td>
                            <td><input type="text" name="txtcarname" placeholder="Enter Car Name" value="<?php if(isset($_GET['editid'])) echo $row['carname']; ?>" required></td>
                        </tr>
                        <tr>
                            <td>Enter Car Model : </td>
                            <td><input type="text" name="txtcarmodel" placeholder="Enter Car Model" value="<?php if(isset($_GET['editid'])) echo $row['modelname']; ?>" required></td>
                        </tr>
                        <tr>
                            <td>Enter Car Year : </td>
                            <td>
                                <select name="selyear">
                                    <option value="">---Select Year---</option> 
                                    <?php
                                    for($i=1990;$i<=2023;$i++)
                                    {
                                    ?>
                                    <option value="<?php echo $i?>" <?php if(isset($_GET['editid']) && $row['year'] == $i) echo 'selected'; ?>><?php echo $i;?></option>
                                    <?php
                                    } 
                                    ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Enter Car Price : </td>
                            <td><input type="number" name="txtcarprice" placeholder="Enter Car Price in ₹" value="<?php if(isset($_GET['editid'])) echo $row['price']; ?>" required></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <?php if(isset($_GET['editid'])){ ?>
                                <input type="submit" name="btnupdate" value="Update Car">
                                <?php } else { ?>
                                <input type="submit" name="btninsert" value="Add Car">
                                <?php } ?>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

            <div class="data-table-container">
                <div class="table-header">
                    <?php
                    $Select="select * from car_tbl order by carid desc"; 
                    $result=mysqli_query($connect,$Select);
                    $count=mysqli_num_rows($result);
                    echo "🚗 Total Cars in Inventory : ".$count;
                    ?>
                </div>
                
                <table class="data-table">
                    <tr>
                        <th><span class="car-icon">🆔</span>Car Id</th>
                        <th><span class="car-icon">🚗</span>Car Name</th>
                        <th><span class="car-icon">🔧</span>Model Name</th>
                        <th><span class="car-icon">📅</span>Car Year</th>
                        <th><span class="car-icon">💰</span>Car Price</th>
                        <th><span class="car-icon">⚙️</span>Action</th>
                    </tr>
                    <?php
                    while($row=mysqli_fetch_array($result))
                    {
                    ?>
                    <tr>
                        <td><?php echo $row['carid'] ?></td>
                        <td><?php echo $row['carname'] ?></td>
                        <td><?php echo $row['modelname'] ?></td>
                        <td><?php echo $row['year'] ?></td>
                        <td><span class="rupee-symbol">₹</span><?php echo number_format($row['price'], 2) ?></td>
                        <td>
                            <a href="home.php?editid=<?php echo $row['carid'];?>" class="action-link edit-link">✏️ Edit</a>
                            <a href="home.php?delid=<?php echo $row['carid'];?>" class="action-link delete-link" onclick="return confirm('Are you sure to delete?');">🗑️ Delete</a>
                        </td>
                    </tr>
                    <?php
                    }
                    ?>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
