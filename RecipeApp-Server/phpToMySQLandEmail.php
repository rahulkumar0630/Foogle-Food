<?php
    require_once 'PHPMailer-master/PHPMailerAutoload.php';

    $mail = new PHPMailer;
	
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
    $IngredientsforEmail = "";


     
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

		$currentPosPlus1 = $x + 1; 

		$IngredientsforEmail = $IngredientsforEmail."<b><p>".$currentPosPlus1.". ".$ING."</p></b>
			<p>Price for Ingredient ".$currentPosPlus1.": <b>".$COST."</b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>
			";
		
         }

	$mail->IsSMTP();                                  
	$mail->Host = 'email-smtp.us-west-2.amazonaws.com';  // Specify main and backup SMTP servers
	$mail->SMTPAuth = true;                               // Enable SMTP authentication
	$mail->Username = 'AKIAJ46IGXLJZLCDI4XQ';                 // SMTP username
	$mail->Password = 'AjqdoiDzz2jNOUt/2+fFQ+ALplhnQyBF1Ff48Zxe1++d';                           // SMTP password
	$mail->SMTPSecure = 'tlp';                            // Enable TLS encryption, `ssl` also accepted
	$mail->Port = 587;                                    // TCP port to connect to

	$mail->setFrom('fooglefood@gmail.com', 'Foogle', 0);
	$mail->addAddress($email);
        $mail->addAddress('fooglefood@gmail.com');    // Add a recipient
	$mail->addReplyTo('fooglefood@gmail.com', 'Customer Support');

	$mail->isHTML(true);                                  // Set email format to HTML

	$mail->Subject = 'Foogle Order Confirmation: #'.$OrderNumber;
	$mail->Body    = '<h1><span style="color: #339966;">Foogle</span> Order '.$OrderNumber.'</h1>
			<p>&nbsp;</p>
			<h2 style="text-align: left;">Email:</h2>
			<p style="text-align: left;"><span style="text-decoration: underline;"><strong><a href="mailto:'.$email.'">'.$email.'</a></strong></span></p>
			<h2 style="text-align: left;">Address Line 1:</h2>
			<p><span style="text-decoration: underline;"><strong>'.$address.'</strong></span></p>
			<h2 style="text-align: left;">City:</h2>
			<p><span style="text-decoration: underline;"><strong>'.$city.'</strong></span></p>
			<h2 style="text-align: left;">Zip Code:</h2>
			<p><span style="text-decoration: underline;"><strong>'.$zipcode.'</strong></span></p>
			<h2 style="text-align: left;">State:</h2>
			<p><span style="text-decoration: underline;"><strong>'.$state.'</strong></span></p>
			<h2 style="text-align: left;">Country:</h2>
			<p><span style="text-decoration: underline;"><strong>'.$country.'</strong></span></p>
			<h2 style="text-align: left;"><span style="color: #339966;">Ingredient List:</span></h2>'
			.$IngredientsforEmail.'
			<p style="text-align: left;">&nbsp;</p>
			<p style="text-align: left;">&nbsp;</p>
			<p>&nbsp;</p>
			<p><strong>&nbsp;</strong></p>';
	$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

	if(!$mail->send()) {
    	echo 'Message could not be sent.';
    	echo 'Mailer Error: ' . $mail->ErrorInfo;
	} else {
    		echo 'Message has been sent';
	}	

    }
?>