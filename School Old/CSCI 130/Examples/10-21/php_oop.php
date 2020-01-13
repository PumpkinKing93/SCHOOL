<?php
// PHP - Object Oriented Programming
// Web programming CSci 130 - Fresno State 

// Introduction to Classes with PHP

// class names, like function names: case insensitive
// Best practice: to stay consistent with the way you write names (functions and classes)

/*
// Example
class file {
    public $a;
}
class File {
    public $a2;
}
$x = new file(); // You will get a fatal error for the redefinition of the class
*/


// Creation of a class (convention: first letter is Upper case)
class Car1 {
  // The code inside the class
}

// Addition of properties in the class (convention: first letter of properties is lower case)
class Car {
  public $comp='ford';
  public $color = 'red';
  public $hasSunRoof = false;
  private $nmiles=37000;
}

// Create an object, instance of a class
$fordfocus= new Car();
echo $fordfocus->comp .'<br>'; // access to a property

// echo $fordfocus->$comp .'<br>'; // undefined variable + undefined property

//$comp=2;
//echo $fordfocus->$comp .'<br>'; // undefined property

// echo $fordfocus->nmiles .'<br>'; // Fatal error: Uncaught Error: Cannot access private property 

class SimpleClass {
    // property declaration
    public $myvar = -1;
    // method declaration
    public function displayVar() {
        echo $this->myvar .'<br>'; // this : when we call a variable or method WITHIN the object
    }
	public function displayVar1() {
        echo $myvar .'<br>'; // undefined variable myvar !
    }
}

$o1=new SimpleClass();
$o1->myvar=2;
$o1->displayVar();
$o1->myvar=4;
$o1->displayVar1();

//////////////////////////////////////////////////////////////////////////////


/* -> It does not work
class MyClass
{
    private $foo = FALSE;
    public function f1()
    {
        $this->$foo = TRUE;
        echo($this->$foo);
    }
}
$bar = new MyClass(); // Fatal error: Cannot access empty property in ...
*/

//////////////////////////////////////////////////////////////////////////

class MyClass
{
    private $foo = FALSE;
    public function f1()
    {
        $this->foo = TRUE;
        echo($this->foo);
    }
}
$bar = new MyClass();


class Car5 {
  //the private access modifier denies access to the method from outside the class's scope
  private $model;
  private $type;
  //the public access modifier allows the access to the method from outside the class
  public function setModel($model) {
    $this -> model = $model;
  }
  public function getModel() {
    return "The car model is  " . $this -> model;
  }
  //the public access modifier allows the access to the method from outside the class
  public function setType($type) {
    //validate that only certain car models are assigned to the $carModel property
    $allowedTypes = array("Sedan","SUV","Hatchback");
    if(in_array($type,$allowedTypes)) {
      $this -> type = $type;
    } else {
      $this -> type = "Not in the list of types";
    }
  }
}
 
$mycar = new Car5();
//Sets the model
$mycar->setModel("Ford");
//Gets the model
echo $mycar->getModel();

//Access modifiers:
//	to limit the modifications that code from outside 
//the classes can do to the classes' methods and properties. 


////////////////////////////////////////////////////////////////////////

// Object assignment

//An Object is some abstract data in memory. 
//A variable always holds a reference to this data in memory. 


$instance = new SimpleClass();
$instance->myvar=20;

$assigned   =  $instance;
$reference  =& $instance;
// $assigned isn't a reference but a copy of $instance.

echo $instance->myvar .'<br>';
echo $reference->myvar .'<br>';


$instance = null; // $instance and $reference become null


// var_dump = Dumps information about a variable
var_dump($instance); // NULL
var_dump($reference); // NULL
var_dump($assigned); // object(SimpleClass)#4 (1) { ["myvar"]=> int(20) }


Class Bar {};
$foo = new Bar;   // $foo holds a reference to an instance of Bar
$bar = $foo;      // $bar holds a copy of the reference to the instance of Bar
$baz =& $foo;     // $baz references the same reference to the instance of Bar as $foo


// Another example

class Car2 { 
  public $tank=0;
  // Add gallons of fuel to the tank when we fill it.
  public function fill($float)
  {
    $this-> tank += $float;
	return $this; // return the whole object
  }
  // Substract gallons of fuel from the tank as we ride the car.
  public function ride($float)
  {
    $miles = $float;
    $gallons = $miles/40;
    $this-> tank -= $gallons;
	return $this; // return the whole object
  }
}

echo '<br>';
$c1=new Car2();
$t1 = $c1 -> fill(10) -> ride(40) -> tank;
echo $c1->tank .'  '.   $t1 .'<br>';


/////////////////////////////////////////////////////////////
// List of magic method: http://php.net/manual/en/language.oop5.magic.php

// The __construct() magic method

// The constructor
class Car8{
  private $model;
  // A constructor method.
  public function __construct($model) // the constructor has an input
  {
    $this -> model = $model;
  }
  // You cant overload methods :(
  
  public function getCarModel()
  {
    echo 'Model is: ' . $this -> model .'<br>';
  }
}
$c1 = new Car8("Subaru");


//Use $this to refer to the current object. 
//Use self to refer to the current class.  
//Use $this->member for non-static members, use self::$member for static members.


class Car9{
  private $model;
  // A constructor method.
  public function __construct() // the constructor has an input
  {
    // allocate some stuff
	$this->model="unknown";
  }
  
  public static function withModel($m) {
	$instance=new self();
	$instance->model=$m;
	return $instance;	  
  }
  
