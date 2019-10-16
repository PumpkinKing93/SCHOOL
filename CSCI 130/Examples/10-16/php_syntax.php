<?php
// Some example for the syntax in PHP
// Web programming CSci 130 - Fresno State

// declare: http://php.net/manual/en/control-structures.declare.php
declare(strict_types = 1); // must be declared at the top!

/*
  function AddFloats(float $a, float $b) : int 
  {
      return $a + $b;
  }
  echo AddFloats(1,'3');
  //without strict typing, PHP will change int(1) to float(1.0)
  // and string('3') to float(3.0) and returns int(4)
*/



# it is a comment
// it is also a comment
/* we have comments 
in several lines */

// Display a string on the HTML webpage
echo 'My first script in PHP';
// Dont forget the semicolon after each instruction!

// go to the next line using HTML
echo "<br>";

// go to the next line using special characters
echo nl2br("bla \n\r");
echo nl2br('bla \n\r'); // does not work
echo 'bli';



echo "<br>";
$name = "John";
// $name contains the string John
echo '1 His name is $name <br>';
echo "2 His name is $name <br>";
echo 'His name is '. $name .'<br>';
echo "His name is ". $name ."<br>";

echo 'His name is $name';
echo "His name is $name";
echo 'His name is '. $name;
echo "His name is ". $name;

echo "<br>";

echo strlen("Hello world!"); // Give the length of string
echo "<br>";
echo str_word_count("web programming CSci130"); // 3 words -  Give the number of words in a sentence
echo "<br>";
echo strrev("Never odd or even"); // reverse
echo strpos("Hello world!", "world"); // outputs 6: position (search a string within a string), false if not found
echo str_replace("John", "Jim", "Hi John!");
// There are many functions to manage strings


// Definition of a constant (global scope): define(name, value, case-insensitive)
// name: Specifies the name of the constant
// value: Specifies the value of the constant
// case-INsensitive: constant name should be case-INsensitive. Default value is FALSE

define("lambda", "1.234567", true); // It is case INSENSITIVE
echo lambda;

//define a array using define function
define('animals', [
    'dog',
    'cat',
    'bird'
]);
print(animals[1]);

// print vs echo : same thing but print returns a value (1)
// both can be used with or without brackets


$my_number=12;
// $my_number contains the value 12

// Remark: no type, no keyword for the declaration !

// $5toto = "test";
// It is not valid because it starts with a number


$fruit = Array();
// Access by index (number)
$fruit[0] = "orange";
$fruit[1] = "apple";
$fruit[2] = "apricot";

// Access by key (string)
$fruit = Array();
$fruit['best'] = "fraise";
$fruit['good'] = "banana";
$fruit['favorite'] = "apricot";


echo "<br>";
$name = "Mike";
echo 'Good morning ';
echo $name; // not echo '$name' otherwise it writes $name instead of Mike
echo ' !';
// Everything on the same line

// String concatenation (it is not a +, it is a point)
$name = "Jimmy";
echo 'Good morning '.$name.' !';

// the Main Super Global Variable

echo 'DOCUMENT_ROOT provides' .$_SERVER['DOCUMENT_ROOT'] .'<br>';	// root of the server
echo 'HTTP_ACCEPT_LANGUAGE provides' .$_SERVER['HTTP_ACCEPT_LANGUAGE'] .'<br>'; // language accepted by the navigator
echo 'HTTP_HOST provides ' .$_SERVER['HTTP_HOST'].'<br>'; 	// Domain name
echo 'HTTP_USER_AGENT provides ' .$_SERVER['HTTP_USER_AGENT'].'<br>'; 	// type of browser
echo 'PATH_INFO provides ' .$_SERVER['PATH_INFO']	.'<br>'; // path to WEB script
echo 'PATH_TRANSLATED provides ' .$_SERVER['PATH_TRANSLATED'] .'<br>'; // full path to the script
echo 'REQUEST_URI provides ' .$_SERVER['REQUEST_URI'] .'<br>'; // path of the script
echo 'REMOTE_ADDR provides ' .$_SERVER['REMOTE_ADDR']  .'<br>'; // IP of client
echo 'REMOTE_PORT provides ' .$_SERVER['REMOTE_PORT']  .'<br>'; // Port for the request
echo 'QUERY_STRING provides ' .$_SERVER['QUERY_STRING']	.'<br>'; // Parameters given to the script
echo 'SERVER_ADDR provides ' .$_SERVER['SERVER_ADDR'] .'<br>'; // IP address of the server
echo 'SERVER_ADMIN provides ' .$_SERVER['SERVER_ADMIN'] .'<br>'; // Address of the server admin
echo 'SERVER_NAME provides ' .$_SERVER['SERVER_NAME'] .'<br>'; // Local name of the server
echo 'SERVER_SIGNATURE provides ' .$_SERVER['SERVER_SIGNATURE'] .'<br>'; // Type of server
echo 'REQUEST_METHOD provides ' .$_SERVER['REQUEST_METHOD']	.'<br>'; // Type of call for the script


