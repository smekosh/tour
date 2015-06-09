<?php
require( "config.php" );
require( "vendor/autoload.php" );
require( "class.db.php" );
require( "class.calendar.php" );
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

$smarty = new Smarty();
$smarty->assign( "homepage", HOMEPAGE );

if( !isset( $_GET['page']) ) {
    $page = "index.tpl";
} else {
    switch( $_GET['page'] ) {
        case 'about': $page = "about.tpl"; break;
        case 'directions': $page = "directions.tpl"; break;
        case 'bring': $page = "bring.tpl"; break;
        case 'visit': $page = "form.tpl"; break;
        case '404': $page = "404.tpl"; break;
        case 'admin':
            $page = "admin.tpl";
            include( "index_admin.php" );
        break;
    }
}

$smarty->display( $page );
