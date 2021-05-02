<?php
	//Step1
	$conn=mysqli_connect("localhost","root","","ace_and_tate");
	
	if(!$conn){
		echo 'Connection error: ' . mysqli_connect_error();
	}
?>

<html>
 <head>
 </head>
 <body>
 <h1>Ace & Tate</h1>

 <h2><u>Male Customers</u></h2>
 
 <?php
$query1 = "SELECT * FROM Customer";
mysqli_query($conn, $query1) or die('Error querying database.');

$result1 = mysqli_query($conn, "SELECT First_Name, Last_Name FROM Customer WHERE Gender='Male'");

while ($row = mysqli_fetch_assoc($result1)) {
 echo "<tr><td>",$row['First_Name']," </td><td>",$row['Last_Name'],"</td></tr>" . '<br />';
}

mysqli_free_result($result1); mysqli_close($conn);
?>

<h3><u>All customers whose first name begins with a C and last name begins with an L.</u></h3>

<?php
$conn=mysqli_connect("localhost","root","","ace_and_tate");
	
	if(!$conn){
		echo 'Connection error: ' . mysqli_connect_error();
	}
?>

<?php
$query2 = "SELECT * FROM Customer";
mysqli_query($conn, $query2) or die('Error querying database.');

$result2 = mysqli_query ($conn, "SELECT * FROM (SELECT * FROM Customer WHERE First_Name LIKE 'C%') AS Customer WHERE Last_Name LIKE 'L%';") ;

while ($row = mysqli_fetch_assoc($result2)) {
 echo "<tr><td>",$row['First_Name']," </td><td>",$row['Last_Name'],"</td></tr>" . '<br />';
 }

mysqli_free_result($result2); mysqli_close($conn);
?>

<?php
$conn=mysqli_connect("localhost","root","","ace_and_tate");
	
	if(!$conn){
		echo 'Connection error: ' . mysqli_connect_error();
	}
?>

<h4><u>Registration Form</u></h4>

<form action="reg_form.php" method="post">
First Name: <input type="text" name="First_name"><br>
Last Name: <input type="text" name="Last_Name"><br>
E-mail: <input type="text" name="E-mail"><br>
Phone number: <input type="text" name="Phone_number"><br>
Gender: <select name="Gender">
    <option value="Female">Female</option>
    <option value="Male">Male</option>
    <option<br>
<input type="submit">
</form>

<br />
<table>
<tr>
<th><b>Accessories_ID</b></th>
<th><b>Product_ID</b></th>
<th><b>Quantity</b></th>
</tr>

<br />

<?php
$query3 = "SELECT * FROM Accessories";
mysqli_query($conn, $query3) or die('Error querying database.');

$result3 = mysqli_query ($conn, "SELECT * FROM accessories NATURAL JOIN (SELECT quantity AS Quantity FROM Stocklist) AS store"); 

while ($row = mysqli_fetch_assoc($result3)) {
 echo "<tr><td>",$row['Accessories_ID']," </td><td>",$row['Product_ID']," </td><td>". $row['Quantity']. "</td></tr>" .'<br />';
 }
 echo "</table>";
 
 mysqli_free_result($result3); mysqli_close($conn);
?>

</body>
</html>