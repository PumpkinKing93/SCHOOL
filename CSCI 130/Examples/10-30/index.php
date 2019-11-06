<?php

    $time = time()+(60*60*24*10);
    $timeMemo = (string)$time;
    setcookie("cookie", "" . $timeMemo . "", $time);

?>
<html>
    <head>
        <title>
            Get cookie expiration date from JS
        </title>
        <script type="text/javascript">

            function cookieExpirationDate(){

                var infodiv = document.getElementById("info");

                var xmlhttp;
                if (window.XMLHttpRequest){ 
                    xmlhttp = new XMLHttpRequest;
                }else{
                    xmlhttp = new ActiveXObject(Microsoft.XMLHTTP);
                }

                xmlhttp.onreadystatechange = function (){
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
                        infodiv.innerHTML = xmlhttp.responseText;
                    }
                }

                xmlhttp.open("GET", "cookie.php", true);
                xmlhttp.send();

            }

        </script>
    </head>
    <body>
        <input type="button" onclick="javascript:cookieExpirationDate();" value="Get Cookie expire date" />
        <hr />
        <div id="info">
        </div>
    </body>
</html>