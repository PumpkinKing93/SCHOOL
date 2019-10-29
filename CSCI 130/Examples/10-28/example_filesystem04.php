<<<<<<< HEAD
<!DOCTYPE html >
<head>
	<title>CSci 130 - Web Programming - My counter in PHP</title>
</head>
<body>

<?php 
$handle = fopen("pagecounter.txt", "r");
if(!$handle){
 echo "Cannot open the file" ;
}
else {
	$counter = (int ) fread($handle,20);
	fclose ($handle);
	$counter++; // increment the value
	echo " <strong> Visitor no ". $counter . " </strong><br>" ;
	// update the value in the text file
	$handle = fopen("counter.txt", "w" );
	fwrite($handle,$counter) ;
	fclose ($handle) ;
}

?>

<p> Web programming CSci 130</p> 
</body>
</html>


=======
<!DOCTYPE html >
<head>
	<title>CSci 130 - Web Programming - My counter in PHP</title>
</head>
<body>

<?php 
$handle = fopen("pagecounter.txt", "r");
if(!$handle){
 echo "Cannot open the file" ;
}
else {
	$counter = (int ) fread($handle,20);
	fclose ($handle);
	$counter++; // increment the value
	echo " <strong> Visitor no ". $counter . " </strong><br>" ;
	// update the value in the text file
	$handle = fopen("counter.txt", "w" );
	fwrite($handle,$counter) ;
	fclose ($handle) ;
}

?>

<p> Web programming CSci 130</p> 
</body>
</html>


>>>>>>> 3c23027f6d2ee9146a630164e604e1edfb3d267b
