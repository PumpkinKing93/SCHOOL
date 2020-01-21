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
 
	function getFirstName() {
		return $this->firstName;
	}
    
    function getLastName() {
		return $this->lastName;
    }
    
    function getAddress() {
		return $this->address;
    }

    function getBorn() {
		return $this->born;
    }

    function getIDNum() {
		return $this->idNum;
    }

    function getGPA() {
		return $this->gpa;
    }

    function getNOU() {
		return $this->numberOfUnits;
    }
 
}

?>