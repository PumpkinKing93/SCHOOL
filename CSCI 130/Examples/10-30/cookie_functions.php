
<?php 
//Setting new cookie
setcookie("name","value",time()+$int);
/*name is your cookie's name
value is cookie's value
$int is time of cookie expires*/
?>

<?php 
// Getting Cookie
echo $_COOKIE["your cookie name"];
?>

<?php 
// Updating Cookie
setcookie("color","red");
echo $_COOKIE["color"];
/*color is red*/
/* your codes and functions*/
setcookie("color","blue");
echo $_COOKIE["color"];
/*new color is blue*/
?>

<?php
// Deleting Cookie 
unset($_COOKIE["yourcookie"]);
/*Or*/
setcookie("yourcookie","yourvalue",time()-1);
/*it expired so it's deleted*/
?>


