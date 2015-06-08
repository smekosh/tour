<?php
require( "config.php" );
require( "vendor/autoload.php" );
require( "class.db.php" );
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

$db = new VOA_DB(
    MYSQL_HOST,
    MYSQL_DATABASE,
    MYSQL_USER,
    MYSQL_PASS
);

// $t = $db->Query("show tables");

$smarty = new Smarty();
$smarty->assign( "homepage", HOMEPAGE );

if( !isset( $_GET['page']) ) {
    $page = "index.tpl";
} else {
    switch( $_GET['page'] ) {
        case 'about': $page = "about.tpl"; break;
        case 'directions': $page = "directions.tpl"; break;
        case 'bring': $page = "bring.tpl"; break;
        case '404': $page = "404.tpl"; break;
    }
}

$smarty->display( $page );
