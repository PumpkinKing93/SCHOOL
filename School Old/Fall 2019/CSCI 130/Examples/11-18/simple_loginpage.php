<?php
   ob_start();  // Turn on output buffering
   session_start();
?>

<?
   // error_reporting(E_ALL);
   // ini_set("display_errors", 1);
?>

<!DOCTYPE html>
<html lang = "en">
   <head>
      <title>Example Login + Password</title>     
   </head>
   <body>    
      <h2>Enter Username and Password</h2> 
      <div class = "container form-signin">
         <?php
            $msg = '';
            if (isset($_POST['login']) && !empty($_POST['username']) 
               && !empty($_POST['password'])) {
               if ($_POST['username'] == 'myusername' && 
                  $_POST['password'] == '1234') {
                  $_SESSION['valid'] = true;
                  $_SESSION['timeout'] = time();
                  $_SESSION['username'] = 'myusername';
                  echo 'You have entered valid use name and password';
               }else {
                  $msg = 'Wrong username or password';
               }
            }
         ?>
      </div> <!-- /container -->   
      <div>    
         <form role = "form" action = "<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method = "post">
            <h4><?php echo $msg; ?></h4>
            <input type = "text" name = "username" placeholder="username = myusername" 
               required autofocus></br>
            <input type="password" name="password" placeholder="password = 1234" required>
            <button type="submit"  name="login">Login</button>
         </form>	
         Clean <a href = "simple_logoutpage.php" tite = "Logout">Session.         
      </div> 
   </body>
</html>