Laravel install


// php artisan make:model Car --migration

<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Car extends Model
{
    //
}

/*

--migration option when generating the model
--> Laravel generated a database migration file for creating that cars database table. 
The migration file is located at [timestamp]_create_cars_table.php and contains the following code:


*/


// To add a column

Schema::table('users', function ($table) {
    $table->string('email');
});


// Addition of tables ...

 Schema::create('cars', function (Blueprint $table) {
    $table->increments('id');
    $table->string('make');
    $table->string('model');
    $table->date('produced_on');
    $table->timestamps();
  });
  
  
$ php artisan migrate
  

$ php artisan make:controller CarController 
// --> create the file app/Http/Controllers/CarController.php controller file

// Creation of the routes
Route::resource('cars', 'CarController');
  

?>


// The view:

<!DOCTYPE html>
<html>
  <head>
    <title>Car {{ $car->id }}</title>
  </head>
  <body>
    <h1>Car {{ $car->id }}</h1>
    <ul>
      <li>Make: {{ $car->make }}</li>
      <li>Model: {{ $car->model }}</li>
      <li>Produced on: {{ $car->produced_on }}</li>
    </ul>
  </body>
</html>









