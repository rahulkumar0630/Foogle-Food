<?php
    $host='foogle-order-db-cluster-1.cluster-cv5vwx555jrp.us-east-2.rds.amazonaws.com:3306';
    $user='rahulkumar0630';
    $password='!ClearCreek5';
 
     
    $connection = mysql_connect($host, $user, $password);

     
    $OrderNumber = $_POST['OrderNumber'];
    $email = $_POST['email'];
    $address = $_POST['address'];
    $city = $_POST['city'];
    $zipcode = $_POST['zipcode'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $URL = $_POST['URL'];
    $AmountofIngredients = $_POST['AOI'];
    $IngredientsArray = array();


     
    if(!$connection){
        die('Failed To Connect');
    }
    else{
        $dbconnect = @mysql_select_db('foogle_orders_db', $connection);
         
        if(!$dbconnect){
            die('Could not connect to Foogle_Orders_DB');
        }
        else{
            $query = "INSERT INTO `foogle_orders_db`.`OrdersTable` (`OrderNumber`, `email`, `address`, `city`, `zipcode`, `state`, `country`, `URL`)
                VALUES ('$OrderNumber','$email', '$address', '$city', '$zipcode', '$state', '$country', '$URL');";
            mysql_query($query, $connection) or die(mysql_error());
             
            echo 'Successfully added.';
            echo $query;
        }
	$UniqueNameForTable = "IngredTable".$OrderNumber;

	$sql = "CREATE TABLE ".$UniqueNameForTable."(
	id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Ingredients VARCHAR(45) NOT NULL,
	Cost VARCHAR(45) NOT NULL
	)";
	
	$InsertIntoDB = mysql_query($sql, $connection) or die(mysql_error());

	echo 'Successfully added Table.';

	 for($x = 0; $x <= $AmountofIngredients; $x++)
         {
		$PostRequest = "ING" .$x;
		$ING = $_POST[$PostRequest];
		$PostRequestForCost = "COST" .$x;
		$COST = $_POST[$PostRequestForCost];


		$query = "INSERT INTO `foogle_orders_db`.`$UniqueNameForTable` (`Ingredients`, `Cost`)
                VALUES ('$ING', $COST);";
                mysql_query($query, $connection) or die(mysql_error());

		
         }

    }
?>