$a=$b=7; // faster to write and execute
echo $a ." and ". $b . "<br>";
// equivalent to
$a=7;
$b=7;


$val=10+"2.55"; // float, 12.55
echo $val.'<br>';
$val=1+"toto2"; // 1 + 0 = 1
echo $val.'<br>';
$val=2+"3 little pigs"; // 2 + 3 = 5 , 3 at the beginning of the string
echo $val.'<br>';

// If then else
echo "***** IFTHENELSE *****<br>";
$n = 11;
if ($n >= 0 && $n < 10) {
	echo $n.' is between 0 and 9';
}
elseif ($n >= 10 && $n < 20) {
	echo $n.' is between 10 and 19';
}
else {
	echo $n.' is greater than 19';
}


// We have also $a?$b:$c for the conditional expressions
$a=TRUE; $b=2;$c=3;
echo $a?$b:$c; // display 2

// Switch
echo "***** SWITCH *****<br>";
$name = "Ryu";
switch ($name) {
	case 'John' :
	echo 'Your name is John.';
	break;
	case 'Alfredo' :
	echo 'Your name is Alfredo.';
	break;
	case 'Ken' :
	echo 'Your name is Ken.';
	break;
	default :
	echo 'I dont know who you are.';
}

// same code with ifthenelse
if ($name == "John") {
	echo 'Your name is John.';
}
elseif ($name == "Alfredo") {
	echo 'Your name is Alfredo.';
}
elseif ($name == "Ken") {
	echo 'Your name is Ken.';
}
else {
	echo 'I dont know who you are.';
}

echo "***** LOOP *****<br>";
// For loop
$n = 5;
// start the loop
for ($i=0;$i<$n;$i++) {
	echo 'The number is '.$i.'<br />';
}

// Foreach loop
$colors = array("red", "green", "blue", "yellow"); 
foreach ($colors as $value) {
    echo "$value <br>";
}

echo "***** WHILE *****<br>";
$n=5;
$i=0;
// start the loop
while ($i<$n) {
	echo 'The nuumber is different than '.$i.'<br />';
	$i = $i + 1;
}
// end of the loop
echo 'n is equal to: '.$i;

$x = 1; 
do {
    echo "The number is: $x <br>";
    $x++;
} while ($x <= n);


// Different version of PHP, different ways with the types
// Types in PHP7
//- int
//- float
//- boolean
//- string
//- interfaces
//- array
//-callable


// example of a function
function sum($x, $y) {
    $z = $x + $y;
    return $z;
}
echo 'Sum example  1+5='. sum(1,5)  .' 5+9='. SUM(5,9) .' 8+6='. SuM(8,6)  .'<br>';  


// Return type declarations --> specify the type of element that is returned
echo "<br> Return types<br>";

   function returnIntValue1(int $value): int {
      return $value;
   }
   print(returnIntValue1(5));
   
   function returnIntValue2(int $value): int {
      return $value + 1.0;
   }
 //  print(returnIntValue2(5));
   
   // it will try to modiy the values of a and b to get a float from them
   function getTotal1(float $a, float $b) {
    return $a + $b;
}
   
//echo getTotal1(2.8, "3.2") ."<br>";
// string "3.2" changed to float(3.2) no notice
//returns float(6)
echo getTotal1(2.5, 1) ."<br>";
// int(1) changed to float(1.0)
//returns float(3.5)



// type for the inputs (float) + type for the output (int)
function getTotal2(float $a, float $b) : int {
      return $a + $b;
}
getTotal2(2, "1 week");
// changes int(2) to float(2.0) & string(“1 more”) to float(1.0)
// returns int(3);
getTotal2(2.8, "3.2");
// changes string "3.2" to float(3.2)
// returns int(6)
getTotal2(2.5, 1); 
// changes int(1) to float(1.0)
// returns int(3)
   


// Try catch novelties in PHP7
try {
   // Code that may throw an Exception or Error.
} catch (Throwable $t) {
   // Executed only in PHP 7, will not match in PHP 5
} catch (Exception $e) {
   // Executed only in PHP 5, will not be reached in PHP 7
}


// Class
class Car {
    function Car() {
        $this->brand = "Ford";
		$this->model = "Focus";
		$this->color = "red";
    }
}

// create an object
$mycar = new Car();

// show object properties
echo $mycar->model;



?>