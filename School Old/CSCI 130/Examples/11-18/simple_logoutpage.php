<?php
   session_start();
   unset($_SESSION["username"]);
   unset($_SESSION["password"]);
   echo 'You have cleaned session :)';
   header('Refresh: 2; URL = simple_loginpage.php');
   // http://php.net/manual/en/function.header.php
?>