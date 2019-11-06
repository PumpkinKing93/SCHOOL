<?php

    function secToDays($sec){
        return ($sec / 60 / 60 / 24);
    }

    if(isset($_COOKIE['cookie'])){

        if(round(secToDays((intval($_COOKIE['cookie']) - time())),1) < 1){
            echo "Cookie will expire today";
        }else{
            echo "Cookie will expire in " . round(secToDays((intval($_COOKIE['cookie']) - time())),1) . " day(s)";
        }
    }else{
        echo "Cookie not set...";
    }

?>