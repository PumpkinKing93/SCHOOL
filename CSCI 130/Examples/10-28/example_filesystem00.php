<?php

// Files in PHP
// Web programming - CSci 130

// Before writing/reading into filesize
// --> prepare the data 


// JSON string
$wweJSON = '[{"name":"Hulk Hogan","gender":"male"},{"name":"Bret Hart","gender":"male"},{"name":"Trish Stratus","gender":"female"}]';

// Convert JSON string to Array
$wweArray = json_decode($wweJSON, true);
print_r($wweArray);        // Dump all data of the Array
echo $wweArray[0]["name"]; // Access Array data

// Convert JSON string to Object
$wweObject = json_decode($wweJSON);
print_r($wweObject);      // Dump all data of the Object
echo $wweObject[0]->name; // Access Object data


// Loop through Array
$wweArray = json_decode($wweJSON, true);
foreach ($wweArray as $key => $value) {
    echo $value["name"] . ", " . $value["gender"] . "<br>";
}

// Loop through Object
$wweObject = json_decode($wweJSON);
foreach($wweObject as $key => $value) {
   echo $value->name . ", " . $value->gender . "<br>";
}


// Array
$wweArray = [
[
  "name"   => "Shawn Michael",
  "gender" => "male"
],
[
  "name"   => "Roddy Piper",
  "gender" => "male"
],
[
  "name"   => "Booker T",
  "gender" => "male"
]
];

// Convert Array to JSON String
$wweJSON = json_encode($wweArray);
echo $wweJSON;



//////////////////////////////////////////////////////////////////////////////////////////


class ArrayValue implements JsonSerializable {
    public function __construct(array $array) {
        $this->array = $array;
    }

    public function jsonSerialize() {
        return $this->array;
    }
}

$array = ['foo' => 'bar', 'quux' => 'baz'];
echo json_encode(new ArrayValue($array), JSON_PRETTY_PRINT);

/* Output:
{
    "foo": "bar",
    "quux": "baz"
}
*/

/////////////////////////////////


class Person implements JsonSerializable {
    private $firstname;
    private $lastname;

    public function __construct() {
        $this->firstname = "unknown";
		$this->lastname = "unknown";
    }

    // to do: access/modify function for lastname and firstname
	
    public function jsonSerialize() {
        return ['firstname' => $this->firstname,
                'lastname' => $this->lastname];
    }
}

$t = new Person();

echo json_encode($t);

// Another example
class Fruit implements JsonSerializable {

        private $type = 'Apple', $lastEaten = null;
        public function __construct() {
            $this->lastEaten = new DateTime();
        }
        public function jsonSerialize() {
            return [
                'category' => $this->type,
                'EatenTime' => $this->lastEaten->format(DateTime::ISO8601)
            ];
        }
}
echo json_encode(new Fruit()); //which outputs:
{"category":"Apple","EatenTime":"2013-01-31T11:17:07-0500"}

///////////////////////////////////////////////

// Other solution
// http://php.net/manual/en/function.get-object-vars.php


class foo {
    private $a;
    public $b = 1;
    public $c;
    private $d;
    static $e;
   
    public function test() {
        var_dump(get_object_vars($this));
    }
}

$test = new foo;
var_dump(get_object_vars($test));
$test->test();


// example will output:
/*
array(2) {
  ["b"]=>
  int(1)
  ["c"]=>
  NULL
}
array(4) {
  ["a"]=>
  NULL
  ["b"]=>
  int(1)
  ["c"]=>
  NULL
  ["d"]=>
  NULL
}

*/


















?>