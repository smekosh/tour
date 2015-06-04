<?php
require( "vendor/autoload.php" );
require( "config.php" );
if( !defined( "HOMEPAGE") ) die( "Error, config file missing?" );

$smarty = new Smarty();
$smarty->assign( "homepage", HOMEPAGE );
$smarty->display( "form.tpl" );
