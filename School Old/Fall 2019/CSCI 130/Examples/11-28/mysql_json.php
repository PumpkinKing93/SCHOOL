<?php

// An example

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
// header() function sends a raw HTTP header to a client

$dbname="mydb.db";
$conn = new mysqli("myServer", "myUser", "myPassword", $dbname);

$result = $conn->query("SELECT CompanyName, City, Country FROM Clients");

$outp = "";

// Double quotes inside the JSON
// Simple quotes for the string
// Concatenate elements piece by piece

while($rs = $result->fetch_array(MYSQLI_ASSOC)) {
    if ($outp != "") {$outp .= ",";}
    $outp .= '{"Name":"'  . $rs["CompanyName"] . '",';
    $outp .= '"City":"'   . $rs["City"]        . '",';
    $outp .= '"Country":"'. $rs["Country"]     . '"}';
}

// Create the JSON string piece by piece
$outp ='{"records":['.$outp.']}';
// You may add other elements
$conn->close();

echo($outp);
?>