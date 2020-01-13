<!DOCTYPE html>
<?php

// setcookie(name, value, expire, path, domain, secure, httponly);

$cookie_name = "username";
$cookie_value = "Jim Smith";
setcookie($cookie_name, $cookie_value, time() + (86400 * 30), "/"); // 86400 = 1 day
//86400 = 60*60*24

// set the cookies
setcookie("cookie[three]", "cookiethree");
setcookie("cookie[two]", "cookietwo");
setcookie("cookie[one]", "cookieone");

// after the page reloads, print them out
if (isset($_COOKIE['cookie'])) {
    foreach ($_COOKIE['cookie'] as $name => $value) {
        $name = htmlspecialchars($name);
        $value = htmlspecialchars($value);
        echo "$name : $value <br />\n";
    }
}

// set the expiration date to one hour ago
// setcookie("user", "", time() - 3600);


?>
<html>
<body>

<?php
if(!isset($_COOKIE[$cookie_name])) {
     echo "Cookie named '" . $cookie_name . "' is not set!";
} else {
     echo "Cookie '" . $cookie_name . "' is set!<br>";
     echo "Value is: " . $_COOKIE[$cookie_name];
}

// Another way to debug/test is to view all cookies
print_r($_COOKIE);


?>

<p><strong>Note:</strong><br> You may have to reload the page to see the value of the cookie.</p>

</body>
</html>