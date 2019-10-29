<?php
// Files in PHP
// Web programming - CSci 130

$x=rand(0,400)/100;
$x=round($x,2);
echo $x;

$x=$x."";

// open a file and read the whole content
echo readfile("myfile.txt");

// open a file
$file = fopen("test.txt","w");
echo fwrite($file,"Hello World. Testing!");
// Always close the file
fclose($file);

// reads the "database.txt" file to the end:

$myfile=fopen("database.txt","r");
fread($myfile,filesize("database.txt"));
fclose($myfile);

$myfile = fopen("database.txt","r") or die("Impossible to open file!");
echo fgets($myfile); // read a single line from a file
fclose($myfile);

$myfile=fopen("database.txt","r");
// Output one line until end-of-file
while(!feof($myfile)) {
  echo fgets($myfile) . "<br>";
}
fclose($myfile);


$myfile=fopen("database.txt","r");
// Output one character until end-of-file
while(!feof($myfile)) {
  echo fgetc($myfile);
}
fclose($myfile);


$myfile = fopen("peopledataabase.txt", "w") or die("Cannot open file!");
$txt = "Jim \n";
fwrite($myfile, $txt); // write first line
$txt = "Alfred \n";
fwrite($myfile, $txt); // write second line
fclose($myfile);


// read the file into an array
$lines = file("myfile.txt");
 foreach($lines as $line) $words[] = str_word_count($line);

 
 // convert object to json
$json = json_encode($myObject);

// convert json to object
$obj = json_decode($json);

// Example
$foo = new StdClass();
$foo->hello = "world";
$foo->bar = "baz";

$json = json_encode($foo);
echo $json;
//=> {"hello":"worldpeace","bar":"baz"}


// Remark:
// print has a return value of 1 so it can be used in expressions
// echo has a void return type
// print_r:
// 	- It outputs a human-readable representation of any one value
// 	- It accepts not just strings, but other types including arrays and objects, and formatting them to be readable 
//  - It is useful when debugging
// 	- It may return its output as a return value (instead of echoing) if the second optional argument is given

print_r(json_decode($json));
// stdClass Object
// (
//   [hello] => worldpeace
//   [bar] => baz
// )


// output as an Array instead of an Object, pass true to json_decode

print_r(json_decode($json, true));
// Array
// (
//   [hello] => world
//   [bar] => baz
// )    
 
 
// In Javascript: let jsonObject = JSON.parse(jsonString);
 

?>