  public function DisplayCarModel()
  {
    echo 'Model is: ' . $this -> model .'<br>';
  }
}

$c1 = new Car9();
$c1->DisplayCarModel();
$tmp="subaru";
$c2 = Car9::withModel($tmp);
$c2->DisplayCarModel();


// Another solution

class Car10{
  private $model;
  // A constructor method.
  public function __construct($model = null)
  {
    // Only if the model value is passed it will be assigned
    if($model) { 
      $this -> model = $model;
    }
	else
	  $this -> model = "unknown";	
  }
  public function DisplayCarModel() {
    echo 'Model is: ' . $this -> model .'<br>';
  }
}

$c1=new Car10();
$c1->DisplayCarModel();


// Magic constant __CLASS__ : get the name of the class
class MyClass1{
	public function __construct() {
		echo 'The name of the class is ' . __CLASS__ .'<br>';
	}
}
$m1=new MyClass1();


// Some magic constants:
//__LINE__	The current line number of the file.
//__FILE__	The full path and filename of the file with symlinks resolved. If used inside an include, the name of the included file is returned.
//__DIR__	The directory of the file. If used inside an include, the directory of the included file is returned. This is equivalent to dirname(__FILE__). This directory name does not have a trailing slash unless it is the root directory.
//__FUNCTION__	The function name.
//__CLASS__	The class name. The class name includes the namespace it was declared in (e.g. Foo\Bar). Note that as of PHP 5.4 __CLASS__ works also in traits. When used in a trait method, __CLASS__ is the name of the class the trait is used in.
//__TRAIT__	The trait name. The trait name includes the namespace it was declared in (e.g. Foo\Bar).
//__METHOD__	The class method name.
//__NAMESPACE__	The name of the current namespace.


/////////////////////////////////////////////////////////////////////////////////////////////

// Concept of Inheritance
// protected keyword

class Parent1 { // The parent's class code 
}
class Child1 extends Parent1 { // we use the keyword extends
  // The  child can use the parent's class code 
  }


// The parent class has its properties and methods
class Motorbike {
  //A private property or method can be used only by the parent.
  private $model;
  protected $brand;
  // Public methods and properties can be used by both the parent and the child classes.
  public function setModel($model) {
    $this -> model = $model;
  }
  public function setBrand($brand) {
    $this -> brand = $brand;
  }
  public function getModel() {
    return $this -> model;
  }
  public function DisplayInfo() {
	echo 'Parent '. __CLASS__ .' '. $this->brand . $this->model .'<br>';
  }
}
 
//The child class can use the code it inherited from the parent class 
// it can also have its own code! 
class Cruiser extends Motorbike{
  private $style = 'cruising';
  public function driveItWithStyle()
  {
    return 'Drive a ' .$this->brand. ' ' .$this -> getModel(). ' <i>' . $this -> style . '</i>';
  }
  
  public function DisplayInfo() {
	  // This function overides the function described at the parent level
	echo 'Child '. __CLASS__ .' '. $this->brand . $this->model .'<br>';
  }
  
}
 
//create an instance from the child class
$cbike=new Cruiser();
// Use a method that the child class inherited from the parent class
$cbike-> setBrand('Indian');
$cbike-> setModel('Scout');
// Use a method that was added to the child class
echo $cbike -> driveItWithStyle();
$cbike ->DisplayInfo();


// use the keyword final in front of the function (parent) so the function (child) cannot be overriden

///////////////////////////////////////////////////////////////////////////////////////
// Abstraction with classes


// Abstract classes are declared with the abstract keyword, and contain abstract methods.
abstract class Car {
	// Contains both abtract and non abstract methods/properties
  abstract public function calcNumMilesOnFullTank(); // just the definition of the header, the body is defined at the child
  // this method must be set in the child
}

// The child classes that inherit from abstract classes must add bodies to the abstract methods.

/////////////////////////////////////////////////////////////////////////////////////////
//Interface (very similar to abstract classes)
// Interface : only public methods, NO variables

interface interfaceName { 
  // abstract methods
}
 
class Child implements interfaceName {
  // defines the interface methods and may have its own code
}

// Read: http://php.net/manual/en/language.oop5.interfaces.php


//Interface
// The code: abstract methods + constants
// Access modifiers: public
// Number of parents: more than 1 interface !!!

// Abstract class
// The code: abstract methods, constants, concrete methods, concrete variables
// Access modifiers: public, protected, private
//Number of parents: only 1 !!!

///////////////////////////////////////////////////////////////////////////////////////////
// Polymorphism

interface Shape {
  public function calcArea();
}

class Circle implements Shape {
  private $radius;
  public function __construct($radius) {
    $this -> radius = $radius;
  }
  // calcArea calculates the area of circles 
  public function calcArea() {
    return $this -> radius * $this -> radius * pi();
  }
}

class Rectangle implements Shape {
  private $width;
  private $height;
  public function __construct($width, $height) {
    $this->width=$width;
    $this->height=$height;
  }
  // calcArea calculates the area of rectangles   
  public function calcArea() {
    return $this->width*$this->height;
  }
}

$circ=new Circle(7);
$rect=new Rectangle(5,9);
echo $circ->calcArea() .'<br>';
echo $rect->calcArea() .'<br>';

//////////////////////////////////////////////////////////////////////////////////////////////////
// Type hinting

// It is possible to specify the input of a function with a particular type of class

class Spaceship {
  protected $pilot;
  // The constructor can only get pilot objects as arguments.
  public function __construct(Pilot $p) {
    $this->pilot = $p;
  }
}
 
class Pilot {}


?>