<?php

class Person {
    private $firstName;
    private $lastName;
    private $dateOfBirth;
    private $address;

    public function displayFirstName() {
        echo $this->firstName;
    }

    public function displayLastName() {
        echo $this->lastName;
    }

    public function displayDateOfBirthday() {
        echo $this->dateOfBirth;
    }

    public function displayAddress() {
        echo $this->address;
    }

    public function setFirstName($name) {
      $this->firstName = $name;
    }
    
    public function setLastName($name) {
      $this->lastName = $name;
    }
    
    public function setDateOfBirth($dob) {
      $x = new DateTime($dob);
      $this->dateOfBirth = $x->format('Y-m-d');
    }
    
    public function setAddress($add) {
      $this->address = $add;
    }

    public function findCurrentAge() {
        $now = new DateTime(Date("Y-m-d", time()));
        $origin = new DateTime($this->dateOfBirth);
        $difference = $origin->date_diff($now);

        echo 'Difference: ' .
        $difference->y . ' years, ' . 
        $difference->m . ' months, ' . 
        $difference->d.' days';
    }

    public function displayAll() {
        echo "Person Class";
        foreach ($this as $key => $value) {
            echo "-- Person $key : $value";
        }
    }
}