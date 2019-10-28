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


