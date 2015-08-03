<?php
if( !defined("PROGRAM_RUNNING") ) die("Error 211.");

// rudimentary authentication
class VOA_Auth {

    function __construct() {
        if(
            !isset($_SERVER['PHP_AUTH_USER']) ||
            empty($_SERVER['PHP_AUTH_USER']) ||
            $_SERVER['PHP_AUTH_USER'] !== ADMIN_USERNAME ||
            $_SERVER['PHP_AUTH_PW'] !== ADMIN_PASSWORD
        ) {
            header('WWW-Authenticate: Basic realm="VOA Tour"');
            header('HTTP/1.0 401 Unauthorized');
            echo "This is a restricted area.";
            echo "<script>setTimeout(function() { window.location = '";
            echo HOMEPAGE;
            echo "'; }, 100 );</script>";
            die;
        }
    }

}
