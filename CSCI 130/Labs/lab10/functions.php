<?php

class Student {
    
    private $firstName; 
    private $lastName; 
    private $address;
    private $born;
    private $idNum; 
    private $gpa; 
    private $numberOfUnits;
 
	function __construct( $name, $age ) {
		$this->firstName = $firstName;
        $this->lastName = $lastName;
        $this->address = $address;
        $this->born = $born;
        $this->idNum = $idNum;
		$this->gpa = $gpa;
		$this->numberOfUnits = $numberOfUnits;
        
        
	}
 
	function getName() {
		return $this->name;
	}
 
	function isAdult() {
		return $this->age >= 18?"an Adult":"Not an Adult";
	}
 
}

?>