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
$smarty->display( "index.tpl" );
